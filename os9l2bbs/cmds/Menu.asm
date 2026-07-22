**********************************************************************
* menu - OS-9 Level 2 BBS command
*
* syntax: Menu <menu-file> <command-file>
* purpose: Display a menu, enforce priority prefixes, and dispatch the selected command.
* menu navigation is implemented through commands and directory changes.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
*          2026/07/21  Codex
* enable echo and automatic linefeed on redirected interactive input.
**********************************************************************

*
* internal operation
* ------------------
* os-9 supplies X as the parameter-string pointer, Y as its end, and U as
* this module's data-area base.  The first argument names the menu text file;
* the second names a command-definition file.  Both names are copied into
* cr-terminated workspace buffers before either file is opened.
*
* bbs.userstats is scanned as fixed 32-byte records until the record whose
* leading word matches the caller's OS-9 user ID.  A zero session allowance
* means no deadline.  Otherwise the allowance is added to the record's saved
* date/time with minute, hour, day, month, and year carry propagation.  The
* resulting six-byte deadline is compared with F$Time before every prompt;
* expired callers are disconnected and callers within five minutes receive
* a warning.
*
* the command-definition file is compiled into three parallel tables with at
* most 40 entries: one selection key, one three-byte access rule, and one
* fixed 80-byte command record.  Ordinary entries receive the unrestricted
* rule '-,$FFFF'.  Entries beginning with '<', '>', or '=' parse a decimal
* user-ID threshold before the actual selection key.  A '/' record terminates
* the table and supplies the prompt line displayed after the menu text.
*
* the selected key is folded to uppercase and looked up in the key table.
* user ID zero bypasses all access checks.  Other users must satisfy the
* entry's unsigned <, >, or = relation or receive the denial message.  A
* normal command is passed to a child shell.  EX exits.  CHMD and CHMX change
* the data or execution directory, while CHMM replaces both filenames and
* reloads another menu, providing submenu navigation without recursion.
*
* menu output is streamed from the in-memory file image.  I$GetStt polling
* lets a pending keystroke interrupt a long display.  CR-delimited chunks use
* i$WritLn; a final unterminated chunk uses I$Write.  This preserves authored
* menu line endings while avoiding one OS-9 write per character.

                    nam       menu
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $02

CommandVerbFirst    equ       1         ; first verb character after the record's leading separator
CommandVerbSecond   equ       2         ; second verb character in CHM or EX
CommandVerbSelector equ       3         ; final character selecting CHMM, CHMD, or CHMX
CommandLength       equ       $4E       ; parameter length stored near the end of each command record

                    mod       eom,name,tylg,atrv,start,size

UserStatsPath       rmb       1         ; path number for the open BBS.userstats file
MenuFilePath        rmb       1         ; path number for the open menu-text file
CommandFilePath     rmb       1         ; path number for the open command-definition file
SelectionChar       rmb       1         ; one-byte menu selection read from standard input
DecimalCounter      rmb       1         ; decimal digit/count scratch used by priority parsing
KeyTableCursor      rmb       2         ; cursor into the 40-byte selection-key table
CommandTableCursor  rmb       2         ; cursor into the 40 fixed-size command records
AccessTableCursor   rmb       2         ; cursor into the 40 three-byte access-rule records
PriorityValue       rmb       2         ; 16-bit result produced by the decimal priority parser
ArgumentEnd         equ       PriorityValue ; startup alias for the end of the OS-9 parameter block
MenuImageStart      equ       PriorityValue ; reload alias for the beginning of menu storage
DecimalPlace        rmb       2         ; decimal place multiplier used while parsing a threshold
MenuImageEnd        rmb       2         ; address immediately beyond the loaded menu image
PromptLength        rmb       2         ; length of the prompt line read after the slash terminator
CallerUserId        rmb       2         ; os-9 user ID returned in Y by F$ID
MenuBytesRemaining  rmb       2         ; number of loaded menu bytes not yet written
UnlimitedSession    rmb       1         ; nonzero when menu prompts must bypass deadline enforcement
MenuLoadScratch     rmb       1         ; spare byte adjacent to the menu byte count
UserStatsRecord     rmb       4         ; 32-byte BBS.userstats record begins here
SessionYear         rmb       1         ; deadline year while the user record is normalized
SessionMonth        rmb       1         ; deadline month while the user record is normalized
SessionDay          rmb       1         ; deadline day while the user record is normalized
SessionHour         rmb       1         ; deadline hour while the user record is normalized
SessionMinute       rmb       1         ; login minute, later normalized into the deadline minute
SessionSecond       rmb       1         ; login second copied unchanged into the deadline
UserStatsReserved   rmb       14        ; intervening fields in the original 32-byte user record
SessionAllowance    rmb       2         ; number of session minutes granted to this caller
UserStatsRecordTail rmb       6         ; remaining bytes of the original user-statistics record
CurrentDate         rmb       3         ; current date from F$Time: year, month, day
CurrentTime         rmb       3         ; current time from F$Time: hour, minute, second
DeadlineDate        rmb       3         ; computed deadline date: year, month, day
DeadlineTime        rmb       3         ; computed deadline time: hour, minute, second
MenuFilename        rmb       32        ; cr-terminated menu-text filename from argument one
CommandFilename     rmb       32        ; cr-terminated command-definition filename from argument two
AccessPrefixScratch rmb       6         ; fixed-width access-relation and decimal-threshold prefix
AccessScratchPad    rmb       200       ; unused separation before the compiled parallel tables
SelectionKeyTable   rmb       40        ; 40-byte table of uppercase selection keys
AccessRuleTable     rmb       120       ; 40 access records: relation byte plus 16-bit user ID
CommandRecordTable  rmb       3200      ; 40 command records of 80 bytes each
PromptPrefix        rmb       2         ; lf/cr prefix immediately before the prompt buffer
PromptBuffer        rmb       80        ; 80-byte prompt line from the command-definition terminator
MenuImage           rmb       4450      ; storage for the in-memory menu text and trailing spare bytes
TerminalOptions     rmb       32        ; keep the SS.Opt packet last to preserve workspace offsets
size                equ       .

