**********************************************************************
* BBS.archive - OS-9 Level 2 BBS command
*
* Syntax: BBS.archive
* Purpose: Remove old board messages and optionally append readable copies to an archive file.
* Data: current bbs.msg/bbs.msg.inx plus an operator-selected text archive.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.archive
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

PendingInput        rmb       1         ; keyboard byte consumed while archiving a body
InxPath             rmb       1         ; open path number for BBS.msg.inx
MsgPath             rmb       1         ; open path number for BBS.msg
AliasPath           rmb       1         ; transient open path number for BBS.alias
ArchivePath         rmb       1         ; optional text archive path, or $FF when disabled
ArchivePathPad      rmb       1         ; unused byte retained from the original workspace layout
DecimalCounter      rmb       1         ; repeated-add counter used by decimal conversion
DecimalCounterPad   rmb       1         ; unused byte retained beside the counter
MessagesToRemove    rmb       2         ; number of oldest index entries selected for removal
MessagesArchived    rmb       2         ; number of message bodies copied to the text archive
CallerUserId        rmb       2         ; caller ID returned by F$ID; only user zero may archive
CallerIdReserved    rmb       34        ; unused remainder of the original caller workspace
DecimalValue        rmb       2         ; numeric parse result or formatter remainder
DecimalDivisor      rmb       2         ; current power of ten used by parser and formatter
DecimalWorkPad      rmb       4         ; unused tail of the original conversion workspace
DecimalTextOrRecordCount rmb   6         ; five-digit text plus CR, later reused as entry counter
TwoDigitScratch     rmb       3         ; leading bytes of a five-digit conversion result
TwoDigitTens        rmb       1         ; tens digit retained from that conversion
TwoDigitOnes        rmb       1         ; ones digit retained from that conversion
TwoDigitTerminator  rmb       1         ; cr written by the decimal formatter
ParseScratch        rmb       1         ; cleared before parsing the requested cutoff
NewHighInput        rmb       10        ; operator-entered first message number to retain
DateText            rmb       1         ; first digit of the formatted message date
DateMonthOnes       rmb       1         ; second month digit
DateSlash1          rmb       1         ; slash between month and day
DateDayTens         rmb       1         ; first day digit
DateDayOnes         rmb       1         ; second day digit
DateSlash2          rmb       1         ; slash between day and year
DateYearTens        rmb       1         ; first year digit
DateYearOnes        rmb       1         ; second year digit
DateSeparator       rmb       1         ; space between date and time
DateHourTens        rmb       1         ; first hour digit
DateHourOnes        rmb       1         ; second hour digit
DateColon           rmb       1         ; colon between hour and minute
DateMinuteTens      rmb       1         ; first minute digit
DateMinuteOnes      rmb       1         ; second minute digit
DateTerminator      rmb       1         ; cr terminating the formatted date/time
IndexHeader         rmb       64        ; index header whose first word is the highest message number
MessageLine         rmb       80        ; one CR-terminated line copied from the message body
MessageOffsetHigh   rmb       2         ; high word of the message body's 32-bit file offset
MessageOffsetLow    rmb       2         ; low word of the message body's 32-bit file offset
AuthorName          rmb       20        ; fixed-width author field from an index record
MessageSubject      rmb       30        ; fixed-width subject field from an index record
MessageYear         rmb       1         ; year byte from the index record
MessageMonth        rmb       1         ; month byte from the index record
MessageDay          rmb       1         ; day byte from the index record
MessageHour         rmb       1         ; hour byte from the index record
MessageMinute       rmb       1         ; minute byte from the index record
MessageSecond       rmb       1         ; second byte retained but not printed
AuthorUserId        rmb       2         ; os-9 user ID of the author, used by BBS.delete ownership checks
RecipientUserId     rmb       2         ; recipient ID, or $FFFF for all users
ArchiveFilename     rmb       200       ; optional archive pathname entered by the operator
AliasRecord         rmb       400       ; line buffer used while resolving recipient IDs to aliases
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.archive/ ; os-9 module name
                    fcc       "Copyright (C) 1988" ; original embedded copyright notice
                    fcc       "By Keith Alphonso" ; original author credit
                    fcc       "Licenced to Alpha Software Technologies" ; original publisher credit and spelling
                    fcc       "All rights reserved" ; original rights notice
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
HighMessagePrompt   fcc       "High message is #" ; text preceding the current high-water mark
HighMessagePromptLength fdb   17        ; fixed prompt length for I$Write
NewHighPrompt       fcc       "Enter new high message #" ; asks for the post-compaction high-water mark
                    fcb       C$CR      ; terminate the operator prompt
