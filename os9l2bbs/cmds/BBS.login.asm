**********************************************************************
* BBS.login - OS-9 Level 2 BBS command
*
* syntax: BBS.login
* purpose: authenticate a caller, enforce the optional daily time allowance,
* run the command configured in BBS.users, and account for the session.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* decoded authentication, session launch, userlog, and time accounting.
*          2026/07/21  Codex
* initialize interactive terminal modes and preserve echo across password entry.
*          2026/07/21  Codex
* corrected the date utility option used for audit timestamps.
**********************************************************************

                    nam       BBS.login
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $03       ; pass the correct date option for audit timestamps

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

UnusedWorkspaceWord rmb       2         ; preserved unused word at workspace offset zero
EotdPath            rmb       1         ; open end-of-day message path
UsersPath           rmb       1         ; open BBS.users authentication path
MotdPath            rmb       1         ; open message-of-the-day path
PrinterPath         rmb       1         ; optional /P audit path, or $FF when unavailable
UserlogArea         rmb       5         ; userlog path byte followed by four scratch bytes
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
UsernameLength      rmb       1         ; matched username length for display and logging
FailedAttempts      rmb       1         ; rejected credential attempts in this invocation
TensDigit           rmb       1         ; first ASCII digit emitted by time formatting
OnesDigit           rmb       1         ; second ASCII digit emitted by time formatting
StatsPathArea       rmb       3         ; statistics path byte followed by two scratch bytes
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
ScratchWord         rmb       1         ; high byte of a reused pointer/length/parser word
ScratchWordLow      rmb       1         ; low byte of that reused word
CommandLength       rmb       2         ; parameter length passed to the configured shell
UsernameInputLength rmb       2         ; byte count returned by the username I$ReadLn
DailyTimeLimit      rmb       2         ; optional fifth BBS.users field, in minutes
AuthenticatedUserId rmb       2         ; fourth BBS.users field and statistics key
StatsOffsetHigh     rmb       2         ; high word of the selected statistics record offset
StatsOffsetLow      rmb       2         ; low word of the selected statistics record offset

* BBS.userstats is a stream of 32-byte records. Login time occupies the six
* formerly unidentified bytes at offsets 4-9; logout time occupies 18-23.
StatsUserId         rmb       2         ; +0 account's OS-9 user ID
CallCount           rmb       2         ; +2 completed login count
LoginYear           rmb       1         ; +4 session-start year
LoginMonthDay       rmb       2         ; +5 session-start month and day
LoginHour           rmb       1         ; +7 session-start hour
LoginMinuteSecond   rmb       2         ; +8 session-start minute and second
MessagesLeft        rmb       2         ; +10 messages posted
MessagesRead        rmb       2         ; +12 messages read
FilesDownloaded     rmb       2         ; +14 files downloaded
FilesUploaded       rmb       2         ; +16 files uploaded
LogoutYear          rmb       1         ; +18 most recent session-end year
LogoutMonth         rmb       1         ; +19 most recent session-end month
LogoutDay           rmb       1         ; +20 most recent session-end day
LogoutHour          rmb       1         ; +21 most recent session-end hour
LogoutMinuteSecond  rmb       2         ; +22 session-end minute and second
MinutesRemainingArea rmb       8         ; +24 remaining minutes word plus six reserved bytes

CurrentDate         rmb       3         ; current year, month, and day from F$Time
CurrentHour         rmb       1         ; current hour from F$Time
CurrentMinute       rmb       1         ; current minute from F$Time
CurrentSecond       rmb       1         ; current second from F$Time
SavedEchoOption     rmb       1         ; inherited PD.EKO value restored after password entry
TerminalOptions     rmb       32        ; terminal SS.Opt packet used to toggle input echo
LineBuffer          rmb       200       ; shared MOTD/EOTD and BBS.users record buffer
UsernameBuffer      rmb       200       ; entered caller name
PasswordBuffer      rmb       400       ; entered password and generous trailing workspace
CommandLine         rmb       1         ; first byte of configured program/parameter text
CommandLineTail     rmb       599       ; remainder of configured command-line storage
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.login/ ; os-9 module name
CopyrightNotice     fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; original author and license text
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
PrinterDeviceName   fcb       '/','P',C$CR ; optional audit device used for date output
UsernamePrompt      fcb       C$LF      ; begin the login prompt on a fresh line
                    fcc       "Enter your user name-->" ; visible username prompt
UsernamePromptLength fcb       0         ; high byte of the 24-byte prompt length
                    fcb       24        ; low byte consumed through a PC-relative word load
PasswordPrompt      fcc       "Enter your Password--->" ; visible password prompt
PasswordPromptLength fcb       0         ; high byte of the 23-byte prompt length
                    fcb       23        ; low byte consumed through a PC-relative word load
MotdFilename        fcc       "Motd"    ; message displayed before authentication
                    fcb       C$CR      ; terminate the filename
ShellModuleName     fcc       "Shell"   ; interpreter for the configured user command
                    fcb       C$CR      ; terminate the module name
                    fcb       C$CR      ; supply an empty trailing parameter line
UsersFilename       fcc       "BBS.users" ; comma-delimited authentication database
                    fcb       C$CR      ; terminate the filename
InvalidCredentialsMessage fcc       "Invald name/password!!!" ; original rejected-login text and spelling
                    fcb       C$CR      ; terminate the response
BannerTitle         fcb       C$LF      ; separate the banner from MOTD text
                    fcc       "OS9 Level II BBS" ; product title
                    fcb       C$CR      ; terminate the title
BannerAuthor        fcc       "By Alpha Software Technologies" ; publisher credit
                    fcb       C$CR      ; terminate the credit