name                fcs       /menu/ ; os-9 module name followed by the original copyright payload
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved"
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
ShellName           fcc       "shell" ; shell module name used for ordinary command dispatch
                    fcb       $0D
UsageMessage        fcc       "Usage is:" ; usage text for a missing or malformed parameter list
                    fcb       $0A
                    fcc       "MENU <menuname> <cmdname>"
                    fcb       $0A
                    fcb       $0D
PromptSpacing       fcb       $0A       ; two blank lines emitted before each selection prompt
                    fcb       $0A
                    fcb       $0D
AccessDeniedMessage fcc       "Sorry, you do not have access to that option" ; message shown when the selected access relation fails
                    fcb       $0D
InvalidPriorityMessage fcc       "A user priority level has been specified incorrectly!" ; message shown when an access threshold contains no digits
                    fcb       $0D
UserStatsName       fcc       "/dd/bbs/BBS.userstats" ; absolute path of the fixed-size user statistics database
                    fcb       $0D
SessionExpiredMessage fcc       "I'm sorry, but your time has expired!" ; message emitted when the computed session deadline has passed
                    fcb       $0D
SessionWarningMessage fcc       "WARNING!!  You have only a few minutes left online!" ; message emitted when fewer than five minutes remain
                    fcb       $0D
MonthLengths        fcb       31,28,31,30,31,30 ; january through june; leap years are not handled
                    fcb       31,31,30,31,30,31 ; july through december
* preserve the startup parameter bounds while F$ID temporarily returns IDs in X and Y.
start               lbsr      InitializeTerminalInput ; configure the stdin supplied by Shellplus </1
                    pshs      u,y,x,d   ; protect the parameter pointer, limit, and data pointer
                    os9       F$ID      ; obtain the caller's OS-9 user ID in Y
                    sty       <CallerUserId,u ; retain the ID used by time and access policy
                    puls      u,y,x,d   ; recover the untouched startup register set
                    lda       #1        ; assume unlimited use until a nonzero allowance is found
                    sta       <UnlimitedSession,u ; prevent uninitialized deadline comparisons
                    ldd       #$0A0D    ; prepare LF/CR immediately before the prompt buffer
                    std       >PromptPrefix,u ; preserve the original prompt-layout prefix
                    sty       ArgumentEnd,u ; remember where the OS-9 parameter block ends
                    leay      <MenuFilename,u ; copy argument one into its pathname buffer
* split "menu-file command-file" into two independent CR-terminated pathnames.
CopyMenuFilename    lda       ,x+       ; consume the next byte of the first pathname
                    cmpx      ArgumentEnd,u ; ensure a separator existed inside the supplied block
                    lbhi      ShowUsage ; reject a missing second argument
                    sta       ,y+       ; append the byte to MenuFilename
                    cmpa      #C$SPAC   ; recognize the argument separator
                    bne       CopyMenuFilename ; continue through the first pathname
                    lda       #C$CR     ; convert the separator to an OS-9 terminator
                    sta       -1,y      ; finish MenuFilename in place
                    leay      <CommandFilename,u ; switch to the second pathname buffer
CopyCommandFilename lda       ,x+       ; consume the next byte of the command pathname
                    cmpx      ArgumentEnd,u ; keep the copy inside the startup parameter block
                    lbhi      ShowUsage ; reject a missing terminating CR
                    sta       ,y+       ; append the byte to CommandFilename
                    cmpa      #C$CR     ; os-9 terminates the complete parameter line with CR
                    bne       CopyCommandFilename ; include every byte through that terminator

* find the caller's 32-byte statistics record. A missing file or missing record leaves
* unlimitedSession set, which is the deliberate fix for the immediate-expiry bug.
                    leax      >UserStatsName,pc ; select the global statistics database
                    lda       #READ.    ; records are consulted but never modified here
                    os9       I$Open    ; open BBS.userstats
                    lbcs      ReloadMenuConfig ; degrade to unlimited access when it is unavailable
                    sta       UserStatsPath,u ; retain the scan path
ScanUserRecord      leax      <UserStatsRecord,u ; receive one complete statistics record
                    ldy       #32       ; records have a fixed 32-byte stride
                    lda       UserStatsPath,u ; select the statistics file
                    os9       I$Read    ; fetch the next caller record candidate
                    bcs       CloseUserStats ; eof leaves the caller unlimited
                    ldd       <CallerUserId,u ; recover the caller's numeric ID
                    cmpd      <UserStatsRecord,u ; compare it with the record's leading ID word
                    bne       ScanUserRecord ; scan until the correct user is found
                    bra       CalculateDeadline ; interpret the matching record's allowance
CloseUserStats      lda       UserStatsPath,u ; select the exhausted statistics file
                    os9       I$Close   ; release it before loading menu files
                    lbra      ReloadMenuConfig ; proceed with the unlimited-session default

