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
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.post/ ; store an OS-9 high-bit-terminated string
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
SubjectPrompt       fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
RecipientPrompt     fcc       "Address message to (BLANK for ALL):" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
SubjectPromptLength fcb       $00       ; store byte data
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
* reserve the next 64-byte index slot, capture its body-file end offset, and
* collect the new subject before resolving the destination user.
start               clr       >ReservedStateByte2,u ; initialize retained state from the original module
                    clr       >ReservedStateByte1,u ; clear >ReservedStateByte1,u to zero and set the condition codes
                    clr       InputLineLength,u ; clear InputLineLength,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sty       CallerUserId,u ; store y at CallerUserId,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageIndexPath,pc ; form the address >MessageIndexPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Close   ; close path A
                    leax      >MessageIndexPath,pc ; form the address >MessageIndexPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
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
                    bne       ShiftNewIndexOffset ; continue multiplying by the 64-byte record size
                    std       IndexOffsetLow,u ; store d at IndexOffsetLow,u
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldx       IndexOffsetTop,u ; load x from IndexOffsetTop,u
                    pshs      u         ; save u on the stack
                    ldu       IndexOffsetLow,u ; load u from IndexOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
                    leax      >MessageTimestamp,u ; form the address >MessageTimestamp,u in x
                    os9       F$Time    ; read the current system date and time
                    leax      >SubjectPrompt,pc ; form the address >SubjectPrompt,pc in x
                    ldy       >SubjectPromptLength,pc ; load y from >SubjectPromptLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    clra                ; clear a to zero and set the condition codes
                    leax      >MessageSubject,u ; form the address >MessageSubject,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >AliasPath,pc ; form the address >AliasPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
* compare an uppercased recipient against BBS.alias.  A blank name records -1,
* the package's representation for a message addressed to all users.
PromptForRecipient  leax      >RecipientPrompt,pc ; ask who should receive this message
                    ldy       #38       ; set y to the constant 38
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >RecipientInputBuffer,u ; form the address >RecipientInputBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       AddressAllUsers ; mark this as a public message
UppercaseRecipient  lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       UppercaseRecipient ; uppercase the next recipient character
ScanAliasFile       leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RecipientNotFound ; report an unknown recipient
                    leay      >RecipientInputBuffer,u ; form the address >RecipientInputBuffer,u in y
                    leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
CompareAliasName    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       AliasNameMatched ; parse the matching alias user ID
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       ScanAliasFile ; compare the next alias record
                    bra       CompareAliasName ; continue in the named workflow
AliasNameMatched    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       ScanAliasFile ; compare the next alias record
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    std       >RecipientUserId,u ; store d at >RecipientUserId,u
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       BeginMessageEntry ; continue in the named workflow
RecipientNotFound   leax      >UserNotFoundText,pc ; form the address >UserNotFoundText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbra      PromptForRecipient ; continue in the named workflow
AddressAllUsers     ldd       #-1       ; set d to the constant -1
                    std       >RecipientUserId,u ; store d at >RecipientUserId,u
* collect up to 99 fixed 80-byte lines, then let the caller abort, finish,
* replace a selected line, continue entering text, or list the draft.
BeginMessageEntry   leax      >MessageEntryPrompt,pc ; introduce the line-oriented editor
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageRule,pc ; form the address >MessageRule,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    ldd       #0        ; set d to the constant 0
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
ReadNextMessageLine ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    addd      #1        ; add to d using #1
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       PromptCompositionAction ; choose what to do with the draft
                    lbsr      ReadMessageLine ; call subroutine ReadMessageLine
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       PromptCompositionAction ; choose what to do with the draft
                    bra       ReadNextMessageLine ; continue in the named workflow
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
                    lbeq      ExitSuccessfully ; restore the caller and exit successfully
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      FinishPost ; commit the completed post
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       EditStoredLine ; replace a selected draft line
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       ContinueMessageEntry ; resume body entry
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      ListMessageFromStart ; list the draft from its first line
                    bra       PromptCompositionAction ; continue in the named workflow