ArchiveFilenamePrompt fcc     "Enter output filename (BLANK = none)" ; optional readable archive destination
                    fcb       C$CR      ; terminate the operator prompt
PromptMarker        fcc       ">"       ; one-character input marker
IndexFilename       fcc       "BBS.msg.inx" ; fixed-size message index
                    fcb       C$CR      ; terminate the OS-9 pathname
MessageFilename     fcc       "BBS.msg" ; variable-length message-body store
                    fcb       C$CR      ; terminate the OS-9 pathname
PackModuleName      fcc       "BBS.pack" ; compacts files after entries are marked deleted
                    fcb       C$CR      ; terminate the module name
DeletedMessageBanner fcc      "******   DELETED   ******" ; retained original status text
                    fcb       C$CR      ; terminate the banner
MessageNumberLabel  fcc       "Message :" ; retained original archive heading
FromLabel           fcc       "From    :" ; archive author heading
ToLabel             fcc       "To      :" ; archive recipient heading
DateLabel           fcc       "Left on :" ; archive timestamp heading
SubjectLabel        fcc       "About   :" ; archive subject heading
HeaderLabelLength   fdb       9         ; every archive heading occupies nine bytes
SeparatorLine       fcc       "----------------------------------------------------------------" ; separates headers from bodies
                    fcb       C$CR      ; make the separator a writable line
MessageSpacing      fcb       C$LF,C$LF ; blank lines between archived messages
PackParameters      fcb       C$CR      ; bbs.pack receives an empty command line
LegacyListFilename  fcc       "BBS.msg.lst" ; retained unreferenced string from the original module
                    fcb       C$CR      ; terminate the legacy pathname
LegacyStatsFilename fcc       "/dd/bbs/BBS.userstats" ; retained unreferenced string from the original module
                    fcb       C$CR      ; terminate the legacy pathname
AliasFilename       fcc       "/dd/bbs/BBS.alias" ; maps numeric user IDs to display names
                    fcb       C$CR      ; terminate the OS-9 pathname
UnknownUserText     fcc       "Unknown User" ; used when no alias record matches
                    fcb       C$CR      ; terminate the fallback recipient
AllUsersText        fcc       "All Users" ; display name for recipient ID $FFFF
                    fcb       C$CR      ; terminate the broadcast recipient
DeletedIndexMarker  fdb       $FFFF     ; tombstone stored over an index entry's body offset
SavingMessage       fcc       "Saving Messages..." ; progress notice before destructive processing
                    fcb       C$CR      ; terminate the progress line

* restrict archive/compaction to the superuser because it rewrites the live index.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    ldb       #E$FNA    ; report function-not-authorized if the caller is not user zero
                    cmpy      #0        ; test for the OS-9 superuser ID
                    lbne      Exit      ; refuse to touch message files for ordinary users
                    sty       CallerUserId,u ; retain the authorized caller ID for the workspace record
                    ldd       #0        ; begin with no message bodies archived
                    std       MessagesArchived,u ; initialize the body-copy counter

* open the index for tombstone writes and the body file for archive reads.
                    leax      >IndexFilename,pc ; select the index pathname
                    lda       #UPDAT.   ; request read/write access to the index
                    os9       I$Open    ; open BBS.msg.inx
                    lbcs      Exit      ; return the OS-9 error if the index cannot be opened
                    sta       InxPath,u ; remember the index path number
                    leax      >MessageFilename,pc ; select the body-store pathname
                    lda       #READ.    ; the message body file is never changed here
                    os9       I$Open    ; open BBS.msg
                    lbcs      Exit      ; return the OS-9 error if the body store is unavailable
                    sta       MsgPath,u ; remember the body-file path number

* the 64-byte index header begins with the current highest message number.
                    leax      <IndexHeader,u ; receive the complete index header
                    ldy       #64       ; preserve the file position at the first entry
                    lda       InxPath,u ; select BBS.msg.inx
                    os9       I$Read    ; read its header block
                    lbcs      Exit      ; abandon the operation on a short or failed read