* add the record's minute allowance to its saved login timestamp. Calendar carry is
* performed in place, then the normalized six-byte deadline is copied aside.
CalculateDeadline   ldd       <SessionAllowance,u ; fetch the configured session minutes
                    cmpd      #0        ; zero explicitly means no deadline
                    lbeq      ReloadMenuConfig ; retain UnlimitedSession for unrestricted users
                    clr       <UnlimitedSession,u ; enable deadline checks only for a real allowance
                    ldb       <SessionMinute,u ; start with the saved login minute
                    clra                ; zero-extend that byte before adding a word
                    addd      <SessionAllowance,u ; calculate total minutes after login
                    cmpd      #60       ; determine whether an hour carry is required
                    bcs       StoreDeadlineMinute ; retain totals that remain in the login hour
CarryDeadlineHour   subd      #60       ; remove one hour from the outstanding minute total
                    pshs      d         ; protect its remainder during calendar normalization
                    lda       <SessionHour,u ; advance the saved login hour
                    inca                ; carry one complete block of 60 minutes
                    cmpa      #24       ; detect midnight
                    bcs       StoreDeadlineHour ; retain hours 0 through 23
                    clr       <SessionHour,u ; wrap midnight to hour zero
                    lda       <SessionDay,u ; carry midnight into the date
                    inca                ; tentatively select the following day
                    leax      >MonthLengths,pc ; select the non-leap-year month table
                    ldb       <SessionMonth,u ; obtain the one-based month
                    decb                ; convert it to a zero-based table index
                    leax      b,x       ; address that month's final day
                    cmpa      ,x        ; test whether the incremented day still belongs to it
                    bls       StoreDeadlineDay ; retain valid dates within the month
                    lda       #1        ; wrap to the first day of the next month
                    sta       <SessionDay,u ; normalize the day before carrying the month
                    lda       <SessionMonth,u ; advance the saved login month
                    inca                ; carry across the month boundary
                    cmpa      #12       ; detect a value beyond December
                    bls       StoreDeadlineMonth ; retain months 1 through 12
                    lda       #1        ; wrap December to January
                    sta       <SessionMonth,u ; normalize the month before carrying the year
                    lda       <SessionYear,u ; advance the two-digit year byte
                    inca                ; carry across the year boundary
StoreDeadlineYear   sta       <SessionYear,u ; retain the normalized year
                    bra       ContinueMinuteCarry ; recover the outstanding minute total
StoreDeadlineMonth  sta       <SessionMonth,u ; retain the normalized month
                    bra       ContinueMinuteCarry ; recover the outstanding minute total
StoreDeadlineDay    sta       <SessionDay,u ; retain the normalized day
                    bra       ContinueMinuteCarry ; recover the outstanding minute total
StoreDeadlineHour   sta       <SessionHour,u ; retain the normalized hour
ContinueMinuteCarry puls      d         ; recover minutes not yet assigned to the timestamp
                    cmpd      #60       ; test for another complete hour
                    bcc       CarryDeadlineHour ; propagate every additional hour
StoreDeadlineMinute stb       <SessionMinute,u ; retain the final minute remainder
                    lda       #6        ; copy year, month, day, hour, minute, and second
                    leax      <SessionYear,u ; select the normalized timestamp in the record buffer
                    leay      <DeadlineDate,u ; select the private comparison buffer
CopyDeadline        ldb       ,x+       ; fetch the next deadline component
                    stb       ,y+       ; preserve it beyond future record-buffer reuse
                    deca                ; account for one of the six components
                    bne       CopyDeadline ; copy through the seconds byte
                    bra       ReloadMenuConfig ; compile the requested menu configuration
* load or reload the command-definition file and reset all three compiled-table cursors.
* submenu selection returns here after replacing both filenames.
ReloadMenuConfig    leax      >SelectionKeyTable,u ; reset the next-key insertion address
                    stx       KeyTableCursor,u ; begin compiling at key slot zero
                    leax      >CommandRecordTable,u ; reset the parallel command insertion address
                    stx       CommandTableCursor,u ; begin compiling at command slot zero
                    leax      >AccessRuleTable,u ; reset the parallel access-rule address
                    stx       AccessTableCursor,u ; begin compiling at access slot zero
                    leax      <CommandFilename,u ; select the current definition pathname
                    lda       #READ.    ; definitions are compiled without modification
                    os9       I$Open    ; open the command-definition stream
                    lbcs      ExitWithStatus ; preserve open failures as the process status
                    sta       CommandFilePath,u ; retain the stream used by all compile reads
* read one command key/prefix byte and classify it as terminator, access rule, or ordinary key.
CompileNextEntry    ldx       KeyTableCursor,u ; use the free key byte as the one-byte input buffer
                    ldy       #1        ; consume only the entry's leading grammar byte
                    os9       I$Read    ; read a key, relation, or slash terminator
                    ldb       ,x        ; classify that leading byte
                    cmpb      #'/'      ; slash ends entries and introduces the prompt line
                    beq       FinishCommandTable ; finish compiling entries when the slash terminator is reached
                    cmpb      #'>'      ; greater-than introduces a minimum-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '>' relation
                    cmpb      #'<'      ; less-than introduces a maximum-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '<' relation
                    cmpb      #'='      ; equals introduces an exact-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '=' relation
                    ldy       AccessTableCursor,u ; address the rule parallel to this ordinary key
                    pshs      d         ; preserve the key while constructing its default rule
                    lda       #'-'      ; '-' denotes an unrestricted menu option
                    sta       ,y+       ; store the relation byte
                    ldd       #$FFFF    ; keep the unused threshold in its historical form
                    std       ,y++      ; complete the three-byte default access rule
                    puls      d         ; recover the selection key
                    sty       AccessTableCursor,u ; advance to the next rule slot
