**********************************************************************
* BBS.read - OS-9 Level 2 BBS command
*
* Syntax: BBS.read
* Purpose: Read messages and navigate next, previous, reply, and thread relationships.
* Separates visible message numbers, index records, and body-file offsets.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded message navigation, thread lookup, display, and user statistics.
**********************************************************************

                    nam       BBS.read
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

IndexPath           rmb       1         ; path number for BBS.msg.inx
BodyPath            rmb       1         ; path number for the shared message body file
MessageListPathNum  rmb       1         ; path number for per-user last-read records
AliasPathNum        rmb       1         ; path number while resolving a recipient ID
IndexShiftCount     rmb       1         ; six shifts turn a message number into a 64-byte offset
DecimalCounter      rmb       1         ; repeated-addition counter used by decimal conversion
UserStatsPathNum    rmb       3         ; statistics path number followed by two unused bytes
ParsedNumber        rmb       1         ; high byte of the parsed command number
ParsedNumberLo      rmb       1         ; low byte of the parsed command number
DecimalPlace        rmb       2         ; current power of ten during number conversion
CallerUserId        rmb       2         ; user ID restored before running BBS.reply
ListEntryUserId     rmb       2         ; user ID read from BBS.msg.lst
ListEntryLastRead   rmb       2         ; last message recorded for that user
CurrentMessage      rmb       2         ; visible one-based message number
SessionReadCount    rmb       2         ; messages displayed by this invocation
MessageNumberText   rmb       6         ; five decimal columns followed by carriage return
NumberScratch       rmb       3         ; tail of a formatted number used in date fields
NumberTensCharacter rmb       1         ; tens column copied from NumberScratch
NumberTailCharacters rmb       2         ; ones column and terminator copied as a word
ParseScratch        rmb       1         ; byte cleared before parsing a numeric command
CommandInput        rmb       6         ; menu letter or decimal message number
IndexOffsetTop      rmb       1         ; most-significant byte of the 32-bit index offset
IndexOffsetHigh     rmb       1         ; next byte of the 32-bit index offset
IndexOffsetLow      rmb       2         ; low word of message-number times 64
DateLineMonthTens   rmb       1         ; assembled MM/DD/YY HH:MM display line
DateLineMonthOnes   rmb       1
DateLineFirstSlash  rmb       1
DateLineDayTens     rmb       1
DateLineDayOnes     rmb       1
DateLineSecondSlash rmb       1
DateLineYearTens    rmb       1
DateLineYearOnes    rmb       1
DateLineSpace       rmb       1
DateLineHourTens    rmb       1
DateLineHourOnes    rmb       1
DateLineColon       rmb       1
DateLineMinuteTens  rmb       1
DateLineMinuteOnes  rmb       1
DateLineReturn      rmb       1
MessageIndexRecord  rmb       64        ; selected 64-byte message index record
StatsUserId         rmb       2         ; first field of a 32-byte user statistics record
StatsLoginCount     rmb       2         ; retained login counter for a new statistics record
StatsLastLoginTime  rmb       6         ; os-9 date/time stamped into a new record
StatsPosts          rmb       2         ; retained post counter
StatsMessagesRead   rmb       2         ; cumulative read counter updated on exit
StatsUploads        rmb       2         ; retained upload counter
StatsReserved       rmb       16        ; unused tail of the 32-byte statistics record
BodyLineBuffer      rmb       80        ; one message-body line
BodyOffsetHigh      rmb       2         ; high word of the 32-bit BBS.msg offset
BodyOffsetLow       rmb       2         ; low word of the 32-bit BBS.msg offset
MessageAuthor       rmb       20        ; author field from the selected index record
MessageSubject      rmb       30        ; subject field from the selected index record
MessageYear         rmb       1         ; os-9 timestamp fields at index-record offset 54
MessageMonth        rmb       1
MessageDay          rmb       1
MessageHour         rmb       1
MessageMinuteAndFlags rmb       4         ; minute byte followed by three record flag bytes
RecipientUserId     rmb       2         ; numeric destination, or -1 for a deleted message
ThreadIndexRecord   rmb       24        ; prefix of a candidate index record during thread scan
ThreadSubject       rmb       40        ; candidate subject plus the remainder of its record
AliasLineFirstByte  rmb       1         ; first byte of the alias-file line buffer
AliasLineRemainder  rmb       399       ; remainder of the alias-file line buffer
size                equ       .

name                fcs       /BBS.read/
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
HighMessageBanner   fcb       $0A
                    fcc       "High    message is #"