BannerCopyright     fcc       "Copyright (c) 1988" ; visible copyright line
                    fcb       C$LF      ; add vertical spacing after the banner
                    fcb       C$CR      ; terminate the line
BlankLine           fcb       C$LF      ; two-byte blank-line sequence
                    fcb       C$CR      ; terminate the blank line
DateCommandName     fcc       "date"    ; command briefly redirected to /P
                    fcb       C$CR      ; terminate the module name
DateCommandParams   fcc       "-t"      ; request the date command's time form
                    fcb       C$CR      ; terminate the parameter line
PaddingSpaces       fcc       "                                       " ; align printer/userlog fields
TimeColon           fcc       ":"      ; separator between two-digit time fields
LoginDeniedMessage  fcc       "Sorry, but I cannot log you on" ; response after four failed attempts
                    fcb       C$CR      ; terminate the response
WelcomePrefix       fcc       "Welcome, " ; successful-login greeting prefix
                    fcb       C$CR      ; adjacent terminator excluded by the fixed write
VerifyingMessage    fcb       C$LF      ; begin verification status on a fresh line
                    fcc       "Verifying Password...Please wait" ; database-scan status
                    fcb       C$LF      ; space the following output
                    fcb       C$CR      ; terminate the status line
EnteringMessage     fcb       C$LF      ; begin the successful-login status
                    fcc       "Entering system..." ; session-launch announcement
                    fcb       C$LF      ; space the following output
                    fcb       C$CR      ; terminate the status line
UserlogFilename     fcc       "Userlog" ; daily human-readable caller log
                    fcb       C$CR      ; terminate the filename
UserlogHeading      fcc       "     List of today's callers" ; header for a new log
                    fcb       C$CR      ; terminate the heading
UserlogDivider      fcc       "=================================" ; header separator
                    fcb       C$CR      ; terminate the separator
EotdFilename        fcc       "eotd"    ; end-of-day text shown after the session
                    fcb       C$CR      ; terminate the filename
PasswordMask        fcb       'X'       ; visible replacement for each password byte
EraseSequence       fcb       C$BSP     ; move back over the previous password mask
                    fcb       C$SPAC    ; replace the mask with a blank
                    fcb       C$BSP     ; leave the cursor at the vacated position
StatsFilename       fcc       "/dd/bbs/BBS.userstats" ; fixed 32-byte account records
                    fcb       C$CR      ; terminate the pathname
NoTimeMessage       fcc       "I'm sorry but you don't have any more time on-line" ; exhausted allowance response
                    fcb       C$CR      ; terminate the response
start               leax      >PrinterDeviceName,pc ; select optional /P audit output
                    lda       #WRITE.   ; open it for date/status output
                    os9       I$Open    ; attempt to acquire the audit device
                    bcc       StorePrinterPath ; retain the returned path on success
                    lda       #$FF      ; use a negative byte as the unavailable sentinel
StorePrinterPath    sta       PrinterPath,u ; remember whether /P can be used
                    ldy       #0        ; authenticate initially as system user zero
                    os9       F$SUser   ; gain access to protected BBS files
                    lbcs      ExitWithStatus ; abort if privilege cannot be established
                    clr       FailedAttempts,u ; begin with no rejected credentials
                    lbsr      InitializeTerminalInput ; configure the final stdin selected by the caller

                    leax      >MotdFilename,pc ; select the optional message of the day
                    lda       #READ.    ; request sequential text access
                    os9       I$Open    ; open Motd when present
                    bcs       ShowBanner ; a missing MOTD does not prevent login
                    leax      <LineBuffer,u ; reuse the common line buffer
                    sta       MotdPath,u ; retain the open MOTD path
CopyMotdLine        ldy       #200      ; bound the next line read
                    lda       MotdPath,u ; select the MOTD stream
                    os9       I$ReadLn  ; fetch one display line
                    bcs       CloseMotd ; eof completes the optional message
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; relay the line to the caller
                    bra       CopyMotdLine ; continue through the file
CloseMotd           lda       MotdPath,u ; select the exhausted MOTD path
                    os9       I$Close   ; release it before authentication

ShowBanner          leax      >BannerTitle,pc ; select the product title
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the title
                    leax      >BannerAuthor,pc ; select the publisher credit
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; display the credit
                    leax      >BannerCopyright,pc ; select the visible copyright line
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; finish the login banner

PromptUsername      leax      >UsernamePrompt,pc ; ask for the caller's account name
                    ldy       >UsernamePromptLength,pc ; use the embedded fixed length
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the unterminated prompt
                    leax      >UsernameBuffer,u ; receive the entered name
                    clra                ; select standard input
                    ldy       #200      ; bound the CR-terminated response
                    os9       I$ReadLn  ; read the caller's account name
                    bcs       PromptUsername ; retry transient input failures
                    sty       <UsernameInputLength,u ; retain its returned byte count
                    lbsr      FoldLineUppercase ; normalize the entered name in place
                    lbsr      DisableInputEcho ; hide raw password characters
                    leax      >PasswordPrompt,pc ; ask for the account password
                    ldy       >PasswordPromptLength,pc ; use the embedded fixed length
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the unterminated prompt
                    leax      >PasswordBuffer,u ; begin the private response buffer

