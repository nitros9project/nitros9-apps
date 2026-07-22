**********************************************************************
* BBS.post - OS-9 Level 2 BBS command
*
* Syntax: BBS.post
* Purpose: Compose and append a public board message.
* Data: bbs.msg, bbs.msg.inx, /dd/bbs/bbs.alias, and BBS.userstats.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded addressing, composition, line editing, commit, and statistics paths.
**********************************************************************

                    nam       BBS.post
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

IndexPathNum        rmb       1         ; open BBS.msg.inx path
BodyPathNum         rmb       1         ; open BBS.msg path
AliasPathNum        rmb       1         ; open BBS.alias path
IndexShiftCount     rmb       1         ; shifts used to multiply by the 64-byte record size
DecimalCounter      rmb       1         ; repeated-addition counter for numeric conversion
EditorCommand       rmb       1         ; composition or character-editor command byte
InputLineLength     rmb       1         ; significant characters in the current 80-byte line
UserStatsPathNum    rmb       1         ; open BBS.userstats path
CallerUserId        rmb       2         ; posting user's OS-9 user ID
MessageLineNumber   rmb       1         ; high byte of the current line number
MessageLineCount    rmb       1         ; low byte and final number of stored lines
IndexOffsetTop      rmb       1         ; upper byte of a 32-bit index offset
IndexOffsetHigh     rmb       1         ; second byte of a 32-bit index offset
IndexOffsetLow      rmb       2         ; low word of a 32-bit index offset
BodyLineIndex       rmb       2         ; line counter while appending the body
BodyByteCount       rmb       2         ; bytes added to the old body-file end
ParsedNumber        rmb       1         ; high byte of a parsed decimal number
ParsedNumberLow     rmb       1         ; low byte of a parsed decimal number
DecimalPlace        rmb       2         ; current power of ten during conversion
SelectedEditLine    rmb       2         ; requested zero-based line to replace
AliasLineBuffer     rmb       200       ; one alias record
ReservedStateByte1  rmb       1         ; initialized state retained by the original program
LineNumberText      rmb       5         ; two digits, colon, and terminator for line display
ReservedStateByte2  rmb       1         ; initialized state retained by the original program
NewMessageNumber    rmb       2         ; high-message number incremented for this post
BodyEndOffsetHigh   rmb       2         ; high word of the old BBS.msg end offset
IndexHeaderTail     rmb       60        ; low offset word and remainder of index record zero
NewBodyOffsetHigh   rmb       2         ; high word stored in the new index record
NewBodyOffsetLow    rmb       2         ; low word stored in the new index record
AuthorAlias         rmb       20        ; posting user's alias
MessageSubject      rmb       30        ; subject entered for the new thread
MessageTimestamp    rmb       6         ; os-9 timestamp for the new message
AuthorUserId        rmb       2         ; posting user's numeric ID
RecipientUserId     rmb       2         ; destination ID, or -1 for all users
StatsUserId         rmb       2         ; first field of a 32-byte statistics record
StatsLoginCount     rmb       2         ; retained login count
StatsLastLoginTime  rmb       6         ; retained last-login timestamp
StatsPostCount      rmb       2         ; cumulative post count incremented here
StatsMessagesRead   rmb       2         ; retained message-read count
StatsUploads        rmb       2         ; retained upload count
StatsReserved       rmb       16        ; unused tail of the statistics record
RecipientInputBuffer rmb       200       ; addressee name entered at the prompt
MessageLineBuffer   rmb       8000      ; up to 100 fixed 80-byte composition lines
EditLineBuffer      rmb       80        ; scratch line used by the character editor
TerminalOptions     rmb       1         ; first byte of the ss.opt packet
TerminalOptionsRemainder rmb       231       ; option packet plus unused workspace tail
size                equ       .

name                fcs       /BBS.post/
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
MessageIndexPath    fcc       "BBS.msg.inx"
                    fcb       $0D
MessageBodyPath     fcc       "BBS.msg"
                    fcb       $0D
SubjectPrompt       fcb       $0A
                    fcc       "Enter subject of message"
                    fcb       $0D
                    fcb       $0A
                    fcc       ">"
