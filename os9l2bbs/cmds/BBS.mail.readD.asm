**********************************************************************
* BBS.mail.readD - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.readD
* Purpose: Read private mail and delete each handled item.
* Data: BBS.mail and BBS.mail.inx; shell compatibility affects deletion errors.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Enabled echo and automatic linefeed on redirected interactive input.
*          2026/07/21  Codex
* Decoded recipient filtering, reread handling, body offsets, and delete chaining.
**********************************************************************

                    nam       BBS.mail.readD
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $02       ; interactive terminal-options revision

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
RecipientUserIdAndTail rmb       62
DeleteParameterArea rmb       1
DeleteParameterRemainder rmb       139
TerminalOptions     rmb       32        ; ss.opt packet kept last to preserve existing workspace offsets
size                equ       .

name                fcs       /BBS.mail.readD/
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
LegacyHighMessageText fcc       "High message is #" ; retained unreferenced reader prompt
                    fcb       $00
                    fcb       $11
LegacyMessagePrompt fcc       "Enter message #" ; retained unreferenced reader prompt
                    fcb       $0D
LegacyInputPrompt   fcc       ">" ; retained unreferenced reader prompt
MailIndexPath       fcc       "BBS.mail.inx"
                    fcb       $0D
MailBodyPath        fcc       "BBS.mail"
                    fcb       $0D
                    fcc       "******   DELETED   ******"
                    fcb       $0D
MailHeaderPrefix    fcb       $0A
                    fcb       $0A
                    fcc       "From    :"
DateLabel           fcc       "Left on :"
SubjectLabel        fcc       "About   :"
HeaderLabelLength   fcb       $00
                    fcb       $09
MailRule            fcc       "---------------------------------------------------------------"
                    fcb       $0D
BlankLine           fcb       $0A
                    fcb       $0D
EndOfMailText       fcb       $0A
                    fcc       "That's all the mail that was left for you"
                    fcb       $0D
NoMailText          fcc       "Sorry, you have no mail"
                    fcb       $0D
CheckingMailText    fcc       "Checking for mail..."
                    fcb       $0A
                    fcb       $0D
RereadPrompt        fcc       "Re-Read? (Y/N):"
                    fcb       $0D
DeleteMailCommand   fcc       "BBS.mail.delete"
                    fcb       $0D

* scan the mail index sequentially and display only records whose recipient ID
* matches the caller.  Deleted records use -1 in the body-offset field.
start               lbsr      InitializeTerminalInput ; configure redirected interactive input
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       CallerUserArea,u ; retain caller user area
                    ldy       #0        ; initialize the pointer or index for this state transition
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >MailIndexPath,pc ; select mail index path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    sta       IndexPathNum,u ; retain index path num
                    leax      >MailBodyPath,pc ; select mail body path
                    lda       #1        ; request OS-9 access mode 1
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    sta       BodyPathArea,u ; retain body path area
                    clr       MatchedMailCount,u ; initialize matched mail count
                    leax      >CheckingMailText,pc ; select checking mail text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      <MailIndexHeader,u ; select mail index header
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Read    ; read the requested fixed-size field
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
FindNextRecipientMail leax      >BodyOffsetHigh,u ; receive the next 64-byte mail index record
                    ldy       #64       ; cap this input field at 64 bytes
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       MailScanEnded ; finish when the index reaches end-of-file
                    ldd       >RecipientUserIdAndTail,u ; recover recipient user id and tail
                    cmpd      CallerUserArea,u ; test against caller user area
                    bne       FindNextRecipientMail ; inspect the next mail index record
                    bra       DisplayRecipientMail ; continue in the named workflow
* after at least one matching message, restore the caller and chain directly to
* BBS.mail.delete; otherwise report that no private mail was found.
MailScanEnded       cmpb      #211      ; distinguish normal end-of-file from an I/O error
                    lbne      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    tst       MatchedMailCount,u ; set condition codes from MatchedMailCount,u without changing it
                    beq       ReportNoMail ; report an empty recipient scan
                    leax      >EndOfMailText,pc ; select end of mail text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPathArea,u ; recover body path area
                    os9       I$Close   ; close the selected path
                    lda       IndexPathNum,u ; recover index path num
                    os9       I$Close   ; close the selected path
                    ldy       CallerUserArea,u ; recover caller user area
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >DeleteMailCommand,pc ; select delete mail command
                    ldy       #1        ; supply 1 as the control, count, or argument value required here
                    leau      >DeleteParameterArea,u ; select delete parameter area
                    lda       #17       ; supply 17 as the control, count, or argument value required here
                    ldb       #3        ; supply 3 as the control, count, or argument value required here
                    os9       F$Chain   ; replace this process with the module at X
