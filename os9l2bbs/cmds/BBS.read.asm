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

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

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
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.read/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; store literal character data
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
HighMessageBanner   fcb       $0A       ; store byte data
                    fcc       "High    message is #" ; store literal character data
CurrentMessageLabel fcc       "Current message is #" ; store literal character data
CommandPrompt       fcc       "[N]ext, [P]revious, [T]hread, [R]eply, [Q]uit or Msg #" ; store literal character data
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
BlankLine           fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
MessageListPath     fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
ReplyCommand        fcc       "BBS.reply" ; store literal character data
                    fcb       $0D       ; store byte data
UserStatsPath       fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
AliasPath           fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
UnknownUserText     fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
AllUsersText        fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data
* enter as the caller long enough to remember who owns the session, then use
* superuser access for the BBS data files.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    sty       CallerUserId,u ; store y at CallerUserId,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    sty       <SessionReadCount,u ; store y at <SessionReadCount,u
                    leax      >MessageIndexPath,pc ; form the address >MessageIndexPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       IndexPath,u ; store a at IndexPath,u
                    leax      >MessageListPath,pc ; form the address >MessageListPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       MessageListReady ; branch when carry is clear; target MessageListReady
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 error in B
MessageListReady    sta       MessageListPathNum,u ; store a at MessageListPathNum,u
                    leax      >MessageBodyPath,pc ; form the address >MessageBodyPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       BodyPath,u ; store a at BodyPath,u
                    leax      <MessageIndexRecord,u ; form the address <MessageIndexRecord,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPath,u ; load a from IndexPath,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       #0        ; set d to the constant 0
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
* show the high-water mark and current selection before accepting a command.
PromptForMessage    ldd       <MessageIndexRecord,u ; read the high message number from record zero
                    leax      <MessageNumberText,u ; form the address <MessageNumberText,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >HighMessageBanner,pc ; form the address >HighMessageBanner,pc in x
                    ldy       #21       ; set y to the constant 21
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <MessageNumberText,u ; form the address <MessageNumberText,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    leax      <MessageNumberText,u ; form the address <MessageNumberText,u in x
                    lbsr      FormatMessageNumber ; format D as a five-column decimal number
                    leax      >CurrentMessageLabel,pc ; form the address >CurrentMessageLabel,pc in x
                    ldy       #20       ; set y to the constant 20
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <MessageNumberText,u ; form the address <MessageNumberText,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >CommandPrompt,pc ; form the address >CommandPrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >InputPrompt,pc ; form the address >InputPrompt,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <CommandInput,u ; form the address <CommandInput,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
RetryCommandRead    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RetryCommandRead ; retry transient terminal read errors
                    lda       <CommandInput,u ; load a from <CommandInput,u
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    blt       ParseSelectedMessage ; treat non-command input as a message number
                    anda      #223      ; mask a using #223
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      QuitAndSaveStats ; save this session and quit
                    cmpa      #78       ; compare a with #78 and set the condition codes
                    lbeq      SelectNextMessage ; select the next message
                    cmpa      #80       ; compare a with #80 and set the condition codes
                    lbeq      SelectPreviousMessage ; select the previous message
                    cmpa      #84       ; compare a with #84 and set the condition codes
                    lbeq      FindNextThreadMessage ; search forward for this subject
                    cmpa      #82       ; compare a with #82 and set the condition codes
                    lbeq      ReplyToMessage ; invoke the reply command
ParseSelectedMessage clr       <ParseScratch,u ; clear <ParseScratch,u to zero and set the condition codes
                    leax      <CommandInput,u ; form the address <CommandInput,u in x
                    lbsr      ParseMessageNumber ; parse the first decimal number in the command
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    lbeq      PromptForMessage ; return to the command prompt
                    cmpd      <MessageIndexRecord,u ; compare d with <MessageIndexRecord,u and set the condition codes
                    lbhi      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    lbra      RecordAndDisplayMessage ; display the selected message