RecipientPrompt     fcc       "Address message to (BLANK for ALL):"
                    fcb       $0D
                    fcb       $0A
                    fcb       $3E
SubjectPromptLength fcb       $00
                    fcb       $1C
MessageEntryPrompt  fcb       $0A
                    fcb       $0A
                    fcc       "    Please enter message now            (Blank line ends)"
                    fcb       $0D
MessageRule         fcc       "----------------------------------------------------------------"
                    fcb       $0D
AliasPath           fcc       "/dd/bbs/BBS.alias"
                    fcb       $0D
CompositionPrompt   fcb       $0A
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist"
                    fcb       $0D
EditLinePrompt      fcc       "Enter line #"
                    fcb       $0D
InputPrompt         fcb       $3E
BlankLine           fcb       $0A
                    fcb       $0D
EraseSequence       fcb       $08
                    fcb       $20
                    fcb       $08
UserStatsPath       fcc       "/dd/bbs/BBS.userstats"
                    fcb       $0D
UserNotFoundText    fcc       "User name not found!"
                    fcb       $0D
* reserve the next 64-byte index slot, capture its body-file end offset, and
* collect the new subject before resolving the destination user.
start               clr       >ReservedStateByte2,u ; initialize retained state from the original module
                    clr       >ReservedStateByte1,u ; initialize reserved state byte1
                    clr       InputLineLength,u ; initialize input line length
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sty       CallerUserId,u ; retain caller user id
                    ldy       #0        ; establish the start loop or field bound (0)
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageIndexPath,pc ; select message index path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; retain index path num
                    leax      >NewMessageNumber,u ; select new message number
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Close   ; close the selected path
                    leax      >MessageIndexPath,pc ; select message index path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; retain index path num
                    lda       #6        ; initialize index shift count to 6
                    sta       IndexShiftCount,u ; retain index shift count
                    ldd       >NewMessageNumber,u ; recover new message number
                    addd      #1        ; add to d using #1
                    std       >NewMessageNumber,u ; retain new message number
                    clr       IndexOffsetTop,u ; initialize index offset top
                    clr       IndexOffsetHigh,u ; initialize index offset high
ShiftNewIndexOffset aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       IndexOffsetHigh,u ; rotate left through carry the value at IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; consume one index shift count
                    bne       ShiftNewIndexOffset ; continue multiplying by the 64-byte record size
                    std       IndexOffsetLow,u ; retain index offset low
                    lda       IndexPathNum,u ; recover index path num
                    ldx       IndexOffsetTop,u ; recover index offset top
                    pshs      u         ; preserve u across the operation
                    ldu       IndexOffsetLow,u ; recover index offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
                    leax      >MessageTimestamp,u ; select message timestamp
                    os9       F$Time    ; read the current system date and time
                    leax      >SubjectPrompt,pc ; select subject prompt
                    ldy       >SubjectPromptLength,pc ; recover subject prompt length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    clra                ; select standard input
                    leax      >MessageSubject,u ; select message subject
                    ldy       #30       ; cap this input field at 30 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >AliasPath,pc ; select alias path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       AliasPathNum,u ; retain alias path num
* compare an uppercased recipient against BBS.alias.  A blank name records -1,
* the package's representation for a message addressed to all users.
PromptForRecipient  leax      >RecipientPrompt,pc ; ask who should receive this message
                    ldy       #38       ; cap this output request at 38 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >RecipientInputBuffer,u ; select recipient input buffer
                    ldy       #200      ; cap this input field at 200 bytes
                    clra                ; select standard input
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; test against #1
                    ble       AddressAllUsers ; mark this as a public message
UppercaseRecipient  lda       ,x+       ; consume the next byte while uppercase recipient
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; replace the byte just examined in place
                    cmpa      #13       ; recognize the carriage-return terminator
                    bne       UppercaseRecipient ; uppercase the next recipient character
ScanAliasFile       leax      <AliasLineBuffer,u ; select alias line buffer
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RecipientNotFound ; report an unknown recipient
                    leay      >RecipientInputBuffer,u ; select recipient input buffer
                    leax      <AliasLineBuffer,u ; select alias line buffer
