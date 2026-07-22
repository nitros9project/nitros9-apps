**********************************************************************
* BBS.mail.read - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.read
* Purpose: Read private mail addressed to the current user without automatic deletion.
* Data: BBS.mail and BBS.mail.inx.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded recipient filtering, reread handling, and 32-bit body offsets.
**********************************************************************

                    nam       BBS.mail.read
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

* open paths, conversion scratch, and the logged-in user ID
IndexPathNum        rmb       1
BodyPathArea        rmb       2
DecimalCounter      rmb       1
MatchedMailCount    rmb       1
RereadResponse      rmb       3
ParsedNumber        rmb       1
ParsedNumberLow     rmb       1
DecimalPlace        rmb       2
CallerUserArea      rmb       8
NumberScratch       rmb       3
NumberTensCharacter rmb       1
NumberTailAndGap    rmb       13
* assembled MM/DD/YY display line
DateLineMonthTens   rmb       1
DateLineMonthOnes   rmb       1
DateLineFirstSlash  rmb       1
DateLineDayTens     rmb       1
DateLineDayOnes     rmb       1
DateLineSecondSlash rmb       1
DateLineYearTens    rmb       1
DateLineYearOnes    rmb       1
DateLineReturn      rmb       1
* record-zero scratch followed by the selected 64-byte mail index record fields
MailIndexHeader     rmb       64
BodyLineBuffer      rmb       80
BodyOffsetHigh      rmb       2
BodyOffsetLow       rmb       2
MailAuthor          rmb       20
MailSubject         rmb       30
MailYear            rmb       1
MailMonth           rmb       1
MailDayTimeAndAuthorId rmb       6
RecipientUserId     rmb       2
UnusedTailBuffer    rmb       200
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.read/ ; store an OS-9 high-bit-terminated string
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
LegacyHighMessageText fcc       "High message is #" ; retained unreferenced reader prompt
                    fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
LegacyMessagePrompt fcc       "Enter message #" ; retained unreferenced reader prompt
                    fcb       $0D       ; store byte data
LegacyInputPrompt   fcc       ">" ; retained unreferenced reader prompt
MailIndexPath       fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
MailBodyPath        fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
MailHeaderPrefix    fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "From    :" ; store literal character data
DateLabel           fcc       "Left on :" ; store literal character data
SubjectLabel        fcc       "About   :" ; store literal character data
HeaderLabelLength   fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
MailRule            fcc       "---------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
BlankLine           fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
EndOfMailText       fcb       $0A       ; store byte data
                    fcc       "That's all the mail that was left for you" ; store literal character data
                    fcb       $0D       ; store byte data
NoMailText          fcc       "Sorry, you have no mail" ; store literal character data
                    fcb       $0D       ; store byte data
CheckingMailText    fcc       "Checking for mail..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
RereadPrompt        fcc       "Re-Read? (Y/N):" ; store literal character data
                    fcb       $0D       ; store byte data

* scan the mail index sequentially and display only records whose recipient ID
* matches the caller.  This variant leaves every index record unchanged.
start               os9       F$ID      ; obtain the caller's user ID in Y
                    sty       CallerUserArea,u ; store y at CallerUserArea,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >MailIndexPath,pc ; form the address >MailIndexPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    sta       IndexPathNum,u ; store a at IndexPathNum,u
                    leax      >MailBodyPath,pc ; form the address >MailBodyPath,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    sta       BodyPathArea,u ; store a at BodyPathArea,u
                    clr       MatchedMailCount,u ; clear MatchedMailCount,u to zero and set the condition codes
                    leax      >CheckingMailText,pc ; form the address >CheckingMailText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      <MailIndexHeader,u ; form the address <MailIndexHeader,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
FindNextRecipientMail leax      >BodyOffsetHigh,u ; receive the next 64-byte mail index record
                    ldy       #64       ; set y to the constant 64
                    lda       IndexPathNum,u ; load a from IndexPathNum,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       MailScanEnded ; finish when the index reaches end-of-file
                    ldd       >RecipientUserId,u ; load d from >RecipientUserId,u
                    cmpd      CallerUserArea,u ; compare d with CallerUserArea,u and set the condition codes
                    bne       FindNextRecipientMail ; inspect the next mail index record
                    bra       DisplayRecipientMail ; continue in the named workflow
