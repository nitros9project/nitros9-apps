**********************************************************************
* BBS.mail.post - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.post
* Purpose: Resolve a recipient and append private mail using the common line editor.
* Data: BBS.mail, BBS.mail.inx, and /dd/bbs/bbs.alias.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded recipient lookup, draft editing, mail-file creation, and commit paths.
**********************************************************************

                    nam       BBS.mail.post
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

IndexPathNum        rmb       1
BodyPathNum         rmb       1
AliasPathNum        rmb       1
IndexShiftCount     rmb       1
DecimalCounter      rmb       1
EditorCommand       rmb       1
InputLineLength     rmb       1
CallerUserId        rmb       2
MessageLineNumber   rmb       1
MessageLineCount    rmb       1
IndexOffsetTop      rmb       1
IndexOffsetHigh     rmb       1
IndexOffsetLow      rmb       2
BodyLineIndex       rmb       2
BodyByteCount       rmb       2
ParsedNumber        rmb       1
ParsedNumberLow     rmb       1
DecimalPlace        rmb       2
SelectedEditLine    rmb       2
AliasLineBuffer     rmb       200
RecipientInputBuffer rmb       200
ReservedStateByte1  rmb       1
LineNumberText      rmb       5
ReservedStateByte2  rmb       1
NewMessageNumber    rmb       2
BodyEndOffsetHigh   rmb       2
IndexHeaderTail     rmb       60
NewBodyOffsetHigh   rmb       2
NewBodyOffsetLow    rmb       2
AuthorAlias         rmb       20
MessageSubject      rmb       30
MessageTimestamp    rmb       6
AuthorUserId        rmb       2
RecipientUserId     rmb       2
MessageLineBuffer   rmb       8000
EditLineBuffer      rmb       80
TerminalOptions     rmb       1
TerminalOptionsRemainder rmb       231
size                equ       .

name                fcs       /BBS.mail.post/
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
MailIndexPath       fcc       "BBS.mail.inx"
                    fcb       $0D
MailBodyPath        fcc       "BBS.mail"
                    fcb       $0D
SubjectPrompt       fcc       "Enter subject of message"
                    fcb       $0D
                    fcb       $0A
                    fcc       ">"
SubjectPromptLength fcb       $00
                    fcb       $1B
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
InputPrompt         fcc       ">"
BlankLine           fcb       $0A
                    fcb       $0D
UserNotFoundText    fcc       "Sorry...cannot locate that name"
                    fcb       $0D
RecipientPrompt     fcc       "Enter the name of the Person to send mail to"
                    fcb       $0D
EraseSequence       fcb       $08
                    fcb       $20
                    fcb       $08

* resolve a mandatory private recipient before opening the mail base.
start               clr       >ReservedStateByte2,u ; initialize retained state from the original module
                    clr       >ReservedStateByte1,u ; initialize reserved state byte1
                    clr       InputLineLength,u ; initialize input line length
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sty       CallerUserId,u ; retain caller user id
                    ldy       #0        ; establish the start loop or field bound (0)
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      ExitWithStatus ; return immediately with the selected status
PromptForRecipient  leax      >RecipientPrompt,pc ; request the private-mail addressee
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; select input prompt
                    ldy       #1        ; cap this output request at 1 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    clra                ; select standard input
                    leax      >RecipientInputBuffer,u ; select recipient input buffer
                    ldy       #200      ; cap this input field at 200 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; test against #1
                    lbls      ExitSuccessfully ; finish the command successfully
UppercaseRecipient  lda       ,x+       ; consume the next byte while uppercase recipient
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       OpenAliasFile ; select open alias file when the requested case matches
                    cmpa      #97       ; establish the uppercase recipient loop or field bound (97)
                    bcs       UppercaseRecipient ; enter uppercase recipient on error or unsigned underflow
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; replace the byte just examined in place
                    bra       UppercaseRecipient ; continue with uppercase recipient
OpenAliasFile       leax      >AliasPath,pc ; select alias path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sta       AliasPathNum,u ; retain alias path num
ScanAliasFile       leax      <AliasLineBuffer,u ; select alias line buffer
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RecipientNotFound ; select recipient not found when carry reports an error or underflow
UppercaseAliasName  lda       ,x+       ; consume the next byte while uppercase alias name
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       CompareRecipientName ; enter compare recipient name when the terminating condition is met
                    cmpa      #97       ; establish the uppercase alias name loop or field bound (97)
                    bcs       UppercaseAliasName ; enter uppercase alias name on error or unsigned underflow
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; replace the byte just examined in place
                    bra       UppercaseAliasName ; continue with uppercase alias name
