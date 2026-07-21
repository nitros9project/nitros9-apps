**********************************************************************
* bbs.scan - OS-9 Level 2 BBS command
*
* syntax: BBS.scan
* purpose: display compact headings from the current message index.
* avoids opening BBS.msg because every displayed field is stored in the index.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.scan
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

IndexPath           rmb       1         ; sequential path for BBS.msg.inx
ShiftOrFormatCounter rmb     1         ; six-bit seek shift count, reused by formatting
DecimalCounter      rmb       1         ; repeated-add counter for decimal conversion
AuthorNameLength    rmb       2         ; measured display width of the current author
DecimalValue        rmb       2         ; parser result or formatter remainder
DecimalDivisor      rmb       2         ; current power of ten for decimal conversion
CurrentMessageOrDecimalText rmb 6       ; formatted number, then binary scan position
TwoDigitScratch     rmb       3         ; unused leading columns of a five-digit conversion
TwoDigitTens        rmb       1         ; tens column used for date components
TwoDigitOnes        rmb       1         ; ones column used for date components
TwoDigitTerminator  rmb       1         ; cr appended by FormatDecimal
ParseScratch        rmb       1         ; retained cleared byte beside the input buffer
StartingMessageInput rmb      6         ; operator-entered first message number
RecordOffsetHigh    rmb       2         ; high word of message-number times 64
RecordOffsetLow     rmb       2         ; low word of message-number times 64
DateText            rmb       1         ; month tens column
DateMonthOnes       rmb       1         ; month ones column
DateSlash1          rmb       1         ; month/day delimiter
DateDayTens         rmb       1         ; day tens column
DateDayOnes         rmb       1         ; day ones column
DateSlash2          rmb       1         ; day/year delimiter
DateYearTens        rmb       1         ; year tens column
DateYearOnes        rmb       1         ; year ones column
DateTerminator      rmb       1         ; cr terminating MM/DD/YY
IndexHeader         rmb       64        ; header whose first word is the high message number
MessageOffset       rmb       4         ; 32-bit body offset at record bytes 0 through 3
AuthorName          rmb       20        ; author display name at record offset 4
MessageSubject      rmb       30        ; subject at record offset 24
MessageYear         rmb       1         ; two-digit year at record offset 54
MessageMonth        rmb       1         ; month at record offset 55
MessageDay          rmb       1         ; day at record offset 56
MessageRecordTail   rmb       7         ; time, author ID, and recipient ID at offsets 57 through 63
ReservedWorkspace   rmb       198       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.scan/ ; os-9 module name
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; original embedded notice
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
HighMessagePrompt   fcc       "High message is #" ; precedes the current high-water mark
HighMessagePromptLength fdb   17        ; visible prompt length for I$Write
StartingMessagePrompt fcc     "Enter starting message #" ; selects the first index row displayed
                    fcb       C$CR      ; terminate the prompt
PromptMarker        fcc       ">"       ; one-byte input marker
ScanHeading         fcc       "Msg #    User name              Date        Subject" ; compact table heading
                    fcb       C$CR      ; terminate the heading
HeadingRule         fcc       "----------------------------------------------------------------" ; underline for the table heading
                    fcb       C$CR      ; terminate the rule
IndexFilename       fcc       "BBS.msg.inx" ; current board's message index
                    fcb       C$CR      ; terminate the OS-9 pathname
ColumnPadding       fcc       "                                       " ; reusable spaces between fields
DeletedMessageBanner fcc      "          ******   DELETED   ******" ; row shown for tombstones
                    fcb       C$CR      ; terminate the deleted row
start               leax      >IndexFilename,pc ; select the current board index
                    lda       #READ.    ; scanning never modifies message metadata
                    os9       I$Open    ; open BBS.msg.inx
                    lbcs      ExitWithStatus ; preserve open errors
                    sta       IndexPath,u ; retain the sequential index path
                    leax      <IndexHeader,u ; receive the complete 64-byte header
                    ldy       #64       ; position the stream at message record one
                    lda       IndexPath,u ; select the index
                    os9       I$Read    ; load its high-water mark
                    lbcs      ExitWithStatus ; preserve header errors