* display the high-water mark and ask what the high-water mark should be after packing.
                    ldd       <IndexHeader,u ; fetch the highest assigned message number
                    leax      <DecimalTextOrRecordCount,u ; use the shared six-byte decimal buffer
                    lbsr      CvtDec    ; format the high-water mark as five characters plus CR
                    leax      >HighMessagePrompt,pc ; select the fixed portion of the status line
                    ldy       >HighMessagePromptLength,pc ; write exactly the 17 visible prompt bytes
                    lda       #1        ; direct operator output to standard output
                    os9       I$Write   ; print without adding a newline
                    lbcs      Exit      ; propagate terminal write errors
                    leax      <DecimalTextOrRecordCount,u ; append the formatted number
                    ldy       #6        ; bound the five digits and terminating CR
                    os9       I$WritLn  ; finish the high-message status line
                    lbcs      Exit      ; propagate terminal write errors
                    ldd       #0        ; repurpose this buffer's first word as an entry counter
                    std       <DecimalTextOrRecordCount,u ; no index entries have been visited yet
                    leax      >NewHighPrompt,pc ; ask for the desired post-compaction high message
                    ldy       #200      ; let I$WritLn stop at the prompt's CR
                    lda       #1        ; write the prompt to standard output
                    os9       I$WritLn  ; display the cutoff question
                    lbcs      Exit      ; propagate terminal write errors
                    leax      >PromptMarker,pc ; print the input marker separately
                    ldy       #1        ; the marker is one byte
                    os9       I$Write   ; leave the cursor after '>'
                    lbcs      Exit      ; propagate terminal write errors
                    leax      <NewHighInput,u ; receive the operator's cutoff
                    ldy       #6        ; accept at most five digits plus CR
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the requested new high-water mark
                    lbcs      Exit      ; propagate terminal input errors
                    clr       <ParseScratch,u ; preserve the original workspace initialization
                    leax      <NewHighInput,u ; parse the line just entered
                    lbsr      ParseDecimal ; convert its first decimal digit run to D
                    cmpd      #1        ; message numbers begin at one
                    lbcs      FinalizeArchive ; treat zero or missing input as cancellation
                    cmpd      <IndexHeader,u ; do not accept a new high beyond the current one
                    lbhi      FinalizeArchive ; cancel instead of walking beyond the index
                    std       MessagesToRemove,u ; temporarily save the requested new high
                    ldd       <IndexHeader,u ; recover the current high-water mark
                    subd      MessagesToRemove,u ; derive how many entries packing must remove
                    std       MessagesToRemove,u ; stop after this many index records

* a blank pathname stores $FF as the original program's no-archive path sentinel.
                    leax      >ArchiveFilenamePrompt,pc ; ask where archived text should be appended
                    ldy       #200      ; let I$WritLn find the prompt's CR
                    lda       #1        ; write to the operator terminal
                    os9       I$WritLn  ; display the optional filename question
                    leax      >PromptMarker,pc ; select the input marker
                    ldy       #1        ; write its single character
                    lda       #1        ; direct output to the terminal
                    os9       I$Write   ; leave the cursor after '>'
                    leax      >ArchiveFilename,u ; receive the pathname
                    ldy       #32       ; respect OS-9's practical pathname limit
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the archive pathname
                    cmpy      #1        ; a lone CR means no archive file
                    bls       DisableArchiveOutput ; select the original no-archive path
                    lda       #UPDAT.   ; prefer an existing file that can be appended
                    os9       I$Open    ; open the chosen archive for update
                    bcc       ArchiveFileReady ; seek to EOF when the file already exists
                    ldb       #3        ; preserve the original file-attribute byte
                    os9       I$Create  ; create a new update-mode archive
                    lbcs      Exit      ; stop before deleting anything if creation fails
                    bra       ArchiveFileReady ; both open paths now share append setup

DisableArchiveOutput lda       #$FF      ; use an invalid path number as the no-output sentinel
                    sta       ArchivePath,u ; mark archive output as disabled
                    bra       ProcessNextIndexEntry ; begin walking the selected index prefix