CompareRecipientName leax      <AliasLineBuffer,u ; select alias line buffer
                    leay      >RecipientInputBuffer,u ; select recipient input buffer
CompareNextNameCharacter lda       ,y+       ; consume the next byte while compare next name character
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       AliasNameMatched ; select alias name matched when the requested case matches
                    cmpa      ,x+       ; test against
                    beq       CompareNextNameCharacter ; enter compare next name character when the terminating condition is met
                    bra       ScanAliasFile ; continue with scan alias file
AliasNameMatched    lda       ,x+       ; consume the next byte while alias name matched
                    cmpa      #44       ; establish the alias name matched loop or field bound (44)
                    bne       ScanAliasFile ; repeat scan alias file until the terminating condition is met
                    lbsr      ParseDecimalNumber ; invoke parse decimal number
                    std       >RecipientUserId,u ; retain recipient user id
                    bra       OpenMailFiles ; continue with open mail files
RecipientNotFound   cmpb      #211      ; recognize the OS-9 end-of-file status
                    lbne      ExitWithStatus ; return immediately with the selected status
                    leax      >UserNotFoundText,pc ; select user not found text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      PromptForRecipient ; continue with prompt for recipient
* open the mail index, creating both index and body files when the base is new.
OpenMailFiles       leax      >MailIndexPath,pc ; open record zero of BBS.mail.inx
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      CreateMailFiles ; select create mail files when carry reports an error or underflow
                    sta       IndexPathNum,u ; retain index path num
                    leax      >NewMessageNumber,u ; select new message number
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Close   ; close the selected path
                    leax      >MailIndexPath,pc ; select mail index path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return immediately with the selected status
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
                    bne       ShiftNewIndexOffset ; repeat shift new index offset until the terminating condition is met
                    std       IndexOffsetLow,u ; retain index offset low
                    lda       IndexPathNum,u ; recover index path num
                    ldx       IndexOffsetTop,u ; recover index offset top
                    pshs      u         ; preserve u across the operation
                    ldu       IndexOffsetLow,u ; recover index offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    puls      u         ; restore u
                    leax      >MessageTimestamp,u ; select message timestamp
                    os9       F$Time    ; read the current system date and time
                    leax      >SubjectPrompt,pc ; select subject prompt
                    ldy       >SubjectPromptLength,pc ; recover subject prompt length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    clra                ; select standard input
                    leax      >MessageSubject,u ; select message subject
                    ldy       #30       ; cap this input field at 30 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >MessageEntryPrompt,pc ; select message entry prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    leax      >MessageRule,pc ; select message rule
                    ldy       #80       ; cap this output request at 80 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    ldd       #0        ; initialize message line number to 0
                    std       MessageLineNumber,u ; retain message line number
ReadNextMessageLine ldd       MessageLineNumber,u ; recover message line number
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; retain message line number
                    cmpd      #99       ; test against #99
                    bge       PromptCompositionAction ; continue with prompt composition action at or above the signed limit
                    lbsr      ReadMessageLine ; invoke read message line
                    cmpy      #1        ; test against #1
                    bls       PromptCompositionAction ; ask again at prompt composition action
                    bra       ReadNextMessageLine ; continue with read next message line
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
                    lbeq      ExitSuccessfully ; finish the command successfully
                    cmpa      #68       ; establish the prompt composition action loop or field bound (68)
                    lbeq      FinishMail ; select finish mail when the requested case matches
                    cmpa      #69       ; establish the prompt composition action loop or field bound (69)
                    beq       EditStoredLine ; select edit stored line when the requested case matches
                    cmpa      #67       ; establish the prompt composition action loop or field bound (67)
                    beq       ContinueMessageEntry ; select continue message entry when the requested case matches
                    cmpa      #76       ; establish the prompt composition action loop or field bound (76)
                    lbeq      ListMessageFromStart ; enter list message from start when the terminating condition is met
                    bra       PromptCompositionAction ; continue with prompt composition action
ContinueMessageEntry ldd       MessageLineNumber,u ; recover message line number
                    subd      #1        ; subtract from d using #1
                    std       MessageLineNumber,u ; retain message line number
                    bra       ReadNextMessageLine ; continue with read next message line
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
                    lbcc      PromptCompositionAction ; ask again at prompt composition action
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
                    bne       CopyEditRemainder ; repeat copy edit remainder until the terminating condition is met
                    ldd       <SelectedEditLine,u ; recover selected edit line
                    bsr       ReadMessageLine ; invoke read message line
                    lbra      PromptCompositionAction ; continue with prompt composition action
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
                    bhi       ListNextMessageLine ; continue list next message line while the range test permits it
                    lbra      PromptCompositionAction ; continue with prompt composition action
