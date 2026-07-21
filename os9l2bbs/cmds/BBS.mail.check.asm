**********************************************************************
* BBS.mail.check - OS-9 Level 2 BBS command
*
* syntax: BBS.mail.check
* purpose: report mail sent by the caller that remains in the pending-mail index.
* resolves each pending recipient through /dd/bbs/BBS.alias.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.mail.check
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

MailIndexPath       rmb       1         ; sequential path for BBS.mail.inx
MailPathReserved    rmb       2         ; retain the original three-byte path area
DecimalCounter      rmb       1         ; repeated-add counter for conversion helpers
PendingMailFound    rmb       2         ; nonzero after a sent-mail entry is found
AliasNameLength     rmb       1         ; bytes preceding the comma in an alias line
AliasPath           rmb       1         ; sequential path for /dd/bbs/BBS.alias
AliasPathReserved   rmb       2         ; retain the original three-byte path area
DecimalValue        rmb       2         ; parser result or unused formatter remainder
DecimalDivisor      rmb       2         ; current power of ten for decimal conversion
CallerUserId        rmb       2         ; authenticated OS-9 user ID
CallerIdReserved    rmb       32        ; unused remainder of the original ID buffer
MailIndexHeader     rmb       64        ; header read before the 64-byte entries
AliasRecord         rmb       160       ; display name, comma, numeric ID, and CR
MailRecordPrefix    rmb       60        ; offset, author, subject, and timestamp fields
SenderUserId        rmb       2         ; message author at index offsets 60 through 61
RecipientUserId     rmb       2         ; message recipient at index offsets 62 through 63
ReservedWorkspace   rmb       200       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.mail.check/ ; os-9 module name
                    fcc       "Copyright (C) 1988" ; original copyright notice
                    fcc       "By Keith Alphonso" ; original author credit
                    fcc       "Licenced to Alpha Software Technologies" ; original license text
                    fcc       "All rights reserved" ; original rights notice
LicensePayload      fcb       $EC       ; opaque high-bit-set licensing payload
                    fcb       $E6       ; preserve licensing payload byte two
                    fcb       $EA       ; preserve licensing payload byte three
                    fcb       $F5       ; preserve licensing payload byte four
                    fcb       $E9       ; preserve licensing payload byte five
                    fcb       $A0       ; preserve licensing payload byte six
                    fcb       $E2       ; preserve licensing payload byte seven
                    fcb       $ED       ; preserve licensing payload byte eight
                    fcb       $F1       ; preserve licensing payload byte nine
                    fcb       $E9       ; preserve licensing payload byte ten
                    fcb       $F0       ; preserve licensing payload byte eleven
                    fcb       $EF       ; preserve licensing payload byte twelve
                    fcb       $F4       ; preserve licensing payload byte thirteen
                    fcb       $F0       ; preserve the original payload terminator
MailIndexFilename   fcc       "BBS.mail.inx" ; private-mail index in the current mailroom
                    fcb       C$CR      ; terminate the OS-9 pathname
UnusedMailFilename  fcc       "BBS.mail" ; retained but never referenced by this command
                    fcb       C$CR      ; terminate the unused pathname
AliasFilename       fcc       "/dd/bbs/BBS.alias" ; global alias-to-user-ID mapping
                    fcb       C$CR      ; terminate the OS-9 pathname
LeadingBlankLines   fcb       C$LF      ; first unused display-control byte
                    fcb       C$CR      ; second unused display-control byte
CheckingMessage     fcb       C$LF      ; begin status output with a blank line
                    fcc       "Checking mailbox..." ; announces the pending-sent-mail scan
                    fcb       C$CR      ; terminate the status line
AllReadMessage      fcb       C$LF      ; separate the empty result from earlier output
                    fcc       "All previously sent mail has been read." ; no pending sent mail remains
                    fcb       C$CR      ; terminate the result line
MailToPrefix        fcc       "Mail to " ; precedes the resolved recipient alias
UnreadSuffix        fcc       " has not yet been read." ; follows the recipient alias
                    fcb       C$CR      ; terminate the pending-mail result

start               os9       F$ID      ; obtain the authenticated caller's OS-9 user ID
                    sty       CallerUserId,u ; retain it for filtering and privilege restoration
                    ldy       #0        ; select the superuser identity
                    os9       F$SUser   ; gain access to the global mail and alias files
                    leax      >MailIndexFilename,pc ; select the private-mail index
                    lda       #READ.    ; checking never changes pending mail
                    os9       I$Open    ; open BBS.mail.inx
                    lbcs      RestoreUserAndExit ; restore the caller after an open failure
                    sta       MailIndexPath,u ; retain the sequential index path
                    clr       PendingMailFound,u ; initialize the result flag's tested byte
                    leax      >AliasFilename,pc ; select the global alias mapping
                    lda       #READ.    ; aliases are resolved without modification
                    os9       I$Open    ; open /dd/bbs/BBS.alias
                    lbcs      RestoreUserAndExit ; preserve alias-open errors
                    sta       AliasPath,u ; retain the alias path for repeated rewinds
                    leax      >CheckingMessage,pc ; announce the outgoing-mail check
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the status message
                    leax      <MailIndexHeader,u ; receive the 64-byte index header
                    ldy       #64       ; position the stream at its first mail entry
                    lda       MailIndexPath,u ; select BBS.mail.inx
                    os9       I$Read    ; consume the header record
                    lbcs      RestoreUserAndExit ; preserve header-read errors