SelectNextMessage   ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    addd      #1        ; add to d using #1
                    cmpd      <MessageIndexRecord,u ; compare d with <MessageIndexRecord,u and set the condition codes
                    lbgt      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    lbra      RecordAndDisplayMessage ; display the selected message
SelectPreviousMessage ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    subd      #1        ; subtract from d using #1
                    lbeq      PromptForMessage ; return to the command prompt
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    lbra      RecordAndDisplayMessage ; display the selected message
* thread navigation scans later 64-byte records and compares their subjects
* case-insensitively with the subject of the current message.
FindNextThreadMessage leax      >ThreadIndexRecord,u ; receive the next candidate index record
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPath,u ; load a from IndexPath,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       ThreadScanEnded ; handle the end of the index scan
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    addd      #1        ; add to d using #1
                    std       <CurrentMessage,u ; store d at <CurrentMessage,u
                    leay      >MessageSubject,u ; form the address >MessageSubject,u in y
                    leax      >ThreadSubject,u ; form the address >ThreadSubject,u in x
CompareThreadSubject lda       ,x        ; load a from ,x
                    anda      #223      ; mask a using #223
                    sta       ,x        ; store a at ,x
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       ThreadSubjectMatched ; accept this thread match
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       FindNextThreadMessage ; search forward for this subject
                    bra       CompareThreadSubject ; continue in the named workflow
ThreadScanEnded     cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lbra      PromptForMessage ; return to the command prompt
ThreadSubjectMatched ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
                    lbra      RecordAndDisplayMessage ; display the selected message
* replies run under the caller's identity and receive the current subject as
* their parameter area.  A successful reply adds one to the high-message mark.
ReplyToMessage      ldy       CallerUserId,u ; restore the caller before forking BBS.reply
                    os9       F$SUser   ; change the process user ID to Y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >ReplyCommand,pc ; form the address >ReplyCommand,pc in x
                    ldy       #80       ; set y to the constant 80
                    pshs      u         ; save u on the stack
                    leau      >MessageSubject,u ; form the workspace or data address >MessageSubject,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    puls      u         ; restore u from the stack
                    lbcs      PromptForMessage ; return to the command prompt
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    tstb                ; set condition codes from b without changing it
                    lbne      PromptForMessage ; return to the command prompt
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    ldd       <MessageIndexRecord,u ; load d from <MessageIndexRecord,u
                    addd      #1        ; add to d using #1
                    std       <MessageIndexRecord,u ; store d at <MessageIndexRecord,u
                    lbra      PromptForMessage ; return to the command prompt
* update BBS.msg.lst for this user before reading the selected index record.
RecordAndDisplayMessage lda       MessageListPathNum,u ; select the per-user last-read file
                    leax      ListEntryUserId,u ; form the address ListEntryUserId,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       AppendMessageListEntry ; append a record for this user
                    ldd       ListEntryUserId,u ; load d from ListEntryUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       RecordAndDisplayMessage ; display the selected message
                    ldd       <ListEntryLastRead,u ; load d from <ListEntryLastRead,u
                    cmpd      <CurrentMessage,u ; compare d with <CurrentMessage,u and set the condition codes
                    bcc       LoadMessageRecord ; load the selected index record
                    pshs      u         ; save u on the stack
                    lda       MessageListPathNum,u ; load a from MessageListPathNum,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <CurrentMessage,u ; form the address <CurrentMessage,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       LoadMessageRecord ; continue in the named workflow
AppendMessageListEntry cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lda       MessageListPathNum,u ; load a from MessageListPathNum,u
                    leax      CallerUserId,u ; form the address CallerUserId,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <CurrentMessage,u ; form the address <CurrentMessage,u in x
                    os9       I$Write   ; write Y bytes from X to path A
