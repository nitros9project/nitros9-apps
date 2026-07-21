**********************************************************************
* Menu - OS-9 Level 2 BBS command
*
* Syntax: Menu <menu-file> <command-file>
* Purpose: Display a menu, enforce priority prefixes, and dispatch the selected command.
* Menu navigation is implemented through commands and directory changes.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

*
* Internal operation
* ------------------
* OS-9 supplies X as the parameter-string pointer, Y as its end, and U as
* this module's data-area base.  The first argument names the menu text file;
* the second names a command-definition file.  Both names are copied into
* CR-terminated workspace buffers before either file is opened.
*
* BBS.userstats is scanned as fixed 32-byte records until the record whose
* leading word matches the caller's OS-9 user ID.  A zero session allowance
* means no deadline.  Otherwise the allowance is added to the record's saved
* date/time with minute, hour, day, month, and year carry propagation.  The
* resulting six-byte deadline is compared with F$Time before every prompt;
* expired callers are disconnected and callers within five minutes receive
* a warning.
*
* The command-definition file is compiled into three parallel tables with at
* most 40 entries: one selection key, one three-byte access rule, and one
* fixed 80-byte command record.  Ordinary entries receive the unrestricted
* rule '-,$FFFF'.  Entries beginning with '<', '>', or '=' parse a decimal
* user-ID threshold before the actual selection key.  A '/' record terminates
* the table and supplies the prompt line displayed after the menu text.
*
* The selected key is folded to uppercase and looked up in the key table.
* User ID zero bypasses all access checks.  Other users must satisfy the
* entry's unsigned <, >, or = relation or receive the denial message.  A
* normal command is passed to a child shell.  EX exits.  CHMD and CHMX change
* the data or execution directory, while CHMM replaces both filenames and
* reloads another menu, providing submenu navigation without recursion.
*
* Menu output is streamed from the in-memory file image.  I$GetStt polling
* lets a pending keystroke interrupt a long display.  CR-delimited chunks use
* I$WritLn; a final unterminated chunk uses I$Write.  This preserves authored
* menu line endings while avoiding one OS-9 write per character.

                    nam       menu
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

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
CallerUserId        rmb       2         ; OS-9 user ID returned in Y by F$ID
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
MenuFilename        rmb       32        ; CR-terminated menu-text filename from argument one
CommandFilename     rmb       32        ; CR-terminated command-definition filename from argument two
AccessPrefixScratch rmb       6         ; fixed-width access-relation and decimal-threshold prefix
AccessScratchPad    rmb       200       ; unused separation before the compiled parallel tables
SelectionKeyTable   rmb       40        ; 40-byte table of uppercase selection keys
AccessRuleTable     rmb       120       ; 40 access records: relation byte plus 16-bit user ID
CommandRecordTable  rmb       3200      ; 40 command records of 80 bytes each
PromptPrefix        rmb       2         ; LF/CR prefix immediately before the prompt buffer
PromptBuffer        rmb       80        ; 80-byte prompt line from the command-definition terminator
MenuImage           rmb       4450      ; storage for the in-memory menu text and trailing spare bytes
size                equ       .

name                fcs       /menu/ ; OS-9 module name followed by the original copyright payload
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved"
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
MonthLengths        fcb       $1F       ; month-length table used while carrying a deadline across dates
                    fcb       $1C
                    fcb       $1F
                    fcb       $1E
                    fcb       $1F
                    fcb       $1E
                    fcb       $1F
                    fcb       $1F
                    fcb       $1E
                    fcb       $1F
                    fcb       $1E
                    fcb       $1F
* Entry: preserve OS-9 startup registers while obtaining the caller user ID.
* Then split the parameter block into menu and command filenames.
start               pshs      u,y,x,d   ; preserve the startup parameter and data-area registers across F$ID
                    os9       F$ID      ; obtain the current process and OS-9 user IDs
                    sty       <CallerUserId,u ; save Y as OS-9 user ID returned in Y by F$ID
                    puls      u,y,x,d   ; restore u,y,x,d
                    lda       #1        ; default to unlimited if user statistics are absent or unreadable
                    sta       <UnlimitedSession,u ; enable the explicit deadline bypass until a limit is found
                    ldd       #2573     ; seed the prompt prefix with LF followed by CR ($0A0D)
                    std       >PromptPrefix,u ; save D as LF/CR prefix immediately before the prompt buffer
                    sty       ArgumentEnd,u ; retain the parameter-block end address for bounds checks
                    leay      <MenuFilename,u ; point Y at CR-terminated menu-text filename from argument one
* Copy argument one until its separating space, then replace that space with CR.
CopyMenuFilename    lda       ,x+       ; a = the next source byte, advancing X
                    cmpx      ArgumentEnd,u ; detect a missing separator before the end of the parameter block
                    lbhi      ShowUsage ; when the unsigned value is greater show command syntax
                    sta       ,y+       ; append this byte to the menu-filename buffer
                    cmpa      #32       ; test for the space separating the two filenames
                    bne       CopyMenuFilename ; while the compared values differ continue copying the first filename
                    lda       #13       ; replace the separating space with an OS-9 pathname terminator
                    sta       -$01,y    ; terminate the copied menu filename with CR
                    leay      <CommandFilename,u ; point Y at CR-terminated command-definition filename from argument two
