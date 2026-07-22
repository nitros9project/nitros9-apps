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

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

IndexPathNum        rmb       1         ; reserve 1 byte(s) in the module workspace
BodyPathNum         rmb       1         ; reserve 1 byte(s) in the module workspace
AliasPathNum        rmb       1         ; reserve 1 byte(s) in the module workspace
IndexShiftCount     rmb       1         ; reserve 1 byte(s) in the module workspace
DecimalCounter      rmb       1         ; reserve 1 byte(s) in the module workspace
EditorCommand       rmb       1         ; reserve 1 byte(s) in the module workspace
InputLineLength     rmb       1         ; reserve 1 byte(s) in the module workspace
CallerUserId        rmb       2         ; reserve 2 byte(s) in the module workspace
MessageLineNumber   rmb       1         ; reserve 1 byte(s) in the module workspace
MessageLineCount    rmb       1         ; reserve 1 byte(s) in the module workspace
IndexOffsetTop      rmb       1         ; reserve 1 byte(s) in the module workspace
IndexOffsetHigh     rmb       1         ; reserve 1 byte(s) in the module workspace
IndexOffsetLow      rmb       2         ; reserve 2 byte(s) in the module workspace
BodyLineIndex       rmb       2         ; reserve 2 byte(s) in the module workspace
BodyByteCount       rmb       2         ; reserve 2 byte(s) in the module workspace
ParsedNumber        rmb       1         ; reserve 1 byte(s) in the module workspace
ParsedNumberLow     rmb       1         ; reserve 1 byte(s) in the module workspace
DecimalPlace        rmb       2         ; reserve 2 byte(s) in the module workspace
SelectedEditLine    rmb       2         ; reserve 2 byte(s) in the module workspace
AliasLineBuffer     rmb       200       ; reserve 200 byte(s) in the module workspace
RecipientInputBuffer rmb       200       ; reserve 200 byte(s) in the module workspace
ReservedStateByte1  rmb       1         ; reserve 1 byte(s) in the module workspace
LineNumberText      rmb       5         ; reserve 5 byte(s) in the module workspace
ReservedStateByte2  rmb       1         ; reserve 1 byte(s) in the module workspace
NewMessageNumber    rmb       2         ; reserve 2 byte(s) in the module workspace
BodyEndOffsetHigh   rmb       2         ; reserve 2 byte(s) in the module workspace
IndexHeaderTail     rmb       60        ; reserve 60 byte(s) in the module workspace
NewBodyOffsetHigh   rmb       2         ; reserve 2 byte(s) in the module workspace
NewBodyOffsetLow    rmb       2         ; reserve 2 byte(s) in the module workspace
AuthorAlias         rmb       20        ; reserve 20 byte(s) in the module workspace
MessageSubject      rmb       30        ; reserve 30 byte(s) in the module workspace
MessageTimestamp    rmb       6         ; reserve 6 byte(s) in the module workspace
AuthorUserId        rmb       2         ; reserve 2 byte(s) in the module workspace
RecipientUserId     rmb       2         ; reserve 2 byte(s) in the module workspace
MessageLineBuffer   rmb       8000      ; reserve 8000 byte(s) in the module workspace
EditLineBuffer      rmb       80        ; reserve 80 byte(s) in the module workspace
TerminalOptions     rmb       1         ; reserve 1 byte(s) in the module workspace
TerminalOptionsRemainder rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.post/ ; store an OS-9 high-bit-terminated string
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
MailIndexPath       fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
MailBodyPath        fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
SubjectPrompt       fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
SubjectPromptLength fcb       $00       ; store byte data
                    fcb       $1B       ; store byte data
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
InputPrompt         fcc       ">" ; store literal character data
BlankLine           fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
UserNotFoundText    fcc       "Sorry...cannot locate that name" ; store literal character data
                    fcb       $0D       ; store byte data
RecipientPrompt     fcc       "Enter the name of the Person to send mail to" ; store literal character data
                    fcb       $0D       ; store byte data
EraseSequence       fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data

* resolve a mandatory private recipient before opening the mail base.
start               clr       >ReservedStateByte2,u ; initialize retained state from the original module
                    clr       >ReservedStateByte1,u ; clear >ReservedStateByte1,u to zero and set the condition codes
                    clr       InputLineLength,u ; clear InputLineLength,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sty       CallerUserId,u ; store y at CallerUserId,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
PromptForRecipient  leax      >RecipientPrompt,pc ; request the private-mail addressee
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >InputPrompt,pc ; form the address >InputPrompt,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >RecipientInputBuffer,u ; form the address >RecipientInputBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      ExitSuccessfully ; branch when the unsigned value is lower or equal; target ExitSuccessfully
UppercaseRecipient  lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       OpenAliasFile ; branch when the values are equal or the result is zero; target OpenAliasFile
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       UppercaseRecipient ; branch when carry reports an error or unsigned underflow; target UppercaseRecipient
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       UppercaseRecipient ; continue execution at UppercaseRecipient
OpenAliasFile       leax      >AliasPath,pc ; form the address >AliasPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
ScanAliasFile       leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       RecipientNotFound ; branch when carry reports an error or unsigned underflow; target RecipientNotFound
UppercaseAliasName  lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       CompareRecipientName ; branch when the values are equal or the result is zero; target CompareRecipientName
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       UppercaseAliasName ; branch when carry reports an error or unsigned underflow; target UppercaseAliasName
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       UppercaseAliasName ; continue execution at UppercaseAliasName
CompareRecipientName leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    leay      >RecipientInputBuffer,u ; form the address >RecipientInputBuffer,u in y
CompareNextNameCharacter lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       AliasNameMatched ; branch when the values are equal or the result is zero; target AliasNameMatched
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    beq       CompareNextNameCharacter ; branch when the values are equal or the result is zero; target CompareNextNameCharacter
                    bra       ScanAliasFile ; continue execution at ScanAliasFile
