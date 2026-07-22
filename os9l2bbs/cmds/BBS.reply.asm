**********************************************************************
* BBS.reply - OS-9 Level 2 BBS command
*
* Syntax: BBS.reply
* Purpose: Compose a response linked to an existing message thread.
* Reads the parent index/body record and appends a new message.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded recipient lookup, composition, line editing, and commit control flow.
**********************************************************************

                    nam       BBS.reply
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

IndexPathNum        rmb       1         ; open BBS.msg.inx path
BodyPathNum         rmb       1         ; open BBS.msg path
AliasPathNum        rmb       1         ; open BBS.alias path
IndexShiftCount     rmb       1         ; shifts used to multiply by the 64-byte record size
DecimalCounter      rmb       1         ; repeated-addition counter for numeric conversion
EditorCommand       rmb       1         ; composition or character-editor command byte
InputLineLength     rmb       1         ; significant characters in the current 80-byte line
UserStatsPathNum    rmb       1         ; open BBS.userstats path
ReplySubjectPointer rmb       2         ; parameter pointer supplied by BBS.read
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
NewMessageNumber    rmb       2         ; high-message number incremented for this reply
BodyEndOffsetHigh   rmb       2         ; high word of the old BBS.msg end offset
IndexHeaderTail     rmb       60        ; low offset word and remainder of index record zero
NewBodyOffsetHigh   rmb       2         ; high word stored in the new index record
NewBodyOffsetLow    rmb       2         ; low word stored in the new index record
AuthorAlias         rmb       20        ; posting user's alias
ReplySubject        rmb       30        ; inherited thread subject
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
MessageLineBuffer   rmb       8000      ; up to 100 fixed 80-byte composition lines
EditLineBuffer      rmb       80        ; scratch line used by the character editor
TerminalOptions     rmb       32        ; ss.opt packet used to toggle terminal echo
RecipientInput      rmb       1         ; first byte of the recipient-name buffer
RecipientInputRemainder rmb       399       ; remainder of the recipient-name buffer
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.reply/ ; store an OS-9 high-bit-terminated string
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
MessageIndexPath    fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
MessageBodyPath     fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1C       ; store byte data
MessageEntryPrompt  fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
MessageRule         fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
AliasPath           fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
CompositionPrompt   fcb       $0A       ; store byte data
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
EditLinePrompt      fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
InputPrompt         fcb       $3E       ; store byte data
BlankLine           fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
EraseSequence       fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
UserStatsPath       fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
UserNotFoundText    fcc       "User name not found!" ; store literal character data
                    fcb       $0D       ; store byte data
RecipientPrompt     fcc       "Address message to (BLANK for ALL)" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
* retain the subject passed by BBS.read, switch to superuser access, and reserve
* the next 64-byte slot in BBS.msg.inx.
start               stx       ReplySubjectPointer,u ; retain the parent subject parameter
                    clr       >ReservedStateByte2,u ; clear >ReservedStateByte2,u to zero and set the condition codes
                    clr       >ReservedStateByte1,u ; clear >ReservedStateByte1,u to zero and set the condition codes
                    clr       InputLineLength,u ; clear InputLineLength,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sty       CallerUserId,u ; store y at CallerUserId,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >MessageIndexPath,pc ; form the address >MessageIndexPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    lda       #6        ; set a to the constant 6
                    sta       IndexShiftCount,u ; store a at IndexShiftCount,u
                    ldd       >NewMessageNumber,u ; load d from >NewMessageNumber,u
                    addd      #1        ; add to d using #1
                    std       >NewMessageNumber,u ; store d at >NewMessageNumber,u
                    clr       IndexOffsetTop,u ; clear IndexOffsetTop,u to zero and set the condition codes
                    clr       IndexOffsetHigh,u ; clear IndexOffsetHigh,u to zero and set the condition codes