NormalizeEntryKey   cmpb      #'a'      ; only lowercase ASCII needs folding
                    bcs       ReadCommandRecord ; leave non-lowercase key bytes unchanged
                    andb      #$DF      ; clear ASCII's lowercase bit
                    stb       ,x        ; canonicalize the table key once during compilation
ReadCommandRecord   leax      1,x       ; advance to the following key slot
                    stx       KeyTableCursor,u ; preserve the updated key cursor
                    ldx       CommandTableCursor,u ; select the parallel command slot
                    ldy       #80       ; cap each shell command record at 80 bytes
                    os9       I$ReadLn  ; copy the entry's CR-terminated command text
                    lbcs      ExitWithStatus ; reject truncated definition files
                    sty       <CommandLength,x ; cache the parameter length inside this record
                    leax      <80,x     ; advance by one fixed command-record stride
                    stx       CommandTableCursor,u ; preserve the updated command cursor
                    bra       CompileNextEntry ; compile the following definition entry
* the slash terminator ends command compilation.  Read its prompt line, close the command file,
* load the entire menu-text file, and remember both its length and end address.
FinishCommandTable  leax      >PromptBuffer,u ; receive the prompt following the slash
                    ldy       #80       ; accept an 80-byte prompt line after the slash terminator
                    os9       I$ReadLn  ; load its CR-terminated text
                    lbcs      ExitWithStatus ; reject a missing prompt record
                    sty       <PromptLength,u ; retain the prompt's authored byte count
                    ldx       KeyTableCursor,u ; select the first unused key slot
                    lda       #$FF      ; a negative key marks the end of the compiled table
                    sta       ,x        ; publish the search sentinel
                    lda       CommandFilePath,u ; select the completed definition stream
                    os9       I$Close   ; release it before opening the menu image
                    lbcs      ExitWithStatus ; preserve close failures
                    leax      <MenuFilename,u ; select the current menu-text pathname
                    lda       #READ.    ; menu text is loaded without modification
                    os9       I$Open    ; open the authored display file
                    lbcs      ExitWithStatus ; preserve menu-file failures
                    sta       MenuFilePath,u ; retain the path for the bulk read
                    leax      >MenuImage,u ; select the in-memory image buffer
                    ldy       #4000     ; reserve at most 4000 bytes for the displayed menu image
                    lda       MenuFilePath,u ; select the menu file
                    os9       I$Read    ; load the display in one operation
                    sty       <MenuBytesRemaining,u ; initialize the streaming byte count
                    lbcs      ExitWithStatus ; preserve read failures
                    os9       I$Close   ; release the menu file after loading it
                    stx       MenuImageStart,u ; remember the first display byte
                    tfr       y,d       ; make the byte count available for address arithmetic
                    leax      d,x       ; calculate the exclusive image end
                    stx       MenuImageEnd,u ; retain the display bounds
                    ldx       MenuImageStart,u ; begin streaming at the image start
                    ldy       #1        ; prepare for one-byte readiness polling
* stream the menu image to standard output.  Stop early if I$GetStt reports pending input;
* otherwise emit one CR-delimited line at a time and advance the remaining-byte count.
DisplayNextChunk    pshs      x         ; preserve the candidate chunk start during scanning
                    lda       #1        ; poll standard input
                    ldb       #SS.Ready ; ask whether the caller has already selected an option
                    os9       I$GetStt  ; avoid forcing the rest of a long menu onto the terminal
                    lbcc      ReadSelection ; consume the pending selection immediately
                    ldy       <MenuBytesRemaining,u ; limit the CR scan to loaded bytes
                    ldx       ,s        ; scan from the preserved chunk start
FindMenuLineEnd     lda       ,x+       ; inspect the next authored menu byte
                    cmpa      #C$CR     ; prefer writing a complete line at a time
                    beq       WriteMenuLine ; emit a line when its terminating CR is found
                    leay      -1,y      ; account for one scanned byte
                    bne       FindMenuLineEnd ; continue until CR or the loaded image end
                    puls      x         ; recover the final fragment's start
                    lda       #1        ; target standard output
                    ldy       <MenuBytesRemaining,u ; write only the bytes that actually remain
                    os9       I$Write   ; emit a final fragment without manufacturing a CR
                    bra       AdvanceMenuCursor ; update the shared image position
WriteMenuLine       puls      x         ; recover the complete line's start
                    lda       #1        ; target standard output
                    ldy       <MenuBytesRemaining,u ; bound I$WritLn by the loaded image
                    os9       I$WritLn  ; preserve the authored CR line ending
AdvanceMenuCursor   lbcs      ExitWithStatus ; preserve terminal output failures
                    pshs      y         ; retain the number of bytes actually emitted
                    ldd       <MenuBytesRemaining,u ; recover the pre-write remaining count
                    subd      ,s        ; remove the emitted chunk length
                    std       <MenuBytesRemaining,u ; publish the remaining image length
                    cmpd      #0        ; detect completion of the loaded image
                    ble       MenuDisplayComplete ; proceed to the deadline and prompt
                    puls      d         ; recover the emitted chunk length
                    leax      d,x       ; advance to the next undisplayed byte
                    lda       #1        ; poll standard input between lines
                    ldb       #SS.Ready ; recognize type-ahead promptly
                    os9       I$GetStt  ; check without consuming a selection
                    lbcc      ReadSelection ; interrupt redisplay for pending input
                    cmpx      MenuImageEnd,u ; defend the image's exclusive upper bound
                    bhi       MenuDisplayComplete ; stop if a malformed count crossed the end
                    bra       DisplayNextChunk ; emit the next CR-delimited chunk