* multiply the one-based message number by 64 to address its index record.
LoadMessageRecord   clr       <IndexOffsetTop,u ; clear the top half of the 32-bit offset
                    clr       <IndexOffsetHigh,u ; clear <IndexOffsetHigh,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       IndexShiftCount,u ; store a at IndexShiftCount,u
                    ldd       <CurrentMessage,u ; load d from <CurrentMessage,u
ShiftMessageIndex   aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <IndexOffsetHigh,u ; rotate left through carry the value at <IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; decrement the value at IndexShiftCount,u
                    bne       ShiftMessageIndex ; continue multiplying by the 64-byte record size
                    std       <IndexOffsetLow,u ; store d at <IndexOffsetLow,u
                    ldx       <IndexOffsetTop,u ; load x from <IndexOffsetTop,u
                    lda       IndexPath,u ; load a from IndexPath,u
                    pshs      u         ; save u on the stack
                    ldu       <IndexOffsetLow,u ; load u from <IndexOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u from the stack
                    lda       IndexPath,u ; load a from IndexPath,u
                    ldy       #64       ; set y to the constant 64
                    leax      >BodyOffsetHigh,u ; form the address >BodyOffsetHigh,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      PromptForMessage ; return to the command prompt
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
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
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
SkipMessageNumberPadding lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       SkipMessageNumberPadding ; skip another leading space
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    ldd       >BodyOffsetHigh,u ; load d from >BodyOffsetHigh,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      ReportDeletedMessage ; report the deleted index entry
                    leax      >FromLabel,pc ; form the address >FromLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MessageAuthor,u ; form the address >MessageAuthor,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
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
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
ScanAliasRecords    leax      >AliasLineFirstByte,u ; form the address >AliasLineFirstByte,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       PrintUnknownRecipient ; fall back when the user ID has no alias
                    leax      >AliasLineFirstByte,u ; form the address >AliasLineFirstByte,u in x
FindAliasSeparator  lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       FindAliasSeparator ; find the comma after the numeric user ID
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      ParseMessageNumber ; parse the first decimal number in the command
                    cmpd      >RecipientUserId,u ; compare d with >RecipientUserId,u and set the condition codes
                    bne       ScanAliasRecords ; scan the next alias record
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
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      >SubjectLabel,pc ; form the address >SubjectLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MessageSubject,u ; form the address >MessageSubject,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    bra       DisplayMessageBody ; continue in the named workflow
ReportDeletedMessage leax      >DeletedMessageText,pc ; form the address >DeletedMessageText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      PromptForMessage ; return to the command prompt
* the index stores a full 32-bit byte offset into BBS.msg.  Copy lines until
* the zero-length record that terminates this message body.
DisplayMessageBody  leax      >MessageRule,pc ; separate the header from the body
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPath,u ; load a from BodyPath,u
                    ldx       >BodyOffsetHigh,u ; load x from >BodyOffsetHigh,u
                    pshs      u         ; save u on the stack
                    ldu       >BodyOffsetLow,u ; load u from >BodyOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u from the stack
CopyBodyLine        lda       BodyPath,u ; load a from BodyPath,u
                    leax      >BodyLineBuffer,u ; form the address >BodyLineBuffer,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       CopyBodyLine ; copy another nonempty body line
                    leax      >MessageRule,pc ; form the address >MessageRule,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <SessionReadCount,u ; load d from <SessionReadCount,u
                    addd      #1        ; add to d using #1
                    std       <SessionReadCount,u ; store d at <SessionReadCount,u
                    lbra      PromptForMessage ; return to the command prompt
* merge this session's read count into the caller's 32-byte statistics record,
* creating that record if this is the user's first recorded BBS session.
QuitAndSaveStats    leax      >UserStatsPath,pc ; open the shared user-statistics file
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 error in B
UserStatsReady      sta       UserStatsPathNum,u ; store a at UserStatsPathNum,u
FindUserStatsRecord leax      <StatsUserId,u ; form the address <StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       <StatsUserId,u ; load d from <StatsUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindUserStatsRecord ; inspect the next statistics record
                    bra       UpdateUserStats ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 error in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserStats     ldd       >StatsMessagesRead,u ; load d from >StatsMessagesRead,u
                    addd      <SessionReadCount,u ; add to d using <SessionReadCount,u
                    std       >StatsMessagesRead,u ; store d at >StatsMessagesRead,u
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       HaveStatsWriteOffset ; seek to the start of the matching record
                    leax      -$01,x    ; form the address -$01,x in x
