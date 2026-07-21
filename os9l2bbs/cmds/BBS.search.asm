**********************************************************************
* BBS.search - OS-9 Level 2 BBS command
*
* syntax: BBS.search
* purpose: search message subjects for caller-entered text.
* scans BBS.msg.inx sequentially and prints compact rows for matching records.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.search
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

IndexPath           rmb       1         ; sequential path for BBS.msg.inx
PathReserved        rmb       2         ; retain the original three-byte path area
AuthorNameLength    rmb       2         ; measured width of the current author field
DecimalValue        rmb       2         ; formatter remainder
DecimalDivisor      rmb       2         ; current decimal place value
MessageNumberText   rmb       6         ; five formatted columns followed by CR
TwoDigitScratch     rmb       3         ; unused leading columns of date conversions
TwoDigitTens        rmb       1         ; tens column used for date components
TwoDigitOnes        rmb       1         ; ones column used for date components
TwoDigitTerminator  rmb       1         ; cr appended by FormatDecimal
SearchStateScratch  rmb       1         ; preserved initialization beside the query buffer
SearchText          rmb       34        ; caller-entered subject substring
DateMonthTens       rmb       1         ; month tens column
DateMonthOnes       rmb       1         ; month ones column
DateSlash1          rmb       1         ; month/day delimiter
DateDayTens         rmb       1         ; day tens column
DateDayOnes         rmb       1         ; day ones column
DateSlash2          rmb       1         ; day/year delimiter
DateYearTens        rmb       1         ; year tens column
DateYearOnes        rmb       1         ; year ones column
DateTerminator      rmb       1         ; cr following the assembled date
IndexHeader         rmb       64        ; 64-byte index header, read to advance the stream
MessageOffset       rmb       4         ; body offset whose first word marks tombstones
AuthorName          rmb       20        ; record author at offset 4
MessageSubject      rmb       30        ; searchable subject at offset 24
MessageYear         rmb       1         ; two-digit year at record offset 54
MessageMonth        rmb       1         ; month at record offset 55
MessageDay          rmb       1         ; day at record offset 56
MessageRecordTail   rmb       7         ; time and user IDs at record offsets 57 through 63
ReservedWorkspace   rmb       198       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.search/ ; os-9 module name
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; original embedded notice
LicensePayload      fcb       $EC       ; opaque high-bit-set licensing payload
                    fcb       $E6       ; preserve the original byte sequence
                    fcb       $EA       ; preserve the original byte sequence
                    fcb       $F5       ; preserve the original byte sequence
                    fcb       $E9       ; preserve the original byte sequence
                    fcb       $A0       ; preserve the original byte sequence
                    fcb       $E2       ; preserve the original byte sequence
                    fcb       $ED       ; preserve the original byte sequence
                    fcb       $F1       ; preserve the original byte sequence
                    fcb       $E9       ; preserve the original byte sequence
                    fcb       $F0       ; preserve the original byte sequence
                    fcb       $EF       ; preserve the original byte sequence
                    fcb       $F4       ; preserve the original byte sequence
                    fcb       $F0       ; preserve the original byte sequence
HighMessagePrompt   fcc       "High message is #" ; unused status text retained from the companion scanner
HighPromptLengthHigh fcb      $00       ; high byte of the unused length word
HighPromptLengthLow fcb       $11       ; low byte gives the prompt's 17 visible characters
SearchPrompt        fcc       "Enter subject search text" ; asks for the subject substring
                    fcb       C$CR      ; terminate the prompt
PromptMarker        fcc       ">"       ; one-byte input marker
SearchHeading       fcc       "Msg #    User name              Date        Subject" ; compact result heading
                    fcb       C$CR      ; terminate the heading
HeadingRule         fcc       "----------------------------------------------------------------" ; heading underline
                    fcb       C$CR      ; terminate the rule
IndexFilename       fcc       "BBS.msg.inx" ; current board's message index
                    fcb       C$CR      ; terminate the OS-9 pathname
ColumnPadding       fcc       "                                       " ; reusable spaces between columns
DeletedMessageBanner fcc      "          ******   DELETED   ******" ; retained tombstone result row
                    fcb       C$CR      ; terminate the deleted row