* pending-mail entries use the same 64-byte metadata layout as message records.
* offset 60 is the sender ID and offset 62 is the recipient ID.
ReadNextMailEntry   leax      >MailRecordPrefix,u ; receive one complete index entry
                    ldy       #64       ; preserve the fixed record size
                    lda       MailIndexPath,u ; select the index stream
                    os9       I$Read    ; fetch the next pending-mail record
                    bcs       FinishMailScan ; distinguish normal EOF from other errors
                    ldd       >SenderUserId,u ; inspect the record's author
                    cmpd      CallerUserId,u ; keep only mail sent by this caller
                    bne       ReadNextMailEntry ; skip another sender's pending mail
                    bra       ReportPendingEntry ; resolve and report its recipient
FinishMailScan      cmpb      #E$EOF    ; eof completes the index scan normally
                    lbne      RestoreUserAndExit ; propagate any actual I/O error
                    tst       PendingMailFound,u ; did any sent entry survive in the index?
                    beq       ReportAllRead ; explain the empty result
                    lbra      ExitSuccess ; otherwise the individual notices are sufficient
ReportAllRead       leax      >AllReadMessage,pc ; select the no-pending-mail result
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; state that all previously sent mail was read
                    lbra      ExitSuccess ; restore the caller and return success

ReportPendingEntry  inc       <PendingMailFound ; mark that at least one entry was found
                    pshs      u         ; protect workspace U while forming a 32-bit offset
                    lda       AliasPath,u ; select the alias file
                    ldx       #0        ; clear the seek offset's high word
                    ldu       #0        ; clear the seek offset's low word
                    os9       I$Seek    ; rewind aliases for this recipient lookup
                    puls      u         ; recover the workspace pointer
                    lbcs      RestoreUserAndExit ; preserve seek errors
ScanAliasRecord     lda       AliasPath,u ; select the rewound alias stream
                    ldy       #200      ; bound a complete alias line
                    leax      <AliasRecord,u ; receive display name, comma, and numeric ID
                    os9       I$ReadLn  ; read the next alias mapping
                    lbcs      ReadNextMailEntry ; an unresolved recipient is silently skipped
                    clr       AliasNameLength,u ; begin measuring the display-name prefix
FindAliasComma      inc       AliasNameLength,u ; include the next candidate byte
                    lda       ,x+       ; advance through the alias display name
                    cmpa      #','      ; the numeric user ID follows the comma
                    bne       FindAliasComma ; continue through the display name
                    dec       AliasNameLength,u ; exclude the delimiter from output
                    lbsr      ParseDecimal ; parse the numeric field following the comma
                    cmpd      >RecipientUserId,u ; compare it with the pending-mail recipient
                    bne       ScanAliasRecord ; keep searching the alias database
                    leax      >MailToPrefix,pc ; select the fixed result prefix
                    ldy       #8        ; write exactly "Mail to "
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor before the alias name
                    leax      <AliasRecord,u ; select the matched display-name prefix
                    ldb       AliasNameLength,u ; zero-extend its measured length through D
                    clra                ; form the unsigned write count
                    tfr       d,y       ; supply that count to I$Write
                    lda       #1        ; target standard output
                    os9       I$Write   ; append the recipient alias without its comma
                    leax      >UnreadSuffix,pc ; select the pending-mail explanation
                    ldy       #200      ; let I$WritLn stop at its CR
                    os9       I$WritLn  ; finish the recipient notice
                    lbra      ReadNextMailEntry ; inspect the following mail entry
ExitSuccess         clrb                ; return success after a normal scan
RestoreUserAndExit  pshs      b         ; preserve status while changing identity
                    ldy       CallerUserId,u ; recover the authenticated user ID
                    os9       F$SUser   ; drop the temporary superuser identity
                    puls      b         ; restore the intended exit status
                    os9       F$Exit    ; return status B to the invoking process
* parse the first contiguous decimal run in the alias record at X. The routine
* walks backward through the run and uses repeated addition for place values.
ParseDecimal        pshs      y         ; preserve the caller's Y register
FindFirstDecimalDigit lda     ,x+       ; scan forward for the first digit
                    cmpa      #C$CR     ; a CR before any digit means failure
                    lbeq      DecimalNotFound ; return the parser's $FFFF sentinel
                    cmpa      #'0'      ; reject bytes below the decimal range
                    bcs       FindFirstDecimalDigit ; continue through delimiters or spaces
                    cmpa      #'9'      ; reject bytes above the decimal range
                    bhi       FindFirstDecimalDigit ; continue until a digit or CR
                    leax      -1,x      ; include this first digit in the run scan
