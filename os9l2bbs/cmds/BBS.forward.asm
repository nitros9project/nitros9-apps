**********************************************************************
* BBS.forward - OS-9 Level 2 BBS command
*
* Syntax: BBS.forward
* Purpose: Read forward through the current message base from a selected position.
* Data: bbs.msg and bbs.msg.inx.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded forward scanning, message display, skip control, and statistics.
**********************************************************************

                    nam       BBS.forward
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

* open paths, session identity, and the 32-byte BBS.userstats record
SkipKey             rmb       1
IndexPathNum        rmb       1
BodyPathNum         rmb       1
MessageListPathNum  rmb       1
AliasPathNum        rmb       1
IndexShiftCount     rmb       1
DecimalCounter      rmb       1
UserStatsPathNum    rmb       1
SessionReadCount    rmb       2
CallerUserId        rmb       2
StatsUserId         rmb       2
StatsLoginCount     rmb       2
StatsLastLoginTime  rmb       6
StatsPosts          rmb       2
StatsMessagesRead   rmb       2
StatsUploads        rmb       2
StatsReserved       rmb       18
* decimal conversion and per-user BBS.msg.lst record
ParsedNumber        rmb       1
ParsedNumberLow     rmb       1
DecimalPlace        rmb       2
ListEntryUserId     rmb       2
ListEntryLastRead   rmb       2
CurrentMessage      rmb       6
NumberScratch       rmb       3
NumberTensCharacter rmb       1
NumberTailCharacters rmb       2
ParseScratch        rmb       1
StartingMessageInput rmb       6
IndexOffsetTop      rmb       1
IndexOffsetHigh     rmb       1
IndexOffsetLow      rmb       2
* assembled MM/DD/YY HH:MM display line
DateLineMonthTens   rmb       1
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
* selected 64-byte index record followed by its body and decoded fields
MessageIndexRecord  rmb       64
BodyLineBuffer      rmb       80
BodyOffsetHigh      rmb       2
BodyOffsetLow       rmb       2
MessageAuthor       rmb       20
MessageSubject      rmb       30
MessageYear         rmb       1
MessageMonth        rmb       1
MessageDay          rmb       1
MessageHour         rmb       1
MessageMinuteAndFlags rmb       4
RecipientUserId     rmb       2
AliasLineFirstByte  rmb       1
AliasLineRemainder  rmb       399
size                equ       .

name                fcs       /BBS.forward/
                    fcc       "Copyright (C) 1988"
                    fcc       "By Keith Alphonso"
                    fcc       "Licenced to Alpha Software Technologies"
                    fcc       "All rights reserved"
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
HighMessageLabel    fcc       "High message is #"
HighMessageLabelLength fcb       $00
                    fcb       $11
StartingMessagePrompt fcc       "Enter starting message #"
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
MessageSpacing      fcb       $0A
                    fcb       $0A
                    fcb       $0D
SkipMessagePrompt   fcc       "Press <SPACE> to skip a message"
                    fcb       $0A
                    fcb       $0D
MessageListPath     fcc       "BBS.msg.lst"
                    fcb       $0D
UserStatsPath       fcc       "/dd/bbs/BBS.userstats"
                    fcb       $0D
AliasPath           fcc       "/dd/bbs/BBS.alias"
                    fcb       $0D
UnknownUserText     fcc       "Unknown User"
                    fcb       $0D
AllUsersText        fcc       "All Users"
                    fcb       $0D