ReportNoMail        leax      >NoMailText,pc ; select no mail text
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      ExitSuccessfully ; continue in the named workflow
DisplayRecipientMail inc       MatchedMailCount,u ; remember that deletion should follow this scan
                    ldd       >BodyOffsetHigh,u ; recover body offset high
                    cmpd      #-1       ; test against #-1
                    lbeq      FindNextRecipientMail ; inspect the next mail index record
                    leax      >MailHeaderPrefix,pc ; select mail header prefix
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    leay      $02,y     ; select $02
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MailAuthor,u ; select mail author
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    leax      >DateLabel,pc ; select date label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      <NumberScratch,u ; select number scratch
                    ldb       >MailMonth,u ; recover mail month
                    clra                ; select standard input
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineMonthTens,u ; retain date line month tens
                    lda       <NumberTailAndGap,u ; recover number tail and gap
                    sta       <DateLineMonthOnes,u ; retain date line month ones
                    lda       #47       ; initialize date line first slash to 47
                    sta       <DateLineFirstSlash,u ; retain date line first slash
                    ldb       >MailDayTimeAndAuthorId,u ; recover mail day time and author id
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineDayTens,u ; retain date line day tens
                    lda       <NumberTailAndGap,u ; recover number tail and gap
                    sta       <DateLineDayOnes,u ; retain date line day ones
                    lda       #47       ; initialize date line second slash to 47
                    sta       <DateLineSecondSlash,u ; retain date line second slash
                    ldb       >MailYear,u ; recover mail year
                    clra                ; select standard input
                    leax      <NumberScratch,u ; select number scratch
                    lbsr      FormatDecimalNumber ; format D as a five-column decimal number
                    lda       <NumberTensCharacter,u ; recover number tens character
                    sta       <DateLineYearTens,u ; retain date line year tens
                    lda       <NumberTailAndGap,u ; recover number tail and gap
                    sta       <DateLineYearOnes,u ; retain date line year ones
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
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    leax      >SubjectLabel,pc ; select subject label
                    ldy       >HeaderLabelLength,pc ; recover header label length
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >MailSubject,u ; select mail subject
                    ldy       #30       ; cap this output request at 30 bytes
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    bra       DisplayMailBody ; continue in the named workflow
* seek through the record's full 32-bit offset and copy body lines until the
* one-byte terminator.  A Y response repeats the same seek and display.
DisplayMailBody     leax      >MailRule,pc ; separate the header from the body
                    ldy       #64       ; cap this output request at 64 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       BodyPathArea,u ; recover body path area
                    ldx       >BodyOffsetHigh,u ; recover body offset high
                    pshs      u         ; preserve u across the operation
                    ldu       >BodyOffsetLow,u ; recover body offset low
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 status in B
                    puls      u         ; restore u
CopyBodyLine        lda       BodyPathArea,u ; recover body path area
                    leax      <BodyLineBuffer,u ; select body line buffer
                    ldy       #80       ; cap this input field at 80 bytes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; test against #1
                    bhi       CopyBodyLine ; copy another nonempty body line
                    leax      >MailRule,pc ; select mail rule
                    ldy       #64       ; cap this output request at 64 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >RereadPrompt,pc ; select reread prompt
                    ldy       #200      ; cap this output request at 200 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      RereadResponse,u ; select reread response
                    ldy       #1        ; cap this input field at 1 bytes
                    clra                ; select standard input
                    os9       I$Read    ; read the requested fixed-size field
                    leax      >BlankLine,pc ; select blank line
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       RereadResponse,u ; recover reread response
                    cmpa      #121      ; recognize 121 as a meaningful value in this parser state
                    lbeq      DisplayMailBody ; reread the same body from its saved offset
                    cmpa      #89       ; recognize 89 as a meaningful value in this parser state
                    lbeq      DisplayMailBody ; reread the same body from its saved offset
                    lbra      FindNextRecipientMail ; continue in the named workflow