* display the high-water mark and ask which record should begin the compact listing.
                    ldd       <IndexHeader,u ; fetch the highest message number
                    leax      CurrentMessageOrDecimalText,u ; select the shared numeric buffer
                    lbsr      FormatDecimal ; render five columns plus CR
                    leax      >HighMessagePrompt,pc ; select the fixed status prefix
                    ldy       >HighMessagePromptLength,pc ; write its 17 visible bytes
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor before the formatted number
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      CurrentMessageOrDecimalText,u ; append the formatted high number
                    ldy       #6        ; bound five columns and CR
                    os9       I$WritLn  ; complete the status line
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >StartingMessagePrompt,pc ; select the first-record question
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; ask for the starting message
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >PromptMarker,pc ; select the one-byte marker
                    ldy       #1        ; write only '>'
                    os9       I$Write   ; leave the cursor ready for input
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      <StartingMessageInput,u ; receive the requested message number
                    ldy       #6        ; accept five digits plus CR
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect the response
                    lbcs      ExitWithStatus ; preserve terminal errors
                    clr       <ParseScratch,u ; retain the original workspace initialization
                    leax      <StartingMessageInput,u ; parse the response just entered
                    lbsr      ParseDecimal ; convert its first decimal run to D
                    cmpd      #1        ; message numbering begins at one
                    lbcs      ExitSuccess ; cancel on zero or missing digits
                    cmpd      <IndexHeader,u ; reject values beyond the high-water mark
                    lbhi      ExitSuccess ; cancel an out-of-range scan
                    std       CurrentMessageOrDecimalText,u ; retain the first displayed number

* multiply the user-visible message number by the 64-byte record stride. Message one
* naturally maps past the 64-byte header to file offset 64.
                    clr       <RecordOffsetHigh,u ; clear the 32-bit product's top byte
                    clr       <RecordOffsetHigh+1,u ; clear its second byte
                    lda       #6        ; multiplication by 64 requires six left shifts
                    sta       ShiftOrFormatCounter,u ; initialize the shift count
                    ldd       CurrentMessageOrDecimalText,u ; fetch the selected message number
ShiftStartingMessage aslb               ; shift the low product byte
                    rola                ; propagate carry through the next byte
                    rol       <RecordOffsetHigh+1,u ; propagate carry into the high word
                    dec       ShiftOrFormatCounter,u ; account for one factor of two
                    bne       ShiftStartingMessage ; complete message number times 64
                    std       <RecordOffsetLow,u ; retain the product's low word
                    ldx       <RecordOffsetHigh,u ; supply the high word to I$Seek
                    lda       IndexPath,u ; select BBS.msg.inx
                    pshs      u         ; protect workspace U while it becomes the low word
                    ldu       <RecordOffsetLow,u ; complete the 32-bit file offset
                    os9       I$Seek    ; position at the requested index record
                    lbcs      ExitWithStatus ; preserve seek errors
                    puls      u         ; recover the workspace pointer
                    leax      >ScanHeading,pc ; select the compact column labels
                    ldy       #80       ; let I$WritLn stop at their CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the table heading
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >HeadingRule,pc ; select its underline
                    ldy       #80       ; let I$WritLn stop at the rule's CR
                    os9       I$WritLn  ; separate headings from rows
                    lbcs      ExitWithStatus ; preserve terminal errors
ReadNextRecord      lda       IndexPath,u ; select the index stream
                    ldy       #64       ; consume one complete fixed-size record
                    leax      <MessageOffset,u ; receive offset, headings, date, and IDs
                    os9       I$Read    ; fetch the next sequential message entry
                    lbcs      ExitSuccess ; eof completes the scan successfully
                    ldd       <MessageOffset,u ; inspect the body-offset high word
                    cmpd      #$FFFF    ; recognize a deleted record
                    lbeq      DisplayDeletedRecord ; show the deletion placeholder row