* open the current board, report its high-message mark, and convert the chosen
* one-based starting number to a 64-byte index-file offset.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    sty       CallerUserId,u ; retain caller user id
                    ldd       #0        ; initialize session read count to 0
                    std       SessionReadCount,u ; retain session read count
                    ldy       #0        ; establish the start loop or field bound (0)
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >MessageIndexPath,pc ; select message index path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; retain index path num
                    leax      >MessageListPath,pc ; select message list path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    bcc       MessageListReady ; use the open last-read file
                    cmpb      #216      ; establish the start loop or field bound (216)
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    ldb       #11       ; initialize message list path num to 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
MessageListReady    sta       MessageListPathNum,u ; retain message list path num
                    leax      >MessageBodyPath,pc ; select message body path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       BodyPathNum,u ; retain body path num
                    leax      <MessageIndexRecord,u ; select message index record
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       <MessageIndexRecord,u ; recover message index record
                    leax      <CurrentMessage,u ; select current message
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >HighMessageLabel,pc ; select high message label
                    ldy       >HighMessageLabelLength,pc ; recover high message label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <CurrentMessage,u ; select current message
                    ldy       #6        ; cap this output request at 6 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >StartingMessagePrompt,pc ; select starting message prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >InputPrompt,pc ; select input prompt
                    ldy       #1        ; cap this output request at 1 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <StartingMessageInput,u ; select starting message input
                    ldy       #6        ; cap this input field at 6 bytes
                    clra                ; select standard input
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    clr       <ParseScratch,u ; initialize parse scratch
                    leax      <StartingMessageInput,u ; select starting message input
                    lbsr      ParseMessageNumber ; parse the first decimal number in the input
                    cmpd      #1        ; test against #1
                    lbcs      ExitSuccessfully ; leave with a successful status
                    cmpd      <MessageIndexRecord,u ; test against message index record
                    lbhi      ExitSuccessfully ; leave with a successful status
                    std       <CurrentMessage,u ; retain current message
                    clr       <IndexOffsetTop,u ; initialize index offset top
                    clr       <IndexOffsetHigh,u ; initialize index offset high
                    lda       #6        ; initialize index shift count to 6
                    sta       IndexShiftCount,u ; retain index shift count
                    ldd       <CurrentMessage,u ; recover current message
ShiftIndexOffset    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <IndexOffsetHigh,u ; rotate left through carry the value at <IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; consume one index shift count
                    bne       ShiftIndexOffset ; continue multiplying by the 64-byte record size
                    std       <IndexOffsetLow,u ; retain index offset low
                    ldx       <IndexOffsetTop,u ; recover index offset top
                    lda       IndexPathNum,u ; recover index path num
                    pshs      u         ; preserve u across the operation
                    ldu       <IndexOffsetLow,u ; recover index offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
                    ldd       <CurrentMessage,u ; recover current message
                    subd      #1        ; subtract from d using #1
                    std       <CurrentMessage,u ; retain current message
* advance this user's last-read mark in BBS.msg.lst before displaying messages.
FindMessageListEntry lda       MessageListPathNum,u ; scan the per-user last-read file
                    leax      <ListEntryUserId,u ; select list entry user id
                    ldy       #4        ; cap this input field at 4 bytes
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       AppendMessageListEntry ; append a record for this user
                    ldd       <ListEntryUserId,u ; recover list entry user id
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FindMessageListEntry ; inspect the next last-read record
                    ldd       <ListEntryLastRead,u ; recover list entry last read
                    cmpd      <MessageIndexRecord,u ; test against message index record
                    bcc       BeginForwardScan ; begin displaying sequential messages
                    pshs      u         ; preserve u across the operation
                    lda       MessageListPathNum,u ; recover message list path num
                    ldb       #5        ; select status operation 5
                    os9       I$GetStt  ; query the selected path status
                    leau      -$02,u    ; select -$02
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u
                    leax      <MessageIndexRecord,u ; select message index record
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    bra       BeginForwardScan ; continue in the named workflow
AppendMessageListEntry cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lda       MessageListPathNum,u ; recover message list path num
                    leax      CallerUserId,u ; select caller user id
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leax      <MessageIndexRecord,u ; select message index record
                    os9       I$Write   ; write the requested fixed-size field
BeginForwardScan    lda       MessageListPathNum,u ; recover message list path num
                    os9       I$Close   ; close the selected path
                    leax      >SkipMessagePrompt,pc ; select skip message prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