ArchiveFileReady    sta       ArchivePath,u ; retain the opened or created archive path
                    pshs      u         ; protect the program workspace pointer from I$GetStt
                    ldb       #SS.Size  ; request the archive's current 32-bit size in X:U
                    os9       I$GetStt  ; obtain the append position
                    os9       I$Seek    ; position the archive after its existing contents
                    puls      u         ; restore the program workspace pointer
                    leax      >SavingMessage,pc ; announce that destructive processing is starting
                    ldy       #200      ; let I$WritLn stop at the notice's CR
                    lda       #1        ; send progress to standard output
                    os9       I$WritLn  ; display the saving notice

* for each 64-byte index record, overwrite its first word with $FFFF, then read the
* original remaining 62 bytes. The original first word was already captured before
* the overwrite and, together with the next word, forms the message body's offset.
ProcessNextIndexEntry lda      InxPath,u ; select the message index
                    leax      >MessageOffsetHigh,u ; receive the record's original first word
                    ldy       #2        ; read only enough to detect an existing tombstone
                    os9       I$Read    ; advance two bytes into the next index record
                    ldb       #SS.Pos   ; ask OS-9 for the current 32-bit file position
                    pshs      u         ; preserve the workspace while U holds the low offset word
                    os9       I$GetStt  ; return the index position in X:U
                    leau      -2,u      ; rewind the low word to the record boundary
                    cmpu      #0        ; detect a borrow from the low offset word
                    bge       RewriteCurrentIndexEntry ; high word needs no adjustment without a borrow
                    leax      -1,x      ; propagate the borrow into the high offset word
RewriteCurrentIndexEntry os9   I$Seek    ; return to the start of the current record
                    puls      u         ; recover the program workspace pointer
                    lbcs      Exit      ; propagate seek failures
                    leax      >DeletedIndexMarker,pc ; select the $FFFF deletion marker
                    ldy       #2        ; replace exactly the record's first word
                    os9       I$Write   ; tombstone the entry before processing its body
                    ldy       #62       ; consume the rest of the fixed-size record
                    leax      >MessageOffsetHigh,u ; start at the saved record workspace
                    leax      2,x       ; preserve the original first word already read
                    os9       I$Read    ; load offset low word, author, subject, date, and recipient
                    lbcs      FinalizeArchive ; eof or a damaged index ends the pass safely
                    ldd       <DecimalTextOrRecordCount,u ; count records, including old tombstones
                    addd      #1        ; advance the selected-prefix position
                    std       <DecimalTextOrRecordCount,u ; retain the number of visited records
                    ldd       >MessageOffsetHigh,u ; recover the original first word
                    cmpd      #$FFFF    ; distinguish a message from an existing tombstone
                    lbeq      SkipDeletedIndexEntry ; never try to archive a deleted body

* emit the fixed author heading and the CR-terminated author field from the index.
                    leax      >FromLabel,pc ; select the nine-byte author heading
                    ldy       >HeaderLabelLength,pc ; all headings share this length
                    lda       ArchivePath,u ; select the optional archive path
                    os9       I$Write   ; no-op with an error when archive output is disabled
                    leax      >AuthorName,u ; select the record's 20-byte author field
                    ldy       #200      ; stop at the field's embedded CR
                    lda       <ArchivePath ; restore the optional path through OS-9's direct page
                    os9       I$WritLn  ; append the author's display name
                    lbcs      Exit      ; preserve the original failure behavior for path $FF
                    leax      >ToLabel,pc ; select the recipient heading
                    ldy       >HeaderLabelLength,pc ; write its fixed nine bytes
                    lda       ArchivePath,u ; select the optional archive path
                    os9       I$Write   ; append the recipient heading

* recipient $FFFF is a broadcast. Other IDs are resolved by scanning comma-delimited
* BBS.alias lines in "display name,user number" form.
                    ldd       >RecipientUserId,u ; fetch the record's recipient ID
                    cmpd      #$FFFF    ; distinguish broadcasts from individual recipients
                    beq       WriteAllUsersRecipient ; avoid opening the alias file for broadcasts
                    leax      >AliasFilename,pc ; select the user-ID mapping file
                    lda       #READ.    ; aliases are only scanned
                    os9       I$Open    ; open BBS.alias for this lookup
                    lbcs      Exit      ; propagate missing or inaccessible alias-file errors
                    sta       AliasPath,u ; save the alias path during the scan