ReadPasswordByte    ldy       #1        ; process the password one character at a time
                    clra                ; select standard input
                    os9       I$Read    ; fetch the next unechoed character
                    bcs       ReadPasswordByte ; retry until a byte is available
                    lda       ,x        ; inspect the character before advancing
                    cmpa      #C$BSP    ; did the caller request an erase?
                    beq       HandlePasswordBackspace ; retreat without storing backspace
                    pshs      x         ; preserve the private input cursor
                    leax      >PasswordMask,pc ; select the visible replacement character
                    ldy       #1        ; echo exactly one mask byte
                    lda       #1        ; target standard output
                    os9       I$Write   ; show progress without revealing the password
                    puls      x         ; recover the private input cursor
                    lda       ,x+       ; accept the character and advance
                    cmpa      #C$CR     ; did the caller finish the password?
                    bne       ReadPasswordByte ; continue through the response
                    leax      >PasswordBuffer,u ; select the completed password
                    lbsr      FoldLineUppercase ; make authentication case-insensitive
                    leax      >BlankLine,pc ; select the post-password spacing
                    ldy       #2        ; preserve the original two-byte write
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; finish the masked entry line
                    lbsr      EnableInputEcho ; restore normal terminal behavior
                    bra       OpenUsersDatabase ; begin credential verification

HandlePasswordBackspace
                    leay      >PasswordBuffer,u ; locate the lower cursor bound
                    sty       <ScratchWord,u ; retain it for a 16-bit comparison
                    cmpx      <ScratchWord,u ; is the password already empty?
                    beq       ReadPasswordByte ; ignore backspace at the beginning
                    pshs      x         ; preserve the private input cursor
                    leax      >EraseSequence,pc ; visually remove one mask character
                    ldy       #3        ; emit backspace-space-backspace
                    lda       #1        ; target standard output
                    os9       I$Write   ; repair the visible password field
                    puls      x         ; recover the private input cursor
                    leax      -1,x      ; discard the previous password byte
                    bra       ReadPasswordByte ; resume private entry

OpenUsersDatabase   leax      >VerifyingMessage,pc ; select the verification status
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; tell the caller that lookup has started
                    leax      >UsersFilename,pc ; select the authentication database
                    lda       #READ.    ; request sequential record access
                    os9       I$Open    ; open BBS.users
                    lbcs      ExitWithStatus ; authentication cannot proceed without it
                    sta       UsersPath,u ; retain the database path

* BBS.users records are name,password,command,user ID[,daily minutes]. The
* entire record and both entered fields are folded to uppercase before compare.
ReadNextUserRecord  leax      <LineBuffer,u ; initialize the record buffer
                    ldb       #200      ; clear its full fixed capacity
                    lda       #C$CR     ; use CR so absent fields terminate safely
FillUserRecordWithCr sta       ,x+       ; initialize the next unused byte
                    decb                ; count down the buffer capacity
                    bne       FillUserRecordWithCr ; continue through all 200 bytes
                    leax      <LineBuffer,u ; receive the next user record
                    clr       UsernameLength,u ; restart the matched-name count
                    lda       UsersPath,u ; select BBS.users
                    ldy       #200      ; bound the record read
                    os9       I$ReadLn  ; fetch one comma-delimited account
                    bcs       AuthenticationFailed ; eof means no credentials matched
                    lbsr      FoldLineUppercase ; normalize the record in place
                    leay      >UsernameBuffer,u ; select the entered account name
CompareUsername     lda       ,y+       ; fetch the next entered-name character
                    cmpa      #C$CR     ; has the entered name ended?
                    beq       UsernameMatched ; require a comma at the same boundary
                    cmpa      #'Z'      ; is additional ASCII case folding needed?
                    bls       CompareUsernameByte ; preserve punctuation and uppercase
                    anda      #$DF      ; fold lowercase ASCII to uppercase
CompareUsernameByte cmpa      ,x+       ; compare with the database name
                    bne       ReadNextUserRecord ; reject this account on mismatch
                    inc       UsernameLength,u ; count bytes for greeting and userlog
                    bra       CompareUsername ; continue through the entered name
UsernameMatched     lda       ,x+       ; inspect the database boundary
                    cmpa      #','      ; did the stored name end at the same point?
                    bne       ReadNextUserRecord ; reject matching prefixes
                    leay      >PasswordBuffer,u ; compare the entered password next
ComparePassword     lda       ,y+       ; fetch the next entered-password byte
                    cmpa      #C$CR     ; has the entered password ended?
                    beq       PasswordMatched ; require the database field to end too
                    cmpa      #'Z'      ; is additional ASCII case folding needed?
                    bls       ComparePasswordByte ; preserve punctuation and uppercase
                    anda      #$DF      ; fold lowercase ASCII to uppercase
ComparePasswordByte cmpa      ,x+       ; compare with the stored password
                    bne       ReadNextUserRecord ; reject this account on mismatch
                    bra       ComparePassword ; continue through the password
PasswordMatched     lda       ,x+       ; inspect the database boundary
                    cmpa      #','      ; did the stored password end here too?
                    bne       ReadNextUserRecord ; reject matching prefixes

                    leay      >CommandLine,u ; build the configured program text
                    clr       <CommandLength,u ; initialize its one-byte effective length
CopyConfiguredCommand
                    inc       <CommandLength,u ; count this field byte or terminator
                    lda       ,x+       ; fetch the next configured-command byte
                    cmpa      #','      ; does a numeric user ID follow?
                    beq       FinishConfiguredCommand ; terminate the command field
                    cmpa      #C$CR     ; is this a legacy record with no numeric fields?
                    beq       FinishConfiguredCommand ; accept the command-only record
                    sta       ,y+       ; append the command byte
                    bra       CopyConfiguredCommand ; continue through the third field