* Copy argument two through its terminating CR.
CopyCommandFilename lda       ,x+       ; a = the next source byte, advancing X
                    cmpx      ArgumentEnd,u ; reject a second filename that runs past the supplied parameters
                    lbhi      ShowUsage ; when the unsigned value is greater show command syntax
                    sta       ,y+       ; append this byte to the command-filename buffer
                    cmpa      #13       ; stop after copying the pathname terminator
                    bne       CopyCommandFilename ; while the compared values differ continue copying the second filename
                    leax      >UserStatsName,pc ; point X at absolute path of the fixed-size user statistics database
                    lda       #1        ; request read access to the user-statistics database
                    os9       I$Open    ; open the pathname in X with access mode A
                    lbcs      ReloadMenuConfig ; continue without enforcing a deadline if userstats cannot be opened
                    sta       UserStatsPath,u ; save A as path number for the open BBS.userstats file
* Scan 32-byte user-statistics records for the caller user ID.
ScanUserRecord      leax      <UserStatsRecord,u ; point X at 32-byte BBS.userstats record begins here
                    ldy       #32       ; read exactly one fixed-size user-statistics record
                    lda       UserStatsPath,u ; a = path number for the open BBS.userstats file
                    os9       I$Read    ; read at most Y bytes from path A into X
                    bcs       CloseUserStats ; stop scanning when EOF or a read error prevents another record
                    ldd       <CallerUserId,u ; d = OS-9 user ID returned in Y by F$ID
                    cmpd      <UserStatsRecord,u ; match the caller's user ID against the record's leading word
                    bne       ScanUserRecord ; while the compared values differ read the next user record
                    bra       CalculateDeadline ; unconditionally process the matching user record
CloseUserStats      lda       UserStatsPath,u ; a = path number for the open BBS.userstats file
                    os9       I$Close   ; close path A
                    lbra      ReloadMenuConfig ; unconditionally reload the selected menu
* A matching user record was found.  Add its session allowance to the stored login time.
* Carry overflow through hour/day/month/year and copy the normalized deadline aside.
CalculateDeadline   ldd       <SessionAllowance,u ; d = user-record tail containing the session-minute allowance
                    cmpd      #0        ; a zero-minute allowance denotes an unrestricted session
                    lbeq      ReloadMenuConfig ; retain the explicit unlimited-session state
                    clr       <UnlimitedSession,u ; enforce the nonzero allowance as a real deadline
                    ldb       <SessionMinute,u ; b = user-record tail; first bytes hold deadline minute/second
                    clra                ; zero the deadline calculation accumulator/state before reuse
                    addd      <SessionAllowance,u ; add user-record tail containing the session-minute allowance while computing deadline calculation
                    cmpd      #60       ; determine whether the accumulated minutes carry into another hour
                    bcs       StoreDeadlineMinute ; minutes below 60 need no calendar carry
CarryDeadlineHour   subd      #60       ; retain the minute remainder after carrying one hour
                    pshs      d         ; retain the remaining minutes while calendar fields are advanced
                    lda       <SessionHour,u ; a = deadline hour while the user record is normalized
                    inca                ; carry one hour into the stored login hour
                    cmpa      #24       ; carry midnight into the next calendar day
                    bcs       StoreDeadlineHour ; an hour below 24 completes this carry
                    clr       <SessionHour,u ; zero the deadline calculation accumulator/state before reuse
                    lda       <SessionDay,u ; a = deadline day while the user record is normalized
                    inca                ; carry midnight into the stored login day
                    leax      >MonthLengths,pc ; point X at month-length table used while carrying a deadline across dates
                    ldb       <SessionMonth,u ; b = deadline month while the user record is normalized
                    decb                ; convert the one-based month to a zero-based table index
                    leax      b,x       ; select that month's maximum day
                    cmpa      ,x        ; compare the incremented day with this month's length
                    bls       StoreDeadlineDay ; the month's final valid day does not carry into the next month
                    lda       #1        ; wrap the day to the first of the next month
                    sta       <SessionDay,u ; save A as deadline day while the user record is normalized
                    lda       <SessionMonth,u ; a = deadline month while the user record is normalized
                    inca                ; carry the date into the following month
                    cmpa      #12       ; carry a month beyond December into the next year
                    bls       StoreDeadlineMonth ; december remains a valid month rather than wrapping early
                    lda       #1        ; wrap the month to January
                    sta       <SessionMonth,u ; save A as deadline month while the user record is normalized
                    lda       <SessionYear,u ; a = deadline year while the user record is normalized
                    inca                ; carry December into the following year
StoreDeadlineYear   sta       <SessionYear,u ; save A as deadline year while the user record is normalized
                    bra       ContinueMinuteCarry ; unconditionally finish this time-field carry
StoreDeadlineMonth  sta       <SessionMonth,u ; save A as deadline month while the user record is normalized
                    bra       ContinueMinuteCarry ; unconditionally finish this time-field carry