ContinueMessageEntry ldd       MessageLineNumber,u ; load d from MessageLineNumber,u
                    subd      #1        ; subtract from d using #1
                    std       MessageLineNumber,u ; store d at MessageLineNumber,u
                    bra       ReadNextMessageLine ; continue in the named workflow
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
                    lbcc      PromptCompositionAction ; choose what to do with the draft
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
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       InputLineLength,u ; store b at InputLineLength,u
                    dec       InputLineLength,u ; decrement the value at InputLineLength,u
                    leay      >EditLineBuffer,u ; form the address >EditLineBuffer,u in y
CopyEditRemainder   lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       CopyEditRemainder ; preserve the edited line tail
                    ldd       <SelectedEditLine,u ; load d from <SelectedEditLine,u
                    bsr       ReadMessageLine ; call subroutine ReadMessageLine
                    lbra      PromptCompositionAction ; continue in the named workflow
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
                    bhi       ListNextMessageLine ; print the next draft line
                    lbra      PromptCompositionAction ; continue in the named workflow
ReadMessageLine     leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    pshs      d         ; save d on the stack
                    lbsr      FormatLineNumber ; call subroutine FormatLineNumber
                    leax      >LineNumberText,u ; form the address >LineNumberText,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
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
                    beq       FinishStoredLine ; complete this stored line
                    sta       <ParsedNumber,u ; store a at <ParsedNumber,u
CopyStoredLine      lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <ParsedNumber,u ; decrement the value at <ParsedNumber,u
                    bne       CopyStoredLine ; copy another input character
FinishStoredLine    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      EditTerminalLine ; call subroutine EditTerminalLine
                    rts                 ; return to the caller
* resolve the author's alias, construct the new 64-byte index record, append
* the body, rewrite record zero, and increment the caller's post count.
FinishPost          leax      <AliasLineBuffer,u ; scan aliases again for the caller's name
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; return the OS-9 status in B
FindAliasIdSeparator lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       FindAliasIdSeparator ; locate the numeric field in this alias record
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FinishPost ; commit the completed post
                    leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    leay      >AuthorAlias,u ; form the address >AuthorAlias,u in y
CopyAuthorAlias     lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       AuthorAliasCopied ; finalize the author field
                    sta       ,y+       ; store a at ,y+
                    bra       CopyAuthorAlias ; continue in the named workflow
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
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >MessageBodyPath,pc ; form the address >MessageBodyPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    sta       BodyPathNum,u ; store a at BodyPathNum,u
                    pshs      u         ; save u on the stack
                    ldx       >BodyEndOffsetHigh,u ; load x from >BodyEndOffsetHigh,u
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    ldu       >IndexHeaderTail,u ; load u from >IndexHeaderTail,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <BodyLineIndex,u ; store a at <BodyLineIndex,u
                    ldd       #1        ; set d to the constant 1
                    std       <BodyByteCount,u ; store d at <BodyByteCount,u
AppendNextBodyLine  lda       <BodyLineIndex,u ; load a from <BodyLineIndex,u
                    inca                ; increment a
                    sta       <BodyLineIndex,u ; store a at <BodyLineIndex,u
                    cmpa      MessageLineCount,u ; compare a with MessageLineCount,u and set the condition codes
                    bhi       BodyAppendComplete ; update the body-file end offset
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >MessageLineBuffer,u ; form the address >MessageLineBuffer,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       BodyAppendComplete ; update the body-file end offset
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       <BodyByteCount,u ; store d at <BodyByteCount,u
                    bra       AppendNextBodyLine ; continue in the named workflow
BodyAppendComplete  ldd       >IndexHeaderTail,u ; load d from >IndexHeaderTail,u
                    addd      <BodyByteCount,u ; add to d using <BodyByteCount,u
                    std       >IndexHeaderTail,u ; store d at >IndexHeaderTail,u
                    bcc       RewriteIndexHeader ; publish the new high-message record
                    ldd       >BodyEndOffsetHigh,u ; load d from >BodyEndOffsetHigh,u
                    addd      #1        ; add to d using #1
                    std       >BodyEndOffsetHigh,u ; store d at >BodyEndOffsetHigh,u