FinishConfiguredCommand
                    pshs      y,x       ; preserve both database cursors during logging
                    lbsr      AppendUserlog ; record the accepted caller and time
                    puls      y,x       ; recover the command and numeric-field cursors
                    lda       #C$CR     ; terminate the configured shell parameters
                    sta       ,y        ; make the copied field an OS-9 parameter line
                    inc       <CommandLength,u ; include that terminator for F$Fork
                    bsr       ParseDecimal ; convert the fourth field
                    std       <AuthenticatedUserId,u ; retain the account's OS-9 identity
                    tfr       d,y       ; pass the user ID to F$SUser
                    os9       F$SUser   ; drop privileges to the authenticated account
                    bsr       ParseDecimal ; convert optional daily minutes, or zero
                    std       <DailyTimeLimit,u ; retain the allowance for accounting
                    lda       UsersPath,u ; select the authentication database
                    os9       I$Close   ; release it after a successful match
                    lbra      BeginAuthenticatedSession ; greet and initialize statistics

AuthenticationFailed
                    leax      >InvalidCredentialsMessage,pc ; select the rejection response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; reject this credential pair
                    lda       UsersPath,u ; select the exhausted database
                    os9       I$Close   ; rewind implicitly by reopening on the next try
                    inc       FailedAttempts,u ; count this complete database miss
                    lda       FailedAttempts,u ; inspect the accumulated failures
                    cmpa      #3        ; have more than three attempts failed?
                    bgt       DenyLogin ; refuse a fourth rejected login
                    lbra      PromptUsername ; collect another credential pair

* Parse the first decimal token at or after X. A missing optional fifth field
* returns zero, which means unlimited daily access.
ReturnZeroNumber    ldd       #0        ; represent an absent numeric field as zero
                    puls      pc,y      ; restore Y and return directly
DenyLogin           leax      >LoginDeniedMessage,pc ; select the terminal denial response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; end authentication after four failures
                    pshs      u         ; match the saved-workspace shape expected by EndSession
                    lbra      EndSession ; show eotd and terminate
ParseDecimal        pshs      y         ; preserve the caller's Y register
FindFirstDigit      lda       ,x+       ; scan toward a decimal token
                    cmpa      #C$CR     ; does the remaining record contain no number?
                    beq       ReturnZeroNumber ; return the unlimited/default value
                    cmpa      #'0'      ; skip bytes below the decimal range
                    bcs       FindFirstDigit ; continue past separators
                    cmpa      #'9'      ; skip bytes above the decimal range
                    bhi       FindFirstDigit ; continue past separators
                    leax      -1,x      ; return to the token's first digit
FindNumberEnd       lda       ,x+       ; scan across the decimal token
                    cmpa      #'0'      ; bytes below zero delimit the token
                    bcs       ConvertNumberBackward ; begin conversion at the end
                    cmpa      #'9'      ; bytes above nine also delimit it
                    bhi       ConvertNumberBackward ; begin conversion at the end
                    bra       FindNumberEnd ; continue through the digit run
ConvertNumberBackward
                    pshs      x         ; retain the pointer following the token
                    leax      -1,x      ; select its rightmost digit
                    clr       <ScratchWord,u ; clear the high result byte
                    clr       <ScratchWordLow,u ; clear the low result byte
                    ldd       #1        ; seed the rightmost decimal place as units
                    std       <DecimalPlace,u ; retain the current multiplier
ParsePreviousDigit  lda       ,-x       ; fetch one digit while moving left
                    cmpa      #'0'      ; a lower delimiter precedes the token
                    bcs       ReturnParsedNumber ; finish conversion there
                    cmpa      #'9'      ; an upper delimiter also precedes the token
                    bhi       ReturnParsedNumber ; finish conversion there
                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       DigitCounter,u ; retain units remaining for this digit
                    ldd       #0        ; initialize this digit's contribution
AddDigitPlace       tst       DigitCounter,u ; has digit times place been accumulated?
                    beq       AccumulateDigit ; merge the completed contribution
                    addd      <DecimalPlace,u ; add one unit of the current place
                    dec       DigitCounter,u ; consume one unit from the digit
                    bra       AddDigitPlace ; finish digit multiplication
AccumulateDigit     addd      <ScratchWord,u ; include lower-order digits
                    std       <ScratchWord,u ; retain the running result
                    lda       #10       ; multiply the place value by ten next
                    sta       DigitCounter,u ; count ten repeated additions
                    ldd       #0        ; initialize the next-place accumulator
ScaleDecimalPlace   tst       DigitCounter,u ; have all ten copies been added?
                    beq       AdvanceDecimalPlace ; publish the completed multiplier
                    addd      <DecimalPlace,u ; add another old-place unit
                    dec       DigitCounter,u ; count down the multiply-by-ten loop
                    bra       ScaleDecimalPlace ; continue forming the next place
AdvanceDecimalPlace std       <DecimalPlace,u ; move one decimal column left
                    bra       ParsePreviousDigit ; continue toward the token start
ReturnParsedNumber  ldd       <ScratchWord,u ; return the converted 16-bit value
                    puls      x         ; recover the pointer following the token
                    puls      pc,y      ; restore Y and return
BeginAuthenticatedSession
                    leax      >WelcomePrefix,pc ; select the fixed greeting prefix
                    lda       #1        ; target standard output
                    ldy       #9        ; omit the adjacent CR from the prefix
                    os9       I$Write   ; begin the caller greeting
                    lbcs      ExitWithStatus ; propagate terminal output failure
                    leax      >UsernameBuffer,u ; select the authenticated display name
                    ldb       UsernameLength,u ; obtain its exact matched length
                    clra                ; form the 16-bit length in D
                    tfr       d,y       ; pass that length to I$Write
                    lda       PrinterPath,u ; select optional audit output
                    bmi       UsernamePrinterDone ; skip it when /P was unavailable
                    os9       I$Write   ; add the caller name to the audit line
