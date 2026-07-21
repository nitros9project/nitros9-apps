**********************************************************************
* BBS.stat - OS-9 Level 2 BBS command
*
* syntax: BBS.stat
* purpose: display the current user's usage totals, or let user zero inspect
* another account. Records are scanned from /dd/bbs/BBS.userstats by OS-9 ID.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.stat
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with the revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

StatsPath           rmb       1         ; sequential path for BBS.userstats
DecimalCounter      rmb       1         ; repeated-add counter for conversion routines
DecimalValue        rmb       2         ; parser result or formatter remainder
DecimalDivisor      rmb       2         ; current power of ten for decimal conversion
TargetUserId        rmb       2         ; os-9 user ID whose record should be displayed
RecordUserId        rmb       2         ; os-9 user ID at record bytes 0 through 1
TimesCalled         rmb       2         ; login count at record bytes 2 through 3
RecordReservedA     rmb       6         ; unreported statistics at record bytes 4 through 9
MessagesLeft        rmb       2         ; posted-message count at record bytes 10 through 11
MessagesRead        rmb       2         ; read-message count at record bytes 12 through 13
FilesDownloaded     rmb       2         ; download count at record bytes 14 through 15
FilesUploaded       rmb       2         ; upload count at record bytes 16 through 17
LastLoginTimestamp  rmb       6         ; year, month, day, hour, minute, second
SessionElapsed      rmb       2         ; nonzero current-login duration value
RecordReservedTail  rmb       6         ; remaining bytes of the 32-byte statistics record
DecimalScratch      rmb       3         ; leading columns of the six-byte conversion buffer
TwoDigitTens        rmb       1         ; tens column used by timestamp formatting
TwoDigitOnes        rmb       1         ; ones column used by timestamp formatting
DecimalTerminator   rmb       1         ; cr appended by FormatDecimal
ReservedWorkspace   rmb       400       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.stat/ ; os-9 module name
StatisticsHeading   fcc       "User Statistics:" ; report title
                    fcb       C$CR      ; terminate the title
HeadingRule         fcc       "----------------------------------------------" ; report separator
                    fcb       C$CR      ; terminate the separator
LastOnLabel         fcc       "Last on         : " ; timestamp field heading
TimesCalledLabel    fcc       "Times called    : " ; login-count field heading
MessagesLeftLabel   fcc       "Messages left   : " ; posted-message field heading
MessagesReadLabel   fcc       "Messages read   : " ; read-message field heading
DownloadsLabel      fcc       "Files downloaded: " ; download-count field heading
UploadsLabel        fcc       "Files uploaded  : " ; upload-count field heading
SessionTimeLabel    fcc       "Time this login : " ; current-login field heading
UserIdPrompt        fcc       "User # to check:" ; shown only to OS-9 user zero
StatsFilename       fcc       "/dd/bbs/BBS.userstats" ; global fixed-record statistics file
MonthNames          fcc       "           January February    March    April      May     June     July   AugustSeptember  October November December" ; twelve nine-column month slots
CenturyPrefix       fcc       ", 19"    ; original fixed twentieth-century date prefix
TimeColon           fcb       ':'       ; hour/minute delimiter
start               leax      >StatsFilename,pc ; select the global user-statistics file
                    lda       #READ.    ; records are inspected without modification
                    os9       I$Open    ; open /dd/bbs/BBS.userstats
                    lbcs      ExitSuccess ; preserve the original silent-open-failure behavior
                    sta       StatsPath,u ; retain the sequential file path
                    os9       F$ID      ; obtain the caller's OS-9 user ID in Y
                    sty       TargetUserId,u ; default the lookup to the caller
                    lda       #C$CR     ; seed the shared number buffer terminator
                    sta       <DecimalTerminator,u ; keep conversions line-writable
                    ldd       TargetUserId,u ; test whether the caller is the superuser
                    cmpd      #0        ; os-9 user zero may inspect another account
                    bne       ReadNextStatsRecord ; ordinary users can inspect only themselves
                    lbsr      PromptForUserId ; replace zero with the requested account ID