start               leax      >IndexFilename,pc ; select the current board index
                    lda       #READ.    ; searching never modifies message metadata
                    os9       I$Open    ; open BBS.msg.inx
                    lbcs      ExitWithStatus ; preserve open errors
                    sta       IndexPath,u ; retain the sequential index path
                    leax      <IndexHeader,u ; receive the complete 64-byte header
                    ldy       #64       ; position the stream at message record one
                    lda       IndexPath,u ; select the index
                    os9       I$Read    ; consume its header record
                    lbcs      ExitWithStatus ; preserve header-read errors
                    ldd       #0        ; message records are numbered from one
                    std       MessageNumberText,u ; initialize the running record number

PromptForSearch     leax      >SearchPrompt,pc ; ask for a subject substring
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the search question
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >PromptMarker,pc ; select the one-byte input marker
                    ldy       #1        ; write only '>'
                    os9       I$Write   ; leave the cursor ready for input
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      <SearchText,u ; receive the subject substring
                    ldy       #30       ; match the index subject field's maximum width
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the CR-terminated query
                    bcs       PromptForSearch ; retry after an input failure
                    clr       <SearchStateScratch,u ; retain the original adjacent initialization
                    leax      <SearchText,u ; preserve the original, immediately superseded pointer load
                    leax      >SearchHeading,pc ; select the compact result headings
                    ldy       #80       ; let I$WritLn stop at their CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the result columns
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >HeadingRule,pc ; select the heading underline
                    ldy       #80       ; let I$WritLn stop at its CR
                    os9       I$WritLn  ; separate headings from result rows
                    lbcs      ExitWithStatus ; preserve terminal errors

* each 64-byte record is searched in place. Y advances through the subject while X
* restarts at the query after mismatches; b caps total comparisons at 30 bytes.
ReadNextIndexRecord lda       IndexPath,u ; select the index stream
                    ldy       #64       ; consume one complete fixed-size record
                    leax      >MessageOffset,u ; receive offset, headings, date, and IDs
                    os9       I$Read    ; fetch the next message entry
                    lbcs      ExitSuccess ; eof completes the search normally
                    ldd       MessageNumberText,u ; advance the user-visible record number
                    addd      #1        ; account for the entry just read
                    std       MessageNumberText,u ; retain it for a matching row
                    leay      >MessageSubject,u ; begin at the record's subject field
                    ldb       #30       ; bound comparisons by the fixed subject width
RestartSubjectMatch leax      <SearchText,u ; restart at the query's first character
CompareSearchText   lda       ,x+       ; fetch the next query character
                    cmpa      #C$CR     ; reaching query end means the substring matched
                    beq       SubjectMatched ; display this index record
                    decb                ; account for one subject comparison
                    beq       ReadNextIndexRecord ; no room remains for a match in this subject
                    cmpa      ,y+       ; compare query and subject bytes case-sensitively
                    bne       RestartSubjectMatch ; advance the subject and restart the query
                    bra       CompareSearchText ; extend the current partial match

SubjectMatched      ldd       >MessageOffset,u ; inspect the body-offset high word
                    cmpd      #$FFFF    ; identify a deleted index record
                    lbeq      DisplayDeletedMatch ; retain the original tombstone result row
                    ldd       MessageNumberText,u ; fetch the matching record number
                    leax      TwoDigitScratch,u ; select the shared six-byte number buffer
                    lbsr      FormatDecimal ; render five columns plus CR
                    leax      TwoDigitScratch,u ; select the five visible number columns
                    ldy       #5        ; omit FormatDecimal's trailing CR
                    lda       #1        ; target standard output
                    os9       I$Write   ; begin the compact result row
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >ColumnPadding,pc ; separate number and author columns
                    ldy       #4        ; retain the original four-space gap
                    os9       I$Write   ; advance to the author column
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >AuthorName,u ; scan the record's author field
                    clr       AuthorNameLength,u ; clear the measured width's high byte
                    clr       AuthorNameLength+1,u ; clear its low byte
MeasureAuthorName   lda       ,x+       ; inspect the next author byte
                    cmpa      #C$CR     ; stop before the field terminator
                    beq       AuthorNameMeasured ; retain the visible length
                    inc       AuthorNameLength+1,u ; account for one display character
                    bra       MeasureAuthorName ; continue through the author field