ScanNextAlias       leax      >AliasRecord,u ; receive one comma-delimited alias record
                    ldy       #200      ; bound the line by the available scratch space
                    lda       AliasPath,u ; select BBS.alias
                    os9       I$ReadLn  ; fetch the next user mapping
                    bcs       WriteUnknownRecipient ; eof means the ID has no known alias
                    leax      >AliasRecord,u ; scan the record from its first byte
FindAliasSeparator  lda       ,x+       ; consume the display-name field
                    cmpa      #','      ; find the delimiter before the numeric user ID
                    bne       FindAliasSeparator ; keep scanning within the alias line
                    lda       #C$CR     ; turn the delimiter into a display-name terminator
                    sta       -1,x      ; make the name at AliasRecord directly writable
                    lbsr      ParseDecimal ; parse the numeric field following the comma
                    cmpd      >RecipientUserId,u ; compare it with the message recipient
                    bne       ScanNextAlias ; continue until the correct user is found
                    leax      >AliasRecord,u ; write the matched alias text
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the resolved recipient name
                    lda       AliasPath,u ; close the per-message alias scan
                    os9       I$Close   ; release BBS.alias
                    lbra      WriteMessageDate ; continue with the message timestamp

WriteUnknownRecipient leax     >UnknownUserText,pc ; use a stable name when the alias scan reaches EOF
                    ldy       #200      ; let I$WritLn stop at the fallback text's CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the unknown-user marker
                    lda       AliasPath,u ; select the exhausted alias file
                    os9       I$Close   ; release BBS.alias
                    lbra      WriteMessageDate ; join the common header path

WriteAllUsersRecipient leax    >AllUsersText,pc ; use the broadcast display name
                    ldy       #200      ; let I$WritLn stop at the text's CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the broadcast recipient
WriteMessageDate    leax      >DateLabel,pc ; begin the timestamp header
                    ldy       >HeaderLabelLength,pc ; write the fixed-width heading
                    lda       ArchivePath,u ; select the archive
                    os9       I$Write   ; leave the cursor after "Left on :"
* build MM/DD/YY HH:MM in place. CvtDec always emits five columns, so only its last
* two digit positions are copied for each byte-sized date component.
                    leax      <TwoDigitScratch,u ; select the shared five-digit conversion area
                    ldb       >MessageMonth,u ; zero-extend the stored month byte
                    clra                ; form the unsigned month in D
                    lbsr      CvtDec    ; render it with two useful trailing digits
                    lda       <TwoDigitTens,u ; take the month tens column
                    sta       <DateText,u ; place it at the start of the timestamp
                    lda       <TwoDigitOnes,u ; take the month ones column
                    sta       <DateMonthOnes,u ; complete the month
                    lda       #'/'      ; insert the month/day delimiter
                    sta       <DateSlash1,u ; retain it in the output buffer
                    ldb       >MessageDay,u ; zero-extend the stored day byte
                    clra                ; form the unsigned day in D
                    leax      <TwoDigitScratch,u ; reuse the conversion area
                    lbsr      CvtDec    ; render the day
                    lda       <TwoDigitTens,u ; take the day tens column
                    sta       <DateDayTens,u ; append it after the first slash
                    lda       <TwoDigitOnes,u ; take the day ones column
                    sta       <DateDayOnes,u ; complete the day
                    lda       #'/'      ; insert the day/year delimiter
                    sta       <DateSlash2,u ; retain it in the output buffer
                    ldb       >MessageYear,u ; zero-extend the stored two-digit year
                    clra                ; form the unsigned year in D
                    leax      <TwoDigitScratch,u ; reuse the conversion area
                    lbsr      CvtDec    ; render the year
                    lda       <TwoDigitTens,u ; take the year tens column
                    sta       <DateYearTens,u ; append it after the second slash
                    lda       <TwoDigitOnes,u ; take the year ones column
                    sta       <DateYearOnes,u ; complete the date
                    lda       #C$SPAC   ; separate date and time
                    sta       <DateSeparator,u ; retain the space in the output buffer
                    ldb       >MessageHour,u ; zero-extend the stored 24-hour value
                    clra                ; form the unsigned hour in D
                    leax      <TwoDigitScratch,u ; reuse the conversion area
                    lbsr      CvtDec    ; render the hour
                    lda       <TwoDigitTens,u ; take the hour tens column
                    sta       <DateHourTens,u ; begin the time portion
                    lda       <TwoDigitOnes,u ; take the hour ones column
                    sta       <DateHourOnes,u ; complete the hour
                    lda       #':'      ; insert the hour/minute delimiter
                    sta       <DateColon,u ; retain it in the output buffer
                    ldb       >MessageMinute,u ; zero-extend the stored minute byte
                    clra                ; form the unsigned minute in D
                    leax      <TwoDigitScratch,u ; reuse the conversion area
                    lbsr      CvtDec    ; render the minute
                    lda       <TwoDigitTens,u ; take the minute tens column
                    sta       <DateMinuteTens,u ; append it after the colon
                    lda       <TwoDigitOnes,u ; take the minute ones column
                    sta       <DateMinuteOnes,u ; complete the timestamp
                    lda       #C$CR     ; terminate the assembled timestamp
                    sta       <DateTerminator,u ; make it suitable for I$WritLn
                    leax      <DateText,u ; scan from the timestamp's first month digit