CompareAliasName    lda       ,x+       ; consume the next byte while compare alias name
                    cmpa      #44       ; establish the compare alias name loop or field bound (44)
                    beq       AliasNameMatched ; parse the matching alias user ID
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; test against
                    bne       ScanAliasFile ; compare the next alias record
                    bra       CompareAliasName ; continue in the named workflow
AliasNameMatched    lda       ,y+       ; consume the next byte while alias name matched
                    cmpa      #13       ; recognize the carriage-return terminator
                    bne       ScanAliasFile ; compare the next alias record
                    lbsr      ParseDecimalNumber ; invoke parse decimal number
                    std       >RecipientUserId,u ; retain recipient user id
                    lda       AliasPathNum,u ; recover alias path num
                    pshs      u         ; preserve u across the operation
                    ldu       #0        ; establish the alias name matched loop or field bound (0)
                    ldx       #0        ; establish the alias name matched loop or field bound (0)
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u
                    bra       BeginMessageEntry ; continue in the named workflow
RecipientNotFound   leax      >UserNotFoundText,pc ; select user not found text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; recover alias path num
                    pshs      u         ; preserve u across the operation
                    ldu       #0        ; establish the recipient not found loop or field bound (0)
                    ldx       #0        ; initialize recipient user id to 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbra      PromptForRecipient ; continue in the named workflow
AddressAllUsers     ldd       #-1       ; initialize recipient user id to -1
                    std       >RecipientUserId,u ; retain recipient user id
* collect up to 99 fixed 80-byte lines, then let the caller abort, finish,
* replace a selected line, continue entering text, or list the draft.
BeginMessageEntry   leax      >MessageEntryPrompt,pc ; introduce the line-oriented editor
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageRule,pc ; select message rule
                    ldy       #80       ; cap this output request at 80 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       #0        ; initialize message line number to 0
                    std       MessageLineNumber,u ; retain message line number
ReadNextMessageLine ldd       MessageLineNumber,u ; recover message line number
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; retain message line number
                    cmpd      #99       ; test against #99
                    bge       PromptCompositionAction ; choose what to do with the draft
                    lbsr      ReadMessageLine ; invoke read message line
                    cmpy      #1        ; test against #1
                    bls       PromptCompositionAction ; choose what to do with the draft
                    bra       ReadNextMessageLine ; continue in the named workflow
PromptCompositionAction leax      >CompositionPrompt,pc ; select composition prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; select input prompt
                    ldy       #1        ; cap this output request at 1 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leax      EditorCommand,u ; select editor command
                    clra                ; select standard input
                    ldy       #1        ; cap this input field at 1 bytes
                    os9       I$Read    ; read the requested fixed-size field
                    leax      >BlankLine,pc ; select blank line
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       EditorCommand,u ; recover editor command
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; establish the prompt composition action loop or field bound (65)
                    lbeq      ExitSuccessfully ; restore the caller and exit successfully
                    cmpa      #68       ; establish the prompt composition action loop or field bound (68)
                    lbeq      FinishPost ; commit the completed post
                    cmpa      #69       ; establish the prompt composition action loop or field bound (69)
                    beq       EditStoredLine ; replace a selected draft line
                    cmpa      #67       ; establish the prompt composition action loop or field bound (67)
                    beq       ContinueMessageEntry ; resume body entry
                    cmpa      #76       ; establish the prompt composition action loop or field bound (76)
                    lbeq      ListMessageFromStart ; list the draft from its first line
                    bra       PromptCompositionAction ; continue in the named workflow
ContinueMessageEntry ldd       MessageLineNumber,u ; recover message line number
                    subd      #1        ; subtract from d using #1
                    std       MessageLineNumber,u ; retain message line number
                    bra       ReadNextMessageLine ; continue in the named workflow