AliasNameMatched    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       ScanAliasFile ; branch when the values differ or the result is nonzero; target ScanAliasFile
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    std       >RecipientUserId,u ; store d at >RecipientUserId,u
                    bra       OpenMailFiles ; continue execution at OpenMailFiles
RecipientNotFound   cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      ExitWithStatus ; branch when the values differ or the result is nonzero; target ExitWithStatus
                    leax      >UserNotFoundText,pc ; form the address >UserNotFoundText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      PromptForRecipient ; continue execution at PromptForRecipient
* open the mail index, creating both index and body files when the base is new.
OpenMailFiles       leax      >MailIndexPath,pc ; open record zero of BBS.mail.inx
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      CreateMailFiles ; branch when carry reports an error or unsigned underflow; target CreateMailFiles
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Close   ; close path A
                    leax      >MailIndexPath,pc ; form the address >MailIndexPath,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
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
                    bne       ShiftNewIndexOffset ; branch when the values differ or the result is nonzero; target ShiftNewIndexOffset
                    std       IndexOffsetLow,u ; store d at IndexOffsetLow,u
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldx       IndexOffsetTop,u ; load x from IndexOffsetTop,u
                    pshs      u         ; save u on the stack
                    ldu       IndexOffsetLow,u ; load u from IndexOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    puls      u         ; restore u from the stack
                    leax      >MessageTimestamp,u ; form the address >MessageTimestamp,u in x
                    os9       F$Time    ; read the current system date and time
                    leax      >SubjectPrompt,pc ; form the address >SubjectPrompt,pc in x
                    ldy       >SubjectPromptLength,pc ; load y from >SubjectPromptLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    clra                ; clear a to zero and set the condition codes
                    leax      >MessageSubject,u ; form the address >MessageSubject,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >MessageEntryPrompt,pc ; form the address >MessageEntryPrompt,pc in x
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
                    lbeq      ExitSuccessfully ; branch when the values are equal or the result is zero; target ExitSuccessfully
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      FinishMail ; branch when the values are equal or the result is zero; target FinishMail
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       EditStoredLine ; branch when the values are equal or the result is zero; target EditStoredLine
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       ContinueMessageEntry ; branch when the values are equal or the result is zero; target ContinueMessageEntry
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      ListMessageFromStart ; branch when the values are equal or the result is zero; target ListMessageFromStart
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
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       InputLineLength,u ; store b at InputLineLength,u
                    dec       InputLineLength,u ; decrement the value at InputLineLength,u
                    leay      >EditLineBuffer,u ; form the address >EditLineBuffer,u in y
CopyEditRemainder   lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       CopyEditRemainder ; branch when the values differ or the result is nonzero; target CopyEditRemainder
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
* resolve the author's alias, append the 64-byte index record and body, then
* publish the new high-message record at the start of BBS.mail.inx.
FinishMail          leax      >AliasPath,pc ; reopen aliases for the author lookup
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       AliasPathNum,u ; store a at AliasPathNum,u
FindAuthorAlias     leax      <AliasLineBuffer,u ; form the address <AliasLineBuffer,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPathNum,u ; load a from AliasPathNum,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
FindAliasIdSeparator lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       FindAliasIdSeparator ; branch when the values differ or the result is nonzero; target FindAliasIdSeparator
                    lbsr      ParseDecimalNumber ; call subroutine ParseDecimalNumber
                    cmpd      CallerUserId,u ; compare d with CallerUserId,u and set the condition codes
                    bne       FindAuthorAlias ; branch when the values differ or the result is nonzero; target FindAuthorAlias
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
                    leax      >MailBodyPath,pc ; form the address >MailBodyPath,pc in x
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
                    sta       BodyLineIndex,u ; store a at BodyLineIndex,u
                    ldd       #1        ; set d to the constant 1
                    std       <BodyByteCount,u ; store d at <BodyByteCount,u
AppendNextBodyLine  lda       BodyLineIndex,u ; load a from BodyLineIndex,u
                    inca                ; increment a
                    sta       BodyLineIndex,u ; store a at BodyLineIndex,u
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
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
                    ldy       CallerUserId,u ; load y from CallerUserId,u
                    os9       F$SUser   ; change the process user ID to Y
ExitWithStatus      os9       F$Exit    ; terminate the process with status B
* edit one 80-column line with terminal echo temporarily disabled.
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
DisableTerminalEcho pshs      y,x,d     ; save y,x,d on the stack
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
ParseDecimalNumber  pshs      y         ; save y on the stack
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
CreateMailFiles     leax      >MailIndexPath,pc ; form the address >MailIndexPath,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >MailBodyPath,pc ; form the address >MailBodyPath,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    sta       BodyPathNum,u ; store a at BodyPathNum,u
                    leax      >NewMessageNumber,u ; form the address >NewMessageNumber,u in x
                    ldd       #0        ; set d to the constant 0
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    std       $04,x     ; store d at $04,x
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    os9       I$Close   ; close path A
                    lbcs      ExitWithStatus ; branch when carry reports an error or unsigned underflow; target ExitWithStatus
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Close   ; close path A
                    lda       BodyPathNum,u ; load a from BodyPathNum,u
                    os9       I$Close   ; close path A
                    lbra      OpenMailFiles ; continue execution at OpenMailFiles

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