ShiftNewIndexOffset aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       IndexOffsetHigh,u ; rotate left through carry the value at IndexOffsetHigh,u
                    dec       IndexShiftCount,u ; decrement the value at IndexShiftCount,u
                    bne       ShiftNewIndexOffset ; branch when the values differ or the result is nonzero; target ShiftNewIndexOffset
                    std       <IndexOffsetLow,u ; store d at <IndexOffsetLow,u
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldx       IndexOffsetTop,u ; load x from IndexOffsetTop,u
                    pshs      u         ; save u on the stack
                    ldu       <IndexOffsetLow,u ; load u from <IndexOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    puls      u         ; restore u from the stack
                    leax      >MessageTimestamp,u ; form the address >MessageTimestamp,u in x
                    os9       F$Time    ; read the current system date and time
                    ldx       ReplySubjectPointer,u ; load x from ReplySubjectPointer,u
                    leay      >ReplySubject,u ; form the address >ReplySubject,u in y
                    ldb       #30       ; set b to the constant 30
CopyReplySubject    lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       ReplySubjectCopied ; branch when the values are equal or the result is zero; target ReplySubjectCopied
                    decb                ; decrement b
                    bne       CopyReplySubject ; branch when the values differ or the result is nonzero; target CopyReplySubject
ReplySubjectCopied  leax      >AliasPath,pc ; form the address >AliasPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
* resolve a private recipient by comparing an uppercased name against BBS.alias;
* a blank response deliberately records recipient -1 for a public message.
PromptForRecipient  leax      >RecipientPrompt,pc ; ask who should receive the reply
                    ldy       #36       ; set y to the constant 36
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >RecipientInput,u ; form the address >RecipientInput,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       AddressAllUsers ; branch when the signed value is less than or equal; target AddressAllUsers
UppercaseRecipient  lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       UppercaseRecipient ; branch when the values differ or the result is nonzero; target UppercaseRecipient
ScanAliasFile       leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RecipientNotFound ; branch when carry reports an error or unsigned underflow; target RecipientNotFound
                    leay      >RecipientInput,u ; form the address >RecipientInput,u in y
                    leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
CompareAliasName    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       AliasNameMatched ; branch when the values are equal or the result is zero; target AliasNameMatched
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       ScanAliasFile ; branch when the values differ or the result is nonzero; target ScanAliasFile
                    bra       CompareAliasName ; continue execution at CompareAliasName
AliasNameMatched    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       ScanAliasFile ; branch when the values differ or the result is nonzero; target ScanAliasFile
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    std       >RecipientUserId,u ; store d at >RecipientUserId,u
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       BeginMessageEntry ; continue execution at BeginMessageEntry
RecipientNotFound   leax      >UserNotFoundText,pc ; form the address >UserNotFoundText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbra      PromptForRecipient ; continue execution at PromptForRecipient
AddressAllUsers     ldd       #-1       ; set d to the constant -1
                    std       >RecipientUserId,u ; store d at >RecipientUserId,u
* collect as many as 99 fixed 80-byte lines, then offer abort, done, edit,
* continue, and list operations over the in-memory message buffer.
BeginMessageEntry   leax      >MessageEntryPrompt,pc ; introduce the line-oriented editor
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >MessageRule,pc ; form the address >MessageRule,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    ldd       #0        ; set d to the constant 0
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
ReadNextMessageLine ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       PromptCompositionAction ; branch when the signed value is greater than or equal; target PromptCompositionAction
                    lbsr      ReadMessageLine ; call subroutine ReadMessageLine
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       PromptCompositionAction ; branch when the unsigned value is lower or equal; target PromptCompositionAction
                    bra       ReadNextMessageLine ; continue execution at ReadNextMessageLine
PromptCompositionAction leax      >CompositionPrompt,pc ; form the address >CompositionPrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; form the address >InputPrompt,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      EditorCommand,u ; form the address EditorCommand,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       EditorCommand,u ; load a from EditorCommand,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      AbortReply ; branch when the values are equal or the result is zero; target AbortReply
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      FinishReply ; branch when the values are equal or the result is zero; target FinishReply
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       EditStoredLine ; branch when the values are equal or the result is zero; target EditStoredLine
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       ContinueMessageEntry ; branch when the values are equal or the result is zero; target ContinueMessageEntry
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    beq       ListMessageFromStart ; branch when the values are equal or the result is zero; target ListMessageFromStart
                    bra       PromptCompositionAction ; continue execution at PromptCompositionAction