EditStoredLine      leax      >EditLinePrompt,pc ; select edit line prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; select input prompt
                    ldy       #1        ; cap this output request at 1 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    clra                ; select standard input
                    leax      >LineNumberText,u ; select line number text
                    ldy       #3        ; cap this input field at 3 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      ParseDecimalNumber ; invoke parse decimal number
                    cmpd      MessageLineNumber,u ; test against message line number
                    lbcc      PromptCompositionAction ; choose what to do with the draft
                    std       <SelectedEditLine,u ; retain selected edit line
                    leax      >LineNumberText,u ; select line number text
                    lbsr      FormatLineNumber ; invoke format line number
                    leax      >LineNumberText,u ; select line number text
                    lda       #58       ; initialize $02 to 58
                    sta       $02,x     ; retain $02
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    ldd       <SelectedEditLine,u ; recover selected edit line
                    leax      >MessageLineBuffer,u ; select message line buffer
                    lda       #80       ; establish the edit stored line loop or field bound (80)
                    mul                 ; form the byte-product in D
                    leax      d,x       ; select d
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; transfer y,d
                    stb       InputLineLength,u ; retain input line length
                    dec       InputLineLength,u ; consume one input line length
                    leay      >EditLineBuffer,u ; select edit line buffer
CopyEditRemainder   lda       ,x+       ; consume the next byte while copy edit remainder
                    sta       ,y+       ; retain
                    decb                ; decrement b
                    bne       CopyEditRemainder ; preserve the edited line tail
                    ldd       <SelectedEditLine,u ; recover selected edit line
                    bsr       ReadMessageLine ; invoke read message line
                    lbra      PromptCompositionAction ; continue in the named workflow
ListMessageFromStart ldd       #0        ; initialize message line number to 0
                    std       MessageLineNumber,u ; retain message line number
ListNextMessageLine ldd       MessageLineNumber,u ; recover message line number
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; retain message line number
                    leax      >LineNumberText,u ; select line number text
                    lbsr      FormatLineNumber ; invoke format line number
                    leax      >LineNumberText,u ; select line number text
                    lda       #58       ; initialize $02 to 58
                    sta       $02,x     ; retain $02
                    lda       #1        ; select standard output
                    ldy       #3        ; cap this output request at 3 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MessageLineBuffer,u ; select message line buffer
                    ldd       MessageLineNumber,u ; recover message line number
                    lda       #80       ; establish the list next message line loop or field bound (80)
                    mul                 ; form the byte-product in D
                    leax      d,x       ; select d
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; test against #1
                    bhi       ListNextMessageLine ; print the next draft line
                    lbra      PromptCompositionAction ; continue in the named workflow
ReadMessageLine     leax      >LineNumberText,u ; select line number text
                    pshs      d         ; preserve d across the operation
                    lbsr      FormatLineNumber ; invoke format line number
                    leax      >LineNumberText,u ; select line number text
                    lda       #58       ; initialize $02 to 58
                    sta       $02,x     ; retain $02
                    lda       #1        ; select standard output
                    ldy       #3        ; cap this output request at 3 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >EditLineBuffer,u ; select edit line buffer
                    ldb       InputLineLength,u ; recover input line length
                    clra                ; select standard input
                    tfr       d,y       ; transfer d,y
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      d         ; restore d
                    lda       #80       ; establish the read message line loop or field bound (80)
                    mul                 ; form the byte-product in D
                    leax      >MessageLineBuffer,u ; select message line buffer
                    leax      d,x       ; select d
                    leay      >EditLineBuffer,u ; select edit line buffer
                    ldb       #80       ; initialize parsed number to 80
                    lda       InputLineLength,u ; recover input line length
                    beq       FinishStoredLine ; complete this stored line
                    sta       <ParsedNumber,u ; retain parsed number
CopyStoredLine      lda       ,y+       ; consume the next byte while copy stored line
                    sta       ,x+       ; retain
                    decb                ; decrement b
                    dec       <ParsedNumber,u ; consume one parsed number
                    bne       CopyStoredLine ; copy another input character
FinishStoredLine    clra                ; select standard input
                    tfr       d,y       ; transfer d,y
                    lbsr      EditTerminalLine ; invoke edit terminal line
                    rts                 ; return to the caller
* resolve the author's alias, construct the new 64-byte index record, append
* the body, rewrite record zero, and increment the caller's post count.
FinishPost          leax      <AliasLineBuffer,u ; scan aliases again for the caller's name
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
FindAliasIdSeparator lda       ,x+       ; consume the next byte while find alias id separator
                    cmpa      #44       ; establish the find alias id separator loop or field bound (44)
                    bne       FindAliasIdSeparator ; locate the numeric field in this alias record
                    lbsr      ParseDecimalNumber ; invoke parse decimal number
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FinishPost ; commit the completed post
                    leax      <AliasLineBuffer,u ; select alias line buffer
                    leay      >AuthorAlias,u ; select author alias