* read sequential index records from the selected starting point.  Deleted
* records are reported and skipped without trying to seek into BBS.msg.
ReadNextIndexRecord lda       IndexPathNum,u ; fetch the next 64-byte message record
                    ldy       #64       ; cap this input field at 64 bytes
                    leax      >BodyOffsetHigh,u ; select body offset high
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      IndexScanEnded ; save statistics at end of the index
                    ldd       <CurrentMessage,u ; recover current message
                    addd      #1        ; add to d using #1
                    std       <CurrentMessage,u ; retain current message
                    leax      >MessageSpacing,pc ; select message spacing
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
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <NumberScratch,u ; select number scratch
SkipMessageNumberPadding lda       ,x+       ; consume the next byte while skip message number padding
                    cmpa      #32       ; recognize the first printable ASCII value
                    beq       SkipMessageNumberPadding ; skip another leading space
                    leax      -$01,x    ; select -$01
                    ldy       #6        ; cap this output request at 6 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       >BodyOffsetHigh,u ; recover body offset high
                    cmpd      #-1       ; test against #-1
                    lbeq      ReportDeletedMessage ; report this deleted index entry
                    leax      >FromLabel,pc ; select from label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MessageAuthor,u ; select message author
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
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
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       AliasPathNum,u ; retain alias path num
ScanAliasRecords    leax      >AliasLineFirstByte,u ; select alias line first byte
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       PrintUnknownRecipient ; fall back when no alias matches
                    leax      >AliasLineFirstByte,u ; select alias line first byte
FindAliasSeparator  lda       ,x+       ; consume the next byte while find alias separator
                    cmpa      #44       ; establish the find alias separator loop or field bound (44)
                    bne       FindAliasSeparator ; locate the numeric field separator
                    lda       #13       ; recognize the carriage-return terminator
                    sta       -$01,x    ; replace the byte just examined in place
                    lbsr      ParseMessageNumber ; parse the first decimal number in the input
                    cmpd      >RecipientUserId,u ; test against recipient user id
                    bne       ScanAliasRecords ; inspect the next alias record
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
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >SubjectLabel,pc ; select subject label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MessageSubject,u ; select message subject
                    ldy       #30       ; cap this output request at 30 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    bra       DisplayMessageBody ; continue in the named workflow
ReportDeletedMessage leax      >DeletedMessageText,pc ; select deleted message text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      ReadNextIndexRecord ; continue in the named workflow
* seek through the full 32-bit body offset.  A pending space character abandons
* the rest of the current body and advances directly to the next index record.
DisplayMessageBody  leax      >MessageRule,pc ; separate the header from the body
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPathNum,u ; recover body path num
                    ldx       >BodyOffsetHigh,u ; recover body offset high
                    pshs      u         ; preserve u across the operation
                    ldu       >BodyOffsetLow,u ; recover body offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
PollSkipKey         clra                ; select standard input
                    ldb       #1        ; select status operation 1
                    os9       I$GetStt  ; query the selected path status
                    bcs       CopyBodyLine ; copy another nonempty body line
                    leax      SkipKey,u ; select skip key
                    ldy       #1        ; cap this input field at 1 bytes
                    os9       I$Read    ; read the requested fixed-size field
                    lda       SkipKey,u ; recover skip key
                    cmpa      #32       ; recognize the first printable ASCII value
                    lbeq      ReadNextIndexRecord ; advance to the next message
CopyBodyLine        lda       BodyPathNum,u ; recover body path num
                    leax      >BodyLineBuffer,u ; select body line buffer
                    ldy       #80       ; cap this input field at 80 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; test against #1
                    bhi       PollSkipKey ; check again before the next body line
                    leax      >MessageRule,pc ; select message rule
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >MessageSpacing,pc ; select message spacing
                    ldy       #5        ; cap this output request at 5 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       SessionReadCount,u ; recover session read count
                    addd      #1        ; add to d using #1
                    std       SessionReadCount,u ; retain session read count
                    lbra      ReadNextIndexRecord ; continue in the named workflow
* add the number displayed this session to the caller's persistent read count,
* creating a statistics record when this is the user's first recorded visit.
IndexScanEnded      leax      >UserStatsPath,pc ; open the shared statistics database
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; initialize user stats path num to 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
UserStatsReady      sta       UserStatsPathNum,u ; retain user stats path num
FindUserStatsRecord leax      StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       StatsUserId,u ; recover stats user id
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FindUserStatsRecord ; inspect the next statistics record
                    bra       UpdateUserStats ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserStats     ldd       <StatsMessagesRead,u ; recover stats messages read
                    addd      SessionReadCount,u ; add to d using SessionReadCount,u
                    std       <StatsMessagesRead,u ; retain stats messages read
                    lda       UserStatsPathNum,u ; recover user stats path num
                    ldb       #5        ; select status operation 5
                    pshs      u         ; preserve u across the operation
                    os9       I$GetStt  ; query the selected path status
                    tfr       u,d       ; transfer u,d
                    subd      #32       ; subtract from d using #32
                    bge       HaveStatsWriteOffset ; seek to the matching record
                    leax      -$01,x    ; select -$01
