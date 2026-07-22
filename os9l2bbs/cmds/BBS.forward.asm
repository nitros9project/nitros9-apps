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

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

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
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.forward/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988" ; store literal character data
                    fcc       "By Keith Alphonso" ; store literal character data
                    fcc       "Licenced to Alpha Software Technologies" ; store literal character data
                    fcc       "All rights reserved" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $EA       ; store byte data
                    fcb       $F5       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $A0       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $F0       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $F0       ; store byte data
HighMessageLabel    fcc       "High message is #" ; store literal character data
HighMessageLabelLength fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
StartingMessagePrompt fcc       "Enter starting message #" ; store literal character data
                    fcb       $0D       ; store byte data
InputPrompt         fcc       ">" ; store literal character data
MessageIndexPath    fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
MessageBodyPath     fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
DeletedMessageText  fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
MessageNumberLabel  fcc       "Message :" ; store literal character data
FromLabel           fcc       "From    :" ; store literal character data
ToLabel             fcc       "To      :" ; store literal character data
DateLabel           fcc       "Left on :" ; store literal character data
SubjectLabel        fcc       "About   :" ; store literal character data
HeaderLabelLength   fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
MessageRule         fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
MessageSpacing      fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
SkipMessagePrompt   fcc       "Press <SPACE> to skip a message" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
MessageListPath     fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
UserStatsPath       fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
AliasPath           fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
UnknownUserText     fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
AllUsersText        fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data

* open the current board, report its high-message mark, and convert the chosen
* one-based starting number to a 64-byte index-file offset.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    sty       CallerUserId,u ; store y at CallerUserId,u
                    ldd       #0        ; set d to the constant 0
                    std       SessionReadCount,u ; store d at SessionReadCount,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >MessageIndexPath,pc ; form the address >MessageIndexPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >MessageListPath,pc ; form the address >MessageListPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       MessageListReady ; use the open last-read file
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
MessageListReady    sta       MessageListPathNum,u ; store a at MessageListPathNum,u
                    leax      >MessageBodyPath,pc ; form the address >MessageBodyPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       BodyPathNum,u ; store a at BodyPathNum,u
                    leax      <MessageIndexRecord,u ; form the address <MessageIndexRecord,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       <MessageIndexRecord,u ; load d from <MessageIndexRecord,u
                    leax      <CurrentMessage,u ; form the address <CurrentMessage,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >HighMessageLabel,pc ; form the address >HighMessageLabel,pc in x
                    ldy       >HighMessageLabelLength,pc ; load y from >HighMessageLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <CurrentMessage,u ; form the address <CurrentMessage,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >StartingMessagePrompt,pc ; form the address >StartingMessagePrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >InputPrompt,pc ; form the address >InputPrompt,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <StartingMessageInput,u ; form the address <StartingMessageInput,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    clr       <ParseScratch,u ; clear <ParseScratch,u to zero and set the condition codes
                    leax      <StartingMessageInput,u ; form the address <StartingMessageInput,u in x
                    lbsr      ParseMessageNumber ; parse the first decimal number in the input
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      ExitSuccessfully ; leave with a successful status
                    cmpd      <MessageIndexRecord,u ; compare d with <MessageIndexRecord,u and set the condition codes
                    lbhi      ExitSuccessfully ; leave with a successful status
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    clr       <IndexOffsetTop,u ; clear <IndexOffsetTop,u to zero and set the condition codes
                    clr       <IndexOffsetHigh,u ; clear <IndexOffsetHigh,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       IndexShiftCount,u ; store a at IndexShiftCount,u
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
ShiftIndexOffset    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <IndexOffsetHigh,u ; rotate left through carry the value at <IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; decrement the value at IndexShiftCount,u
                    bne       ShiftIndexOffset ; continue multiplying by the 64-byte record size
                    std       <IndexOffsetLow,u ; store d at <IndexOffsetLow,u
                    ldx       <IndexOffsetTop,u ; load x from <IndexOffsetTop,u
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    pshs      u         ; save u on the stack
                    ldu       <IndexOffsetLow,u ; load u from <IndexOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    subd      #1        ; subtract from d using #1
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
* advance this user's last-read mark in BBS.msg.lst before displaying messages.
FindMessageListEntry lda       MessageListPathNum,u ; scan the per-user last-read file
                    leax      <ListEntryUserId,u ; form the address <ListEntryUserId,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       AppendMessageListEntry ; append a record for this user
                    ldd       <ListEntryUserId,u ; load d from <ListEntryUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindMessageListEntry ; inspect the next last-read record
                    ldd       <ListEntryLastRead,u ; load d from <ListEntryLastRead,u
                    cmpd      <MessageIndexRecord,u ; compare d with <MessageIndexRecord,u and set the condition codes
                    bcc       BeginForwardScan ; begin displaying sequential messages
                    pshs      u         ; save u on the stack
                    lda       MessageListPathNum,u ; load a from MessageListPathNum,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <MessageIndexRecord,u ; form the address <MessageIndexRecord,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       BeginForwardScan ; continue in the named workflow