ExitSuccessfully    clrb                ; clear the byte accumulator for counting
ExitWithStatus      pshs      b         ; preserve b across the operation
                    ldy       CallerUserArea,u ; recover caller user area
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b
                    os9       F$Exit    ; terminate the process with status B

* retained decimal parser from the generic reader; no live path calls it here.
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
                    clr       ParsedNumber,u ; initialize parsed number
                    clr       ParsedNumberLow,u ; initialize parsed number low
                    ldd       #1        ; initialize decimal place to 1
                    std       DecimalPlace,u ; retain decimal place
AccumulatePreviousDigit lda       ,-x       ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    bcs       ReturnParsedNumber ; return the accumulated value
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bhi       ReturnParsedNumber ; return the accumulated value
                    suba      #48       ; subtract from a using #48
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
AddDigitPlace       tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       StoreDigitSum ; merge this digit into the result
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       AddDigitPlace ; continue in the named workflow
StoreDigitSum       addd      ParsedNumber,u ; add to d using ParsedNumber,u
                    std       ParsedNumber,u ; retain parsed number
                    lda       #10       ; select the line-feed control byte
                    sta       DecimalCounter,u ; retain decimal counter
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
MultiplyPlaceByTen  tst       DecimalCounter,u ; set condition codes from DecimalCounter,u without changing it
                    beq       UseNextDecimalPlace ; use the next power of ten
                    addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    dec       DecimalCounter,u ; consume one decimal counter
                    bra       MultiplyPlaceByTen ; continue in the named workflow
UseNextDecimalPlace std       DecimalPlace,u ; retain decimal place
                    bra       AccumulatePreviousDigit ; continue in the named workflow
ReturnParsedNumber  ldd       ParsedNumber,u ; recover parsed number
                    puls      x         ; restore x
                    puls      pc,y      ; restore pc,y and return to the caller
* format unsigned D as five decimal columns followed by carriage return.
FormatDecimalNumber pshs      x         ; retain the start of the output field
                    std       ParsedNumber,u ; retain parsed number
                    lda       #48       ; recognize or generate ASCII zero
                    sta       ,x        ; retain
                    sta       $01,x     ; retain $01
                    sta       $02,x     ; retain $02
                    sta       $03,x     ; retain $03
                    sta       $04,x     ; retain $04
                    ldd       #10000    ; initialize decimal place to 10000
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    lbsr      EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1000     ; initialize decimal place to 1000
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #100      ; initialize decimal place to 100
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #10       ; select the line-feed control byte
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
                    bsr       EmitDecimalDigit ; emit the digit for the current decimal place
                    ldd       #1        ; initialize decimal place to 1
                    std       DecimalPlace,u ; retain decimal place
                    ldd       ParsedNumber,u ; recover parsed number
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
EmitDecimalDigit    subd      DecimalPlace,u ; subtract from d using DecimalPlace,u
                    bcs       DecimalDigitComplete ; restore the remainder after repeated subtraction
                    inc       ,x        ; increment the value at ,x
                    bra       EmitDecimalDigit ; continue in the named workflow
DecimalDigitComplete addd      DecimalPlace,u ; add to d using DecimalPlace,u
                    std       ParsedNumber,u ; retain parsed number
                    leax      $01,x     ; select $01
                    rts                 ; return to the caller
NoDecimalNumber     ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,y      ; restore pc,y and return to the caller

* enable the SCF behavior required for interactive mail prompts.
InitializeTerminalInput
                    pshs      y,x,d     ; preserve the caller's startup registers
                    leax      >TerminalOptions,u ; select the local terminal-option packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt terminal options
                    os9       I$GetStt  ; copy the current path options into the packet
                    bcs       InitializeTerminalDone ; tolerate stdin paths that are not SCF devices
                    lda       #1        ; select the enabled value for both options
                    sta       PD.EKO-PD.OPT,x ; make typed responses visible
                    sta       PD.ALF-PD.OPT,x ; advance after echoed carriage returns
                    leax      >TerminalOptions,u ; resubmit the modified packet
                    clra                ; update standard input
                    clrb                ; select SS.Opt terminal options
                    os9       I$SetStt  ; install the interactive input settings
InitializeTerminalDone
                    puls      pc,y,x,d  ; restore the caller and continue

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