MailScanEnded       cmpb      #211      ; distinguish normal end-of-file from an I/O error
                    lbne      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    tst       MatchedMailCount,u ; set condition codes from MatchedMailCount,u without changing it
                    beq       ReportNoMail ; report an empty recipient scan
                    leax      >EndOfMailText,pc ; form the address >EndOfMailText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      ExitSuccessfully ; continue in the named workflow
ReportNoMail        leax      >NoMailText,pc ; form the address >NoMailText,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      ExitSuccessfully ; continue in the named workflow
DisplayRecipientMail inc       MatchedMailCount,u ; remember that at least one message matched
                    ldd       >BodyOffsetHigh,u ; load d from >BodyOffsetHigh,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      FindNextRecipientMail ; inspect the next mail index record
                    leax      >MailHeaderPrefix,pc ; form the address >MailHeaderPrefix,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    leay      $02,y     ; form the address $02,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MailAuthor,u ; form the address >MailAuthor,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    leax      >DateLabel,pc ; form the address >DateLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    ldb       >MailMonth,u ; load b from >MailMonth,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineMonthTens,u ; store a at <DateLineMonthTens,u
                    lda       <NumberTailAndGap,u ; load a from <NumberTailAndGap,u
                    sta       <DateLineMonthOnes,u ; store a at <DateLineMonthOnes,u
                    lda       #47       ; set a to the constant 47
                    sta       <DateLineFirstSlash,u ; store a at <DateLineFirstSlash,u
                    ldb       >MailDayTimeAndAuthorId,u ; load b from >MailDayTimeAndAuthorId,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineDayTens,u ; store a at <DateLineDayTens,u
                    lda       <NumberTailAndGap,u ; load a from <NumberTailAndGap,u
                    sta       <DateLineDayOnes,u ; store a at <DateLineDayOnes,u
                    lda       #47       ; set a to the constant 47
                    sta       <DateLineSecondSlash,u ; store a at <DateLineSecondSlash,u
                    ldb       >MailYear,u ; load b from >MailYear,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <NumberScratch,u ; form the address <NumberScratch,u in x
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; load a from <NumberTensCharacter,u
                    sta       <DateLineYearTens,u ; store a at <DateLineYearTens,u
                    lda       <NumberTailAndGap,u ; load a from <NumberTailAndGap,u
                    sta       <DateLineYearOnes,u ; store a at <DateLineYearOnes,u
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
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    leax      >SubjectLabel,pc ; form the address >SubjectLabel,pc in x
                    ldy       >HeaderLabelLength,pc ; load y from >HeaderLabelLength,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >MailSubject,u ; form the address >MailSubject,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    bra       DisplayMailBody ; continue in the named workflow
* seek through the record's full 32-bit offset and copy body lines until the
* one-byte terminator.  A Y response repeats the same seek and display.
DisplayMailBody     leax      >MailRule,pc ; separate the header from the body
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPathArea,u ; load a from BodyPathArea,u
                    ldx       >BodyOffsetHigh,u ; load x from >BodyOffsetHigh,u
                    pshs      u         ; save u on the stack
                    ldu       >BodyOffsetLow,u ; load u from >BodyOffsetLow,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    puls      u         ; restore u from the stack
CopyBodyLine        lda       BodyPathArea,u ; load a from BodyPathArea,u
                    leax      <BodyLineBuffer,u ; form the address <BodyLineBuffer,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       CopyBodyLine ; copy another nonempty body line
                    leax      >MailRule,pc ; form the address >MailRule,pc in x
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >RereadPrompt,pc ; form the address >RereadPrompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      RereadResponse,u ; form the address RereadResponse,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >BlankLine,pc ; form the address >BlankLine,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       RereadResponse,u ; load a from RereadResponse,u
                    cmpa      #121      ; compare a with #121 and set the condition codes
                    lbeq      DisplayMailBody ; reread the same body from its saved offset
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbeq      DisplayMailBody ; reread the same body from its saved offset
                    lbra      FindNextRecipientMail ; continue in the named workflow
ExitSuccessfully    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      pshs      b         ; save b on the stack
                    ldy       CallerUserArea,u ; load y from CallerUserArea,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B

* retained decimal parser from the generic reader; no live path calls it here.
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
                    clr       ParsedNumber,u ; clear ParsedNumber,u to zero and set the condition codes
                    clr       ParsedNumberLow,u ; clear ParsedNumberLow,u to zero and set the condition codes
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
FormatDecimalNumber pshs      x         ; retain the start of the output field
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