* begin a live row with its number and author, using fixed columns independent of
* the author's actual display-name length.
                    ldd       CurrentMessageOrDecimalText,u ; fetch this record's visible number
                    leax      TwoDigitScratch,u ; reuse the six-byte decimal buffer
                    lbsr      FormatDecimal ; render the five-column message number
                    ldd       CurrentMessageOrDecimalText,u ; advance the row counter
                    addd      #1        ; select the following message number
                    std       CurrentMessageOrDecimalText,u ; retain it for the next record
                    leax      TwoDigitScratch,u ; select the five visible number columns
                    ldy       #5        ; omit FormatDecimal's trailing CR
                    lda       #1        ; target standard output
                    os9       I$Write   ; begin the compact row
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >ColumnPadding,pc ; separate number and author columns
                    ldy       #4        ; retain the original four-space gap
                    os9       I$Write   ; advance to the author column
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      <AuthorName,u ; scan the record's author field
                    clr       AuthorNameLength,u ; clear the measured width's high byte
                    clr       AuthorNameLength+1,u ; clear its low byte
MeasureAuthorName   lda       ,x+       ; inspect the next author byte
                    cmpa      #C$CR     ; stop before the field terminator
                    beq       AuthorNameMeasured ; retain the visible length
                    inc       AuthorNameLength+1,u ; account for one display character
                    bra       MeasureAuthorName ; continue through the author field
AuthorNameMeasured  leax      <AuthorName,u ; select the author field's first byte
                    ldy       AuthorNameLength,u ; write exactly its visible characters
                    lda       #1        ; target standard output
                    os9       I$Write   ; append the author without its CR
                    lbcs      ExitWithStatus ; preserve terminal errors
                    ldd       #22       ; the date begins 22 columns after the author starts
                    subd      AuthorNameLength,u ; derive the required padding width
                    tfr       d,y       ; supply that width to I$Write
                    leax      >ColumnPadding,pc ; select reusable spaces
                    lda       #1        ; target standard output
                    os9       I$Write   ; align the date column
                    lbcs      ExitWithStatus ; preserve terminal errors

* construct MM/DD/YY from the index's byte-sized date fields. FormatDecimal emits
* five columns, so only its final tens and ones positions are copied.
                    leax      TwoDigitScratch,u ; select the shared conversion buffer
                    ldb       >MessageMonth,u ; zero-extend the stored month
                    clra                ; form unsigned month in D
                    lbsr      FormatDecimal ; render it as five columns
                    lda       <TwoDigitTens,u ; take the month tens column
                    sta       <DateText,u ; begin the compact date
                    lda       <TwoDigitOnes,u ; take the month ones column
                    sta       <DateMonthOnes,u ; complete the month
                    lda       #'/'      ; insert the month/day delimiter
                    sta       <DateSlash1,u ; retain it in the output buffer
                    ldb       >MessageDay,u ; zero-extend the stored day
                    clra                ; form unsigned day in D
                    leax      TwoDigitScratch,u ; reuse the conversion buffer
                    lbsr      FormatDecimal ; render the day
                    lda       <TwoDigitTens,u ; take the day tens column
                    sta       <DateDayTens,u ; append it after the slash
                    lda       <TwoDigitOnes,u ; take the day ones column
                    sta       <DateDayOnes,u ; complete the day
                    lda       #'/'      ; insert the day/year delimiter
                    sta       <DateSlash2,u ; retain it in the output buffer
                    ldb       >MessageYear,u ; zero-extend the stored year
                    clra                ; form unsigned two-digit year in D
                    leax      TwoDigitScratch,u ; reuse the conversion buffer
                    lbsr      FormatDecimal ; render the year
                    lda       <TwoDigitTens,u ; take the year tens column
                    sta       <DateYearTens,u ; append it after the slash
                    lda       <TwoDigitOnes,u ; take the year ones column
                    sta       <DateYearOnes,u ; complete the date
                    lda       #C$CR     ; retain the historical unused terminator byte
                    sta       <DateTerminator,u ; follow the eight visible date bytes
                    leax      <DateText,u ; select MM/DD/YY
                    ldy       #8        ; omit the stored CR
                    lda       #1        ; target standard output
                    os9       I$Write   ; append the date column
                    lbcs      ExitWithStatus ; preserve terminal errors
                    ldy       #5        ; separate date and subject columns
                    leax      >ColumnPadding,pc ; select reusable spaces
                    os9       I$Write   ; advance to the subject column
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >MessageSubject,u ; select the fixed-width subject field
                    ldy       #30       ; bound output by its index-record allocation
                    os9       I$WritLn  ; finish the row at the subject CR
                    lbcs      ExitWithStatus ; preserve terminal errors
                    lbra      ReadNextRecord ; display the following index entry