StoreDeadlineDay    sta       <SessionDay,u ; save A as deadline day while the user record is normalized
                    bra       ContinueMinuteCarry ; unconditionally finish this time-field carry
StoreDeadlineHour   sta       <SessionHour,u ; save A as deadline hour while the user record is normalized
ContinueMinuteCarry puls      d         ; restore d
                    cmpd      #60       ; repeat while at least one more hour remains to carry
                    bcc       CarryDeadlineHour ; carry each additional block of 60 allowance minutes
StoreDeadlineMinute stb       <SessionMinute,u ; store the normalized deadline minute
                    lda       #6        ; copy year through second into the private deadline fields
                    leax      <SessionYear,u ; point X at deadline year while the user record is normalized
                    leay      <DeadlineDate,u ; point Y at computed deadline date: year, month, day
CopyDeadline        ldb       ,x+       ; b = the next source byte, advancing X
                    stb       ,y+       ; copy one normalized deadline field
                    deca                ; count down the six deadline bytes
                    bne       CopyDeadline ; while the compared values differ copy the six-byte deadline
                    bra       ReloadMenuConfig ; unconditionally reload the selected menu
* Load or reload the command-definition file and reset all three compiled-table cursors.
* Submenu selection returns here after replacing both filenames.
ReloadMenuConfig    leax      >SelectionKeyTable,u ; point X at 40-byte table of uppercase selection keys
                    stx       KeyTableCursor,u ; reset the selection-key insertion cursor
                    leax      >CommandRecordTable,u ; point X at 40 command records of 80 bytes each
                    stx       CommandTableCursor,u ; reset the command-record insertion cursor
                    leax      >AccessRuleTable,u ; point X at 40 access records: relation byte plus 16-bit user ID
                    stx       AccessTableCursor,u ; reset the access-record insertion cursor
                    leax      <CommandFilename,u ; point X at CR-terminated command-definition filename from argument two
                    lda       #1        ; open the command-definition file for reading
                    os9       I$Open    ; open the pathname in X with access mode A
                    lbcs      ExitWithStatus ; propagate a command-definition open error to the caller
                    sta       CommandFilePath,u ; save A as path number for the open command-definition file
* Read one command key/prefix byte and classify it as terminator, access rule, or ordinary key.
CompileNextEntry    ldx       KeyTableCursor,u ; address the next free key-table slot
                    ldy       #1        ; read the next key or access-relation marker
                    os9       I$Read    ; read at most Y bytes from path A into X
                    ldb       ,x        ; b = the byte currently addressed by X
                    cmpb      #47       ; slash ends the entry list and introduces the prompt line
                    beq       FinishCommandTable ; finish compiling entries when the slash terminator is reached
                    cmpb      #62       ; greater-than introduces a minimum-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '>' relation
                    cmpb      #60       ; less-than introduces a maximum-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '<' relation
                    cmpb      #61       ; equals introduces an exact-user-ID rule
                    lbeq      CompileAccessRule ; parse the numeric threshold following the '=' relation
                    ldy       AccessTableCursor,u ; y = cursor into the 40 three-byte access-rule records
                    pshs      d         ; preserve the selection key while synthesizing an unrestricted rule
                    lda       #45       ; use '-' as the relation for an unrestricted command
                    sta       ,y+       ; store the unrestricted relation and advance to its threshold
                    ldd       #-1       ; retain $FFFF as the unused unrestricted threshold
                    std       ,y++      ; complete the three-byte access record
                    puls      d         ; restore d
                    sty       AccessTableCursor,u ; retain the next free access-record address
NormalizeEntryKey   cmpb      #97       ; only bytes at or above lowercase 'a' need case folding
                    bcs       ReadCommandRecord ; leave non-lowercase key bytes unchanged
                    andb      #223      ; fold a lowercase selection key to uppercase ASCII
                    stb       ,x        ; replace the compiled key with its uppercase form
ReadCommandRecord   leax      $01,x     ; advance past the compiled selection key
                    stx       KeyTableCursor,u ; advance the key-table cursor to the next slot
                    ldx       CommandTableCursor,u ; address the next free 80-byte command record
                    ldy       #80       ; cap each shell command record at 80 bytes
                    os9       I$ReadLn  ; read one CR-terminated command line into X
                    lbcs      ExitWithStatus ; propagate a malformed or unreadable command line
                    sty       <$004E,x  ; retain the line length in the final word of this record
                    leax      <$0050,x  ; advance to the next 80-byte command record
                    stx       CommandTableCursor,u ; preserve the advanced command-table cursor
                    bra       CompileNextEntry ; unconditionally compile the next command entry