CopyAuthorAlias     lda       ,x+       ; consume the next byte while copy author alias
                    cmpa      #44       ; establish the copy author alias loop or field bound (44)
                    beq       AuthorAliasCopied ; finalize the author field
                    sta       ,y+       ; retain
                    bra       CopyAuthorAlias ; continue in the named workflow
AuthorAliasCopied   lda       #13       ; recognize the carriage-return terminator
                    sta       ,y        ; retain
                    ldd       >BodyEndOffsetHigh,u ; recover body end offset high
                    std       >NewBodyOffsetHigh,u ; retain new body offset high
                    ldd       >IndexHeaderTail,u ; recover index header tail
                    std       >NewBodyOffsetLow,u ; retain new body offset low
                    ldd       CallerUserId,u ; recover caller user id
                    std       >AuthorUserId,u ; retain author user id
                    leax      >NewBodyOffsetHigh,u ; select new body offset high
                    lda       IndexPathNum,u ; recover index path num
                    ldy       #64       ; cap this output request at 64 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageBodyPath,pc ; select message body path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       BodyPathNum,u ; retain body path num
                    pshs      u         ; preserve u across the operation
                    ldx       >BodyEndOffsetHigh,u ; recover body end offset high
                    lda       BodyPathNum,u ; recover body path num
                    ldu       >IndexHeaderTail,u ; recover index header tail
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
                    lda       #0        ; initialize body line index to 0
                    sta       <BodyLineIndex,u ; retain body line index
                    ldd       #1        ; initialize body byte count to 1
                    std       <BodyByteCount,u ; retain body byte count
AppendNextBodyLine  lda       <BodyLineIndex,u ; recover body line index
                    inca                ; preserve the flags or register state required by the following operation
                    sta       <BodyLineIndex,u ; retain body line index
                    cmpa      MessageLineCount,u ; test against message line count
                    bhi       BodyAppendComplete ; update the body-file end offset
                    ldb       #80       ; establish the append next body line loop or field bound (80)
                    mul                 ; form the byte-product in D
                    leax      >MessageLineBuffer,u ; select message line buffer
                    leax      d,x       ; select d
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       BodyPathNum,u ; recover body path num
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    cmpy      #1        ; test against #1
                    bls       BodyAppendComplete ; update the body-file end offset
                    tfr       y,d       ; transfer y,d
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       <BodyByteCount,u ; retain body byte count
                    bra       AppendNextBodyLine ; continue in the named workflow
BodyAppendComplete  ldd       >IndexHeaderTail,u ; recover index header tail
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       >IndexHeaderTail,u ; retain index header tail
                    bcc       RewriteIndexHeader ; publish the new high-message record
                    ldd       >BodyEndOffsetHigh,u ; recover body end offset high
                    addd      #1        ; add to d using #1
                    std       >BodyEndOffsetHigh,u ; retain body end offset high
RewriteIndexHeader  pshs      u         ; preserve u across the operation
                    lda       IndexPathNum,u ; recover index path num
                    ldx       #0        ; establish the rewrite index header loop or field bound (0)
                    ldu       #0        ; establish the rewrite index header loop or field bound (0)
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u
                    leax      >NewMessageNumber,u ; select new message number
                    ldy       #64       ; cap this output request at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >UserStatsPath,pc ; select user stats path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; initialize user stats path num to 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
UserStatsReady      sta       UserStatsPathNum,u ; retain user stats path num
FindUserStatsRecord leax      >StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       >StatsUserId,u ; recover stats user id
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FindUserStatsRecord ; inspect the next user record
                    bra       UpdateUserPostCount ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserPostCount ldd       >StatsPostCount,u ; recover stats post count
                    addd      #1        ; add to d using #1
                    std       >StatsPostCount,u ; retain stats post count
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
                    leax      >StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    lbra      ExitSuccessfully ; continue in the named workflow