ContinueMessageEntry ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    subd      #1        ; subtract from d using #1
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
                    bra       ReadNextMessageLine ; continue execution at ReadNextMessageLine
EditStoredLine      leax      >EditLinePrompt,pc ; form the address >EditLinePrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; form the address >InputPrompt,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    cmpd      MessageLineNumber,u ; compare d with MessageLineNumber,u and set the condition codes
                    lbcc      PromptCompositionAction ; branch when carry is clear; target PromptCompositionAction
                    std       <SelectedEditLine,u ; store d at <SelectedEditLine,u
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lbsr      FormatLineNumber ; call subroutine FormatLineNumber
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <SelectedEditLine,u ; load d from <SelectedEditLine,u
                    leax      >MessageLineBuffer,u ; form the address >MessageLineBuffer,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <SelectedEditLine,u ; load d from <SelectedEditLine,u
                    bsr       ReadMessageLine ; call subroutine ReadMessageLine
                    lbra      PromptCompositionAction ; continue execution at PromptCompositionAction
ListMessageFromStart ldd       #0        ; set d to the constant 0
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
ListNextMessageLine ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lbsr      FormatLineNumber ; call subroutine FormatLineNumber
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MessageLineBuffer,u ; form the address >MessageLineBuffer,u in x
                    ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       ListNextMessageLine ; branch when the unsigned value is higher; target ListNextMessageLine
                    lbra      PromptCompositionAction ; continue execution at PromptCompositionAction
ReadMessageLine     leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    pshs      d         ; save d on the stack
                    lbsr      FormatLineNumber ; call subroutine FormatLineNumber
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >EditLineBuffer,u ; form the address >EditLineBuffer,u in x
                    ldb       InputLineLength,u ; load b from InputLineLength,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >MessageLineBuffer,u ; form the address >MessageLineBuffer,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >EditLineBuffer,u ; form the address >EditLineBuffer,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       InputLineLength,u ; load a from InputLineLength,u
                    beq       FinishStoredLine ; branch when the values are equal or the result is zero; target FinishStoredLine
                    sta       <ParsedNumber,u ; store a at <ParsedNumber,u
CopyStoredLine      lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <ParsedNumber,u ; decrement the value at <ParsedNumber,u
                    bne       CopyStoredLine ; branch when the values differ or the result is nonzero; target CopyStoredLine
FinishStoredLine    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      EditTerminalLine ; call subroutine EditTerminalLine
                    rts                 ; return to the caller
* recover the caller's alias, build the new 64-byte index record, append the
* body text, publish the new high-message header, and increment post statistics.
FinishReply         leax      <AliasLineBuffer,u ; rewind the alias file scan buffer
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
FindAliasIdSeparator lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       FindAliasIdSeparator ; branch when the values differ or the result is nonzero; target FindAliasIdSeparator
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FinishReply ; branch when the values differ or the result is nonzero; target FinishReply
                    leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    leay      >AuthorAlias,u ; form the address >AuthorAlias,u in y
CopyAuthorAlias     lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       AuthorAliasCopied ; branch when the values are equal or the result is zero; target AuthorAliasCopied
                    sta       ,y+       ; store a at ,y+
                    bra       CopyAuthorAlias ; continue execution at CopyAuthorAlias