AuthorNameMeasured  leax      >AuthorName,u ; select the author field's first byte
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

* build MM/DD/YY from the index bytes. FormatDecimal emits five columns, so only
* the final tens and ones positions are copied for each component.
                    leax      TwoDigitScratch,u ; select the shared conversion buffer
                    ldb       >MessageMonth,u ; zero-extend the stored month
                    clra                ; form unsigned month in D
                    lbsr      FormatDecimal ; render the month
                    lda       <TwoDigitTens,u ; take the month tens column
                    sta       <DateMonthTens,u ; begin the compact date
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
                    sta       <DateYearTens,u ; append it after the second slash
                    lda       <TwoDigitOnes,u ; take the year ones column
                    sta       <DateYearOnes,u ; complete the date
                    lda       #C$CR     ; retain the historical unused terminator byte
                    sta       <DateTerminator,u ; follow the eight visible date bytes
                    leax      <DateMonthTens,u ; select MM/DD/YY
                    ldy       #8        ; omit the stored CR
                    lda       #1        ; target standard output
                    os9       I$Write   ; append the compact date
                    lbcs      ExitWithStatus ; preserve terminal errors
                    ldy       #5        ; separate date and subject columns
                    leax      >ColumnPadding,pc ; select reusable spaces
                    os9       I$Write   ; advance to the subject column
                    lbcs      ExitWithStatus ; preserve terminal errors
                    leax      >MessageSubject,u ; select the matching subject field
                    ldy       #30       ; bound output by its index allocation
                    os9       I$WritLn  ; finish the row at the subject CR
                    lbcs      ExitWithStatus ; preserve terminal errors
                    lbra      ReadNextIndexRecord ; search the following entry

DisplayDeletedMatch leax      >DeletedMessageBanner,pc ; select the tombstone placeholder
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; show that a matching record has been deleted
                    lbra      ReadNextIndexRecord ; continue the sequential search
