**********************************************************************
* bbs.delete - OS-9 Level 2 BBS command
*
* syntax: BBS.delete
* purpose: mark a selected message deleted in the current board index.
* deletion is logical until BBS.pack rewrites the base.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.delete
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

IndexPath           rmb       1         ; update-mode path for BBS.msg.inx
ShiftOrDecimalCounter rmb     1         ; six-bit shift count, reused by decimal formatting
DecimalCounter      rmb       1         ; repeated-add counter used by decimal parsing
CallerUserId        rmb       2         ; original caller ID returned by F$ID
CallerIdReserved    rmb       2         ; unused remainder of the original caller workspace
DecimalValue        rmb       2         ; parser result or formatter remainder
DecimalDivisor      rmb       2         ; current power of ten for numeric conversion
MessageNumberOrDecimalText rmb 6        ; formatted high number, later requested message number
DecimalTextReserved rmb       6         ; unused tail of the original conversion buffer
ParseScratch        rmb       1         ; retained cleared byte beside the input buffer
MessageNumberInput  rmb       6         ; operator-entered message number
RecordOffsetHigh    rmb       2         ; high word of message-number times 64
RecordOffsetLow     rmb       2         ; low word of message-number times 64
OffsetWorkspace     rmb       9         ; unused tail beside the computed seek offset
IndexHeader         rmb       64        ; header whose first word is the high message number
IndexRecordPrefix   rmb       60        ; offset, names, subject, and timestamp of one record
OwnerUserId         rmb       2         ; author ID at record offset 60
RecipientUserId     rmb       2         ; recipient ID at record offset 62
ReservedWorkspace   rmb       200       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.delete/ ; os-9 module name
                    fcc       "Copyright (C) 1988" ; original embedded copyright notice
                    fcc       "By Keith Alphonso" ; original author credit
                    fcc       "Licenced to Alpha Software Technologies" ; original publisher credit and spelling
                    fcc       "All rights reserved" ; original rights notice
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
HighMessagePrompt   fcc       "High message is #" ; precedes the current index high-water mark
HighMessagePromptLength fdb   17        ; visible prompt length for I$Write
DeletePrompt        fcc       "Enter message number to delete" ; operator question
                    fcb       C$CR      ; terminate the prompt
PromptAndLegacyHeading fcc    ">Msg #    User name              Date        Subject" ; only the leading '>' is used
                    fcb       C$CR      ; terminate the retained legacy heading
                    fcc       "-------------------------------------------------------------------------------" ; retained legacy underline
                    fcb       C$CR      ; terminate the underline
IndexFilename       fcc       "BBS.msg.inx" ; fixed-size message index in the current board
                    fcb       C$CR      ; terminate the OS-9 pathname
LegacyPadding       fcc       "                                       " ; retained unreferenced display padding
DeletedMessage      fcc       "          ******   DELETED   ******" ; deletion confirmation
                    fcb       C$CR      ; terminate the status line
PermissionDeniedMessage fcc   "Sorry, you cannot delete that message" ; ownership failure notice
                    fcb       C$CR      ; terminate the status line

* temporarily become user zero so the index can be opened for update, but retain the
* original ID both for ownership checks and for restoring process credentials on exit.
start               os9       F$ID      ; obtain the caller's OS-9 user ID in Y
                    sty       CallerUserId,u ; preserve it before privilege elevation
                    ldy       #0        ; select the superuser identity
                    os9       F$SUser   ; gain access to the board index
                    leax      >IndexFilename,pc ; select BBS.msg.inx
                    lda       #UPDAT.   ; deletion rewrites one complete index record
                    os9       I$Open    ; open the index under user zero
                    lbcs      ExitRestoringUser ; never leave the process elevated on failure
                    sta       IndexPath,u ; retain the update path
                    leax      <IndexHeader,u ; receive the 64-byte header
                    ldy       #64       ; leave the path positioned at message record one
                    lda       IndexPath,u ; select the index
                    os9       I$Read    ; load its header block
                    lbcs      ExitRestoringUser ; restore credentials after index errors