* The slash terminator ends command compilation.  Read its prompt line, close the command file,
* load the entire menu-text file, and remember both its length and end address.
FinishCommandTable  leax      >PromptBuffer,u ; point X at 80-byte prompt line from the command-definition terminator
                    ldy       #80       ; accept an 80-byte prompt line after the slash terminator
                    os9       I$ReadLn  ; read one CR-terminated command line into X
                    lbcs      ExitWithStatus ; propagate an unreadable prompt line
                    sty       <PromptLength,u ; save Y as length of the prompt line read after the slash terminator
                    ldx       KeyTableCursor,u ; address the first unused key-table slot
                    lda       #255      ; use a negative byte as the end-of-key-table sentinel
                    sta       ,x        ; terminate the compiled selection-key table
                    lda       CommandFilePath,u ; a = path number for the open command-definition file
                    os9       I$Close   ; close path A
                    lbcs      ExitWithStatus ; propagate a command-definition close error
                    leax      <MenuFilename,u ; point X at CR-terminated menu-text filename from argument one
                    lda       #1        ; open the selected menu-text file for reading
                    os9       I$Open    ; open the pathname in X with access mode A
                    lbcs      ExitWithStatus ; propagate a menu-file open error
                    sta       MenuFilePath,u ; save A as path number for the open menu-text file
                    leax      >MenuImage,u ; point X at first byte of the in-memory menu-text image
                    ldy       #4000     ; reserve at most 4000 bytes for the displayed menu image
                    lda       MenuFilePath,u ; a = path number for the open menu-text file
                    os9       I$Read    ; read at most Y bytes from path A into X
                    sty       <MenuBytesRemaining,u ; save Y as remaining menu-image byte count (word; following bytes spare)
                    lbcs      ExitWithStatus ; propagate a menu-file read error
                    os9       I$Close   ; close path A
                    stx       MenuImageStart,u ; remember the beginning of the loaded menu image
                    tfr       y,d       ; move the loaded byte count into an indexable register pair
                    leax      d,x       ; compute the address immediately beyond the loaded menu
                    stx       MenuImageEnd,u ; remember the address immediately beyond the menu image
                    ldx       MenuImageStart,u ; restart X at the first menu byte
                    ldy       #1        ; prepare the one-byte pending-input status request
* Stream the menu image to standard output.  Stop early if I$GetStt reports pending input;
* otherwise emit one CR-delimited line at a time and advance the remaining-byte count.
DisplayNextChunk    pshs      x         ; save the start of this candidate output chunk
                    lda       #1        ; query standard input
                    ldb       #1        ; request the ready-character status function
                    os9       I$GetStt  ; test whether standard input already has a pending byte
                    lbcc      ReadSelection ; interrupt menu display when a selection byte is already pending
                    ldy       <MenuBytesRemaining,u ; y = remaining menu-image byte count (word; following bytes spare)
                    ldx       ,s        ; restart the line scan at the saved chunk address
FindMenuLineEnd     lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      #13       ; find the CR ending the next complete display line
                    beq       WriteMenuLine ; emit a line when its terminating CR is found
                    leay      -$01,y    ; point Y at -$01,y
                    bne       FindMenuLineEnd ; while the compared values differ scan for a carriage return
                    puls      x         ; restore x
                    lda       #1        ; write the final unterminated fragment to standard output
                    ldy       <MenuBytesRemaining,u ; y = remaining menu-image byte count (word; following bytes spare)
                    os9       I$Write   ; write the unterminated menu fragment at X
                    bra       AdvanceMenuCursor ; unconditionally account for emitted menu bytes
WriteMenuLine       puls      x         ; restore x
                    lda       #1        ; write the complete line to standard output
                    ldy       <MenuBytesRemaining,u ; y = remaining menu-image byte count (word; following bytes spare)
                    os9       I$WritLn  ; write one CR-terminated line from X
AdvanceMenuCursor   lbcs      ExitWithStatus ; when carry reports lower/error leave with the current status
                    pshs      y         ; retain the count actually written for pointer and length updates
                    ldd       <MenuBytesRemaining,u ; d = remaining menu-image byte count (word; following bytes spare)
                    subd      ,s        ; subtract the temporary word at the top of the stack while computing menu display
                    std       <MenuBytesRemaining,u ; save D as remaining menu-image byte count (word; following bytes spare)
                    cmpd      #0        ; stop when all loaded menu bytes have been emitted
                    ble       MenuDisplayComplete ; when the signed value is less or equal finish menu display
                    puls      d         ; restore d
                    leax      d,x       ; advance X by the number of bytes just written
                    lda       #1        ; query standard input between menu lines
                    ldb       #1        ; request the ready-character status function
                    os9       I$GetStt  ; test whether standard input already has a pending byte
                    lbcc      ReadSelection ; stop redisplay as soon as the caller types a selection
                    cmpx      MenuImageEnd,u ; guard against advancing beyond the loaded menu image
                    bhi       MenuDisplayComplete ; when the unsigned value is greater finish menu display
                    bra       DisplayNextChunk ; unconditionally emit the next menu chunk