* BBS.userstats consists of fixed 32-byte records keyed by the leading OS-9 user ID.
ReadNextStatsRecord leax      RecordUserId,u ; receive one complete statistics record
                    ldy       #32       ; preserve the on-disk record stride
                    lda       StatsPath,u ; select the open statistics stream
                    os9       I$Read    ; fetch the next account's counters and timestamps
                    bcs       CheckStatsReadError ; distinguish EOF from other read failures
                    ldd       RecordUserId,u ; inspect this record's account key
                    cmpd      TargetUserId,u ; compare it with the requested OS-9 ID
                    beq       DisplayStatistics ; stop at the matching account
                    bra       ReadNextStatsRecord ; scan the following fixed record
CheckStatsReadError cmpb      #E$EOF    ; a missing account naturally ends at EOF
                    lbne      ExitWithStatus ; propagate any actual I/O error
                    lbra      ExitSuccess ; report no statistics for an absent account

DisplayStatistics   leax      >StatisticsHeading,pc ; select the report title
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; introduce the matched user's statistics
                    leax      >HeadingRule,pc ; select the report separator
                    ldy       #200      ; let I$WritLn stop at its CR
                    os9       I$WritLn  ; underline the title
                    leax      >LastOnLabel,pc ; select the timestamp heading
                    ldy       #18       ; all report labels occupy eighteen columns
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor after "Last on"
                    leax      <LastLoginTimestamp,u ; select year through second from the record
                    lbsr      WriteLoginTimestamp ; render month, day, year, hour, and minute
                    leax      >TimesCalledLabel,pc ; select the login-count heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       TimesCalled,u ; fetch the accumulated login count
                    lbsr      WriteDecimalLine ; render and write it without leading zeroes
                    leax      >DownloadsLabel,pc ; select the download-count heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       <FilesDownloaded,u ; fetch the accumulated download count
                    lbsr      WriteDecimalLine ; render it as an unsigned decimal line
                    leax      >UploadsLabel,pc ; select the upload-count heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       <FilesUploaded,u ; fetch the accumulated upload count
                    lbsr      WriteDecimalLine ; render it as an unsigned decimal line
                    leax      >MessagesLeftLabel,pc ; select the post-count heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       <MessagesLeft,u ; fetch the number of messages posted
                    lbsr      WriteDecimalLine ; render it as an unsigned decimal line
                    leax      >MessagesReadLabel,pc ; select the read-count heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       <MessagesRead,u ; fetch the number of messages read
                    lbsr      WriteDecimalLine ; render it as an unsigned decimal line
                    ldd       <SessionElapsed,u ; inspect the optional current-login value
                    beq       FinishStatistics ; omit the field when no value is recorded
                    leax      >SessionTimeLabel,pc ; select the current-login heading
                    ldy       #18       ; write its fixed field width
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor at the numeric column
                    ldd       <SessionElapsed,u ; recover the nonzero session value
                    lbsr      WriteDecimalLine ; append it as an unsigned decimal line
FinishStatistics    leax      >HeadingRule,pc ; close the report with the same separator
                    lda       #1        ; target standard output
                    ldy       #200      ; let I$WritLn stop at its CR
                    os9       I$WritLn  ; finish the statistics display
ExitSuccess         clrb                ; return success for EOF and normal completion
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process
* format unsigned D, skip the formatter's leading zeroes, and emit one line.
WriteDecimalLine    leax      <DecimalScratch,u ; select the shared six-byte text buffer
                    lbsr      FormatDecimal ; render D as five digits plus CR
                    leax      <DecimalScratch,u ; scan from the first formatted column
SkipLeadingZero     lda       ,x+       ; inspect a possible leading zero
                    cmpa      #'0'      ; suppress zeroes before the significant digits
                    beq       SkipLeadingZero ; continue until a digit or CR is reached
                    cmpa      #C$CR     ; zero is represented by the formatter's final zero
                    bne       WriteDecimalValue ; back up over the first significant digit
                    leax      -1,x      ; step back from the byte after CR to the terminator
WriteDecimalValue   leax      -1,x      ; point at the first byte to display
                    ldy       #200      ; let I$WritLn stop at the formatter's CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; append the decimal value and newline
                    rts                 ; return after writing the counter

* render the six record bytes at X as "Month DD, 19YY HH:MM". The month table uses
* nine-byte slots; its leading padding is skipped while Y tracks the remaining width.
WriteLoginTimestamp lda       1,x       ; fetch the one-based month number
                    ldb       #9        ; each month-table slot is nine bytes wide
                    mul                 ; derive the table offset in D
                    pshs      x         ; preserve the record timestamp pointer