MenuDisplayComplete lbra      CheckSessionTime ; enforce the deadline before prompting
* compile an access-controlled entry.  The six following bytes contain the decimal threshold;
* the next byte is the actual selection key stored beside the parsed 16-bit value.
CompileAccessRule   pshs      x,a       ; protect the key slot and command-file path
                    ldy       AccessTableCursor,u ; select the parallel three-byte rule slot
                    stb       ,y+       ; retain '<', '>', or '=' as its relation
                    leax      >AccessPrefixScratch,u ; receive the fixed-width threshold text
                    pshs      y         ; protect the binary-threshold destination
                    ldy       #6        ; read the fixed-width decimal threshold field
                    os9       I$Read    ; consume the access prefix after its relation
                    leax      >AccessPrefixScratch,u ; parse from the beginning of that prefix
                    lbsr      ParsePriority ; convert its first decimal run to a user-ID threshold
                    puls      y         ; recover the threshold destination
                    std       ,y++      ; complete the rule with the parsed 16-bit value
                    sty       AccessTableCursor,u ; advance to the following rule slot
                    puls      x,a       ; recover the key slot and definition-file path
                    ldy       #1        ; read the selection key following the access prefix
                    os9       I$Read    ; place it directly in the compiled key table
                    ldb       ,x        ; bring the key into the normalizer
                    lbra      NormalizeEntryKey ; join ordinary-entry compilation
* disconnect the caller after reporting that the session deadline has expired.
SessionExpired      leax      >SessionExpiredMessage,pc ; select the disconnect notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; tell the caller why the menu is closing
                    lbra      ExitSuccess ; disconnect without reporting an OS-9 error
* report the five-minute warning and return to the prompt path.
WarnSessionTime     leax      >SessionWarningMessage,pc ; select the five-minute notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; warn before displaying the prompt
                    rts                 ; resume the normal prompt path
* unlimited sessions bypass wall-clock checks entirely.  Limited sessions compare
* the current clock lexicographically with the six-byte session deadline.
* only hour/minute/second differences need the five-minute warning calculation.
CheckSessionTime    tst       <UnlimitedSession,u ; decide whether a deadline was actually initialized
                    lbne      WritePrompt ; bypass comparisons for zero/missing allowances
                    leax      <CurrentDate,u ; receive the current six-byte timestamp
                    os9       F$Time    ; sample the clock immediately before the prompt
                    ldb       #6        ; compare all six date/time fields lexicographically
                    leax      <CurrentDate,u ; scan current year through second
                    leay      <DeadlineDate,u ; scan the normalized deadline in parallel
CompareDeadlineFields lda       ,x+       ; fetch the next current-time component
                    cmpa      ,y+       ; order it against the corresponding deadline component
                    lbhi      SessionExpired ; a later first difference means time has expired
                    bcs       CheckWarningWindow ; a current field below its deadline cannot yet be expired
                    decb                ; account for one equal component
                    bne       CompareDeadlineFields ; compare through the seconds byte
CheckWarningWindow  cmpb      #3        ; only a difference in hour/minute/second can be within five minutes
                    bgt       WritePrompt ; date differences cannot need an immediate warning
                    ldd       <CurrentTime,u ; take the current hour/minute pair
                    addb      #5        ; form the minute value five minutes from now
                    cmpb      #60       ; carry a minute value past 59 into the hour
                    bcs       CompareWarningDeadline ; minute plus five still lies within the current hour
                    subb      #60       ; retain the minute remainder after the hour carry
                    inca                ; carry the five-minute window into the next hour
                    cmpa      #24       ; wrap an hour past 23 to midnight
                    bcs       CompareWarningDeadline ; the warning window does not cross midnight
                    clra                ; represent midnight as hour zero
CompareWarningDeadline cmpd      <DeadlineTime,u ; warn only when now plus five minutes passes the deadline time
                    bls       WritePrompt ; remain quiet when more than five minutes remain
                    bsr       WarnSessionTime ; emit the near-deadline warning
WritePrompt         leax      >PromptBuffer,u ; select the compiled prompt line
                    ldy       <PromptLength,u ; recover its CR-inclusive length
                    leay      -1,y      ; omit the CR so input remains on the prompt line
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the prompt without a newline
* read one selection byte, echo prompt spacing, fold lowercase ASCII to uppercase, and search the key table.
ReadSelection       leax      SelectionChar,u ; receive one menu key
                    ldy       #1        ; accept exactly one menu-selection byte
                    clra                ; select standard input
                    os9       I$Read    ; consume either typed-ahead or newly entered input
                    ldy       #2        ; emit the two leading LF bytes plus the following CR via I$WritLn
                    lda       #1        ; target standard output
                    pshs      x         ; protect the selection address during spacing output
                    leax      >PromptSpacing,pc ; select the LF/LF/CR separator
                    os9       I$WritLn  ; move subsequent output below the prompt
                    puls      x         ; recover the selection address
                    lda       ,x        ; inspect the typed key
                    cmpa      #'?'      ; question mark requests a full menu reload
                    lbeq      ReloadMenuConfig ; redisplay and rebuild the menu when '?' is selected
                    cmpa      #'a'      ; preserve punctuation and already-uppercase keys
                    bcs       BeginKeySearch ; search punctuation and uppercase selections without modification
                    anda      #$DF      ; clear ASCII's lowercase bit
                    sta       ,x        ; canonicalize the selection for lookup