CurrentMessageLabel fcc       "Current message is #"
CommandPrompt       fcc       "[N]ext, [P]revious, [T]hread, [R]eply, [Q]uit or Msg #"
                    fcb       $0D
InputPrompt         fcc       ">"
MessageIndexPath    fcc       "BBS.msg.inx"
                    fcb       $0D
MessageBodyPath     fcc       "BBS.msg"
                    fcb       $0D
DeletedMessageText  fcc       "******   DELETED   ******"
                    fcb       $0D
MessageNumberLabel  fcc       "Message :"
FromLabel           fcc       "From    :"
ToLabel             fcc       "To      :"
DateLabel           fcc       "Left on :"
SubjectLabel        fcc       "About   :"
HeaderLabelLength   fcb       $00
                    fcb       $09
MessageRule         fcc       "----------------------------------------------------------------"
                    fcb       $0D
BlankLine           fcb       $0A
                    fcb       $0D
MessageListPath     fcc       "BBS.msg.lst"
                    fcb       $0D
ReplyCommand        fcc       "BBS.reply"
                    fcb       $0D
UserStatsPath       fcc       "/dd/bbs/BBS.userstats"
                    fcb       $0D
AliasPath           fcc       "/dd/bbs/BBS.alias"
                    fcb       $0D
UnknownUserText     fcc       "Unknown User"
                    fcb       $0D
AllUsersText        fcc       "All Users"
                    fcb       $0D
* enter as the caller long enough to remember who owns the session, then use
* superuser access for the BBS data files.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    sty       CallerUserId,u ; retain caller user id
                    ldy       #0        ; initialize session read count to 0
                    os9       F$SUser   ; change the process user ID to Y
                    sty       <SessionReadCount,u ; retain session read count
                    leax      >MessageIndexPath,pc ; select message index path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       IndexPath,u ; retain index path
                    leax      >MessageListPath,pc ; select message list path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    bcc       MessageListReady ; select message list ready when carry remains clear
                    ldb       #3        ; initialize message list path num to 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 error in B
MessageListReady    sta       MessageListPathNum,u ; retain message list path num
                    leax      >MessageBodyPath,pc ; select message body path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       BodyPath,u ; retain body path
                    leax      <MessageIndexRecord,u ; select message index record
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPath,u ; recover index path
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       #0        ; initialize current message to 0
                    std       <CurrentMessage,u ; retain current message
* show the high-water mark and current selection before accepting a command.
PromptForMessage    ldd       <MessageIndexRecord,u ; read the high message number from record zero
                    leax      <MessageNumberText,u ; select message number text
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >HighMessageBanner,pc ; select high message banner
                    ldy       #21       ; cap this output request at 21 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <MessageNumberText,u ; select message number text
                    ldy       #6        ; cap this output request at 6 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       <CurrentMessage,u ; recover current message
                    leax      <MessageNumberText,u ; select message number text
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >CurrentMessageLabel,pc ; select current message label
                    ldy       #20       ; cap this output request at 20 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <MessageNumberText,u ; select message number text
                    ldy       #6        ; cap this output request at 6 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >CommandPrompt,pc ; select command prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >InputPrompt,pc ; select input prompt
                    ldy       #1        ; cap this output request at 1 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <CommandInput,u ; select command input
                    ldy       #6        ; cap this input field at 6 bytes
                    clra                ; select standard input
RetryCommandRead    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RetryCommandRead ; retry transient terminal read errors
                    lda       <CommandInput,u ; recover command input
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    blt       ParseSelectedMessage ; treat non-command input as a message number
                    anda      #223      ; mask a using #223
                    cmpa      #81       ; recognize 81 as a meaningful value in this parser state
                    lbeq      QuitAndSaveStats ; save this session and quit
                    cmpa      #78       ; recognize 78 as a meaningful value in this parser state
                    lbeq      SelectNextMessage ; select the next message
                    cmpa      #80       ; recognize 80 as a meaningful value in this parser state
                    lbeq      SelectPreviousMessage ; select the previous message
                    cmpa      #84       ; recognize 84 as a meaningful value in this parser state
                    lbeq      FindNextThreadMessage ; search forward for this subject
                    cmpa      #82       ; recognize 82 as a meaningful value in this parser state
                    lbeq      ReplyToMessage ; invoke the reply command