AuthorAliasCopied   lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    ldd       >BodyEndOffsetHigh,u ; load d from >BodyEndOffsetHigh,u
                    std       >NewBodyOffsetHigh,u ; store d at >NewBodyOffsetHigh,u
                    ldd       >IndexHeaderTail,u ; load d from >IndexHeaderTail,u
                    std       >NewBodyOffsetLow,u ; store d at >NewBodyOffsetLow,u
                    ldd       CallerUserId,u ; load d from CallerUserId,u
                    std       >AuthorUserId,u ; store d at >AuthorUserId,u
                    leax      >NewBodyOffsetHigh,u ; form the address >NewBodyOffsetHigh,u in x
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >MessageBodyPath,pc ; form the address >MessageBodyPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       BodyPathNum,u ; store a at BodyPathNum,u
                    pshs      u         ; save u on the stack
                    ldx       >BodyEndOffsetHigh,u ; load x from >BodyEndOffsetHigh,u
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    ldu       >IndexHeaderTail,u ; load u from >IndexHeaderTail,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <BodyLineIndex,u ; store a at <BodyLineIndex,u
                    ldd       #1        ; set d to the constant 1
                    std       <BodyByteCount,u ; store d at <BodyByteCount,u
AppendNextBodyLine  lda       <BodyLineIndex,u ; load a from <BodyLineIndex,u
                    inca                ; increment a
                    sta       <BodyLineIndex,u ; store a at <BodyLineIndex,u
                    cmpa      MessageLineCount,u ; compare a with MessageLineCount,u and set the condition codes
                    bhi       BodyAppendComplete ; branch when the unsigned value is higher; target BodyAppendComplete
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >MessageLineBuffer,u ; form the address >MessageLineBuffer,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       BodyAppendComplete ; branch when the unsigned value is lower or equal; target BodyAppendComplete
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       <BodyByteCount,u ; store d at <BodyByteCount,u
                    bra       AppendNextBodyLine ; continue execution at AppendNextBodyLine
BodyAppendComplete  ldd       >IndexHeaderTail,u ; load d from >IndexHeaderTail,u
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       >IndexHeaderTail,u ; store d at >IndexHeaderTail,u
                    bcc       RewriteIndexHeader ; branch when carry is clear; target RewriteIndexHeader
                    ldd       >BodyEndOffsetHigh,u ; load d from >BodyEndOffsetHigh,u
                    addd      #1        ; add to d using #1
                    std       >BodyEndOffsetHigh,u ; store d at >BodyEndOffsetHigh,u
RewriteIndexHeader  pshs      u         ; save u on the stack
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    puls      u         ; restore u from the stack
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >UserStatsPath,pc ; form the address >UserStatsPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       UserStatsReady ; branch when carry is clear; target UserStatsReady
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
UserStatsReady      sta       UserStatsPathNum,u ; store a at UserStatsPathNum,u
FindUserStatsRecord leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       UserStatsScanEnded ; branch when carry reports an error or unsigned underflow; target UserStatsScanEnded
                    ldd       >StatsUserId,u ; load d from >StatsUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindUserStatsRecord ; branch when the values differ or the result is nonzero; target FindUserStatsRecord
                    bra       UpdateUserPostCount ; continue execution at UpdateUserPostCount
UserStatsScanEnded  cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; branch when the values differ or the result is nonzero; target ExitWithStatus
                    lbra      CreateUserStatsRecord ; continue execution at CreateUserStatsRecord
UpdateUserPostCount ldd       >StatsPostCount,u ; load d from >StatsPostCount,u
                    addd      #1        ; add to d using #1
                    std       >StatsPostCount,u ; store d at >StatsPostCount,u
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       HaveStatsWriteOffset ; branch when the signed value is greater than or equal; target HaveStatsWriteOffset
                    leax      -$01,x    ; form the address -$01,x in x
HaveStatsWriteOffset ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    puls      u         ; restore u from the stack
                    leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      ExitSuccessfully ; continue execution at ExitSuccessfully
CreateUserStatsRecord leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldd       #1        ; set d to the constant 1
                    std       >StatsLoginCount,u ; store d at >StatsLoginCount,u
                    ldd       #0        ; set d to the constant 0
                    std       >StatsPostCount,u ; store d at >StatsPostCount,u
                    std       >StatsMessagesRead,u ; store d at >StatsMessagesRead,u
                    std       >StatsReserved,u ; store d at >StatsReserved,u
                    std       >StatsUploads,u ; store d at >StatsUploads,u
                    ldd       CallerUserId,u ; load d from CallerUserId,u
                    std       >StatsUserId,u ; store d at >StatsUserId,u
                    leax      >StatsLastLoginTime,u ; form the address >StatsLastLoginTime,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
                    ldy       CallerUserId,u ; load y from CallerUserId,u
                    os9       F$SUser   ; change the process user ID to Y
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
AbortReply          ldb       #1        ; set b to the constant 1
                    bra       ExitWithStatus ; continue execution at ExitWithStatus