* show the current high-water mark and collect the record number to tombstone.
                    ldd       <IndexHeader,u ; fetch the high message number
                    leax      MessageNumberOrDecimalText,u ; select the shared numeric buffer
                    lbsr      FormatDecimal ; render five columns plus CR
                    leax      >HighMessagePrompt,pc ; select the fixed status prefix
                    ldy       >HighMessagePromptLength,pc ; write its 17 visible bytes
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor before the formatted number
                    lbcs      ExitRestoringUser ; preserve terminal errors
                    leax      MessageNumberOrDecimalText,u ; append the formatted high number
                    ldy       #6        ; bound five columns and CR
                    os9       I$WritLn  ; complete the status line
                    lbcs      ExitRestoringUser ; preserve terminal errors
                    leax      >DeletePrompt,pc ; select the deletion question
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; ask for the message number
                    lbcs      ExitRestoringUser ; preserve terminal errors
                    leax      >PromptAndLegacyHeading,pc ; use only the leading prompt marker
                    ldy       #1        ; write its single '>' byte
                    os9       I$Write   ; leave the cursor ready for numeric input
                    lbcs      ExitRestoringUser ; preserve terminal errors
                    leax      <MessageNumberInput,u ; receive the operator's response
                    ldy       #6        ; retain the original input bound
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect a CR-terminated number
                    lbcs      ExitRestoringUser ; preserve terminal errors
                    clr       <ParseScratch,u ; retain the original workspace initialization
                    leax      <MessageNumberInput,u ; parse from the response buffer
                    lda       #C$CR     ; preserve the original two-digit truncation behavior
                    sta       2,x       ; ignore any third and later digits
                    lbsr      ParseDecimal ; convert the first decimal run to D
                    cmpd      #1        ; message numbering begins at one
                    lbcs      ExitSuccess ; cancel on zero or missing digits
                    cmpd      <IndexHeader,u ; reject records beyond the high-water mark
                    lbhi      ExitSuccess ; cancel invalid high numbers
                    std       MessageNumberOrDecimalText,u ; retain the selected record number

* user zero may delete any record. Other callers must own the message according to
* the author user ID stored at index-record offset 60.
                    ldy       CallerUserId,u ; recover the original caller ID
                    beq       DeleteAuthorized ; bypass ownership checks for the sysop
                    bsr       SeekMessageRecord ; position at the selected 64-byte record
                    leax      <IndexRecordPrefix,u ; receive the complete index record
                    ldy       #64       ; include author and recipient IDs at its tail
                    lda       IndexPath,u ; select the index
                    os9       I$Read    ; load the ownership field and surrounding metadata
                    ldy       CallerUserId,u ; recover the caller ID after the read
                    cmpy      >OwnerUserId,u ; authorize only the record's original author
                    lbne      ReportPermissionDenied ; leave the index unchanged on mismatch

* mark the first offset word $FFFF and rewrite the full record. For non-sysop callers
* the preceding ownership read preserves all other fields; the sysop path retains the
* original program's zero-initialized remainder.
DeleteAuthorized    bsr       SeekMessageRecord ; return to the selected record boundary
                    leax      <IndexRecordPrefix,u ; select the buffered index record
                    ldd       #$FFFF    ; use the shared message-index tombstone
                    std       ,x        ; replace the body-offset high word
                    ldy       #64       ; rewrite exactly one record
                    lda       IndexPath,u ; select the index
                    os9       I$Write   ; commit the logical deletion
                    leax      >DeletedMessage,pc ; select the confirmation banner
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; confirm that the record is now hidden
                    bra       ExitSuccess ; restore credentials with status zero