RewriteIndexHeader  pshs      u         ; save u on the stack
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    puls      u         ; restore u from the stack
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >UserStatsPath,pc ; form the address >UserStatsPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       UserStatsReady ; use the open statistics file
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; return the OS-9 status in B
UserStatsReady      sta       UserStatsPathNum,u ; store a at UserStatsPathNum,u
FindUserStatsRecord leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       UserStatsScanEnded ; handle the end of the statistics file
                    ldd       >StatsUserId,u ; load d from >StatsUserId,u
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindUserStatsRecord ; inspect the next user record
                    bra       UpdateUserPostCount ; continue in the named workflow
UserStatsScanEnded  cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; return the OS-9 status in B
                    lbra      CreateUserStatsRecord ; continue in the named workflow
UpdateUserPostCount ldd       >StatsPostCount,u ; load d from >StatsPostCount,u
                    addd      #1        ; add to d using #1
                    std       >StatsPostCount,u ; store d at >StatsPostCount,u
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
                    leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      ExitSuccessfully ; continue in the named workflow
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
                    lbcs      ExitWithStatus ; return the OS-9 status in B
                    leax      >StatsUserId,u ; form the address >StatsUserId,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       UserStatsPathNum,u ; load a from UserStatsPathNum,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; return the OS-9 status in B
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
                    ldy       CallerUserId,u ; load y from CallerUserId,u
                    os9       F$SUser   ; change the process user ID to Y
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* read one editable terminal line without normal echo.  The control characters
* below move, erase, terminate, and wrap within an 80-column record.
EditTerminalLine    lbsr      DisableTerminalEcho ; enter character-at-a-time terminal mode
                    ldb       InputLineLength,u ; load b from InputLineLength,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       InputLineLength,u ; clear InputLineLength,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      AcceptEditedLine ; terminate the edited line
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
PadUnusedInput      sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       PadUnusedInput ; fill the unused columns with carriage returns
                    puls      y,x       ; restore y,x from the stack
EditCharacterLoop   pshs      y,x       ; save y,x on the stack
                    leax      EditorCommand,u ; form the address EditorCommand,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       RetryCharacterRead ; ignore the failed or control input
                    lda       EditorCommand,u ; load a from EditorCommand,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       MoveCursorRight ; advance across existing text
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       ErasePreviousCharacter ; process backspace
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       EraseCurrentCharacter ; process delete
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      FinishEditedLine ; accept the line on carriage return
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       RetryCharacterRead ; ignore the failed or control input
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       EditorCommand,u ; load a from EditorCommand,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      WrapFullInputLine ; wrap a full 80-column line
                    bra       EditCharacterLoop ; continue in the named workflow
RetryCharacterRead  puls      y,x       ; restore y,x from the stack
                    bra       EditCharacterLoop ; continue in the named workflow
MoveCursorRight     puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       ResumeCharacterInput ; resume at the adjusted cursor
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       BackOverTerminator ; position before the line terminator
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       MoveCursorRight ; continue in the named workflow
BackOverTerminator  leax      -$01,x    ; form the address -$01,x in x
ResumeCharacterInput leay      $01,y     ; form the address $01,y in y
                    lbra      EditCharacterLoop ; continue in the named workflow
ErasePreviousCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       KeepCursorAtStart ; prevent backing past the buffer start
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      EditCharacterLoop ; continue in the named workflow
KeepCursorAtStart   leay      -$01,y    ; form the address -$01,y in y
                    lbra      EditCharacterLoop ; continue in the named workflow
EraseCurrentCharacter puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       KeepCursorAtStart ; prevent backing past the buffer start
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      EditCharacterLoop ; read another editor character
                    pshs      y,x       ; save y,x on the stack
                    bra       EraseCurrentCharacter ; continue in the named workflow
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
                    beq       WriteFullInputLine ; emit the full line when no boundary exists
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       CarryWrappedWord ; carry the trailing word to the next line
                    pshs      y,x       ; save y,x on the stack
                    leax      >EraseSequence,pc ; form the address >EraseSequence,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       FindWrapPoint ; continue in the named workflow
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
                    bne       CopyWrappedWord ; copy another carried character
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      RestoreTerminalEcho ; call subroutine RestoreTerminalEcho
                    rts                 ; return to the caller
* update the terminal's ss.opt echo byte while preserving the editor state.
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