ReadMessageLine     leax      >LineNumberText,u ; select line number text
                    pshs      d         ; preserve d across the operation
                    lbsr      FormatLineNumber ; invoke format line number
                    leax      >LineNumberText,u ; select line number text
                    lda       #58       ; initialize $02 to 58
                    sta       $02,x     ; retain $02
                    lda       #1        ; select standard output
                    ldy       #3        ; cap this output request at 3 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return immediately with the selected status
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
                    beq       FinishStoredLine ; select finish stored line when the requested case matches
                    sta       <ParsedNumber,u ; retain parsed number
CopyStoredLine      lda       ,y+       ; consume the next byte while copy stored line
                    sta       ,x+       ; retain
                    decb                ; decrement b
                    dec       <ParsedNumber,u ; consume one parsed number
                    bne       CopyStoredLine ; repeat copy stored line until the terminating condition is met
FinishStoredLine    clra                ; select standard input
                    tfr       d,y       ; transfer d,y
                    lbsr      EditTerminalLine ; invoke edit terminal line
                    rts                 ; return to the caller
* resolve the author's alias, append the 64-byte index record and body, then
* publish the new high-message record at the start of BBS.mail.inx.
FinishMail          leax      >AliasPath,pc ; reopen aliases for the author lookup
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sta       AliasPathNum,u ; retain alias path num
FindAuthorAlias     leax      <AliasLineBuffer,u ; select alias line buffer
                    ldy       #200      ; cap this input field at 200 bytes
                    lda       AliasPathNum,u ; recover alias path num
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; return immediately with the selected status
FindAliasIdSeparator lda       ,x+       ; consume the next byte while find alias id separator
                    cmpa      #44       ; establish the find alias id separator loop or field bound (44)
                    bne       FindAliasIdSeparator ; repeat find alias id separator until the terminating condition is met
                    lbsr      ParseDecimalNumber ; invoke parse decimal number
                    cmpd      CallerUserId,u ; test against caller user id
                    bne       FindAuthorAlias ; repeat find author alias until the terminating condition is met
                    leax      <AliasLineBuffer,u ; select alias line buffer
                    leay      >AuthorAlias,u ; select author alias
CopyAuthorAlias     lda       ,x+       ; consume the next byte while copy author alias
                    cmpa      #44       ; establish the copy author alias loop or field bound (44)
                    beq       AuthorAliasCopied ; select author alias copied when the requested case matches
                    sta       ,y+       ; retain
                    bra       CopyAuthorAlias ; continue with copy author alias
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
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    leax      >MailBodyPath,pc ; select mail body path
                    lda       #3        ; request OS-9 access mode 3
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sta       BodyPathNum,u ; retain body path num
                    pshs      u         ; preserve u across the operation
                    ldx       >BodyEndOffsetHigh,u ; recover body end offset high
                    lda       BodyPathNum,u ; recover body path num
                    ldu       >IndexHeaderTail,u ; recover index header tail
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    puls      u         ; restore u
                    lda       #0        ; initialize body line index to 0
                    sta       BodyLineIndex,u ; retain body line index
                    ldd       #1        ; initialize body byte count to 1
                    std       <BodyByteCount,u ; retain body byte count
AppendNextBodyLine  lda       BodyLineIndex,u ; recover body line index
                    inca                ; preserve the flags or register state required by the following operation
                    sta       BodyLineIndex,u ; retain body line index
                    cmpa      MessageLineCount,u ; test against message line count
                    bhi       BodyAppendComplete ; select body append complete above the unsigned boundary
                    ldb       #80       ; establish the append next body line loop or field bound (80)
                    mul                 ; form the byte-product in D
                    leax      >MessageLineBuffer,u ; select message line buffer
                    leax      d,x       ; select d
                    ldy       #80       ; cap this output request at 80 bytes
                    lda       BodyPathNum,u ; recover body path num
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    cmpy      #1        ; test against #1
                    bls       BodyAppendComplete ; select body append complete at or below the unsigned boundary
                    tfr       y,d       ; transfer y,d
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       <BodyByteCount,u ; retain body byte count
                    bra       AppendNextBodyLine ; continue with append next body line