MenuDisplayComplete lbra      CheckSessionTime ; unconditionally recheck the session clock
* Compile an access-controlled entry.  The six following bytes contain the decimal threshold;
* the next byte is the actual selection key stored beside the parsed 16-bit value.
CompileAccessRule   pshs      x,a       ; retain the key slot and command-file path during threshold parsing
                    ldy       AccessTableCursor,u ; y = cursor into the 40 three-byte access-rule records
                    stb       ,y+       ; store the relation byte at the start of this access record
                    leax      >AccessPrefixScratch,u ; point X at six-byte access-prefix input scratch
                    pshs      y         ; retain the access-record threshold destination across the parser
                    ldy       #6        ; read the fixed-width decimal threshold field
                    os9       I$Read    ; read at most Y bytes from path A into X
                    leax      >AccessPrefixScratch,u ; point X at six-byte access-prefix input scratch
                    lbsr      ParsePriority ; convert the first decimal run in the prefix to a 16-bit threshold
                    puls      y         ; restore y
                    std       ,y++      ; store the threshold after its relation byte
                    sty       AccessTableCursor,u ; retain the next free access-record address
                    puls      x,a       ; restore x,a
                    ldy       #1        ; read the selection key following the access prefix
                    os9       I$Read    ; read at most Y bytes from path A into X
                    ldb       ,x        ; b = the byte currently addressed by X
                    lbra      NormalizeEntryKey ; unconditionally normalize the selection key
* Disconnect the caller after reporting that the session deadline has expired.
SessionExpired      leax      >SessionExpiredMessage,pc ; point X at message emitted when the computed session deadline has passed
                    ldy       #200      ; let I$WritLn locate the message's CR within this bound
                    lda       #1        ; write the expiry message to standard output
                    os9       I$WritLn  ; write one CR-terminated line from X
                    lbra      ExitSuccess ; unconditionally exit successfully
* Report the five-minute warning and return to the prompt path.
WarnSessionTime     leax      >SessionWarningMessage,pc ; point X at message emitted when fewer than five minutes remain
                    ldy       #200      ; let I$WritLn locate the message's CR within this bound
                    lda       #1        ; write the warning to standard output
                    os9       I$WritLn  ; write one CR-terminated line from X
                    rts                 ; return after completing warning handling
* Unlimited sessions bypass wall-clock checks entirely.  Limited sessions compare
* the current clock lexicographically with the six-byte session deadline.
* Only hour/minute/second differences need the five-minute warning calculation.
CheckSessionTime    tst       <UnlimitedSession,u ; determine whether this caller has a finite daily allowance
                    lbne      WritePrompt ; never manufacture a deadline for an unlimited caller
                    leax      <CurrentDate,u ; point X at current date from F$Time: year, month, day
                    os9       F$Time    ; read the six-byte system date and time
                    ldb       #6        ; compare all six date/time fields lexicographically
                    leax      <CurrentDate,u ; point X at current date from F$Time: year, month, day
                    leay      <DeadlineDate,u ; point Y at computed deadline date: year, month, day
CompareDeadlineFields lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      ,y+       ; compare the next current-time field with its deadline field
                    lbhi      SessionExpired ; when the unsigned value is greater report session expiry
                    bcs       CheckWarningWindow ; a current field below its deadline cannot yet be expired
                    decb                ; count one successfully matched date/time field
                    bne       CompareDeadlineFields ; while the compared values differ compare the next deadline byte
CheckWarningWindow  cmpb      #3        ; only a difference in hour/minute/second can be within five minutes
                    bgt       WritePrompt ; when the signed value is greater display the prompt
                    ldd       <CurrentTime,u ; d = current time from F$Time: hour, minute, second
                    addb      #5        ; form the minute value five minutes from now
                    cmpb      #60       ; carry a minute value past 59 into the hour
                    bcs       CompareWarningDeadline ; minute plus five still lies within the current hour
                    subb      #60       ; retain the minute remainder after the hour carry
                    inca                ; carry the five-minute window into the next hour
                    cmpa      #24       ; wrap an hour past 23 to midnight
                    bcs       CompareWarningDeadline ; the warning window does not cross midnight
                    clra                ; zero the session-time check accumulator/state before reuse
CompareWarningDeadline cmpd      <DeadlineTime,u ; warn only when now plus five minutes passes the deadline time
                    bls       WritePrompt ; when the unsigned value is lower or equal display the prompt
                    bsr       WarnSessionTime ; report the five-minute warning
WritePrompt         leax      >PromptBuffer,u ; point X at 80-byte prompt line from the command-definition terminator
                    ldy       <PromptLength,u ; y = length of the prompt line read after the slash terminator
                    leay      -$01,y    ; point Y at -$01,y
                    lda       #1        ; write the prompt text to standard output
                    os9       I$Write   ; write the unterminated menu fragment at X