HaveStatsWriteOffset ldu       ,s        ; recover
                    tfr       d,y       ; transfer d,y
                    lda       UserStatsPathNum,u ; recover user stats path num
                    tfr       y,u       ; transfer y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
                    leax      StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    os9       I$Close   ; close the selected path
                    lbra      ExitSuccessfully ; continue in the named workflow
CreateUserStatsRecord leax      StatsUserId,u ; select stats user id
                    ldd       #1        ; initialize stats login count to 1
                    std       StatsLoginCount,u ; retain stats login count
                    std       <StatsMessagesRead,u ; retain stats messages read
                    ldd       #0        ; initialize stats posts to 0
                    std       <StatsPosts,u ; retain stats posts
                    std       <StatsReserved,u ; retain stats reserved
                    std       <StatsUploads,u ; retain stats uploads
                    ldd       CallerUserId,u ; recover caller user id
                    std       StatsUserId,u ; retain stats user id
                    leax      <StatsLastLoginTime,u ; select stats last login time
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    os9       I$Close   ; close the selected path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
ExitSuccessfully    clrb                ; clear the byte accumulator for counting
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* parse the first decimal run in X; return -1 when no digits are present.
ParseMessageNumber  pshs      y         ; preserve the caller's byte count
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
                    clr       <ParsedNumber,u ; initialize parsed number
                    clr       <ParsedNumberLow,u ; initialize parsed number low
                    ldd       #1        ; initialize decimal place to 1
                    std       <DecimalPlace,u ; retain decimal place
AccumulatePreviousDigit lda       ,-x       ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       ReturnParsedNumber ; return the accumulated value
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       ReturnParsedNumber ; return the accumulated value
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; establish the accumulate previous digit loop or field bound (0)
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; merge this digit into the result
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       AddDigitPlace ; continue in the named workflow
StoreDigitSum       addd      <ParsedNumber,u ; add to d using <ParsedNumber,u
                    std       <ParsedNumber,u ; retain parsed number
                    lda       #10       ; select the line-feed control byte
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; establish the store digit sum loop or field bound (0)
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; use the next power of ten
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       MultiplyPlaceByTen ; continue in the named workflow
UseNextDecimalPlace std       <DecimalPlace,u ; retain decimal place
                    bra       AccumulatePreviousDigit ; continue in the named workflow
ReturnParsedNumber  ldd       <ParsedNumber,u ; recover parsed number
                    puls      x         ; restore x
                    puls      pc,y      ; restore pc,y and return to the caller
* format unsigned D as five decimal columns followed by carriage return.
FormatMessageNumber pshs      x         ; retain the start of the output field
                    std       <ParsedNumber,u ; retain parsed number
                    lda       #48       ; recognize or generate ASCII zero
                    sta       ,x        ; retain
                    sta       $01,x     ; retain $01
                    sta       $02,x     ; retain $02
                    sta       $03,x     ; retain $03
                    sta       $04,x     ; retain $04
                    ldd       #10000    ; initialize decimal place to 10000
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    lbsr      EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1000     ; initialize decimal place to 1000
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #100      ; initialize decimal place to 100
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #10       ; select the line-feed control byte
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1        ; initialize decimal place to 1
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
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
EmitDecimalDigit    subd      <DecimalPlace,u ; subtract from d using <DecimalPlace,u
                    bcs       DecimalDigitComplete ; restore the remainder after repeated subtraction
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue in the named workflow
DecimalDigitComplete addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    std       <ParsedNumber,u ; retain parsed number
                    leax      $01,x     ; select $01
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; establish the no decimal number loop or field bound (-1)
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