SkipDatePadding     lda       ,x+       ; discard any space CvtDec used for a leading zero
                    cmpa      #C$SPAC   ; stop at the first actual digit
                    beq       SkipDatePadding ; omit only leading padding, never internal fields
                    leax      -1,x      ; back up so the first digit is written
                    ldy       #200      ; let I$WritLn find the timestamp CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the formatted date and time
                    lbcs      Exit      ; propagate archive write errors
                    leax      >SubjectLabel,pc ; select the subject heading
                    ldy       >HeaderLabelLength,pc ; write its fixed nine bytes
                    lda       ArchivePath,u ; select the archive
                    os9       I$Write   ; leave the cursor after "About   :"
                    leax      >MessageSubject,u ; select the record's subject field
                    ldy       #30       ; bound output to the field's fixed width
                    os9       I$WritLn  ; append the CR-terminated subject
                    lbcs      Exit      ; propagate archive write errors
                    bra       ArchiveMessageBody ; follow the header with the stored body

SkipDeletedIndexEntry lbra     ProcessNextIndexEntry ; ignore old tombstones and inspect the next record

* seek to the 32-bit body offset and copy CR-delimited lines. A one-byte line marks
* the end of a message; pressing space while copying skips directly to the next entry.
ArchiveMessageBody  leax      >SeparatorLine,pc ; visually separate the header and body
                    ldy       #80       ; let I$WritLn stop at the separator's CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the separator
                    lda       MsgPath,u ; select the shared message body store
                    ldx       >MessageOffsetHigh,u ; load the high word of its 32-bit offset
                    pshs      u         ; save the workspace pointer before U becomes an offset
                    ldu       >MessageOffsetLow,u ; load the low word of the body offset
                    os9       I$Seek    ; position BBS.msg at this message
                    lbcs      Exit      ; propagate an invalid or inaccessible body offset
                    puls      u         ; restore the workspace pointer
CheckForAbortKey    clra                ; poll standard input without consuming by default
                    ldb       #SS.Ready ; ask whether at least one input byte is ready
                    os9       I$GetStt  ; carry set means there is nothing to consume
                    bcs       CopyMessageLine ; continue copying while the keyboard is idle
                    leax      PendingInput,u ; receive the pending keystroke
                    ldy       #1        ; consume exactly one byte
                    os9       I$Read    ; remove it from standard input
                    lda       PendingInput,u ; inspect the consumed key
                    cmpa      #C$SPAC   ; space is the operator's skip key
                    lbeq      ProcessNextIndexEntry ; abandon the rest of this body
CopyMessageLine     lda       MsgPath,u ; select BBS.msg
                    leax      >MessageLine,u ; receive one stored body line
                    ldy       #80       ; cap each physical line at the archive buffer size
                    os9       I$ReadLn  ; read through the next CR
                    lda       ArchivePath,u ; select the archive destination
                    os9       I$WritLn  ; reproduce the line verbatim
                    cmpy      #1        ; a CR-only line terminates the stored message
                    bhi       CheckForAbortKey ; copy additional nonempty lines
                    leax      >SeparatorLine,pc ; close the archived message visually
                    ldy       #200      ; let I$WritLn stop at the separator's CR
                    lda       ArchivePath,u ; select the archive
                    os9       I$WritLn  ; append the closing separator
                    leax      >MessageSpacing,pc ; select the inter-message spacing bytes
                    ldy       #5        ; retain the original generous write bound
                    os9       I$WritLn  ; add blank lines after the archived body
                    ldd       MessagesArchived,u ; update the count of copied bodies
                    addd      #1        ; account for the body just completed
                    std       MessagesArchived,u ; retain the new total
                    ldd       <DecimalTextOrRecordCount,u ; fetch the visited-record count
                    cmpd      MessagesToRemove,u ; test whether the selected prefix is complete
                    lbcs      ProcessNextIndexEntry ; tombstone and archive the next old record