* read one editable terminal line with echo disabled.  The control keys below
* move, erase, terminate, and wrap text while preserving an 80-column record.
EditTerminalLine    lbsr      DisableTerminalEcho ; enter character-at-a-time terminal mode
                    ldb       InputLineLength,u ; load b from InputLineLength,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       InputLineLength,u ; clear InputLineLength,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      AcceptEditedLine ; branch when the values are equal or the result is zero; target AcceptEditedLine
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
PadUnusedInput      sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       PadUnusedInput ; branch when the values differ or the result is nonzero; target PadUnusedInput
                    puls      y,x       ; restore y,x from the stack
EditCharacterLoop   pshs      y,x       ; save y,x on the stack
                    leax      EditorCommand,u ; form the address EditorCommand,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       RetryCharacterRead ; branch when carry reports an error or unsigned underflow; target RetryCharacterRead
                    lda       EditorCommand,u ; load a from EditorCommand,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       MoveCursorRight ; branch when the values are equal or the result is zero; target MoveCursorRight
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       ErasePreviousCharacter ; branch when the values are equal or the result is zero; target ErasePreviousCharacter
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       EraseCurrentCharacter ; branch when the values are equal or the result is zero; target EraseCurrentCharacter
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      FinishEditedLine ; branch when the values are equal or the result is zero; target FinishEditedLine
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       RetryCharacterRead ; branch when carry reports an error or unsigned underflow; target RetryCharacterRead
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       EditorCommand,u ; load a from EditorCommand,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      WrapFullInputLine ; branch when the values are equal or the result is zero; target WrapFullInputLine
                    bra       EditCharacterLoop ; continue execution at EditCharacterLoop
RetryCharacterRead  puls      y,x       ; restore y,x from the stack
                    bra       EditCharacterLoop ; continue execution at EditCharacterLoop
MoveCursorRight     puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       ResumeCharacterInput ; branch when the values are equal or the result is zero; target ResumeCharacterInput
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       BackOverTerminator ; branch when the values are equal or the result is zero; target BackOverTerminator
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       MoveCursorRight ; continue execution at MoveCursorRight
BackOverTerminator  leax      -$01,x    ; form the address -$01,x in x
ResumeCharacterInput leay      $01,y     ; form the address $01,y in y
                    lbra      EditCharacterLoop ; continue execution at EditCharacterLoop
ErasePreviousCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       KeepCursorAtStart ; branch when the unsigned value is higher; target KeepCursorAtStart
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      EditCharacterLoop ; continue execution at EditCharacterLoop
KeepCursorAtStart   leay      -$01,y    ; form the address -$01,y in y
                    lbra      EditCharacterLoop ; continue execution at EditCharacterLoop
EraseCurrentCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       KeepCursorAtStart ; branch when the unsigned value is higher; target KeepCursorAtStart
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      EditCharacterLoop ; branch when the unsigned value is higher; target EditCharacterLoop
                    pshs      y,x       ; save y,x on the stack
                    bra       EraseCurrentCharacter ; continue execution at EraseCurrentCharacter
FinishEditedLine    puls      y,x       ; restore y,x from the stack
AcceptEditedLine    lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leay      $01,y     ; form the address $01,y in y
                    lbsr      RestoreTerminalEcho ; call subroutine RestoreTerminalEcho
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
WrapFullInputLine   puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
FindWrapPoint       leay      -$01,y    ; form the address -$01,y in y
                    beq       WriteFullInputLine ; branch when the values are equal or the result is zero; target WriteFullInputLine
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       CarryWrappedWord ; branch when the values are equal or the result is zero; target CarryWrappedWord
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       FindWrapPoint ; continue execution at FindWrapPoint
WriteFullInputLine  lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
CarryWrappedWord    lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       InputLineLength,u ; store b at InputLineLength,u
                    leay      >EditLineBuffer,u ; form the address >EditLineBuffer,u in y