ExitSuccess         clrb                ; treat eof as successful completion
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process
* unreachable parser image retained byte-for-byte from the original module. It is
* valid 6809 code, but no live branch or call enters it. The distant no-digit return
* remains after FormatDecimal because the embedded LBEQ spans that intervening code.
EmbeddedParserImage fcb       $34       ; pshs opcode for the parser prologue
                    fcb       $20       ; register mask saves Y
                    fcb       $A6       ; lda indexed opcode begins the digit scan
                    fcb       $80       ; postincrement X after each inspected byte
                    fcb       $81       ; cmpa immediate opcode
                    fcb       $0D       ; carriage-return failure sentinel
                    fcb       $10       ; long-branch instruction prefix
                    fcb       $27       ; lbeq opcode targeting EmbeddedNoDigitReturn
                    fcb       $00       ; high byte of the forward displacement
                    fcb       $CB       ; low byte crosses the live formatter
                    fcb       $81       ; cmpa immediate opcode
                    fcb       $30       ; lower ASCII digit bound
                    fcb       $25       ; bcs opcode restarts the scan below '0'
                    fcb       $F4       ; backward displacement to the scan loop
                    fcb       $81       ; cmpa immediate opcode
                    fcb       $39       ; upper ASCII digit bound
                    fcb       $22       ; bhi opcode restarts the scan above '9'
                    fcb       $F0       ; backward displacement to the scan loop
                    fcb       $30       ; leax indexed opcode
                    fcb       $1F       ; indexed -1 adjustment includes the first digit
                    fcb       $A6       ; lda indexed opcode scans to the run's end
                    fcb       $80       ; postincrement X through the digit run
                    fcb       $81       ; cmpa immediate opcode
                    fcb       $30       ; lower ASCII digit bound
                    fcb       $25       ; bcs opcode leaves the forward scan
                    fcb       $06       ; displacement to parser initialization
                    fcb       $81       ; cmpa immediate opcode
                    fcb       $39       ; upper ASCII digit bound
                    fcb       $22       ; bhi opcode leaves the forward scan
                    fcb       $02       ; displacement to parser initialization
                    fcb       $20       ; bra opcode continues through digits
                    fcb       $F4       ; backward displacement to the run scan
                    fcb       $34       ; pshs opcode preserves the end pointer
                    fcb       $10       ; register mask saves X
                    fcb       $30       ; leax indexed opcode
                    fcb       $1F       ; indexed -1 prepares reverse traversal
                    fcc       "oEoF"    ; machine bytes decode as clr 5,u and clr 6,u
                    fcb       $CC       ; ldd immediate opcode initializes the ones place
                    fcb       $00       ; high byte of decimal one
                    fcb       $01       ; low byte of decimal one
                    fcb       $ED       ; std indexed opcode
                    fcb       $47       ; store divisor at workspace offset seven
                    fcb       $A6       ; lda indexed opcode fetches the previous digit
                    fcb       $82       ; predecrement X before the fetch
                    fcb       $81       ; cmpa immediate opcode
                    fcc       "0%."     ; printable bytes encode compare '0' and bcs +46
                    fcb       $81       ; cmpa immediate opcode
                    fcc       /9"*/     ; printable bytes encode compare '9' and bhi +42
                    fcb       $80       ; suba immediate opcode
                    fcb       $30       ; ascii-zero bias
                    fcb       $A7       ; sta indexed opcode
                    fcb       $42       ; save the binary digit at workspace offset two
                    fcb       $CC       ; ldd immediate opcode
                    fcb       $00       ; high byte of zero product
                    fcb       $00       ; low byte of zero product
                    fcc       "mB'"     ; machine bytes encode tst 2,u and beq
                    fcb       $06       ; skip to merge when the product is complete
                    fcb       $E3       ; addd indexed opcode
                    fcc       "GjB "    ; machine bytes add divisor, decrement count, and loop
                    fcb       $F6       ; backward displacement for digit multiplication
                    fcb       $E3       ; addd indexed opcode merges the contribution
                    fcb       $45       ; add the accumulated result at offset five
                    fcb       $ED       ; std indexed opcode
                    fcb       $45       ; retain the accumulated result at offset five
                    fcb       $86       ; lda immediate opcode
                    fcb       $0A       ; ten additions produce the next decimal place
                    fcb       $A7       ; sta indexed opcode
                    fcb       $42       ; store the repeated-add count at offset two
                    fcb       $CC       ; ldd immediate opcode
                    fcb       $00       ; high byte of the next-place accumulator
                    fcb       $00       ; low byte of the next-place accumulator
                    fcc       "mB'"     ; machine bytes encode tst 2,u and beq
                    fcb       $06       ; skip to divisor storage when ten additions finish
                    fcb       $E3       ; addd indexed opcode
                    fcc       "GjB "    ; machine bytes add divisor, decrement count, and loop
                    fcb       $F6       ; backward displacement for place multiplication
                    fcb       $ED       ; std indexed opcode
                    fcb       $47       ; retain the next divisor at workspace offset seven
                    fcb       $20       ; bra opcode processes the digit to the left
                    fcb       $CC       ; backward displacement to reverse traversal
                    fcb       $EC       ; ldd indexed opcode fetches the parsed result
                    fcb       $45       ; result resides at workspace offset five
                    fcb       $35       ; puls opcode begins the success epilogue
                    fcb       $10       ; restore X
                    fcb       $35       ; puls opcode returns through the saved frame
                    fcb       $A0       ; restore Y and PC
* convert unsigned D to five ASCII columns followed by CR at X. Leading zeroes
* become spaces, and X returns at the first byte following significant digits.
FormatDecimal       pshs      x         ; preserve the destination's first column
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

EmitDecimalDigit    subd      DecimalDivisor,u ; try to remove one unit of this place
                    bcs       DecimalDigitComplete ; underflow marks the finished digit
                    inc       ,x        ; record one more unit in the ASCII digit
                    bra       EmitDecimalDigit ; continue until the remainder is smaller
DecimalDigitComplete addd     DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalValue,u ; retain the remainder for the next digit
                    leax      1,x       ; advance to the next output column
                    rts                 ; return the remainder and destination position

* failure tail reached only by the long branch inside EmbeddedParserImage.
EmbeddedNoDigitReturn fcb      $CC       ; ldd immediate opcode
                    fcb       $FF       ; high byte of the $FFFF failure sentinel
                    fcb       $FF       ; low byte of the $FFFF failure sentinel
                    fcb       $35       ; puls opcode
                    fcb       $A0       ; restore Y and PC to return from the embedded parser

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