stk_timestamp_ptr   equ       0         ; saved six-byte timestamp pointer at the current stack top
                    leax      >MonthNames,pc ; select the packed month-name table
                    leax      d,x       ; enter the requested padded month slot
                    ldy       #10       ; include its separator space in the maximum width
SkipMonthPadding    lda       ,x+       ; discard left padding before the month name
                    cmpa      #C$SPAC   ; stop at the first name character
                    bne       WriteMonthName ; preserve the remaining field width in Y
                    leay      -1,y      ; omit one padding column from output
                    bne       SkipMonthPadding ; continue across the slot's leading spaces
WriteMonthName      leax      -1,x      ; restore the first month-name character
                    lda       #1        ; target standard output
                    os9       I$Write   ; write the month and its trailing separator
                    ldx       stk_timestamp_ptr,s ; recover the saved timestamp pointer
                    ldb       2,x       ; fetch the day of month
                    clra                ; zero-extend it to unsigned D
                    leax      <DecimalScratch,u ; select the shared conversion buffer
                    lbsr      FormatDecimal ; render the day in five columns
                    leax      <DecimalScratch,u ; return to the conversion buffer's first column
                    leax      3,x       ; select only its tens and ones columns
                    ldy       #2        ; write the two-digit day
                    lda       #1        ; target standard output
                    os9       I$Write   ; append DD
                    leax      >CenturyPrefix,pc ; select the original comma and century text
                    ldy       #4        ; write ", 19"
                    os9       I$Write   ; begin the four-digit year
                    ldx       stk_timestamp_ptr,s ; recover the saved timestamp pointer
                    ldb       ,x        ; fetch the stored two-digit year
                    clra                ; zero-extend it to unsigned D
                    leax      <DecimalScratch,u ; reuse the conversion buffer
                    lbsr      FormatDecimal ; render the year
                    leax      <TwoDigitTens,u ; select YY from its trailing columns
                    ldy       #2        ; write the two stored year digits
                    lda       #1        ; target standard output
                    os9       I$Write   ; complete the date
                    leax      >MonthNames,pc ; reuse the table's leading space as a separator
                    ldy       #1        ; write one byte before the time
                    os9       I$Write   ; separate date and hour
                    clra                ; prepare to zero-extend the hour
                    ldx       stk_timestamp_ptr,s ; recover the saved timestamp pointer
                    ldb       3,x       ; fetch the 24-hour value
                    leax      <DecimalScratch,u ; reuse the conversion buffer
                    lbsr      FormatDecimal ; render the hour
                    leax      <TwoDigitTens,u ; select HH from its trailing columns
                    ldy       #2        ; write the two-digit hour
                    lda       #1        ; target standard output
                    os9       I$Write   ; append HH
                    leax      >TimeColon,pc ; select the hour/minute delimiter
                    ldy       #1        ; write one colon
                    os9       I$Write   ; separate hour and minute
                    clra                ; prepare to zero-extend the minute
                    ldx       stk_timestamp_ptr,s ; recover the saved timestamp pointer
                    ldb       4,x       ; fetch the minute value
                    leax      <DecimalScratch,u ; reuse the conversion buffer
                    lbsr      FormatDecimal ; render the minute
                    leax      <DecimalScratch,u ; return to the conversion buffer's first column
                    leax      3,x       ; select MM plus the following CR
                    ldy       #200      ; let I$WritLn stop at that terminator
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; finish the timestamp line
                    puls      pc,x      ; restore X and return to the report writer
* parse the first decimal run in the CR-terminated text at X. Digits are accumulated
* from right to left with repeated addition because the 6809 has no divide instruction.
ParseDecimal        pshs      y         ; preserve the caller's Y register
FindFirstDecimalDigit lda     ,x+       ; scan for the first numeric character
                    cmpa      #C$CR     ; a blank or digit-free line is invalid here
                    lbeq      InvalidUserId ; terminate with the command's status-one result
                    cmpa      #'0'      ; reject characters below the decimal range
                    bcs       FindFirstDecimalDigit ; continue through prompt text or spaces
                    cmpa      #'9'      ; reject characters above the decimal range
                    bhi       FindFirstDecimalDigit ; continue until a digit or CR
                    leax      -1,x      ; include this first digit in the run scan
FindDecimalEnd      lda       ,x+       ; locate the first byte following the digit run
                    cmpa      #'0'      ; test the lower decimal bound
                    bcs       InitializeDecimalParse ; x now follows the number
                    cmpa      #'9'      ; test the upper decimal bound
                    bhi       InitializeDecimalParse ; x now follows the number
                    bra       FindDecimalEnd ; consume another contiguous digit