AppendMessageListEntry cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lda       MessageListPathNum,u ; load a from MessageListPathNum,u
                    leax      CallerUserId,u ; form the address CallerUserId,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <MessageIndexRecord,u ; form the address <MessageIndexRecord,u in x
                    os9       I$Write   ; write Y bytes from X to path A
BeginForwardScan    lda       MessageListPathNum,u ; load a from MessageListPathNum,u
                    os9       I$Close   ; close path A
                    leax      >SkipMessagePrompt,pc ; form the address >SkipMessagePrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
* read sequential index records from the selected starting point.  Deleted
* records are reported and skipped without trying to seek into BBS.msg.
ReadNextIndexRecord lda       IndexPathNum,u ; fetch the next 64-byte message record
                    ldy       #64       ; set y to the constant 64
                    leax      >BodyOffsetHigh,u ; form the address >BodyOffsetHigh,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      IndexScanEnded ; save statistics at end of the index
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    addd      #1        ; add to d using #1
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    leax      >MessageSpacing,pc ; form the address >MessageSpacing,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >MessageNumberLabel,pc ; form the address >MessageNumberLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
SkipMessageNumberPadding lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       SkipMessageNumberPadding ; skip another leading space
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       >BodyOffsetHigh,u ; load d from >BodyOffsetHigh,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      ReportDeletedMessage ; report this deleted index entry
                    leax      >FromLabel,pc ; form the address >FromLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MessageAuthor,u ; form the address >MessageAuthor,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >ToLabel,pc ; form the address >ToLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >RecipientUserId,u ; load d from >RecipientUserId,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       PrintAllUsersRecipient ; show the broadcast recipient
                    leax      >AliasPath,pc ; form the address >AliasPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
ScanAliasRecords    leax      >AliasLineFirstByte,u ; form the address >AliasLineFirstByte,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       PrintUnknownRecipient ; fall back when no alias matches
                    leax      >AliasLineFirstByte,u ; form the address >AliasLineFirstByte,u in x
FindAliasSeparator  lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       FindAliasSeparator ; locate the numeric field separator
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      ParseMessageNumber ; parse the first decimal number in the input
                    cmpd      >RecipientUserId,u ; compare d with >RecipientUserId,u and set the condition codes
                    bne       ScanAliasRecords ; inspect the next alias record
                    leax      >AliasLineFirstByte,u ; form the address >AliasLineFirstByte,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$Close   ; close path A
                    lbra      PrintMessageDate ; continue in the named workflow
PrintUnknownRecipient leax      >UnknownUserText,pc ; form the address >UnknownUserText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$Close   ; close path A
                    lbra      PrintMessageDate ; continue in the named workflow