* Read one selection byte, echo prompt spacing, fold lowercase ASCII to uppercase, and search the key table.
ReadSelection       leax      SelectionChar,u ; point X at one-byte menu selection read from standard input
                    ldy       #1        ; accept exactly one menu-selection byte
                    clra                ; select standard input path zero
                    os9       I$Read    ; read at most Y bytes from path A into X
                    ldy       #2        ; emit the two leading LF bytes plus the following CR via I$WritLn
                    lda       #1        ; write the prompt spacing to standard output
                    pshs      x         ; retain the input-byte address while writing prompt spacing
                    leax      >PromptSpacing,pc ; point X at two blank lines emitted before each selection prompt
                    os9       I$WritLn  ; write one CR-terminated line from X
                    puls      x         ; restore x
                    lda       ,x        ; a = the byte currently addressed by X
                    cmpa      #63       ; question mark requests a full menu reload
                    lbeq      ReloadMenuConfig ; redisplay and rebuild the menu when '?' is selected
                    cmpa      #97       ; preserve punctuation and already-uppercase keys
                    bcs       BeginKeySearch ; search punctuation and uppercase selections without modification
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    sta       ,x        ; replace the typed selection with its uppercase form
BeginKeySearch      lda       ,x        ; a = the byte currently addressed by X
                    leax      >SelectionKeyTable,u ; point X at 40-byte table of uppercase selection keys
                    clrb                ; start with key-table index zero
* Search at most 40 compiled key entries; a negative sentinel restarts the time/prompt cycle.
SearchNextKey       tst       ,x        ; test for the key lookup sentinel without changing the byte
                    lbmi      CheckSessionTime ; when the sentinel/high bit is set recheck the session clock
                    cmpa      ,x+       ; compare the requested key and advance to the next compiled entry
                    beq       CheckAccessRule ; authorize the access record at the matching table index
                    incb                ; advance the key-table index used by the parallel tables
                    cmpb      #40       ; enforce the command table's 40-entry capacity
                    bls       SearchNextKey ; when the unsigned value is lower or equal inspect the next key-table entry
                    lbra      CheckSessionTime ; unconditionally recheck the session clock
* The key matched.  Locate its three-byte access record and test the relation byte.
* An unrestricted entry falls directly into dispatch; user ID zero bypasses every relation.
CheckAccessRule     pshs      b         ; preserve the matched index for parallel command-table lookup
                    lda       #3        ; each access record occupies relation plus 16-bit threshold
                    mul                 ; form the table offset required for authorization
                    leax      >AccessRuleTable,u ; point X at 40 access records: relation byte plus 16-bit user ID
                    leax      d,x       ; address the access record parallel to the matched key
                    lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      #60       ; dispatch '<' records to the upper-bound test
                    beq       CheckLessThanRule ; apply the less-than access rule
                    cmpa      #62       ; dispatch '>' records to the lower-bound test
                    beq       CheckGreaterThanRule ; apply the greater-than access rule
                    cmpa      #61       ; dispatch '=' records to the exact-match test
                    beq       CheckEqualRule ; apply the equality access rule
* Dispatch the selected 80-byte command record.  Recognize CHM directory/submenu controls first,
* then EX, otherwise fork a shell with the record text as its parameter block.
DispatchCommand     puls      b         ; recover the matching key-table index
                    lda       #80       ; convert the selected index into an 80-byte record offset
                    mul                 ; form the table offset required for command dispatch
                    pshs      u         ; preserve the module data pointer while U addresses a command record
                    leau      >CommandRecordTable,u ; make U point at the command-record table
                    leau      d,u       ; make U point at the selected command record
                    lda       CommandVerbFirst,u ; fetch the first command character at record offset one
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    cmpa      #67       ; test for the leading 'C' of a CHM control command
                    bne       CheckExitCommand ; a non-'C' record may still be EX or an ordinary shell command
                    lda       CommandVerbSecond,u ; fetch the second command character
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    cmpa      #72       ; require 'H' as the second character of a CHM verb
                    bne       CheckExitCommand ; a non-CH record may still be EX or an ordinary shell command
                    lda       CommandVerbSelector,u ; fetch the third command character
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    cmpa      #77       ; chmm replaces the menu and command-definition files
                    lbeq      ChangeMenu ; parse the two filenames following CHMM
                    cmpa      #88       ; chmx changes the execution directory
                    lbeq      ChangeExecDirectory ; execute the CHMX directory control command
                    cmpa      #68       ; chmd changes the data directory
                    beq       ChangeDataDirectory ; handle the CHMD control command
CheckExitCommand    lda       CommandVerbFirst,u ; restart at the first command character for the EX test
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    cmpa      #69       ; test for the leading 'E' of the EX pseudo-command
                    bne       RunShellCommand ; a command not beginning with E is passed to shell
                    lda       CommandVerbSecond,u ; fetch the second command character
                    anda      #223      ; fold lowercase ASCII to uppercase by clearing bit 5
                    cmpa      #88       ; an 'X' completes the EX pseudo-command
                    bne       RunShellCommand ; an E command not followed by X is passed to shell
                    lbra      ExitSuccess ; unconditionally exit successfully
* For a less-than rule, allow user ID zero or IDs strictly below the configured threshold.
CheckLessThanRule   ldd       <CallerUserId,u ; d = OS-9 user ID returned in Y by F$ID
                    lbeq      DispatchCommand ; privileged user zero bypasses the upper-bound rule
                    cmpd      ,x        ; compare the caller ID with the configured upper bound
                    lbcs      DispatchCommand ; authorize caller IDs strictly below the threshold
                    bra       DenyAccess ; unconditionally report access denial