HaveStatsWriteOffset ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    puls      u         ; restore u from the stack
                    leax      <StatsUserId,u ; form the address <StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      ExitSuccessfully ; continue in the named workflow
CreateUserStatsRecord leax      <StatsUserId,u ; form the address <StatsUserId,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <StatsLoginCount,u ; store d at <StatsLoginCount,u
                    std       >StatsMessagesRead,u ; store d at >StatsMessagesRead,u
                    ldd       #0        ; set d to the constant 0
                    std       >StatsPosts,u ; store d at >StatsPosts,u
                    std       >StatsReserved,u ; store d at >StatsReserved,u
                    std       >StatsUploads,u ; store d at >StatsUploads,u
                    ldd       CallerUserId,u ; load d from CallerUserId,u
                    std       <StatsUserId,u ; store d at <StatsUserId,u
                    leax      >StatsLastLoginTime,u ; form the address >StatsLastLoginTime,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; return the OS-9 error in B
                    leax      <StatsUserId,u ; form the address <StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      ExitWithStatus ; return the OS-9 error in B
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* parse the first run of decimal digits in X.  D returns -1 when none exists.
ParseMessageNumber  pshs      y         ; preserve the caller's byte-count register
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
                    clr       ParsedNumber,u ; clear ParsedNumber,u to zero and set the condition codes
                    clr       ParsedNumberLo,u ; clear ParsedNumberLo,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       DecimalPlace,u ; store d at DecimalPlace,u
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
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       AddDigitPlace ; continue in the named workflow
StoreDigitSum       addd      ParsedNumber,u ; add to d using ParsedNumber,u
                    std       ParsedNumber,u ; store d at ParsedNumber,u
                    lda       #10       ; set a to the constant 10
                    sta       DecimalCounter,u ; store a at DecimalCounter,u
                    ldd       #0        ; set d to the constant 0
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; use the next power of ten
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       MultiplyPlaceByTen ; continue in the named workflow
UseNextDecimalPlace std       DecimalPlace,u ; store d at DecimalPlace,u
                    bra       AccumulatePreviousDigit ; continue in the named workflow
ReturnParsedNumber  ldd       ParsedNumber,u ; load d from ParsedNumber,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
* format unsigned D as five decimal columns followed by carriage return.
FormatMessageNumber pshs      x         ; retain the start of the output field
                    std       ParsedNumber,u ; store d at ParsedNumber,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       DecimalPlace,u ; store d at DecimalPlace,u
                    ldd       ParsedNumber,u ; load d from ParsedNumber,u
                    lbsr      EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1000     ; set d to the constant 1000
                    std       DecimalPlace,u ; store d at DecimalPlace,u
                    ldd       ParsedNumber,u ; load d from ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #100      ; set d to the constant 100
                    std       DecimalPlace,u ; store d at DecimalPlace,u
                    ldd       ParsedNumber,u ; load d from ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #10       ; set d to the constant 10
                    std       DecimalPlace,u ; store d at DecimalPlace,u
                    ldd       ParsedNumber,u ; load d from ParsedNumber,u
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1        ; set d to the constant 1
                    std       DecimalPlace,u ; store d at DecimalPlace,u
                    ldd       ParsedNumber,u ; load d from ParsedNumber,u
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
EmitDecimalDigit    subd      DecimalPlace,u ; subtract from d using DecimalPlace,u
                    bcs       DecimalDigitComplete ; restore the remainder after repeated subtraction
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue in the named workflow
DecimalDigitComplete addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    std       ParsedNumber,u ; store d at ParsedNumber,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