PrintAllUsersRecipient leax      >AllUsersText,pc ; form the address >AllUsersText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
PrintMessageDate    leax      >DateLabel,pc ; form the address >DateLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    ldb       >MessageMonth,u ; load b from >MessageMonth,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineMonthTens,u ; store a at <DateLineMonthTens,u
                    lda       <NumberTailCharacters,u ; load a from <NumberTailCharacters,u
                    sta       <DateLineMonthOnes,u ; store a at <DateLineMonthOnes,u
                    lda       #47       ; set a to the constant 47
                    sta       <DateLineFirstSlash,u ; store a at <DateLineFirstSlash,u
                    ldb       >MessageDay,u ; load b from >MessageDay,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineDayTens,u ; store a at <DateLineDayTens,u
                    lda       <NumberTailCharacters,u ; load a from <NumberTailCharacters,u
                    sta       <DateLineDayOnes,u ; store a at <DateLineDayOnes,u
                    lda       #47       ; set a to the constant 47
                    sta       <DateLineSecondSlash,u ; store a at <DateLineSecondSlash,u
                    ldb       >MessageYear,u ; load b from >MessageYear,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineYearTens,u ; store a at <DateLineYearTens,u
                    lda       <NumberTailCharacters,u ; load a from <NumberTailCharacters,u
                    sta       <DateLineYearOnes,u ; store a at <DateLineYearOnes,u
                    lda       #32       ; set a to the constant 32
                    sta       <DateLineSpace,u ; store a at <DateLineSpace,u
                    ldb       >MessageHour,u ; load b from >MessageHour,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineHourTens,u ; store a at <DateLineHourTens,u
                    lda       <NumberTailCharacters,u ; load a from <NumberTailCharacters,u
                    sta       <DateLineHourOnes,u ; store a at <DateLineHourOnes,u
                    lda       #58       ; set a to the constant 58
                    sta       <DateLineColon,u ; store a at <DateLineColon,u
                    ldb       >MessageMinuteAndFlags,u ; load b from >MessageMinuteAndFlags,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineMinuteTens,u ; store a at <DateLineMinuteTens,u
                    lda       <NumberTailCharacters,u ; load a from <NumberTailCharacters,u
                    sta       <DateLineMinuteOnes,u ; store a at <DateLineMinuteOnes,u
                    lda       #13       ; set a to the constant 13
                    sta       <DateLineReturn,u ; store a at <DateLineReturn,u
                    leax      <DateLineMonthTens,u ; form the address <DateLineMonthTens,u in x
SkipDatePadding     lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       SkipDatePadding ; skip another leading space
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >SubjectLabel,pc ; form the address >SubjectLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MessageSubject,u ; form the address >MessageSubject,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    bra       DisplayMessageBody ; continue in the named workflow
ReportDeletedMessage leax      >DeletedMessageText,pc ; form the address >DeletedMessageText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      ReadNextIndexRecord ; continue in the named workflow
* seek through the full 32-bit body offset.  A pending space character abandons
* the rest of the current body and advances directly to the next index record.
DisplayMessageBody  leax      >MessageRule,pc ; separate the header from the body
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    ldx       >BodyOffsetHigh,u ; load x from >BodyOffsetHigh,u
                    pshs      u         ; save u on the stack
                    ldu       >BodyOffsetLow,u ; load u from >BodyOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
PollSkipKey         clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       CopyBodyLine ; copy another nonempty body line
                    leax      SkipKey,u ; form the address SkipKey,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       SkipKey,u ; load a from SkipKey,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      ReadNextIndexRecord ; advance to the next message
CopyBodyLine        lda       BodyPathNum,u ; load a from BodyPathNum,u
                    leax      >BodyLineBuffer,u ; form the address >BodyLineBuffer,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       PollSkipKey ; check again before the next body line
                    leax      >MessageRule,pc ; form the address >MessageRule,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >MessageSpacing,pc ; form the address >MessageSpacing,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       SessionReadCount,u ; load d from SessionReadCount,u
                    addd      #1        ; add to d using #1
                    std       SessionReadCount,u ; store d at SessionReadCount,u
                    lbra      ReadNextIndexRecord ; continue in the named workflow