UsernamePrinterDone
                    lbcs      ExitWithStatus ; propagate audit output failure
                    lda       #1        ; return to the caller's terminal
                    leay      1,y       ; include the username's CR terminator
                    os9       I$WritLn  ; finish the visible welcome line
                    lbcs      ExitWithStatus ; propagate terminal output failure
                    leax      >EnteringMessage,pc ; select the launch status
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; announce entry into the configured system

                    ldb       #21       ; target a 21-column audit name field
                    subb      UsernameLength,u ; compute trailing padding
                    clra                ; form the 16-bit padding length
                    tfr       d,y       ; pass it to I$Write
                    leax      >PaddingSpaces,pc ; select reusable blank padding
                    lda       PrinterPath,u ; select optional audit output
                    bmi       PrinterPaddingDone ; skip it when /P was unavailable
                    os9       I$Write   ; align the following date/time field
PrinterPaddingDone  lbcs      ExitWithStatus ; propagate audit output failure

* Temporarily replace standard output with /P, run "date t", then duplicate
* standard input back into path one. This appends a timestamp to the audit line.
                    pshs      u         ; preserve the login workspace during F$Fork
                    lda       #1        ; select current standard output
                    os9       I$Close   ; free path one for redirection
                    lda       PrinterPath,u ; select optional /P output
                    bmi       RestoreTerminalOutput ; skip the date command without /P
                    os9       I$Dup     ; duplicate /P into the free path-one slot
                    leax      >DateCommandName,pc ; select the date utility
                    leau      >DateCommandParams,pc ; supply its "-t" parameter
                    ldy       #3        ; pass option prefix, character, and CR
                    lda       #17       ; fork an executable object module
                    ldb       #3        ; grant the child three 256-byte pages
                    os9       F$Fork    ; run date with output redirected to /P
                    lbcs      ExitWithStatus ; propagate a fork failure
                    os9       F$Wait    ; keep authentication serialized with date
                    lbcs      ExitWithStatus ; propagate child failure
                    lda       #1        ; select redirected path one
                    os9       I$Close   ; release it before restoring the terminal
RestoreTerminalOutput
                    clra                ; select standard input
                    os9       I$Dup     ; duplicate it back into standard output
                    puls      u         ; recover the login workspace

                    leax      >StatsFilename,pc ; select the account statistics database
                    lda       #UPDAT.   ; request read/write access
                    os9       I$Open    ; open an existing database
                    bcc       StatsFileReady ; scan it when available
                    ldb       #$1B      ; create a public read/write data file
                    os9       I$Create  ; initialize a missing statistics database
                    lbcs      ExitWithStatus ; propagate create failure
StatsFileReady      sta       <StatsPathArea,u ; retain the statistics path
ReadNextStatsRecord leax      <StatsUserId,u ; receive one complete account record
                    ldy       #32       ; records have a fixed 32-byte layout
                    lda       <StatsPathArea,u ; select the statistics stream
                    os9       I$Read    ; fetch the next account record
                    bcs       StatsReadEnded ; eof means this user has no record yet
                    ldd       <StatsUserId,u ; obtain the record's account key
                    cmpd      <AuthenticatedUserId,u ; does it belong to this caller?
                    bne       ReadNextStatsRecord ; continue through other accounts
                    bra       ExistingStatsRecord ; update the matched record in place
StatsReadEnded      cmpb      #E$EOF    ; was the short read normal end-of-file?
                    lbne      ExitWithStatus ; propagate any other read error
                    lbra      CreateStatsRecord ; append a new account record
DenyNoTime          leax      >NoTimeMessage,pc ; select the exhausted-allowance response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; refuse entry for the rest of the day
                    lbra      EndSession ; show eotd and terminate

ExistingStatsRecord ldd       <CallCount,u ; recover this account's call count
                    addd      #1        ; include the accepted login
                    std       <CallCount,u ; retain the incremented count
                    leax      <LoginYear,u ; overwrite the session-start timestamp
                    os9       F$Time    ; record the current six-byte date and time
                    lda       <LogoutYear,u ; recover the previous session's year
                    cmpa      <LoginYear,u ; is this login on the same calendar year?
                    bne       NewLoginDay ; reset allowance after a year/date change
                    ldd       <LogoutMonth,u ; recover previous month and day together
                    cmpd      <LoginMonthDay,u ; is this the same calendar day?
                    bne       NewLoginDay ; reset allowance on a new day
                    bra       CheckRemainingTime ; preserve today's prior balance
NewLoginDay         ldd       <DailyTimeLimit,u ; recover the configured daily allowance
                    std       <MinutesRemainingArea,u ; start a fresh daily balance
CheckRemainingTime  ldd       <MinutesRemainingArea,u ; inspect today's balance
                    cmpd      #1        ; one is the stored exhausted sentinel
                    lbeq      DenyNoTime ; do not launch another session today

* SS.Pos returns the current 32-bit file position after the matching read.
* Subtracting 32 finds that record's starting offset for later rewrite.
                    lda       <StatsPathArea,u ; select BBS.userstats
                    ldb       #SS.Pos   ; request its current 32-bit stream position
                    pshs      u         ; preserve the workspace while U receives a word
                    os9       I$GetStt  ; obtain the stream position in X:U
                    tfr       u,d       ; move the low word into arithmetic registers
                    subd      #32       ; back up over the matched record
                    bge       StatsAppendPositionReady ; retain X when no borrow occurred
                    leax      -1,x      ; borrow from the high position word