BeginKeySearch      lda       ,x        ; retain the canonical selection during the scan
                    leax      >SelectionKeyTable,u ; start at compiled key slot zero
                    clrb                ; maintain the parallel-table entry index
* search at most 40 compiled key entries; a negative sentinel restarts the time/prompt cycle.
SearchNextKey       tst       ,x        ; recognize the negative end sentinel
                    lbmi      CheckSessionTime ; an unknown key simply redraws the prompt
                    cmpa      ,x+       ; test this key while advancing the scan
                    beq       CheckAccessRule ; authorize the access record at the matching table index
                    incb                ; keep the access/command index parallel with X
                    cmpb      #40       ; enforce the command table's 40-entry capacity
                    bls       SearchNextKey ; inspect another compiled slot within capacity
                    lbra      CheckSessionTime ; recover safely from a missing sentinel
* the key matched.  Locate its three-byte access record and test the relation byte.
* an unrestricted entry falls directly into dispatch; user ID zero bypasses every relation.
CheckAccessRule     pshs      b         ; retain the matched index for later command lookup
                    lda       #3        ; each access record occupies relation plus 16-bit threshold
                    mul                 ; convert entry index B to a three-byte rule offset
                    leax      >AccessRuleTable,u ; select the rule table base
                    leax      d,x       ; address the matched key's parallel rule
                    lda       ,x+       ; fetch its relation and leave X at the threshold
                    cmpa      #'<'      ; dispatch upper-bound rules
                    beq       CheckLessThanRule ; apply the less-than access rule
                    cmpa      #'>'      ; dispatch lower-bound rules
                    beq       CheckGreaterThanRule ; apply the greater-than access rule
                    cmpa      #'='      ; dispatch exact-match rules
                    beq       CheckEqualRule ; apply the equality access rule
* dispatch the selected 80-byte command record.  Recognize CHM directory/submenu controls first,
* then EX, otherwise fork a shell with the record text as its parameter block.
DispatchCommand     puls      b         ; recover the matched entry index
                    lda       #80       ; convert the selected index into an 80-byte record offset
                    mul                 ; calculate the parallel command-record offset
                    pshs      u         ; protect the module data pointer while U addresses the record
                    leau      >CommandRecordTable,u ; select command slot zero
                    leau      d,u       ; advance to the matched command text
                    lda       CommandVerbFirst,u ; inspect the first verb character
                    anda      #$DF      ; compare verbs without regard to case
                    cmpa      #'C'      ; recognize the CHM pseudo-command family
                    bne       CheckExitCommand ; a non-'C' record may still be EX or an ordinary shell command
                    lda       CommandVerbSecond,u ; inspect the second verb character
                    anda      #$DF      ; compare it without regard to case
                    cmpa      #'H'      ; require CH before testing the selector
                    bne       CheckExitCommand ; a non-CH record may still be EX or an ordinary shell command
                    lda       CommandVerbSelector,u ; inspect the CHM selector character
                    anda      #$DF      ; compare it without regard to case
                    cmpa      #'M'      ; chmm replaces the menu and definition pathnames
                    lbeq      ChangeMenu ; parse the two filenames following CHMM
                    cmpa      #'X'      ; chmx changes the execution directory
                    lbeq      ChangeExecDirectory ; execute the CHMX directory control command
                    cmpa      #'D'      ; chmd changes the data directory
                    beq       ChangeDataDirectory ; handle the CHMD control command
CheckExitCommand    lda       CommandVerbFirst,u ; restart at the first verb character
                    anda      #$DF      ; compare it without regard to case
                    cmpa      #'E'      ; recognize the EX pseudo-command
                    bne       RunShellCommand ; a command not beginning with E is passed to shell
                    lda       CommandVerbSecond,u ; inspect the second verb character
                    anda      #$DF      ; compare it without regard to case
                    cmpa      #'X'      ; require the complete two-character pseudo-command
                    bne       RunShellCommand ; an E command not followed by X is passed to shell
                    lbra      ExitSuccess ; leave the menu loop cleanly
* for a less-than rule, allow user ID zero or IDs strictly below the configured threshold.
CheckLessThanRule   ldd       <CallerUserId,u ; recover the caller ID being authorized
                    lbeq      DispatchCommand ; privileged user zero bypasses the upper-bound rule
                    cmpd      ,x        ; compare the caller ID with the configured upper bound
                    lbcs      DispatchCommand ; authorize caller IDs strictly below the threshold
                    bra       DenyAccess ; reject IDs at or above the threshold
* for a greater-than rule, allow user ID zero or IDs strictly above the configured threshold.
CheckGreaterThanRule ldd       <CallerUserId,u ; recover the caller ID being authorized
                    lbeq      DispatchCommand ; privileged user zero bypasses the lower-bound rule
                    cmpd      ,x        ; compare the caller ID with the configured lower bound
                    lbhi      DispatchCommand ; authorize caller IDs strictly above the threshold
                    bra       DenyAccess ; reject IDs at or below the threshold
* for an equality rule, allow user ID zero or an exact threshold match.
CheckEqualRule      ldd       <CallerUserId,u ; recover the caller ID being authorized
                    lbeq      DispatchCommand ; privileged user zero bypasses the equality rule
                    cmpd      ,x        ; compare the caller ID with the required exact value
                    lbeq      DispatchCommand ; authorize an exact caller-ID match
* the access relation failed; report denial and return to the clock/prompt cycle.
DenyAccess          leax      >AccessDeniedMessage,pc ; select the policy-denial message
                    ldy       #200      ; let I$WritLn locate the denial message's CR within this bound
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain why the option was not dispatched
                    puls      b         ; discard the saved entry index
                    lbra      CheckSessionTime ; return to the timed prompt loop