* close every possible path and invoke BBS.pack to physically compact the files.
FinalizeArchive     lda       InxPath,u ; select the message index
                    os9       I$Close   ; flush tombstone writes and release the index
                    lda       MsgPath,u ; select the message body store
                    os9       I$Close   ; release the body file
                    lda       AliasPath,u ; select any alias scan left open on an error path
                    os9       I$Close   ; harmlessly attempt to release it
                    lda       ArchivePath,u ; select the optional archive
                    os9       I$Close   ; flush and release it when present
                    leax      >PackModuleName,pc ; select the companion compaction command
                    leau      >PackParameters,pc ; pass its empty CR-terminated command line
                    ldy       #1        ; parameter area contains only the CR
                    lda       #17       ; preserve the original child language/type byte
                    ldb       #3        ; allocate the original three memory pages
                    os9       F$Fork    ; start BBS.pack after all message files are closed
                    bcs       Exit      ; return the fork error if the packer cannot start
                    clrb                ; default to success before collecting child status
                    os9       F$Wait    ; wait synchronously for compaction to finish

Exit                os9       F$Exit    ; return status B to the invoking shell

* parse the first contiguous decimal run in the CR-terminated text at X.
* returns D=$FFFF when no digit appears. The original implementation walks backward
* so it can multiply each digit by 1, 10, 100, ... using only repeated addition.
ParseDecimal        pshs      y         ; preserve the caller's Y register
FindFirstDecimalDigit lda     ,x+       ; scan forward for the first digit
                    cmpa      #C$CR     ; a CR before any digit means failure
                    lbeq      DecimalNotFound ; return the parser's $FFFF sentinel
                    cmpa      #'0'      ; reject punctuation and spaces below zero
                    bcs       FindFirstDecimalDigit ; keep looking within the input line
                    cmpa      #'9'      ; reject characters above nine
                    bhi       FindFirstDecimalDigit ; keep looking within the input line
                    leax      -1,x      ; include the first digit in the following scan
FindDecimalEnd      lda       ,x+       ; advance to the first non-digit after the run
                    cmpa      #'0'      ; test the lower decimal bound
                    bcs       InitializeDecimalParse ; x now follows the digit run
                    cmpa      #'9'      ; test the upper decimal bound
                    bhi       InitializeDecimalParse ; x now follows the digit run
                    bra       FindDecimalEnd ; consume the rest of the contiguous number
InitializeDecimalParse pshs   x         ; preserve the caller-visible end pointer
                    leax      -1,x      ; point just after the number for predecrement reads
                    clr       <DecimalValue,u ; clear the high byte of the result
                    clr       <DecimalValue+1,u ; clear the low byte of the result
                    ldd       #1        ; the rightmost digit occupies the ones place
                    std       <DecimalDivisor,u ; initialize the decimal place value
AccumulatePreviousDigit lda    ,-x       ; fetch digits from right to left
                    cmpa      #'0'      ; stop when the scan leaves the numeric run
                    bcs       ReturnParsedDecimal ; return the accumulated value
                    cmpa      #'9'      ; also stop above the decimal range
                    bhi       ReturnParsedDecimal ; return the accumulated value
                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       DecimalCounter,u ; use the digit as a repeated-add count
                    ldd       #0        ; begin this digit's place-value product
MultiplyDigitByPlace tst      DecimalCounter,u ; test whether all copies were added
                    beq       AddDigitContribution ; merge the completed product into the result
                    addd      <DecimalDivisor,u ; add one copy of the current place value
                    dec       DecimalCounter,u ; consume one unit of the digit
                    bra       MultiplyDigitByPlace ; finish digit times place value

AddDigitContribution addd     <DecimalValue,u ; add this digit's contribution to the result
                    std       <DecimalValue,u ; retain the partial binary value
                    lda       #10       ; the next digit's place is ten times larger
                    sta       DecimalCounter,u ; repeat the current place value ten times
                    ldd       #0        ; begin calculating the next place value