StatsAppendPositionReady
                    ldu       ,s        ; address the workspace saved on the stack
                    stx       <StatsOffsetHigh,u ; save the record offset's high word
                    std       <StatsOffsetLow,u ; save its adjusted low word
                    tfr       d,y       ; preserve the low word across workspace loads
                    lda       <StatsPathArea,u ; select the statistics path
                    tfr       y,u       ; place the low offset word in U
                    os9       I$Seek    ; return to the matching record's beginning
                    lbcs      ExitWithStatus ; propagate a seek failure
                    puls      u         ; recover the workspace pointer
                    leax      <StatsUserId,u ; select the modified 32-byte record
                    ldy       #32       ; write exactly one account record
                    lda       <StatsPathArea,u ; target BBS.userstats
                    os9       I$Write   ; persist login count, time, and allowance
                    os9       I$Close   ; release the statistics stream
                    lbra      LaunchConfiguredCommand ; enter the caller's BBS command

CreateStatsRecord   leax      <StatsUserId,u ; select a new blank record area
                    ldd       #1        ; this is the account's first recorded call
                    std       <CallCount,u ; initialize the call counter
                    ldd       #0        ; initialize all activity counters and end time
                    std       <MessagesLeft,u ; no messages posted yet
                    std       <MessagesRead,u ; no messages read yet
                    std       <FilesUploaded,u ; no files uploaded yet
                    std       <FilesDownloaded,u ; no files downloaded yet
                    std       <LogoutYear,u ; clear logout year and month
                    std       <LogoutDay,u ; clear logout day and hour
                    std       <LogoutMinuteSecond,u ; clear logout minute and second
                    ldd       <DailyTimeLimit,u ; recover the configured allowance
                    std       <MinutesRemainingArea,u ; initialize today's balance
                    ldd       <AuthenticatedUserId,u ; recover the account key
                    std       <StatsUserId,u ; identify the new statistics record
                    leax      <LoginYear,u ; select the session-start fields
                    os9       F$Time    ; stamp the accepted login
                    lbcs      ExitWithStatus ; propagate clock failure
                    lda       <StatsPathArea,u ; select the stream at eof
                    ldb       #SS.Pos   ; request its current position at eof
                    pshs      u         ; preserve the workspace while U receives a word
                    os9       I$GetStt  ; obtain the current end position in X:U
                    lbcs      ExitWithStatus ; propagate status failure
                    tfr       u,d       ; retain the low offset word in D
                    puls      u         ; recover the workspace pointer
                    stx       <StatsOffsetHigh,u ; save the new record's high offset word
                    std       <StatsOffsetLow,u ; save its low offset word
                    leax      <StatsUserId,u ; select the initialized record
                    ldy       #32       ; write exactly one account record
                    lda       <StatsPathArea,u ; target BBS.userstats
                    os9       I$Write   ; append the new account
                    lbcs      ExitWithStatus ; propagate write failure
                    os9       I$Close   ; release the statistics stream

LaunchConfiguredCommand
                    pshs      u         ; preserve login state while the shell runs
                    ldb       <CommandLength,u ; obtain the copied parameter length
                    clra                ; form the 16-bit length in D
                    tfr       d,y       ; pass it to F$Fork
                    leax      >ShellModuleName,pc ; invoke the standard command interpreter
                    leau      >CommandLine,u ; supply the configured command line
                    lda       #17       ; fork an executable object module
                    ldb       #3        ; grant the child three 256-byte pages
                    os9       F$Fork    ; start the user's configured command or script
                    lbcs      ExitWithStatus ; propagate launch failure
                    os9       F$Wait    ; keep login alive for session accounting
                    lbra      CommandFinished ; restore privilege and close the session
InitializeTerminalInput
                    leax      <TerminalOptions,u ; select the local option buffer
                    clra                ; use standard input
                    clrb                ; request the terminal option packet
                    os9       I$GetStt  ; copy the current terminal settings
                    bcs       InitializeTerminalDone ; leave non-SCF input unchanged
                    leax      -$20,x    ; recover the beginning of the returned packet
                    lda       #1        ; enable interactive input behavior
                    sta       <$0024,x  ; make entered characters visible
                    sta       <$0025,x  ; advance a line after an echoed carriage return
                    leax      <TerminalOptions,u ; submit the modified option packet
                    clra                ; update standard input
                    clrb                ; select terminal options
                    os9       I$SetStt  ; install echo and automatic linefeed
InitializeTerminalDone
                    rts                 ; continue even when stdin is not an SCF path
DisableInputEcho
                    leax      <TerminalOptions,u ; select the local option buffer
                    clra                ; use standard input
                    clrb                ; request the terminal option packet
                    os9       I$GetStt  ; copy the current terminal settings
                    leax      -$20,x    ; recover the beginning of the returned packet
                    lda       <$0024,x  ; preserve the inherited keyboard echo value
                    sta       <SavedEchoOption,u ; retain it across password collection
                    clr       <$0024,x  ; suppress echo while the password is entered
                    leax      <TerminalOptions,u ; submit the modified option packet
                    clra                ; update standard input
                    clrb                ; select terminal options
                    os9       I$SetStt  ; install the no-echo setting
                    rts                 ; resume password collection
EnableInputEcho
                    leax      <TerminalOptions,u ; select the local option buffer
                    clra                ; use standard input
                    clrb                ; request the terminal option packet
                    os9       I$GetStt  ; preserve every option except echo
                    leax      -$20,x    ; recover the beginning of the returned packet
                    lda       <SavedEchoOption,u ; recover the pre-password echo value
                    sta       <$0024,x  ; restore the inherited keyboard echo mode
                    leax      <TerminalOptions,u ; submit the modified option packet
                    clra                ; update standard input
                    clrb                ; select terminal options
                    os9       I$SetStt  ; make typed characters visible again
                    rts                 ; return with the terminal restored