ParseSelectedMessage clr       <ParseScratch,u ; initialize parse scratch
                    leax      <CommandInput,u ; select command input
                    lbsr      ParseMessageNumber ; parse the first decimal number in the command
                    cmpd      #0        ; test against #0
                    lbeq      PromptForMessage ; return to the command prompt
                    cmpd      <MessageIndexRecord,u ; test against message index record
                    lbhi      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; retain current message
                    lbra      RecordAndDisplayMessage ; display the selected message
SelectNextMessage   ldd       <CurrentMessage,u ; recover current message
                    addd      #1        ; add to d using #1
                    cmpd      <MessageIndexRecord,u ; test against message index record
                    lbgt      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; retain current message
                    lbra      RecordAndDisplayMessage ; display the selected message
SelectPreviousMessage ldd       <CurrentMessage,u ; recover current message
                    subd      #1        ; subtract from d using #1
                    lbeq      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; retain current message
                    lbra      RecordAndDisplayMessage ; display the selected message
* thread navigation scans later 64-byte records and compares their subjects
* case-insensitively with the subject of the current message.
FindNextThreadMessage leax      >ThreadIndexRecord,u ; receive the next candidate index record
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPath,u ; recover index path
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       ThreadScanEnded ; handle the end of the index scan
                    ldd       <CurrentMessage,u ; recover current message
                    addd      #1        ; add to d using #1
                    std       <CurrentMessage,u ; retain current message
                    leay      >MessageSubject,u ; select message subject
                    leax      >ThreadSubject,u ; select thread subject
CompareThreadSubject lda       ,x        ; recover
                    anda      #223      ; mask a using #223
                    sta       ,x        ; retain
                    lda       ,y+       ; consume the next byte while compare thread subject
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       ThreadSubjectMatched ; accept this thread match
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; test against
                    bne       FindNextThreadMessage ; search forward for this subject
                    bra       CompareThreadSubject ; continue in the named workflow
ThreadScanEnded     cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lbra      PromptForMessage ; return to the command prompt
ThreadSubjectMatched ldd       <CurrentMessage,u ; recover current message
                    lbra      RecordAndDisplayMessage ; display the selected message
* replies run under the caller's identity and receive the current subject as
* their parameter area.  A successful reply adds one to the high-message mark.
ReplyToMessage      ldy       CallerUserId,u ; restore the caller before forking BBS.reply
                    os9       F$SUser   ; change the process user ID to Y
                    lda       #17       ; supply 17 as the control, count, or argument value required here
                    ldb       #3        ; supply 3 as the control, count, or argument value required here
                    leax      >ReplyCommand,pc ; select reply command
                    ldy       #80       ; supply 80 as the control, count, or argument value required here
                    pshs      u         ; preserve u across the operation
                    leau      >MessageSubject,u ; select message subject
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    puls      u         ; restore u
                    lbcs      PromptForMessage ; return to the command prompt
                    clrb                ; clear the byte accumulator for counting
                    os9       F$Wait    ; wait for a child process to terminate
                    tstb                ; set condition codes from b without changing it
                    lbne      PromptForMessage ; return to the command prompt
                    ldy       #0        ; initialize message index record to 0
                    os9       F$SUser   ; change the process user ID to Y
                    ldd       <MessageIndexRecord,u ; recover message index record
                    addd      #1        ; add to d using #1
                    std       <MessageIndexRecord,u ; retain message index record
                    lbra      PromptForMessage ; return to the command prompt
* update BBS.msg.lst for this user before reading the selected index record.
RecordAndDisplayMessage lda       MessageListPathNum,u ; select the per-user last-read file
                    leax      ListEntryUserId,u ; select list entry user id
                    ldy       #4        ; cap this input field at 4 bytes
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       AppendMessageListEntry ; append a record for this user
                    ldd       ListEntryUserId,u ; recover list entry user id
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       RecordAndDisplayMessage ; display the selected message
                    ldd       <ListEntryLastRead,u ; recover list entry last read
                    cmpd      <CurrentMessage,u ; test against current message
                    bcc       LoadMessageRecord ; load the selected index record
                    pshs      u         ; preserve u across the operation
                    lda       MessageListPathNum,u ; recover message list path num
                    ldb       #5        ; select status operation 5
                    os9       I$GetStt  ; query the selected path status
                    leau      -$02,u    ; select -$02
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u
                    leax      <CurrentMessage,u ; select current message
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    bra       LoadMessageRecord ; continue in the named workflow
AppendMessageListEntry cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lda       MessageListPathNum,u ; recover message list path num
                    leax      CallerUserId,u ; select caller user id
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leax      <CurrentMessage,u ; select current message
                    os9       I$Write   ; write the requested fixed-size field