* add the number displayed this session to the caller's persistent read count,
* creating a statistics record when this is the user's first recorded visit.
IndexScanEnded      leax      >UserStatsPath,pc ; open the shared statistics database
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
UserStatsReady      sta       UserStatsPathNum,u ; store a at UserStatsPathNum,u
FindUserStatsRecord leax      StatsUserId,u ; form the address StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       StatsUserId,u ; load d from StatsUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindUserStatsRecord ; inspect the next statistics record
                    bra       UpdateUserStats ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserStats     ldd       <StatsMessagesRead,u ; load d from <StatsMessagesRead,u
                    addd      SessionReadCount,u ; add to d using SessionReadCount,u
                    std       <StatsMessagesRead,u ; store d at <StatsMessagesRead,u
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       HaveStatsWriteOffset ; seek to the matching record
                    leax      -$01,x    ; form the address -$01,x in x
HaveStatsWriteOffset ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
                    leax      StatsUserId,u ; form the address StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      ExitSuccessfully ; continue in the named workflow
CreateUserStatsRecord leax      StatsUserId,u ; form the address StatsUserId,u in x
                    ldd       #1        ; set d to the constant 1
                    std       StatsLoginCount,u ; store d at StatsLoginCount,u
                    std       <StatsMessagesRead,u ; store d at <StatsMessagesRead,u
                    ldd       #0        ; set d to the constant 0
                    std       <StatsPosts,u ; store d at <StatsPosts,u
                    std       <StatsReserved,u ; store d at <StatsReserved,u
                    std       <StatsUploads,u ; store d at <StatsUploads,u
                    ldd       CallerUserId,u ; load d from CallerUserId,u
                    std       StatsUserId,u ; store d at StatsUserId,u
                    leax      <StatsLastLoginTime,u ; form the address <StatsLastLoginTime,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      StatsUserId,u ; form the address StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* parse the first decimal run in X; return -1 when no digits are present.
ParseMessageNumber  pshs      y         ; preserve the caller's byte count
FindFirstDigit      lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      NoDecimalNumber ; report that no number was present
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       FindFirstDigit ; keep looking for a decimal digit
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       FindFirstDigit ; keep looking for a decimal digit
                    leax      -$01,x    ; form the address -$01,x in x
FindDigitRunEnd     lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       AccumulateDigits ; convert the digits from right to left
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       AccumulateDigits ; convert the digits from right to left
                    bra       FindDigitRunEnd ; continue in the named workflow
AccumulateDigits    pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <ParsedNumber,u ; clear <ParsedNumber,u to zero and set the condition codes
                    clr       <ParsedNumberLow,u ; clear <ParsedNumberLow,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
AccumulatePreviousDigit lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       ReturnParsedNumber ; return the accumulated value
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       ReturnParsedNumber ; return the accumulated value
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; store a at DecimalCounter,u
                    ldd       #0        ; set d to the constant 0
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; merge this digit into the result
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       AddDigitPlace ; continue in the named workflow
StoreDigitSum       addd      <ParsedNumber,u ; add to d using <ParsedNumber,u
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    lda       #10       ; set a to the constant 10
                    sta       DecimalCounter,u ; store a at DecimalCounter,u
                    ldd       #0        ; set d to the constant 0
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; use the next power of ten
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       MultiplyPlaceByTen ; continue in the named workflow
UseNextDecimalPlace std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    bra       AccumulatePreviousDigit ; continue in the named workflow
ReturnParsedNumber  ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
* format unsigned D as five decimal columns followed by carriage return.
FormatMessageNumber pshs      x         ; retain the start of the output field
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    lbsr      EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1000     ; set d to the constant 1000
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #100      ; set d to the constant 100
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #10       ; set d to the constant 10
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1        ; set d to the constant 1
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
BlankLeadingZeroes  lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       FindFormattedNumberEnd ; find the first byte after the digits
                    stb       ,x+       ; store b at ,x+
                    bra       BlankLeadingZeroes ; continue in the named workflow
FindFormattedNumberEnd lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       ReturnFormattedNumber ; return X at the final digit
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       ReturnFormattedNumber ; return X at the final digit
                    bra       FindFormattedNumberEnd ; continue in the named workflow
ReturnFormattedNumber leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
EmitDecimalDigit    subd      <DecimalPlace,u ; subtract from d using <DecimalPlace,u
                    bcs       DecimalDigitComplete ; restore the remainder after repeated subtraction
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue in the named workflow
DecimalDigitComplete addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