BodyAppendComplete  ldd       >IndexHeaderTail,u ; recover index header tail
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       >IndexHeaderTail,u ; retain index header tail
                    bcc       RewriteIndexHeader ; select rewrite index header when carry remains clear
                    ldd       >BodyEndOffsetHigh,u ; recover body end offset high
                    addd      #1        ; add to d using #1
                    std       >BodyEndOffsetHigh,u ; retain body end offset high
RewriteIndexHeader  pshs      u         ; preserve u across the operation
                    lda       IndexPathNum,u ; recover index path num
                    ldx       #0        ; establish the rewrite index header loop or field bound (0)
                    ldu       #0        ; establish the rewrite index header loop or field bound (0)
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    puls      u         ; restore u
                    leax      >NewMessageNumber,u ; select new message number
                    ldy       #64       ; cap this output request at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return immediately with the selected status
ExitSuccessfully    clrb                ; clear the byte accumulator for counting
                    ldy       CallerUserId,u ; recover caller user id
                    os9       F$SUser   ; change the process user ID to Y
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* edit one 80-column line with terminal echo temporarily disabled.
EditTerminalLine    lbsr      DisableTerminalEcho ; enter character-at-a-time terminal mode
                    ldb       InputLineLength,u ; recover input line length
                    leay      b,y       ; select b
                    pshs      y         ; preserve y across the operation
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; select d
                    clr       InputLineLength,u ; initialize input line length
                    cmpy      #0        ; test against #0
                    lbeq      AcceptEditedLine ; select accept edited line when the requested case matches
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; recognize the carriage-return terminator
PadUnusedInput      sta       ,x+       ; retain
                    leay      -$01,y    ; select -$01
                    bne       PadUnusedInput ; select pad unused input when the requested case does not match
                    puls      y,x       ; restore y,x from the stack
EditCharacterLoop   pshs      y,x       ; save y,x on the stack
                    leax      EditorCommand,u ; select editor command
                    ldy       #1        ; cap this input field at 1 bytes
                    clra                ; select standard input
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       RetryCharacterRead ; select retry character read when carry reports an error or underflow
                    lda       EditorCommand,u ; recover editor command
                    cmpa      #1        ; establish the edit character loop loop or field bound (1)
                    beq       MoveCursorRight ; select move cursor right when the requested case matches
                    cmpa      #8        ; establish the edit character loop loop or field bound (8)
                    beq       ErasePreviousCharacter ; select erase previous character when the requested case matches
                    cmpa      #24       ; establish the edit character loop loop or field bound (24)
                    beq       EraseCurrentCharacter ; select erase current character when the requested case matches
                    cmpa      #13       ; recognize the carriage-return terminator
                    lbeq      FinishEditedLine ; select finish edited line when the requested case matches
                    cmpa      #32       ; recognize the first printable ASCII value
                    bcs       RetryCharacterRead ; select retry character read when carry reports an error or underflow
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    lda       EditorCommand,u ; recover editor command
                    sta       ,x+       ; retain
                    leay      -$01,y    ; select -$01
                    lbeq      WrapFullInputLine ; select wrap full input line when the requested case matches
                    bra       EditCharacterLoop ; continue with edit character loop
RetryCharacterRead  puls      y,x       ; restore y,x from the stack
                    bra       EditCharacterLoop ; continue with edit character loop
MoveCursorRight     puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; select -$01
                    beq       ResumeCharacterInput ; select resume character input when the requested case matches
                    lda       ,x+       ; consume the next byte while move cursor right
                    cmpa      #13       ; recognize the carriage-return terminator
                    beq       BackOverTerminator ; select back over terminator when the requested case matches
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; select -$01
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    bra       MoveCursorRight ; continue with move cursor right
BackOverTerminator  leax      -$01,x    ; select -$01
ResumeCharacterInput leay      $01,y     ; select $01
                    lbra      EditCharacterLoop ; continue with edit character loop
ErasePreviousCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; select $01
                    cmpy      ,s        ; test against
                    bhi       KeepCursorAtStart ; select keep cursor at start above the unsigned boundary
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; select -$01
                    lbra      EditCharacterLoop ; continue with edit character loop
KeepCursorAtStart   leay      -$01,y    ; select -$01
                    lbra      EditCharacterLoop ; continue with edit character loop
EraseCurrentCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; select $01
                    cmpy      ,s        ; test against
                    bhi       KeepCursorAtStart ; select keep cursor at start above the unsigned boundary
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; select -$01
                    cmpy      ,s        ; test against
                    lbhi      EditCharacterLoop ; select edit character loop above the unsigned boundary
                    pshs      y,x       ; save y,x on the stack
                    bra       EraseCurrentCharacter ; continue with erase current character
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
                    beq       WriteFullInputLine ; enter write full input line when the terminating condition is met
                    lda       ,-x       ; recover
                    cmpa      #32       ; recognize the first printable ASCII value
                    beq       CarryWrappedWord ; select carry wrapped word when the requested case matches
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; select erase sequence
                    ldy       #3        ; cap this output request at 3 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    incb                ; preserve the flags or register state required by the following operation
                    puls      y,x       ; restore y,x from the stack
                    bra       FindWrapPoint ; continue with find wrap point
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
                    bne       CopyWrappedWord ; repeat copy wrapped word until the terminating condition is met
                    leax      >BlankLine,pc ; select blank line
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      RestoreTerminalEcho ; invoke restore terminal echo
                    rts                 ; return to the caller
DisableTerminalEcho pshs      y,x,d     ; save y,x,d on the stack
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
ParseDecimalNumber  pshs      y         ; preserve y across the operation
FindFirstDigit      lda       ,x+       ; consume the next byte while find first digit
                    cmpa      #13       ; recognize the carriage-return terminator
                    lbeq      NoDecimalNumber ; select no decimal number when the requested case matches
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       FindFirstDigit ; enter find first digit on error or unsigned underflow
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       FindFirstDigit ; continue find first digit while the range test permits it
                    leax      -$01,x    ; select -$01
FindDigitRunEnd     lda       ,x+       ; consume the next byte while find digit run end
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       AccumulateDigits ; enter accumulate digits on error or unsigned underflow
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       AccumulateDigits ; continue accumulate digits while the range test permits it
                    bra       FindDigitRunEnd ; continue with find digit run end
AccumulateDigits    pshs      x         ; preserve x across the operation
                    leax      -$01,x    ; select -$01
                    clr       <ParsedNumber,u ; initialize parsed number
                    clr       <ParsedNumberLow,u ; initialize parsed number low
                    ldd       #1        ; initialize decimal place to 1
                    std       <DecimalPlace,u ; retain decimal place
AccumulatePreviousDigit lda       ,-x       ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       ReturnParsedNumber ; select return parsed number when carry reports an error or underflow
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       ReturnParsedNumber ; select return parsed number above the unsigned boundary
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; establish the accumulate previous digit loop or field bound (0)
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; select store digit sum when the requested case matches
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       AddDigitPlace ; continue with add digit place
StoreDigitSum       addd      <ParsedNumber,u ; add to d using <ParsedNumber,u
                    std       <ParsedNumber,u ; retain parsed number
                    lda       #10       ; select the line-feed control byte
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; establish the store digit sum loop or field bound (0)
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; select use next decimal place when the requested case matches
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       MultiplyPlaceByTen ; continue with multiply place by ten
UseNextDecimalPlace std       <DecimalPlace,u ; retain decimal place
                    bra       AccumulatePreviousDigit ; continue with accumulate previous digit
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
                    bcs       DecimalDigitComplete ; select decimal digit complete when carry reports an error or underflow
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue with emit decimal digit
DecimalDigitComplete addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    std       <ParsedNumber,u ; retain parsed number
                    leax      $01,x     ; select $01
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; establish the no decimal number loop or field bound (-1)
                    puls      pc,y      ; restore pc,y and return to the caller
CreateMailFiles     leax      >MailIndexPath,pc ; select mail index path
                    lda       #11       ; initialize index path num to 11
                    tfr       a,b       ; transfer a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sta       IndexPathNum,u ; retain index path num
                    leax      >MailBodyPath,pc ; select mail body path
                    lda       #11       ; initialize body path num to 11
                    tfr       a,b       ; transfer a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    sta       BodyPathNum,u ; retain body path num
                    leax      >NewMessageNumber,u ; select new message number
                    ldd       #0        ; initialize  to 0
                    std       ,x        ; retain
                    std       $02,x     ; retain $02
                    std       $04,x     ; retain $04
                    lda       IndexPathNum,u ; recover index path num
                    ldy       #64       ; cap this output request at 64 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    os9       I$Close   ; close the selected path
                    lbcs      ExitWithStatus ; return immediately with the selected status
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Close   ; close the selected path
                    lda       BodyPathNum,u ; recover body path num
                    os9       I$Close   ; close the selected path
                    lbra      OpenMailFiles ; continue with open mail files

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