* input D is the user-visible message number. Multiplication by the 64-byte record
* stride also accounts for the 64-byte header: message one maps to file offset 64.
SeekMessageRecord   clr       <RecordOffsetHigh,u ; clear the 32-bit product's top byte
                    clr       <RecordOffsetHigh+1,u ; clear its second byte
                    lda       #6        ; multiplying by 64 requires six left shifts
                    sta       ShiftOrDecimalCounter,u ; initialize the shift count
                    ldd       MessageNumberOrDecimalText,u ; load the selected message number
ShiftMessageNumber  aslb                ; shift the low product byte
                    rola                ; propagate carry through the next byte
                    rol       <RecordOffsetHigh+1,u ; propagate carry into the high word
                    dec       ShiftOrDecimalCounter,u ; account for one factor of two
                    bne       ShiftMessageNumber ; finish message number times 64
                    std       <RecordOffsetLow,u ; retain the product's low word
                    ldx       <RecordOffsetHigh,u ; supply the high word to I$Seek
                    lda       IndexPath,u ; select BBS.msg.inx
                    pshs      u         ; protect workspace U while it becomes the low word
                    ldu       <RecordOffsetLow,u ; complete the 32-bit file offset
                    os9       I$Seek    ; position at the selected record boundary
                    lbcs      ExitRestoringUser ; preserve seek errors and restore credentials
                    puls      pc,u      ; recover workspace U and return

ExitSuccess         clrb                ; report successful deletion or cancellation
ExitRestoringUser   pshs      b         ; protect the pending exit status
                    ldy       CallerUserId,u ; recover the process's original identity
                    os9       F$SUser   ; drop the temporary superuser identity
                    puls      b         ; recover the original operation status
                    os9       F$Exit    ; return it to the invoking process

ReportPermissionDenied leax   >PermissionDeniedMessage,pc ; select the ownership failure notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain why the record was not changed
                    bra       ExitSuccess ; denial is reported as a clean command result
* parse the first contiguous decimal run in the CR-terminated text at X.
* returns D=$FFFF when no digit appears. X returns just after the digit run.
ParseDecimal        pshs      y         ; preserve the caller's Y register
FindFirstDecimalDigit lda     ,x+       ; scan forward for the first digit
                    cmpa      #C$CR     ; a CR before any digit means failure
                    lbeq      DecimalNotFound ; return the parser's sentinel
                    cmpa      #'0'      ; reject bytes below the decimal range
                    bcs       FindFirstDecimalDigit ; continue within the input line
                    cmpa      #'9'      ; reject bytes above the decimal range
                    bhi       FindFirstDecimalDigit ; continue within the input line
                    leax      -1,x      ; include the first digit in the run scan
FindDecimalEnd      lda       ,x+       ; advance to the first non-digit
                    cmpa      #'0'      ; test the lower decimal bound
                    bcs       InitializeDecimalParse ; begin reverse conversion
                    cmpa      #'9'      ; test the upper decimal bound
                    bhi       InitializeDecimalParse ; begin reverse conversion
                    bra       FindDecimalEnd ; consume another digit
InitializeDecimalParse pshs   x         ; preserve the caller-visible end pointer
                    leax      -1,x      ; prepare for predecrement reads
                    clr       DecimalValue,u ; clear the result's high byte
                    clr       DecimalValue+1,u ; clear the result's low byte
                    ldd       #1        ; the rightmost digit occupies the ones place
                    std       DecimalDivisor,u ; initialize the current place value
AccumulatePreviousDigit lda    ,-x       ; fetch digits from right to left
                    cmpa      #'0'      ; stop below the decimal range
                    bcs       ReturnParsedDecimal ; return the accumulated value
                    cmpa      #'9'      ; stop above the decimal range
                    bhi       ReturnParsedDecimal ; return the accumulated value
                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       DecimalCounter,u ; use the digit as a repeated-add count
                    ldd       #0        ; begin this digit's contribution