CopyWrappedWord     lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       CopyWrappedWord ; branch when the values differ or the result is nonzero; target CopyWrappedWord
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      RestoreTerminalEcho ; call subroutine RestoreTerminalEcho
                    rts                 ; return to the caller
* toggle the terminal echo flag through SS.Opt while preserving all callers.
DisableTerminalEcho pshs      y,x,d     ; preserve the line editor's live registers
                    leax      >TerminalOptions,u ; form the address >TerminalOptions,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
RestoreTerminalEcho pshs      y,x,d     ; save y,x,d on the stack
                    leax      >TerminalOptions,u ; form the address >TerminalOptions,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <$0020,x  ; form the address <$0020,x in x
                    clra                ; clear a to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
* parse the first decimal run in X; return -1 when the text has no number.
ParseDecimalNumber  pshs      y         ; preserve the caller's byte count
FindFirstDigit      lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      NoDecimalNumber ; branch when the values are equal or the result is zero; target NoDecimalNumber
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       FindFirstDigit ; branch when carry reports an error or unsigned underflow; target FindFirstDigit
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       FindFirstDigit ; branch when the unsigned value is higher; target FindFirstDigit
                    leax      -$01,x    ; form the address -$01,x in x
FindDigitRunEnd     lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       AccumulateDigits ; branch when carry reports an error or unsigned underflow; target AccumulateDigits
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       AccumulateDigits ; branch when the unsigned value is higher; target AccumulateDigits
                    bra       FindDigitRunEnd ; continue execution at FindDigitRunEnd
AccumulateDigits    pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <ParsedNumber,u ; clear <ParsedNumber,u to zero and set the condition codes
                    clr       <ParsedNumberLow,u ; clear <ParsedNumberLow,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
AccumulatePreviousDigit lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       ReturnParsedNumber ; branch when carry reports an error or unsigned underflow; target ReturnParsedNumber
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       ReturnParsedNumber ; branch when the unsigned value is higher; target ReturnParsedNumber
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; store a at DecimalCounter,u
                    ldd       #0        ; set d to the constant 0
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; branch when the values are equal or the result is zero; target StoreDigitSum
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       AddDigitPlace ; continue execution at AddDigitPlace
StoreDigitSum       addd      <ParsedNumber,u ; add to d using <ParsedNumber,u
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    lda       #10       ; set a to the constant 10
                    sta       DecimalCounter,u ; store a at DecimalCounter,u
                    ldd       #0        ; set d to the constant 0
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; branch when the values are equal or the result is zero; target UseNextDecimalPlace
                    addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    dec       DecimalCounter,u ; decrement the value at DecimalCounter,u
                    bra       MultiplyPlaceByTen ; continue execution at MultiplyPlaceByTen
UseNextDecimalPlace std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    bra       AccumulatePreviousDigit ; continue execution at AccumulatePreviousDigit
ReturnParsedNumber  ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
FormatLineNumber    pshs      y         ; save y on the stack
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; call subroutine EmitDecimalDigit
                    ldd       #1        ; set d to the constant 1
                    std       <DecimalPlace,u ; store d at <DecimalPlace,u
                    ldd       <ParsedNumber,u ; load d from <ParsedNumber,u
                    bsr       EmitDecimalDigit ; call subroutine EmitDecimalDigit
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
EmitDecimalDigit    subd      <DecimalPlace,u ; subtract from d using <DecimalPlace,u
                    bcs       DecimalDigitComplete ; branch when carry reports an error or unsigned underflow; target DecimalDigitComplete
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue execution at EmitDecimalDigit
DecimalDigitComplete addd      <DecimalPlace,u ; add to d using <DecimalPlace,u
                    std       <ParsedNumber,u ; store d at <ParsedNumber,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