DisplayDeletedRecord ldd      CurrentMessageOrDecimalText,u ; advance past this tombstone's number
                    addd      #1        ; keep numbering parallel with index records
                    std       CurrentMessageOrDecimalText,u ; retain the next visible number
                    leax      >DeletedMessageBanner,pc ; select the deletion placeholder
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; show that the numbered record has no live message
                    lbra      ReadNextRecord ; continue the sequential scan
ExitSuccess         clrb                ; treat eof and cancellation as success
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process
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
                    clr       DecimalValue,u ; clear the high byte of the result
                    clr       DecimalValue+1,u ; clear the low byte of the result
                    ldd       #1        ; the rightmost digit occupies the ones place
                    std       DecimalDivisor,u ; initialize the decimal place value
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
                    addd      DecimalDivisor,u ; add one copy of the current place value
                    dec       DecimalCounter,u ; consume one unit of the digit
                    bra       MultiplyDigitByPlace ; finish digit times place value

AddDigitContribution addd     DecimalValue,u ; add this digit's contribution to the result
                    std       DecimalValue,u ; retain the partial binary value
                    lda       #10       ; the next digit's place is ten times larger
                    sta       DecimalCounter,u ; repeat the current place value ten times
                    ldd       #0        ; begin calculating the next place value
MultiplyPlaceByTen  tst       DecimalCounter,u ; test whether ten copies have been added
                    beq       SaveNextDecimalPlace ; retain the completed power of ten
                    addd      DecimalDivisor,u ; add another copy of the current place
                    dec       DecimalCounter,u ; consume one of the ten copies
                    bra       MultiplyPlaceByTen ; complete place times ten

SaveNextDecimalPlace std      DecimalDivisor,u ; retain the next power of ten
                    bra       AccumulatePreviousDigit ; process the digit to the left

ReturnParsedDecimal ldd       DecimalValue,u ; return the accumulated unsigned value in D
                    puls      x         ; return X at the end of the parsed digit run
                    puls      pc,y      ; preserve the caller's Y register on return

* convert unsigned D to five ASCII columns followed by CR at X. Leading zeroes become
* spaces, and X returns pointing at the first byte following the significant digits.
FormatDecimal       pshs      x         ; preserve the start of the destination buffer
                    std       DecimalValue,u ; retain the unformatted remainder
                    lda       #'0'      ; seed all five columns with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       1,x       ; initialize the thousands column
                    sta       2,x       ; initialize the hundreds column
                    sta       3,x       ; initialize the tens column
                    sta       4,x       ; initialize the ones column
                    ldd       #10000    ; begin at the highest supported decimal place
                    std       DecimalDivisor,u ; select the ten-thousands divisor
                    ldd       DecimalValue,u ; recover the unformatted value
                    lbsr      EmitDecimalDigit ; emit the ten-thousands digit
                    ldd       #1000     ; select the thousands place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the thousands digit
                    ldd       #100      ; select the hundreds place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the hundreds digit
                    ldd       #10       ; select the tens place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit the tens digit
                    ldd       #1        ; select the ones place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the final remainder
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
EmitDecimalDigit    subd      DecimalDivisor,u ; try to remove one unit of this place
                    bcs       DecimalDigitComplete ; underflow marks the finished digit
                    inc       ,x        ; record one more unit in the ASCII digit
                    bra       EmitDecimalDigit ; continue until the remainder is smaller

DecimalDigitComplete addd     DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalValue,u ; retain the remainder for the next digit
                    leax      1,x       ; advance to the next output column
                    rts                 ; return the remainder and destination position

DecimalNotFound     ldd       #$FFFF    ; return the original no-decimal-run sentinel
                    puls      pc,y      ; preserve the caller's Y register on the failure return

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