* Denied sessions reach here with the workspace pointer saved by the caller.
* Restore system privileges, display the optional exit bulletin, and leave
* without creating or changing a statistics record.
EndSession
                    puls      u         ; recover the login workspace
                    ldy       #0        ; select the system owner
                    os9       F$SUser   ; regain access to protected BBS files
                    leax      >EotdFilename,pc ; locate the exit bulletin
                    lda       #1        ; open it for reading
                    os9       I$Open    ; tolerate a missing optional bulletin
                    bcs       ExitAfterEotd ; finish when it cannot be opened
                    sta       EotdPath,u ; remember its path number
CopyEotdBeforeExit
                    leax      <LineBuffer,u ; receive one bulletin line
                    lda       EotdPath,u ; read from the exit bulletin
                    ldy       #200      ; bound the line to the shared buffer
                    os9       I$ReadLn  ; fetch the next line
                    bcs       ExitAfterEotd ; eof completes the bulletin
                    lda       #1        ; send the line to the caller
                    ldy       #200      ; let OS-9 stop at its carriage return
                    os9       I$WritLn  ; display the line
                    bra       CopyEotdBeforeExit ; continue through the file
ExitAfterEotd
                    clrb                ; denial itself is not an OS-9 error
                    os9       F$Exit    ; end the login process successfully

* A completed child command returns here with U still saved beneath F$Fork's
* temporary parameter pointer.  The logout path displays the exit bulletin,
* reopens the caller's statistics record, and charges the session time.
CommandFinished
                    puls      u         ; recover the login workspace
                    ldy       #0        ; select the system owner
                    os9       F$SUser   ; regain access to protected BBS files
                    leax      >EotdFilename,pc ; locate the exit bulletin
                    lda       #1        ; open it for reading
                    os9       I$Open    ; continue accounting if it is absent
                    bcs       EotdDisplayedAfterCommand
                    sta       EotdPath,u ; remember its path number
CopyEotdAfterCommand
                    leax      <LineBuffer,u ; receive one bulletin line
                    lda       EotdPath,u ; read from the exit bulletin
                    ldy       #200      ; bound the line to the shared buffer
                    os9       I$ReadLn  ; fetch the next line
                    bcs       EotdDisplayedAfterCommand ; eof begins accounting
                    lda       #1        ; send the line to the caller
                    ldy       #200      ; let OS-9 stop at its carriage return
                    os9       I$WritLn  ; display the line
                    bra       CopyEotdAfterCommand ; continue through the file
EotdDisplayedAfterCommand
                    cmpb      #E$EOF    ; accept only normal end-of-file
                    lbne      ExitWithStatus ; propagate a real bulletin error
                    leax      >StatsFilename,pc ; reopen the statistics database
                    lda       #3        ; request update access
                    os9       I$Open    ; obtain a stream for the final rewrite
                    sta       <StatsPathArea,u ; retain its path number
                    lbcs      ExitWithStatus ; require the accounting database
                    pshs      u         ; preserve the workspace across the seek
                    ldx       <StatsOffsetHigh,u ; restore the record's high offset
                    ldu       <StatsOffsetLow,u ; supply its low offset to I$Seek
                    os9       I$Seek    ; return to this caller's record
                    puls      u         ; recover the workspace pointer
                    leax      <StatsUserId,u ; select the in-memory record
                    ldy       #32       ; reload every accounting field
                    lda       <StatsPathArea,u ; read from BBS.userstats
                    os9       I$Read    ; recover counters changed by the session
                    leax      <LogoutYear,u ; select the logout timestamp fields
                    os9       F$Time    ; stamp year through second
                    ldd       <DailyTimeLimit,u ; test the configured daily limit
                    cmpd      #0        ; zero denotes unlimited access
                    beq       WriteUpdatedStats ; unlimited users need no debit
                    lda       <LoginYear,u ; compare the session's calendar year
                    cmpa      <LogoutYear,u
                    bne       ResetDailyAllowance ; crossing midnight starts a new day
                    ldd       <LoginMonthDay,u ; compare packed month and day
                    cmpd      <LogoutMonth,u
                    bne       ResetDailyAllowance ; do not carry yesterday's balance
                    lda       <LogoutHour,u ; find elapsed whole hours
                    suba      <LoginHour,u
                    ldb       #60       ; convert the hour difference to minutes
                    mul                 ; form the unsigned minute subtotal
                    std       <DailyTimeLimit,u ; reuse the limit slot as elapsed time
                    lda       <LogoutMinuteSecond,u ; find the signed minute difference
                    suba      <LoginMinuteSecond,u
                    tfr       a,b       ; prepare it for sign extension
                    sex                 ; preserve a negative minute difference
                    addd      <DailyTimeLimit,u ; complete the elapsed-minute count
                    std       <DailyTimeLimit,u ; retain it for the balance update
                    ldd       <MinutesRemainingArea,u ; recover today's balance
                    subd      <DailyTimeLimit,u ; debit the completed session
                    bgt       ClampRemainingTime ; retain any positive balance
                    ldd       #1        ; one is the persistent exhausted marker
ClampRemainingTime
                    std       <MinutesRemainingArea,u ; store the revised balance
                    bra       WriteUpdatedStats
ResetDailyAllowance
                    ldd       <DailyTimeLimit,u ; recover the configured allowance
                    std       <MinutesRemainingArea,u ; begin the new day at full time