MultiplyDigitByPlace tst      DecimalCounter,u ; test whether every copy was added
                    beq       AddDigitContribution ; merge the finished product
                    addd      DecimalDivisor,u ; add one copy of the current place
                    dec       DecimalCounter,u ; consume one digit unit
                    bra       MultiplyDigitByPlace ; complete digit times place
AddDigitContribution addd     DecimalValue,u ; merge this digit into the binary result
                    std       DecimalValue,u ; retain the partial value
                    lda       #10       ; the next place is ten times larger
                    sta       DecimalCounter,u ; count ten repeated additions
                    ldd       #0        ; begin the next place-value product
MultiplyPlaceByTen  tst       DecimalCounter,u ; test whether all ten copies were added
                    beq       SaveNextDecimalPlace ; retain the finished power of ten
                    addd      DecimalDivisor,u ; add another copy of the current place
                    dec       DecimalCounter,u ; consume one of ten copies
                    bra       MultiplyPlaceByTen ; complete place times ten
SaveNextDecimalPlace std      DecimalDivisor,u ; retain the next power of ten
                    bra       AccumulatePreviousDigit ; process the digit to the left
ReturnParsedDecimal ldd       DecimalValue,u ; return the accumulated unsigned value
                    puls      x         ; return X at the digit run's end
                    puls      pc,y      ; preserve Y and return

* format unsigned D as five columns plus CR at X, replacing leading zeroes with spaces.
FormatDecimal       pshs      x         ; preserve the destination start
                    std       DecimalValue,u ; retain the initial remainder
                    lda       #'0'      ; seed all five ASCII digit columns
                    sta       ,x        ; initialize ten-thousands
                    sta       1,x       ; initialize thousands
                    sta       2,x       ; initialize hundreds
                    sta       3,x       ; initialize tens
                    sta       4,x       ; initialize ones
                    ldd       #10000    ; select the highest supported place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalValue,u ; recover the current remainder
                    lbsr      EmitDecimalDigit ; emit ten-thousands
                    ldd       #1000     ; select thousands
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit thousands
                    ldd       #100      ; select hundreds
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit hundreds
                    ldd       #10       ; select tens
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; emit tens
                    ldd       #1        ; select ones
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalValue,u ; recover the final remainder
                    bsr       EmitDecimalDigit ; emit ones
                    lda       #C$CR     ; terminate the five-column text
                    sta       ,x        ; append CR after ones
                    puls      x         ; return to the first column
                    ldb       #C$SPAC   ; use spaces for leading zeroes
TrimLeadingZero     lda       ,x        ; inspect the next leading column
                    cmpa      #'0'      ; preserve the first nonzero digit
                    bne       FindFormattedNumberEnd ; locate the text boundary
                    stb       ,x+       ; blank this leading zero
                    bra       TrimLeadingZero ; continue through leading columns
FindFormattedNumberEnd lda    ,x+       ; scan through significant digits
                    cmpa      #'0'      ; stop below the decimal range
                    bcs       ReturnFormattedNumber ; return at the terminator
                    cmpa      #'9'      ; stop above the decimal range
                    bhi       ReturnFormattedNumber ; return at the terminator
                    bra       FindFormattedNumberEnd ; consume another digit
ReturnFormattedNumber leax    -1,x      ; leave X on the first nondigit
                    rts                 ; return the formatted buffer

EmitDecimalDigit    subd      DecimalDivisor,u ; try to remove one unit of this place
                    bcs       DecimalDigitComplete ; underflow completes the digit
                    inc       ,x        ; record one additional unit
                    bra       EmitDecimalDigit ; continue while the remainder permits
DecimalDigitComplete addd     DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalValue,u ; retain the next-place remainder
                    leax      1,x       ; advance to the following output column
                    rts                 ; return to the formatter

DecimalNotFound     ldd       #$FFFF    ; return the original no-number sentinel
                    puls      pc,y      ; preserve Y on the failure return

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