* For a greater-than rule, allow user ID zero or IDs strictly above the configured threshold.
CheckGreaterThanRule ldd       <CallerUserId,u ; d = OS-9 user ID returned in Y by F$ID
                    lbeq      DispatchCommand ; privileged user zero bypasses the lower-bound rule
                    cmpd      ,x        ; compare the caller ID with the configured lower bound
                    lbhi      DispatchCommand ; when the unsigned value is greater dispatch the authorized command
                    bra       DenyAccess ; unconditionally report access denial
* For an equality rule, allow user ID zero or an exact threshold match.
CheckEqualRule      ldd       <CallerUserId,u ; d = OS-9 user ID returned in Y by F$ID
                    lbeq      DispatchCommand ; privileged user zero bypasses the equality rule
                    cmpd      ,x        ; compare the caller ID with the required exact value
                    lbeq      DispatchCommand ; authorize an exact caller-ID match
* The access relation failed; report denial and return to the clock/prompt cycle.
DenyAccess          leax      >AccessDeniedMessage,pc ; point X at message shown when the selected access relation fails
                    ldy       #200      ; let I$WritLn locate the denial message's CR within this bound
                    lda       #1        ; write the denial message to standard output
                    os9       I$WritLn  ; write one CR-terminated line from X
                    puls      b         ; restore b
                    lbra      CheckSessionTime ; unconditionally recheck the session clock
* Fork shell for an ordinary command record and wait for the child before redisplaying the menu.
RunShellCommand     ldy       <CommandLength,u ; recover the selected record's parameter-line length from offset $4E
                    leax      >ShellName,pc ; point X at shell module name used for ordinary command dispatch
                    ldb       #3        ; supply the original fork parameter in B
                    lda       #17       ; supply the original shell language/type byte in A
                    os9       F$Fork    ; start shell with the selected command record as parameters
                    puls      u         ; restore u
                    bcc       WaitForCommand ; wait normally when shell was forked successfully
                    os9       F$PErr    ; print the child-creation error held in B
WaitForCommand      os9       F$Wait    ; reap the selected command child
                    lbra      CheckSessionTime ; unconditionally recheck the session clock
* CHMD: change the process data directory using the pathname after the four-byte verb.
ChangeDataDirectory tfr       u,x       ; preserve the selected record address in X
                    puls      u         ; restore u
                    leax      $04,x     ; skip the CHMD verb and point at its pathname
                    lda       #1        ; select data-directory mode
                    os9       I$ChgDir  ; change the directory named at X using mode A
                    lbra      ReloadMenuConfig ; unconditionally reload the selected menu
* CHMX: change the process execution directory using the pathname after the four-byte verb.
ChangeExecDirectory tfr       u,x       ; preserve the selected record address in X
                    puls      u         ; restore u
                    leax      $04,x     ; skip the CHMX verb and point at its pathname
                    lda       #4        ; select execution-directory mode
                    os9       I$ChgDir  ; change the directory named at X using mode A
                    lbra      ReloadMenuConfig ; unconditionally reload the selected menu
* CHMM: parse replacement menu/command filenames and reload them without growing the stack.
ChangeMenu          tfr       u,x       ; preserve the selected record address in X
                    puls      u         ; restore u
                    leay      <MenuFilename,u ; point Y at CR-terminated menu-text filename from argument one
                    leax      $04,x     ; skip the CHMM verb and point at its two pathname arguments
SkipSubmenuSpaces   lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      #32       ; discard spaces before the submenu menu filename
                    beq       SkipSubmenuSpaces ; continue skipping leading spaces
                    leax      -$01,x    ; back up so the first filename character is copied
CopySubmenuMenuName lda       ,x+       ; a = the next source byte, advancing X
                    sta       ,y+       ; append this byte to the replacement menu filename
                    cmpa      #32       ; space separates the submenu's menu and command filenames
                    bne       CopySubmenuMenuName ; while the compared values differ copy the submenu menu filename
                    lda       #13       ; convert the separator into an OS-9 pathname terminator
                    sta       -$01,y    ; terminate the submenu menu filename with CR
                    leay      <CommandFilename,u ; point Y at CR-terminated command-definition filename from argument two
CopySubmenuCommandName lda       ,x+       ; a = the next source byte, advancing X
                    sta       ,y+       ; append this byte to the replacement command filename
                    cmpa      #13       ; copy the command filename through its pathname terminator
                    bne       CopySubmenuCommandName ; while the compared values differ copy the submenu command filename
                    lbra      ReloadMenuConfig ; unconditionally reload the selected menu
* Exit successfully for the EX pseudo-command or an explicit command-table exit.
ExitSuccess         clrb                ; return a successful zero exit status
                    os9       F$Exit    ; terminate Menu with status B
* Report command syntax when either required filename is absent.
ShowUsage           leax      >UsageMessage,pc ; point X at usage text for a missing or malformed parameter list
                    ldy       #200      ; let I$WritLn locate the usage text's final CR within this bound
                    lda       #1        ; write usage text to standard output
                    os9       I$WritLn  ; write one CR-terminated line from X
                    clrb                ; treat malformed invocation as a clean exit