WriteUpdatedStats
                    lda       <StatsPathArea,u ; select BBS.userstats
                    pshs      u         ; preserve the workspace across the seek
                    ldx       <StatsOffsetHigh,u ; restore the record's high offset
                    ldu       <StatsOffsetLow,u ; supply its low offset to I$Seek
                    os9       I$Seek    ; return to this caller's record
                    puls      u         ; recover the workspace pointer
                    leax      <StatsUserId,u ; select the updated record
                    ldy       #32       ; rewrite its complete fixed-size image
                    lda       <StatsPathArea,u ; target the statistics database
                    os9       I$Write   ; commit logout time and remaining minutes
                    bcs       ExitWithStatus ; report an accounting failure
                    clrb                ; report a clean completed session
ExitWithStatus
                    os9       F$Exit    ; return B as the process status
* Append one caller and login time to BBS.userlog.  The fixed 24-column name
* field keeps the timestamps vertically aligned for an operator reading it.
AppendUserlog
                    leax      >UserlogFilename,pc ; locate the caller log
                    lda       #3        ; request update access
                    os9       I$Open    ; reuse an existing log when present
                    bcc       UserlogReady
                    cmpb      #E$PNNF   ; creation is valid only when it is absent
                    lbne      ExitWithStatus ; propagate other open failures
                    leax      >UserlogFilename,pc ; restore the pathname consumed above
                    lda       #3        ; create an updateable log
                    ldb       #11       ; grant owner read/write and public read
                    os9       I$Create  ; make the first caller-log file
                    leax      >UserlogHeading,pc ; give a new log column labels
                    ldy       #200      ; write through the heading's carriage return
                    os9       I$WritLn
                    leax      >UserlogDivider,pc ; visually separate labels from entries
                    ldy       #200      ; write through the divider's carriage return
                    os9       I$WritLn
UserlogReady
                    sta       UserlogArea,u ; retain the open path number
                    pshs      u         ; free U for the 32-bit file position
                    ldb       #SS.Size  ; request the current end-of-file offset
                    os9       I$GetStt  ; return that offset in X:U
                    os9       I$Seek    ; append rather than overwrite old callers
                    puls      u         ; recover the login workspace
                    leax      >UsernameBuffer,u ; select the authenticated name
                    ldy       <UsernameInputLength,u ; include its input terminator
                    leay      -$01,y    ; omit the carriage return from the log
                    os9       I$Write   ; append the caller name
                    sty       <ScratchWord,u ; remember its visible width
                    ldd       #24       ; reserve a 24-column name field
                    subd      <ScratchWord,u ; find the required padding
                    blt       UserlogPaddingDone ; long names need no padding
                    tfr       d,y       ; use the gap as the write length
                    leax      >PaddingSpaces,pc ; supply a bank of spaces
                    lda       UserlogArea,u ; append to the caller log
                    os9       I$Write   ; align the following timestamp
UserlogPaddingDone
                    leax      <CurrentDate,u ; select a six-byte time packet
                    os9       F$Time    ; capture the login time
                    bsr       AppendTimeToUserlog ; append it as HH:MM:SS
                    os9       I$Close   ; flush and release BBS.userlog
                    rts                 ; resume authenticated setup

AppendTimeToUserlog
                    lda       <CurrentHour,u ; begin with the hour byte
                    bsr       WriteTwoDigitValue ; emit a zero-padded hour
                    leax      >TimeColon,pc ; separate hour and minute
                    ldy       #1        ; append one punctuation byte
                    lda       UserlogArea,u ; target the caller log
                    os9       I$Write
                    lda       <CurrentMinute,u ; select the minute byte
                    bsr       WriteTwoDigitValue ; emit a zero-padded minute
                    leax      >TimeColon,pc ; separate minute and second
                    ldy       #1        ; append one punctuation byte
                    lda       UserlogArea,u ; target the caller log
                    os9       I$Write
                    lda       <CurrentSecond,u ; select the second byte
                    bsr       WriteTwoDigitValue ; emit a zero-padded second
                    leax      >BlankLine,pc ; terminate the caller entry
                    ldy       #1        ; write only its carriage return
                    lda       UserlogArea,u ; target the caller log
                    os9       I$WritLn
                    rts                 ; return after one complete timestamp

* Convert the binary byte in A to two decimal characters.  Repeated subtraction
* is compact here because every clock field is below 60.
WriteTwoDigitValue
                    clrb                ; start the tens digit at zero
DivideByTen
                    cmpa      #10       ; stop when A contains the ones digit
                    blt       WriteTwoDigits
                    incb                ; count one group of ten
                    suba      #10       ; leave the unconverted remainder in A
                    bra       DivideByTen
WriteTwoDigits
                    addb      #'0       ; translate the tens count to ASCII
                    stb       TensDigit,u ; place it first in the output pair
                    adda      #'0       ; translate the remainder to ASCII
                    sta       OnesDigit,u ; place it second in the output pair
                    leax      TensDigit,u ; select the adjacent digit bytes
                    ldy       #2        ; emit exactly one two-digit field
                    lda       UserlogArea,u ; target the caller log
                    os9       I$Write
                    rts                 ; preserve the log's current position

* Fold a CR-terminated input line to the BBS's uppercase comparison form.
* Bytes at or below "Z" are retained; later codes have bit 5 cleared, matching
* the original ASCII-oriented treatment of lowercase account names.
FoldLineUppercase
                    pshs      x         ; preserve the caller's buffer pointer
FoldCaseLoop
                    lda       ,x+       ; inspect the next input byte
                    cmpa      #C$CR     ; the line terminator is not converted
                    beq       FoldCaseDone
                    cmpa      #'Z       ; uppercase and punctuation already compare
                    bls       FoldCaseLoop
                    anda      #$DF      ; fold lowercase ASCII to uppercase
                    sta       -$01,x    ; replace the byte just inspected
                    bra       FoldCaseLoop
FoldCaseDone
                    puls      pc,x      ; restore X and return

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