FindDecimalEnd      lda       ,x+       ; advance to the first non-digit after the run
                    cmpa      #'0'      ; test the lower decimal bound
                    bcs       InitializeDecimalParse ; x now follows the digit run
                    cmpa      #'9'      ; test the upper decimal bound
                    bhi       InitializeDecimalParse ; x now follows the digit run
                    bra       FindDecimalEnd ; consume another contiguous digit
InitializeDecimalParse pshs   x         ; preserve the caller-visible end pointer
                    leax      -1,x      ; prepare for right-to-left predecrement reads
                    clr       DecimalValue,u ; clear the result's high byte
                    clr       DecimalValue+1,u ; clear the result's low byte
                    ldd       #1        ; the rightmost digit occupies the ones place
                    std       DecimalDivisor,u ; initialize the decimal place value
AccumulatePreviousDigit lda    ,-x       ; fetch the next digit moving leftward
                    cmpa      #'0'      ; stop before the numeric run
                    bcs       ReturnParsedDecimal ; return the accumulated value
                    cmpa      #'9'      ; also stop above the decimal range
                    bhi       ReturnParsedDecimal ; return the accumulated value
                    suba      #'0'      ; convert ASCII to a binary digit
                    sta       DecimalCounter,u ; use the digit as a repeated-add count
                    ldd       #0        ; begin digit times current place value
MultiplyDigitByPlace tst      DecimalCounter,u ; test whether the product is complete
                    beq       AddDigitContribution ; merge it into the running result
                    addd      DecimalDivisor,u ; add one copy of the current place value
                    dec       DecimalCounter,u ; consume one unit of the digit
                    bra       MultiplyDigitByPlace ; finish the digit's contribution
AddDigitContribution addd     DecimalValue,u ; merge this digit into the result
                    std       DecimalValue,u ; retain the partial binary value
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

* unreachable decimal formatter retained from the original command. No live call
* enters this fallthrough-block because ParseDecimal returns immediately above.
UnusedFormatDecimal pshs      x         ; preserve the destination's first column
                    std       DecimalValue,u ; retain the unformatted remainder
                    lda       #'0'      ; seed all five output columns
                    sta       ,x        ; initialize the ten-thousands column
                    sta       1,x       ; initialize the thousands column
                    sta       2,x       ; initialize the hundreds column
                    sta       3,x       ; initialize the tens column
                    sta       4,x       ; initialize the ones column
                    ldd       #10000    ; begin at the highest supported decimal place
                    std       DecimalDivisor,u ; select the ten-thousands divisor
                    ldd       DecimalValue,u ; recover the unformatted value
                    lbsr      UnusedEmitDecimalDigit ; emit the ten-thousands digit
                    ldd       #1000     ; select the thousands place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       UnusedEmitDecimalDigit ; emit the thousands digit
                    ldd       #100      ; select the hundreds place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       UnusedEmitDecimalDigit ; emit the hundreds digit
                    ldd       #10       ; select the tens place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the current remainder
                    bsr       UnusedEmitDecimalDigit ; emit the tens digit
                    ldd       #1        ; select the ones place
                    std       DecimalDivisor,u ; publish its divisor to the helper
                    ldd       DecimalValue,u ; recover the final remainder
                    bsr       UnusedEmitDecimalDigit ; emit the ones digit
                    lda       #C$CR     ; terminate the numeric text
                    sta       ,x        ; append CR after the ones column
                    puls      x         ; return to the destination's first column
                    ldb       #C$SPAC   ; leading zeroes would display as spaces
UnusedTrimLeadingZero lda     ,x        ; inspect the next leading column
                    cmpa      #'0'      ; preserve the first nonzero digit
                    bne       UnusedFindNumberEnd ; locate the trailing boundary
                    stb       ,x+       ; replace this leading zero and advance
                    bra       UnusedTrimLeadingZero ; blank any additional leading zeroes
UnusedFindNumberEnd lda       ,x+       ; scan through the significant digit run
                    cmpa      #'0'      ; a byte below zero ends the result
                    bcs       UnusedReturnFormatted ; return with X at that terminator
                    cmpa      #'9'      ; a byte above nine also ends it
                    bhi       UnusedReturnFormatted ; return with X at that terminator
                    bra       UnusedFindNumberEnd ; consume another digit
UnusedReturnFormatted leax    -1,x      ; leave X pointing at the first nondigit
                    rts                 ; return from the unused formatter
UnusedEmitDecimalDigit subd   DecimalDivisor,u ; try to remove one unit of this place
                    bcs       UnusedDigitComplete ; underflow marks the finished digit
                    inc       ,x        ; record one more unit in the ASCII digit
                    bra       UnusedEmitDecimalDigit ; continue until the remainder is smaller
UnusedDigitComplete addd      DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalValue,u ; retain the remainder for the next column
                    leax      1,x       ; advance to the following output digit
                    rts                 ; return the updated remainder and pointer
DecimalNotFound     ldd       #$FFFF    ; return the original no-decimal-run sentinel
                    puls      pc,y      ; restore Y and return to the caller

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