* multiply the one-based message number by 64 to address its index record.
LoadMessageRecord   clr       <IndexOffsetTop,u ; clear the top half of the 32-bit offset
                    clr       <IndexOffsetHigh,u ; initialize index offset high
                    lda       #6        ; initialize index shift count to 6
                    sta       IndexShiftCount,u ; retain index shift count
                    ldd       <CurrentMessage,u ; recover current message
ShiftMessageIndex   aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <IndexOffsetHigh,u ; rotate left through carry the value at <IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; consume one index shift count
                    bne       ShiftMessageIndex ; continue multiplying by the 64-byte record size
                    std       <IndexOffsetLow,u ; retain index offset low
                    ldx       <IndexOffsetTop,u ; recover index offset top
                    lda       IndexPath,u ; recover index path
                    pshs      u         ; preserve u across the operation
                    ldu       <IndexOffsetLow,u ; recover index offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u
                    lda       IndexPath,u ; recover index path
                    ldy       #64       ; cap this input field at 64 bytes
                    leax      >BodyOffsetHigh,u ; select body offset high
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      PromptForMessage ; return to the command prompt
                    leax      >BlankLine,pc ; select blank line
                    ldy       #2        ; cap this output request at 2 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <CurrentMessage,u ; recover current message
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >MessageNumberLabel,pc ; select message number label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <NumberScratch,u ; select number scratch
SkipMessageNumberPadding lda       ,x+       ; consume the next byte while skip message number padding
                    cmpa      #32       ; recognize the first printable ASCII value
                    beq       SkipMessageNumberPadding ; skip another leading space
                    leax      -$01,x    ; select -$01
                    ldy       #6        ; cap this output request at 6 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       >BodyOffsetHigh,u ; recover body offset high
                    cmpd      #-1       ; test against #-1
                    lbeq      ReportDeletedMessage ; report the deleted index entry
                    leax      >FromLabel,pc ; select from label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MessageAuthor,u ; select message author
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >ToLabel,pc ; select to label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    ldd       >RecipientUserId,u ; recover recipient user id
                    cmpd      #-1       ; test against #-1
                    beq       PrintAllUsersRecipient ; show the broadcast recipient
                    leax      >AliasPath,pc ; select alias path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       AliasPathNum,u ; retain alias path num
ScanAliasRecords    leax      >AliasLineFirstByte,u ; select alias line first byte
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       PrintUnknownRecipient ; fall back when the user ID has no alias
                    leax      >AliasLineFirstByte,u ; select alias line first byte
FindAliasSeparator  lda       ,x+       ; consume the next byte while find alias separator
                    cmpa      #44       ; recognize 44 as a meaningful value in this parser state
                    bne       FindAliasSeparator ; find the comma after the numeric user ID
                    lda       #13       ; recognize the carriage-return terminator
                    sta       -$01,x    ; replace the byte just examined in place
                    lbsr      ParseMessageNumber ; parse the first decimal number in the command
                    cmpd      >RecipientUserId,u ; test against recipient user id
                    bne       ScanAliasRecords ; scan the next alias record
                    leax      >AliasLineFirstByte,u ; select alias line first byte
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$Close   ; close the selected path
                    lbra      PrintMessageDate ; continue in the named workflow
PrintUnknownRecipient leax      >UnknownUserText,pc ; select unknown user text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$Close   ; close the selected path
                    lbra      PrintMessageDate ; continue in the named workflow