InitializeDecimalParse pshs   x         ; preserve the caller-visible end pointer
                    leax      -1,x      ; prepare for right-to-left predecrement reads
                    clr       DecimalValue,u ; clear the result's high byte
                    clr       DecimalValue+1,u ; clear the result's low byte
                    ldd       #1        ; the rightmost digit occupies the ones place
                    std       DecimalDivisor,u ; initialize the decimal place value
AccumulatePreviousDigit lda    ,-x       ; fetch the next digit moving leftward
                    cmpa      #'0'      ; stop before the numeric run
                    bcs       ReturnParsedDecimal ; return the accumulated binary value
                    cmpa      #'9'      ; stop if the preceding byte is above nine
                    bhi       ReturnParsedDecimal ; return the accumulated binary value
                    suba      #'0'      ; convert ASCII to a binary digit
                    sta       DecimalCounter,u ; use the digit as a repeated-add count
                    ldd       #0        ; begin digit times current place value
MultiplyDigitByPlace tst      DecimalCounter,u ; test whether the product is complete
                    beq       AddDigitContribution ; merge it into the running result
                    addd      DecimalDivisor,u ; add one copy of the current place value
                    dec       DecimalCounter,u ; consume one unit of the digit
                    bra       MultiplyDigitByPlace ; finish the digit's contribution
AddDigitContribution addd     DecimalValue,u ; merge this digit into the binary result
                    std       DecimalValue,u ; retain the partial value
                    lda       #10       ; the next place is ten times larger
                    sta       DecimalCounter,u ; prepare ten repeated additions
                    ldd       #0        ; begin computing the next power of ten
MultiplyPlaceByTen  tst       DecimalCounter,u ; test whether all ten copies were added
                    beq       SaveNextDecimalPlace ; retain the completed place value
                    addd      DecimalDivisor,u ; add another copy of the current place
                    dec       DecimalCounter,u ; consume one of the ten copies
                    bra       MultiplyPlaceByTen ; complete current place times ten
SaveNextDecimalPlace std      DecimalDivisor,u ; retain the next power of ten
                    bra       AccumulatePreviousDigit ; process the digit to the left
ReturnParsedDecimal ldd       DecimalValue,u ; return the parsed unsigned value in D
                    puls      x         ; leave X following the digit run
                    puls      pc,y      ; restore Y and return to the caller

* convert unsigned D to five zero-padded ASCII digits followed by CR at X.
FormatDecimal       std       DecimalValue,u ; retain the unformatted remainder
                    lda       #'0'      ; seed every output column with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       1,x       ; initialize the thousands column
                    sta       2,x       ; initialize the hundreds column
                    sta       3,x       ; initialize the tens column
                    sta       4,x       ; initialize the ones column
                    ldd       #10000    ; begin at the highest supported decimal place
                    std       DecimalDivisor,u ; select the ten-thousands divisor
                    ldd       DecimalValue,u ; recover the original value
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
                    lda       #C$CR     ; terminate the numeric text
                    sta       ,x        ; append CR after the ones column
                    rts                 ; return with X pointing at the CR

EmitDecimalDigit    subd      DecimalDivisor,u ; try to remove one unit of this place
                    bcs       DecimalDigitComplete ; underflow marks the finished digit
                    inc       ,x        ; record one more unit in the ASCII digit
                    bra       EmitDecimalDigit ; continue until the remainder is smaller
DecimalDigitComplete addd     DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalValue,u ; retain the remainder for the next column
                    leax      1,x       ; advance to the following output digit
                    rts                 ; return the updated remainder and pointer

InvalidUserId       ldb       #1        ; retain the original invalid-input exit status
                    lbra      ExitWithStatus ; terminate instead of scanning for user zero

PromptForUserId     leax      >UserIdPrompt,pc ; ask the superuser which account to inspect
                    ldy       #16       ; write the prompt's visible bytes
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor after the colon
                    leax      <DecimalScratch,u ; receive up to four ID digits and CR
                    ldy       #5        ; bound the response by the shared buffer
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the requested OS-9 user ID
                    lbsr      ParseDecimal ; convert the first digit run to binary
                    std       TargetUserId,u ; replace the root caller ID with that selection
                    rts                 ; resume the fixed-record scan

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