MultiplyPlaceByTen  tst       DecimalCounter,u ; test whether ten copies have been added
                    beq       SaveNextDecimalPlace ; retain the completed power of ten
                    addd      <DecimalDivisor,u ; add another copy of the current place
                    dec       DecimalCounter,u ; consume one of the ten copies
                    bra       MultiplyPlaceByTen ; complete place times ten

SaveNextDecimalPlace std      <DecimalDivisor,u ; retain the next power of ten
                    bra       AccumulatePreviousDigit ; process the digit to the left

ReturnParsedDecimal ldd       <DecimalValue,u ; return the accumulated unsigned value in D
                    puls      x         ; return X at the end of the parsed digit run
                    puls      pc,y      ; preserve the caller's Y register on return

* convert unsigned D to five ASCII columns followed by CR at X. Leading zeroes become
* spaces, and X returns pointing at the first byte following the significant digits.
CvtDec              pshs      x         ; preserve the start of the destination buffer
                    std       <DecimalValue,u ; retain the unformatted remainder
                    lda       #'0'      ; seed all five columns with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       1,x       ; initialize the thousands column
                    sta       2,x       ; initialize the hundreds column
                    sta       3,x       ; initialize the tens column
                    sta       4,x       ; initialize the ones column
                    ldd       #10000    ; begin at the highest supported decimal place
                    std       <DecimalDivisor,u ; select the ten-thousands divisor
                    ldd       <DecimalValue,u ; recover the unformatted value
                    lbsr      EmitDecimalDigit ; emit the ten-thousands digit
                    ldd       #1000     ; select the thousands place
                    std       <DecimalDivisor,u ; publish its divisor to the helper
                    ldd       <DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the thousands digit
                    ldd       #100      ; select the hundreds place
                    std       <DecimalDivisor,u ; publish its divisor to the helper
                    ldd       <DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the hundreds digit
                    ldd       #10       ; select the tens place
                    std       <DecimalDivisor,u ; publish its divisor to the helper
                    ldd       <DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the tens digit
                    ldd       #1        ; select the ones place
                    std       <DecimalDivisor,u ; publish its divisor to the helper
                    ldd       <DecimalValue,u ; recover the final remainder
                    bsr       EmitDecimalDigit ; emit the ones digit
                    lda       #C$CR     ; terminate the five-column result
                    sta       ,x        ; append CR after the ones column
                    puls      x         ; return to the destination's first column
                    ldb       #C$SPAC   ; leading zeroes are displayed as spaces
TrimLeadingZero     lda       ,x        ; inspect the next leading column
                    cmpa      #'0'      ; preserve the first nonzero digit
                    bne       FindFormattedNumberEnd ; locate the result's trailing boundary
                    stb       ,x+       ; replace this leading zero and advance
                    bra       TrimLeadingZero ; blank any additional leading zeroes

FindFormattedNumberEnd lda    ,x+       ; scan through the significant digit run
                    cmpa      #'0'      ; a byte below zero ends the formatted number
                    bcs       ReturnFormattedNumber ; return with X at that terminator
                    cmpa      #'9'      ; a byte above nine also ends it
                    bhi       ReturnFormattedNumber ; return with X at that terminator
                    bra       FindFormattedNumberEnd ; consume another digit

ReturnFormattedNumber leax    -1,x      ; leave X pointing at the first nondigit
                    rts                 ; return the formatted buffer to the caller

* increment the current output digit while subtracting one decimal place from D.
EmitDecimalDigit    subd      <DecimalDivisor,u ; try to remove one unit of this place
                    bcs       DecimalDigitComplete ; underflow marks the finished digit
                    inc       ,x        ; record one more unit in the ASCII digit
                    bra       EmitDecimalDigit ; continue until the remainder is smaller

DecimalDigitComplete addd     <DecimalDivisor,u ; undo the subtraction that underflowed
                    std       <DecimalValue,u ; retain the remainder for the next digit
                    leax      1,x       ; advance to the next output column
                    rts                 ; return the remainder and destination position

DecimalNotFound     ldd       #$FFFF    ; return the original no-decimal-run sentinel
                    puls      pc,y      ; preserve the caller's Y register on the failure return

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