PrintAllUsersRecipient leax      >AllUsersText,pc ; select all users text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
PrintMessageDate    leax      >DateLabel,pc ; select date label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      <NumberScratch,u ; select number scratch
                    ldb       >MessageMonth,u ; recover message month
                    clra                ; select standard input
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineMonthTens,u ; retain date line month tens
                    lda       <NumberTailCharacters,u ; recover number tail characters
                    sta       <DateLineMonthOnes,u ; retain date line month ones
                    lda       #47       ; initialize date line first slash to 47
                    sta       <DateLineFirstSlash,u ; retain date line first slash
                    ldb       >MessageDay,u ; recover message day
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineDayTens,u ; retain date line day tens
                    lda       <NumberTailCharacters,u ; recover number tail characters
                    sta       <DateLineDayOnes,u ; retain date line day ones
                    lda       #47       ; initialize date line second slash to 47
                    sta       <DateLineSecondSlash,u ; retain date line second slash
                    ldb       >MessageYear,u ; recover message year
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineYearTens,u ; retain date line year tens
                    lda       <NumberTailCharacters,u ; recover number tail characters
                    sta       <DateLineYearOnes,u ; retain date line year ones
                    lda       #32       ; recognize the first printable ASCII value
                    sta       <DateLineSpace,u ; retain date line space
                    ldb       >MessageHour,u ; recover message hour
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineHourTens,u ; retain date line hour tens
                    lda       <NumberTailCharacters,u ; recover number tail characters
                    sta       <DateLineHourOnes,u ; retain date line hour ones
                    lda       #58       ; initialize date line colon to 58
                    sta       <DateLineColon,u ; retain date line colon
                    ldb       >MessageMinuteAndFlags,u ; recover message minute and flags
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineMinuteTens,u ; retain date line minute tens
                    lda       <NumberTailCharacters,u ; recover number tail characters
                    sta       <DateLineMinuteOnes,u ; retain date line minute ones
                    lda       #13       ; recognize the carriage-return terminator
                    sta       <DateLineReturn,u ; retain date line return
                    leax      <DateLineMonthTens,u ; select date line month tens
SkipDatePadding     lda       ,x+       ; consume the next byte while skip date padding
                    cmpa      #32       ; recognize the first printable ASCII value
                    beq       SkipDatePadding ; skip another leading space
                    leax      -$01,x    ; select -$01
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >SubjectLabel,pc ; select subject label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MessageSubject,u ; select message subject
                    ldy       #30       ; cap this output request at 30 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    bra       DisplayMessageBody ; continue in the named workflow
ReportDeletedMessage leax      >DeletedMessageText,pc ; select deleted message text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      PromptForMessage ; return to the command prompt
* the index stores a full 32-bit byte offset into BBS.msg.  Copy lines until
* the zero-length record that terminates this message body.
DisplayMessageBody  leax      >MessageRule,pc ; separate the header from the body
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPath,u ; recover body path
                    ldx       >BodyOffsetHigh,u ; recover body offset high
                    pshs      u         ; preserve u across the operation
                    ldu       >BodyOffsetLow,u ; recover body offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u
CopyBodyLine        lda       BodyPath,u ; recover body path
                    leax      >BodyLineBuffer,u ; select body line buffer
                    ldy       #80       ; cap this input field at 80 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; test against #1
                    bhi       CopyBodyLine ; copy another nonempty body line
                    leax      >MessageRule,pc ; select message rule
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <SessionReadCount,u ; recover session read count
                    addd      #1        ; add to d using #1
                    std       <SessionReadCount,u ; retain session read count
                    lbra      PromptForMessage ; return to the command prompt
* merge this session's read count into the caller's 32-byte statistics record,
* creating that record if this is the user's first recorded BBS session.
QuitAndSaveStats    leax      >UserStatsPath,pc ; open the shared user-statistics file
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; initialize user stats path num to 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 error in B
UserStatsReady      sta       UserStatsPathNum,u ; retain user stats path num
FindUserStatsRecord leax      <StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       <StatsUserId,u ; recover stats user id
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FindUserStatsRecord ; inspect the next statistics record
                    bra       UpdateUserStats ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserStats     ldd       >StatsMessagesRead,u ; recover stats messages read
                    addd      <SessionReadCount,u ; add to d using <SessionReadCount,u
                    std       >StatsMessagesRead,u ; retain stats messages read
                    lda       UserStatsPathNum,u ; recover user stats path num
                    ldb       #5        ; select status operation 5
                    pshs      u         ; preserve u across the operation
                    os9       I$GetStt  ; query the selected path status
                    tfr       u,d       ; transfer u,d
                    subd      #32       ; subtract from d using #32
                    bge       HaveStatsWriteOffset ; seek to the start of the matching record
                    leax      -$01,x    ; select -$01
HaveStatsWriteOffset ldu       ,s        ; recover
                    tfr       d,y       ; transfer d,y
                    lda       UserStatsPathNum,u ; recover user stats path num
                    tfr       y,u       ; transfer y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u
                    leax      <StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    os9       I$Close   ; close the selected path
                    lbra      ExitSuccessfully ; continue in the named workflow