* Common fatal exit: B already contains the OS-9 error status when applicable.
ExitWithStatus      os9       F$Exit    ; terminate Menu with status B
* Parse the first decimal digit run in the six-byte access prefix.
* The reverse pass accumulates digit * place into a 16-bit result; carry is not accepted.
ParsePriority       pshs      y         ; preserve the caller's access-record cursor
FindFirstPriorityDigit lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      #13       ; reject a prefix that reaches CR before any digit
                    lbeq      InvalidPriority ; report a priority prefix containing no decimal digit
                    cmpa      #48       ; skip bytes below ASCII '0'
                    bcs       FindFirstPriorityDigit ; ignore a non-digit below ASCII '0'
                    cmpa      #57       ; skip bytes above ASCII '9'
                    bhi       FindFirstPriorityDigit ; when the unsigned value is greater find the first decimal digit
                    leax      -$01,x    ; restore X to the first decimal digit
FindPriorityDigitEnd lda       ,x+       ; a = the next source byte, advancing X
                    cmpa      #48       ; a byte below '0' terminates the decimal run
                    bcs       InitializePriorityParse ; begin conversion after the last digit in the run
                    cmpa      #57       ; a byte above '9' terminates the decimal run
                    bhi       InitializePriorityParse ; when the unsigned value is greater initialize decimal accumulation
                    bra       FindPriorityDigitEnd ; unconditionally find the end of the decimal run
InitializePriorityParse pshs      x         ; preserve the source position following the numeric field
                    leax      -$01,x    ; point just beyond the last digit for the reverse pass
                    clr       PriorityValue,u ; clear the high byte of the 16-bit conversion result
                    clr       PriorityValue+1,u ; clear the low byte of the 16-bit conversion result
                    ldd       #1        ; begin with the units-place multiplier
                    std       DecimalPlace,u ; initialize the decimal place value to one
ParsePriorityDigit  lda       ,-x       ; a = the previous source digit while walking backward
                    cmpa      #48       ; stop before the digit run when the preceding byte is below '0'
                    bcs       ReturnPriorityValue ; finish when the reverse scan passes the first digit
                    cmpa      #57       ; stop before the digit run when the preceding byte is above '9'
                    bhi       ReturnPriorityValue ; when the unsigned value is greater return the parsed threshold
                    suba      #48       ; convert the ASCII digit to a binary value from zero through nine
                    sta       DecimalCounter,u ; use the digit value as a repeated-add counter
                    ldd       #0        ; start this digit's weighted contribution at zero
MultiplyDigitByPlace tst       DecimalCounter,u ; test for the decimal threshold parsing sentinel without changing the byte
                    beq       AccumulatePriorityDigit ; add the finished digit contribution to the result
                    addd      DecimalPlace,u ; add decimal place multiplier used while parsing a threshold while computing decimal threshold parsing
                    dec       DecimalCounter,u ; count one multiplication-by-addition step
                    bra       MultiplyDigitByPlace ; unconditionally multiply a digit by its decimal place
AccumulatePriorityDigit addd      PriorityValue,u ; accumulate this digit times its decimal place value
                    std       PriorityValue,u ; retain the growing 16-bit threshold result
                    lda       #10       ; multiply the place value by decimal radix ten
                    sta       DecimalCounter,u ; count ten additions of the current place value
                    ldd       #0        ; start the next place-value product at zero
MultiplyPlaceByTen  tst       DecimalCounter,u ; test for the decimal threshold parsing sentinel without changing the byte
                    beq       StoreNextDecimalPlace ; save the completed power-of-ten multiplier
                    addd      DecimalPlace,u ; add decimal place multiplier used while parsing a threshold while computing decimal threshold parsing
                    dec       DecimalCounter,u ; count one of the ten place-value additions
                    bra       MultiplyPlaceByTen ; unconditionally multiply the decimal place by ten
StoreNextDecimalPlace std       DecimalPlace,u ; use the product as the next digit's place multiplier
                    bra       ParsePriorityDigit ; unconditionally consume the preceding digit
ReturnPriorityValue ldd       PriorityValue,u ; return the completed 16-bit threshold in D
                    puls      x         ; restore x
                    puls      pc,y      ; restore pc,y and return to the caller
* Byte-encoded decimal formatter preserved from the original image.
* It writes five zero-padded digits plus CR: for divisors 10000, 1000,
* 100, 10, and 1, a shared subtract loop increments the current ASCII
* digit, retains the remainder, advances X, and processes the next place.
* No visible source path calls this island; it may be retained library code.
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
* Reject an access prefix that contains no decimal digit before CR.
InvalidPriority     leax      >InvalidPriorityMessage,pc ; point X at message shown when an access threshold contains no digits
                    ldy       #200      ; let I$WritLn locate the error message's CR within this bound
                    lda       #1        ; write the malformed-priority message to standard output
                    os9       I$WritLn  ; write one CR-terminated line from X
                    lda       #1        ; return a nonzero status after the malformed access rule
                    lbra      ExitWithStatus ; unconditionally leave with the current status

                    emod
eom                 equ       *
                    end