CreateUserStatsRecord leax      >StatsUserId,u ; select stats user id
                    ldd       #1        ; initialize stats login count to 1
                    std       >StatsLoginCount,u ; retain stats login count
                    ldd       #0        ; initialize stats post count to 0
                    std       >StatsPostCount,u ; retain stats post count
                    std       >StatsMessagesRead,u ; retain stats messages read
                    std       >StatsReserved,u ; retain stats reserved
                    std       >StatsUploads,u ; retain stats uploads
                    ldd       CallerUserId,u ; recover caller user id
                    std       >StatsUserId,u ; retain stats user id
                    leax      >StatsLastLoginTime,u ; select stats last login time
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >StatsUserId,u ; select stats user id
                    ldy       #32       ; recognize the first printable ASCII value
                    lda       UserStatsPathNum,u ; recover user stats path num
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return the OS-9 status in B
ExitSuccessfully    clrb                ; clear the byte accumulator for counting
                    ldy       CallerUserId,u ; recover caller user id
                    os9       F$SUser   ; change the process user ID to Y
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* read one editable terminal line without normal echo.  The control characters
* below move, erase, terminate, and wrap within an 80-column record.
EditTerminalLine    lbsr      DisableTerminalEcho ; enter character-at-a-time terminal mode
                    ldb       InputLineLength,u ; recover input line length
                    leay      b,y       ; select b
                    pshs      y         ; preserve y across the operation
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; select d
                    clr       InputLineLength,u ; initialize input line length
                    cmpy      #0        ; test against #0
                    lbeq      AcceptEditedLine ; terminate the edited line
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; recognize the carriage-return terminator
PadUnusedInput      sta       ,x+       ; retain
                    leay      -$01,y    ; select -$01
                    bne       PadUnusedInput ; fill the unused columns with carriage returns
                    puls      y,x       ; restore y,x from the stack
EditCharacterLoop   pshs      y,x       ; save y,x on the stack
                    leax      EditorCommand,u ; select editor command
                    ldy       #1        ; cap this input field at 1 bytes
                    clra                ; select standard input
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       RetryCharacterRead ; ignore the failed or control input
                    lda       EditorCommand,u ; recover editor command
                    cmpa      #1        ; establish the edit character loop loop or field bound (1)
                    beq       MoveCursorRight ; advance across existing text
                    cmpa      #8        ; establish the edit character loop loop or field bound (8)
                    beq       ErasePreviousCharacter ; process backspace
                    cmpa      #24       ; establish the edit character loop loop or field bound (24)
                    beq       EraseCurrentCharacter ; process delete
                    cmpa      #13       ; recognize the carriage-return terminator
                    lbeq      FinishEditedLine ; accept the line on carriage return
                    cmpa      #32       ; recognize the first printable ASCII value
                    bcs       RetryCharacterRead ; ignore the failed or control input
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    lda       EditorCommand,u ; recover editor command
                    sta       ,x+       ; retain
                    leay      -$01,y    ; select -$01
                    lbeq      WrapFullInputLine ; wrap a full 80-column line
                    bra       EditCharacterLoop ; continue in the named workflow
RetryCharacterRead  puls      y,x       ; restore y,x from the stack
                    bra       EditCharacterLoop ; continue in the named workflow
MoveCursorRight     puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; select -$01
                    beq       ResumeCharacterInput ; resume at the adjusted cursor
                    lda       ,x+       ; consume the next byte while move cursor right
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       BackOverTerminator ; position before the line terminator
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; select -$01
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    bra       MoveCursorRight ; continue in the named workflow
BackOverTerminator  leax      -$01,x    ; select -$01
ResumeCharacterInput leay      $01,y     ; select $01
                    lbra      EditCharacterLoop ; continue in the named workflow
ErasePreviousCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; select $01
                    cmpy      ,s        ; test against
                    bhi       KeepCursorAtStart ; prevent backing past the buffer start
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; select -$01
                    lbra      EditCharacterLoop ; continue in the named workflow
KeepCursorAtStart   leay      -$01,y    ; select -$01
                    lbra      EditCharacterLoop ; continue in the named workflow
EraseCurrentCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; select $01
                    cmpy      ,s        ; test against
                    bhi       KeepCursorAtStart ; prevent backing past the buffer start
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; select -$01
                    cmpy      ,s        ; test against
                    lbhi      EditCharacterLoop ; read another editor character
                    pshs      y,x       ; save y,x on the stack
                    bra       EraseCurrentCharacter ; continue in the named workflow