* fork shell for an ordinary command record and wait for the child before redisplaying the menu.
RunShellCommand     ldy       <CommandLength,u ; pass the record's cached CR-inclusive length
                    leax      >ShellName,pc ; execute ordinary records through shell
                    ldb       #3        ; preserve the original child memory-page request
                    lda       #17       ; preserve the original child language/type byte
                    os9       F$Fork    ; give the selected record to the child as its parameters
                    puls      u         ; recover the module data pointer
                    bcc       WaitForCommand ; wait normally when shell was forked successfully
                    os9       F$PErr    ; print the child-creation error held in B
WaitForCommand      os9       F$Wait    ; keep the menu synchronous with the selected command
                    lbra      CheckSessionTime ; enforce time again when the child returns
* chmd: change the process data directory using the pathname after the four-byte verb.
ChangeDataDirectory tfr       u,x       ; retain the selected record after restoring workspace U
                    puls      u         ; recover the module data pointer
                    leax      4,x       ; skip CHMD and select its pathname
                    lda       #1        ; select data-directory mode
                    os9       I$ChgDir  ; change the directory named at X using mode A
                    lbra      ReloadMenuConfig ; reopen configuration relative to the new data directory
* chmx: change the process execution directory using the pathname after the four-byte verb.
ChangeExecDirectory tfr       u,x       ; retain the selected record after restoring workspace U
                    puls      u         ; recover the module data pointer
                    leax      4,x       ; skip CHMX and select its pathname
                    lda       #4        ; select execution-directory mode
                    os9       I$ChgDir  ; change the directory named at X using mode A
                    lbra      ReloadMenuConfig ; reopen configuration after changing execution context
* chmm: parse replacement menu/command filenames and reload them without growing the stack.
ChangeMenu          tfr       u,x       ; retain the selected record after restoring workspace U
                    puls      u         ; recover the module data pointer
                    leay      <MenuFilename,u ; overwrite the current menu pathname first
                    leax      4,x       ; skip CHMM and select its two pathname arguments
SkipSubmenuSpaces   lda       ,x+       ; consume padding after the pseudo-command
                    cmpa      #C$SPAC   ; recognize another leading space
                    beq       SkipSubmenuSpaces ; continue skipping leading spaces
                    leax      -1,x      ; include the first nonspace in the pathname copy
CopySubmenuMenuName lda       ,x+       ; consume the next menu-path byte
                    sta       ,y+       ; append it to MenuFilename
                    cmpa      #C$SPAC   ; the next space separates the two pathnames
                    bne       CopySubmenuMenuName ; copy the complete menu pathname
                    lda       #C$CR     ; convert that separator to an OS-9 terminator
                    sta       -1,y      ; finish the replacement menu pathname
                    leay      <CommandFilename,u ; overwrite the definition pathname next
CopySubmenuCommandName lda       ,x+       ; consume the next definition-path byte
                    sta       ,y+       ; append it to CommandFilename
                    cmpa      #C$CR     ; retain the command record's final terminator
                    bne       CopySubmenuCommandName ; copy through the complete pathname
                    lbra      ReloadMenuConfig ; compile and display the selected submenu
* exit successfully for the EX pseudo-command or an explicit command-table exit.
ExitSuccess         clrb                ; report a successful menu exit
                    os9       F$Exit    ; return control to the invoking process
* report command syntax when either required filename is absent.
ShowUsage           leax      >UsageMessage,pc ; select the two-line invocation guide
                    ldy       #200      ; let I$WritLn locate the usage text's final CR within this bound
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain the two required pathname arguments
                    clrb                ; treat malformed invocation as a clean exit
* common fatal exit: B already contains the OS-9 error status when applicable.
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

* Enable the SCF behavior required by Menu and by commands forked from it.
InitializeTerminalInput
                    pshs      y,x,d     ; preserve the caller's startup registers
                    leax      >TerminalOptions,u ; select the local terminal-option packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt terminal options
                    os9       I$GetStt  ; copy the current path options into the packet
                    bcs       InitializeTerminalDone ; tolerate stdin paths that are not SCF devices
                    lda       #1        ; select the enabled value for both options
                    sta       PD.EKO-PD.OPT,x ; make typed menu selections visible
                    sta       PD.ALF-PD.OPT,x ; advance after echoed carriage returns
                    leax      >TerminalOptions,u ; resubmit the modified packet
                    clra                ; update standard input
                    clrb                ; select SS.Opt terminal options
                    os9       I$SetStt  ; install the interactive input settings
InitializeTerminalDone
                    puls      pc,y,x,d  ; restore the caller and continue

* parse the first decimal digit run in the six-byte access prefix.
* the reverse pass accumulates digit * place into a 16-bit result; carry is not accepted.
ParsePriority       pshs      y         ; preserve the caller's access-record cursor
FindFirstPriorityDigit lda       ,x+       ; scan for the first decimal digit
                    cmpa      #C$CR     ; reject a prefix that ends before any digit
                    lbeq      InvalidPriority ; report a priority prefix containing no decimal digit
                    cmpa      #'0'      ; skip bytes below the decimal range
                    bcs       FindFirstPriorityDigit ; ignore a non-digit below ASCII '0'
                    cmpa      #'9'      ; skip bytes above the decimal range
                    bhi       FindFirstPriorityDigit ; continue within the fixed-width prefix
                    leax      -1,x      ; include this first digit in the run scan