CreateUserStatsRecord leax      <StatsUserId,u ; select stats user id
                    ldd       #1        ; initialize stats login count to 1
                    std       <StatsLoginCount,u ; retain stats login count
                    std       >StatsMessagesRead,u ; retain stats messages read
                    ldd       #0        ; initialize stats posts to 0
                    std       >StatsPosts,u ; retain stats posts
                    std       >StatsReserved,u ; retain stats reserved
                    std       >StatsUploads,u ; retain stats uploads
                    ldd       CallerUserId,u ; recover caller user id
                    std       <StatsUserId,u ; retain stats user id
                    leax      >StatsLastLoginTime,u ; select stats last login time
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    os9       I$Close   ; close the selected path
                    lbcs      ExitWithStatus ; return the OS-9 error in B
ExitSuccessfully    clrb                ; clear the byte accumulator for counting
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* parse the first run of decimal digits in X.  D returns -1 when none exists.
ParseMessageNumber  pshs      y         ; preserve the caller's byte-count register
FindFirstDigit      lda       ,x+       ; consume the next byte while find first digit
                    cmpa      #13       ; recognize the carriage-return terminator
                    lbeq      NoDecimalNumber ; report that no number was present
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       FindFirstDigit ; keep looking for a decimal digit
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       FindFirstDigit ; keep looking for a decimal digit
                    leax      -$01,x    ; select -$01
FindDigitRunEnd     lda       ,x+       ; consume the next byte while find digit run end
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       AccumulateDigits ; convert the digits from right to left
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       AccumulateDigits ; convert the digits from right to left
                    bra       FindDigitRunEnd ; continue in the named workflow
AccumulateDigits    pshs      x         ; preserve x across the operation
                    leax      -$01,x    ; select -$01
                    clr       ParsedNumber,u ; initialize parsed number
                    clr       ParsedNumberLo,u ; initialize parsed number lo
                    ldd       #1        ; initialize decimal place to 1
                    std       DecimalPlace,u ; retain decimal place
AccumulatePreviousDigit lda       ,-x       ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       ReturnParsedNumber ; return the accumulated value
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       ReturnParsedNumber ; return the accumulated value
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; merge this digit into the result
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       AddDigitPlace ; continue in the named workflow
StoreDigitSum       addd      ParsedNumber,u ; add to d using ParsedNumber,u
                    std       ParsedNumber,u ; retain parsed number
                    lda       #10       ; select the line-feed control byte
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; use the next power of ten
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       MultiplyPlaceByTen ; continue in the named workflow
UseNextDecimalPlace std       DecimalPlace,u ; retain decimal place
                    bra       AccumulatePreviousDigit ; continue in the named workflow
ReturnParsedNumber  ldd       ParsedNumber,u ; recover parsed number
                    puls      x         ; restore x
                    puls      pc,y      ; restore pc,y and return to the caller
* format unsigned D as five decimal columns followed by carriage return.
FormatMessageNumber pshs      x         ; retain the start of the output field
                    std       ParsedNumber,u ; retain parsed number
                    lda       #48       ; recognize or generate ASCII zero
                    sta       ,x        ; retain
                    sta       $01,x     ; retain $01
                    sta       $02,x     ; retain $02
                    sta       $03,x     ; retain $03
                    sta       $04,x     ; retain $04
                    ldd       #10000    ; initialize decimal place to 10000
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    lbsr      EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1000     ; initialize decimal place to 1000
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #100      ; initialize decimal place to 100
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #10       ; select the line-feed control byte
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1        ; initialize decimal place to 1
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    lda       #13       ; recognize the carriage-return terminator
                    sta       ,x        ; retain
                    puls      x         ; restore x
                    ldb       #32       ; recognize the first printable ASCII value
BlankLeadingZeroes  lda       ,x        ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    bne       FindFormattedNumberEnd ; find the first byte after the digits
                    stb       ,x+       ; retain
                    bra       BlankLeadingZeroes ; continue in the named workflow
FindFormattedNumberEnd lda       ,x+       ; consume the next byte while find formatted number end
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       ReturnFormattedNumber ; return X at the final digit
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       ReturnFormattedNumber ; return X at the final digit
                    bra       FindFormattedNumberEnd ; continue in the named workflow
ReturnFormattedNumber leax      -$01,x    ; select -$01
                    rts                 ; return to the caller
EmitDecimalDigit    subd      DecimalPlace,u ; subtract from d using DecimalPlace,u
                    bcs       DecimalDigitComplete ; restore the remainder after repeated subtraction
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue in the named workflow
DecimalDigitComplete addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    std       ParsedNumber,u ; retain parsed number
                    leax      $01,x     ; select $01
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