FinishEditedLine    puls      y,x       ; restore y,x from the stack
AcceptEditedLine    lda       #13       ; recognize the carriage-return terminator
                    sta       ,x+       ; retain
                    pshs      y,x       ; save y,x on the stack
                    leax      >BlankLine,pc ; select blank line
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    puls      d         ; restore d
                    pshs      y         ; preserve y across the operation
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; release $02,s bytes of stack state
                    tfr       d,y       ; transfer d,y
                    leay      $01,y     ; select $01
                    lbsr      RestoreTerminalEcho ; invoke restore terminal echo
                    rts                 ; return to the caller
                    fcc       "50"
WrapFullInputLine   puls      d         ; restore d
                    pshs      y         ; preserve y across the operation
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; release $02,s bytes of stack state
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; transfer d,y
                    clrb                ; clear the byte accumulator for counting
FindWrapPoint       leay      -$01,y    ; select -$01
                    beq       WriteFullInputLine ; emit the full line when no boundary exists
                    lda       ,-x       ; recover
                    cmpa      #32       ; recognize the first printable ASCII value
                    beq       CarryWrappedWord ; carry the trailing word to the next line
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    incb                ; preserve the flags or register state required by the following operation
                    puls      y,x       ; restore y,x from the stack
                    bra       FindWrapPoint ; continue in the named workflow
WriteFullInputLine  lda       #13       ; recognize the carriage-return terminator
                    sta       <$004F,x  ; retain $004 f
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y
                    rts                 ; return to the caller
CarryWrappedWord    lda       #13       ; recognize the carriage-return terminator
                    sta       ,x+       ; retain
                    pshs      y,x       ; save y,x on the stack
                    stb       InputLineLength,u ; retain input line length
                    leay      >EditLineBuffer,u ; select edit line buffer
CopyWrappedWord     lda       ,x+       ; consume the next byte while copy wrapped word
                    sta       ,y+       ; retain
                    decb                ; decrement b
                    bne       CopyWrappedWord ; copy another carried character
                    leax      >BlankLine,pc ; select blank line
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      RestoreTerminalEcho ; invoke restore terminal echo
                    rts                 ; return to the caller
* update the terminal's ss.opt echo byte while preserving the editor state.
DisableTerminalEcho pshs      y,x,d     ; preserve the line editor's live registers
                    leax      >TerminalOptions,u ; select terminal options
                    clra                ; select standard input
                    ldb       #0        ; select status operation 0
                    os9       I$GetStt  ; query the selected path status
                    leax      -$20,x    ; select -$20
                    clr       <$0024,x  ; initialize $0024
                    leax      <$0020,x  ; select $0020
                    os9       I$SetStt  ; apply the selected path status operation
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
RestoreTerminalEcho pshs      y,x,d     ; save y,x,d on the stack
                    leax      >TerminalOptions,u ; select terminal options
                    clra                ; select standard input
                    ldb       #0        ; select status operation 0
                    os9       I$GetStt  ; query the selected path status
                    leax      -$20,x    ; select -$20
                    lda       #1        ; initialize $0024 to 1
                    sta       <$0024,x  ; retain $0024
                    leax      <$0020,x  ; select $0020
                    clra                ; select standard input
                    os9       I$SetStt  ; apply the selected path status operation
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
* parse the first decimal run in X; return -1 when the text has no number.
ParseDecimalNumber  pshs      y         ; preserve the caller's byte count
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
FormatLineNumber    pshs      y         ; preserve y across the operation
                    std       <ParsedNumber,u ; retain parsed number
                    lda       #48       ; recognize or generate ASCII zero
                    sta       ,x        ; retain
                    sta       $01,x     ; retain $01
                    ldd       #10       ; select the line-feed control byte
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; invoke emit decimal digit
                    ldd       #1        ; initialize decimal place to 1
                    std       <DecimalPlace,u ; retain decimal place
                    ldd       <ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; invoke emit decimal digit
                    lda       #13       ; recognize the carriage-return terminator
                    sta       ,x        ; retain
                    puls      pc,y      ; restore pc,y and return to the caller
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