FindPriorityDigitEnd lda       ,x+       ; advance through the contiguous decimal run
                    cmpa      #'0'      ; a lower byte marks its end
                    bcs       InitializePriorityParse ; begin conversion after the last digit in the run
                    cmpa      #'9'      ; a higher byte also marks its end
                    bhi       InitializePriorityParse ; begin conversion after the digit run
                    bra       FindPriorityDigitEnd ; consume another decimal digit
InitializePriorityParse pshs      x         ; preserve the source position following the threshold
                    leax      -1,x      ; prepare for predecrement reverse reads
                    clr       PriorityValue,u ; clear the high byte of the 16-bit conversion result
                    clr       PriorityValue+1,u ; clear the low byte of the 16-bit conversion result
                    ldd       #1        ; begin with the units-place multiplier
                    std       DecimalPlace,u ; initialize the decimal place value to one
ParsePriorityDigit  lda       ,-x       ; walk the digit run from right to left
                    cmpa      #'0'      ; stop before a byte below the decimal range
                    bcs       ReturnPriorityValue ; finish when the reverse scan passes the first digit
                    cmpa      #'9'      ; stop before a byte above the decimal range
                    bhi       ReturnPriorityValue ; return the completed threshold
                    suba      #'0'      ; convert ASCII to a binary digit
                    sta       DecimalCounter,u ; use the digit value as a repeated-add counter
                    ldd       #0        ; start this digit's weighted contribution at zero
MultiplyDigitByPlace tst       DecimalCounter,u ; test whether every digit unit has been added
                    beq       AccumulatePriorityDigit ; add the finished digit contribution to the result
                    addd      DecimalPlace,u ; add one copy of the current place value
                    dec       DecimalCounter,u ; count one multiplication-by-addition step
                    bra       MultiplyDigitByPlace ; complete digit times place value
AccumulatePriorityDigit addd      PriorityValue,u ; accumulate this digit times its decimal place value
                    std       PriorityValue,u ; retain the growing 16-bit threshold result
                    lda       #10       ; multiply the place value by decimal radix ten
                    sta       DecimalCounter,u ; count ten additions of the current place value
                    ldd       #0        ; start the next place-value product at zero
MultiplyPlaceByTen  tst       DecimalCounter,u ; test whether all ten copies were added
                    beq       StoreNextDecimalPlace ; save the completed power-of-ten multiplier
                    addd      DecimalPlace,u ; add another copy of the current place value
                    dec       DecimalCounter,u ; count one of the ten place-value additions
                    bra       MultiplyPlaceByTen ; complete place value times ten
StoreNextDecimalPlace std       DecimalPlace,u ; use the product as the next digit's place multiplier
                    bra       ParsePriorityDigit ; consume the digit to the left
ReturnPriorityValue ldd       PriorityValue,u ; return the completed 16-bit threshold in D
                    puls      x         ; recover the caller-visible end of the threshold text
                    puls      pc,y      ; preserve the caller's access-table cursor on return
* byte-encoded decimal formatter preserved from the original image.
* it writes five zero-padded digits plus CR: for divisors 10000, 1000,
* 100, 10, and 1, a shared subtract loop increments the current ASCII
* digit, retains the remainder, advances X, and processes the next place.
* no visible source path calls this island; it may be retained library code.
                    fcb       $ED
                    fcb       $4B
                    fcb       $86
                    fcb       $30
                    fcb       $A7
                    fcb       $84
                    fcb       $A7
                    fcb       $01
                    fcb       $A7
                    fcb       $02
                    fcb       $A7
                    fcb       $03
                    fcb       $A7
                    fcb       $04
                    fcb       $CC
                    fcb       $27
                    fcb       $10
                    fcb       $ED
                    fcb       $4D
                    fcb       $EC
                    fcb       $4B
                    fcb       $17
                    fcb       $00
                    fcb       $29
                    fcb       $CC
                    fcb       $03
                    fcb       $E8
                    fcb       $ED
                    fcb       $4D
                    fcb       $EC
                    fcb       $4B
                    fcb       $8D
                    fcb       $20
                    fcb       $CC
                    fcb       $00
                    fcb       $64
                    fcb       $ED
                    fcb       $4D
                    fcb       $EC
                    fcb       $4B
                    fcb       $8D
                    fcb       $17
                    fcb       $CC
                    fcb       $00
                    fcb       $0A
                    fcb       $ED
                    fcb       $4D
                    fcb       $EC
                    fcb       $4B
                    fcb       $8D
                    fcb       $0E
                    fcb       $CC
                    fcb       $00
                    fcb       $01
                    fcb       $ED
                    fcb       $4D
                    fcb       $EC
                    fcb       $4B
                    fcb       $8D
                    fcb       $05
                    fcb       $86
                    fcb       $0D
                    fcb       $A7
                    fcb       $84
                    fcb       $39
                    fcb       $A3
                    fcb       $4D
                    fcb       $25
                    fcb       $04
                    fcb       $6C
                    fcb       $84
                    fcb       $20
                    fcb       $F8
                    fcb       $E3
                    fcb       $4D
                    fcb       $ED
                    fcb       $4B
                    fcb       $30
                    fcb       $01
                    fcb       $39
* reject an access prefix that contains no decimal digit before CR.
InvalidPriority     leax      >InvalidPriorityMessage,pc ; select the malformed-rule diagnostic
                    ldy       #200      ; let I$WritLn locate the error message's CR within this bound
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; identify a definition file with no numeric threshold
                    lda       #1        ; return the command's historical nonzero status
                    lbra      ExitWithStatus ; abort menu compilation

                    emod
eom                 equ       *
                    end
