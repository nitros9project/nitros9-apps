**********************************************************************
* BBS.who - OS-9 Level 2 BBS command
*
* syntax: BBS.who
* purpose: list distinct OS-9 user IDs represented by active processes.
* resolves each nonzero user ID through /dd/bbs/BBS.alias for display.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.who
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

AliasPath           rmb       1         ; open path to /dd/bbs/BBS.alias
CandidatePid        rmb       1         ; process ID currently being examined
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
ParsedAliasId       rmb       2         ; numeric user ID parsed from an alias record
CurrentUserId       rmb       2         ; process user ID currently being resolved
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
AliasRecord         rmb       200       ; one name,ID line from BBS.alias
SeenUserIds         rmb       200       ; zero-terminated table of distinct 16-bit user IDs
ProcessDescriptor   rmb       912       ; f$gprdsc result; p$user is inspected at offset eight
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.who/ ; os-9 module name
UnknownUserMessage  fcc       "Unknown User" ; fallback for an ID absent from BBS.alias
                    fcb       C$CR      ; terminate the fallback line
AliasFilename       fcc       "/dd/bbs/BBS.alias" ; system-wide user ID mapping
                    fcb       C$CR      ; terminate the path name
HeadingMessage      fcc       "The following users are on-line" ; report heading
                    fcb       C$CR      ; terminate the heading line
HeadingDivider      fcc       "-------------------------------" ; visual separator
                    fcb       C$CR      ; terminate the divider line

start               clra                ; seed the seen-ID table with zero bytes
                    leax      >SeenUserIds,u ; select its first byte
                    ldb       #200      ; clear all one hundred word slots
ClearSeenIds        sta       ,x+       ; initialize the next table byte
                    decb                ; count down the fixed buffer size
                    bne       ClearSeenIds ; continue until every slot is zero
                    clr       CandidatePid,u ; begin with process ID zero
                    leax      >AliasFilename,pc ; select the user mapping file
                    lda       #READ.    ; open it for sequential lookup
                    os9       I$Open    ; obtain the alias path in A
                    lbcs      ExitWithStatus ; listing requires an accessible alias file
                    sta       AliasPath,u ; retain the path across process scans
                    leax      >HeadingMessage,pc ; select the report heading
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; introduce the online-user list
                    leax      >HeadingDivider,pc ; select the visual separator
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; underline the heading

ScanNextProcess     leax      >ProcessDescriptor,u ; receive the candidate descriptor
                    lda       CandidatePid,u ; select the process ID
                    os9       F$GPrDsc  ; copy its Level 2 process descriptor
                    bcs       AdvanceProcess ; skip unused process IDs
                    ldd       P$User,x  ; obtain the process's 16-bit OS-9 user ID
                    bsr       ListUserOnce ; resolve it only if not already seen
AdvanceProcess      lda       CandidatePid,u ; recover the current process ID
                    inca                ; advance to the next ID
                    sta       CandidatePid,u ; retain it for F$GPrDsc
                    cmpa      #255      ; has the scan reached the final one-byte ID?
                    bcs       ScanNextProcess ; continue through process 254
                    lbra      ExitSuccess ; finish after the process-table scan

* zero is both the table terminator and the system user ID, so system processes
* are suppressed automatically. Each new nonzero ID is appended before lookup.
ListUserOnce        leax      >SeenUserIds,u ; begin at the first saved user ID
FindSeenId          cmpd      ,x        ; has this ID already been listed?
                    beq       ReturnFromLookup ; suppress duplicate processes
                    pshs      d         ; preserve the candidate while reading this slot
                    ldd       ,x++      ; fetch the saved ID and advance one word
                    beq       AppendSeenId ; zero marks the first unused slot
                    puls      d         ; recover the candidate ID
                    bra       FindSeenId ; continue through the compact table
ReturnFromLookup    rts                 ; leave duplicates and system user zero unprinted
AppendSeenId        puls      d         ; recover the first occurrence's user ID
                    std       -2,x      ; replace the zero terminator with that ID
                    std       CurrentUserId,u ; retain it during alias lookup
                    lda       AliasPath,u ; select BBS.alias
                    pshs      u         ; preserve the workspace pointer for 32-bit seek
                    ldu       #0        ; set the high file-position word to zero
                    ldx       #0        ; set the low file-position word to zero
                    os9       I$Seek    ; rewind the alias file for this user
                    puls      u         ; recover the workspace pointer

ReadNextAlias       lda       AliasPath,u ; select BBS.alias
                    leax      AliasRecord,u ; receive one comma-delimited mapping
                    ldy       #200      ; bound the line by the available buffer
                    os9       I$ReadLn  ; fetch the next name,ID record
                    bcs       PrintUnknownUser ; eof means this ID has no alias
FindAliasComma      lda       ,x+       ; scan the display name
                    cmpa      #','      ; does this byte separate name from numeric ID?
                    beq       ParseAliasId ; terminate the name and parse the suffix
                    cmpa      #C$CR     ; malformed records have no ID field
                    bne       FindAliasComma ; continue through the display name
                    bra       ReadNextAlias ; ignore the malformed record
ParseAliasId        lda       #C$CR     ; turn the comma into a printable line terminator
                    sta       -1,x      ; leave AliasRecord containing only the name
                    lbsr      ParseDecimalId ; convert the numeric suffix at X
                    cmpd      CurrentUserId,u ; is this the active process user ID?
                    beq       PrintAliasName ; display the matching record
                    bra       ReadNextAlias ; continue through the mapping file
PrintUnknownUser    leax      >UnknownUserMessage,pc ; select the fallback text
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; represent the unresolved active ID
                    rts                 ; resume the process-table scan
PrintAliasName      leax      AliasRecord,u ; select the CR-terminated display name
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; list this distinct active user
                    rts                 ; resume the process-table scan
ExitSuccess         clrb                ; report a successful listing
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process
* convert the first decimal token at or after X. The parser scans to the token's
* end, walks its digits backward, and forms the value with repeated addition.
ParseDecimalId      pshs      y         ; preserve the caller's Y register
FindFirstDigit      lda       ,x+       ; scan toward a numeric alias ID
                    cmpa      #C$CR     ; an absent ID converts to zero
                    lbeq      ReturnZeroId ; stop at the record terminator
                    cmpa      #'0'      ; skip bytes below the decimal range
                    bcs       FindFirstDigit ; continue past separators
                    cmpa      #'9'      ; skip bytes above the decimal range
                    bhi       FindFirstDigit ; continue past separators
                    leax      -1,x      ; return to the token's first digit
FindIdEnd           lda       ,x+       ; scan across the decimal token
                    cmpa      #'0'      ; bytes below zero delimit the token
                    bcs       ConvertIdBackward ; begin conversion at the end
                    cmpa      #'9'      ; bytes above nine also delimit it
                    bhi       ConvertIdBackward ; begin conversion at the end
                    bra       FindIdEnd ; continue through the digit run
ConvertIdBackward   pshs      x         ; retain the pointer following the token
                    leax      -1,x      ; select its rightmost digit
                    clr       ParsedAliasId,u ; clear the high result byte
                    clr       ParsedAliasId+1,u ; clear the low result byte
                    ldd       #1        ; seed the rightmost decimal place as units
                    std       DecimalPlace,u ; retain the current place multiplier
ParsePreviousDigit  lda       ,-x       ; fetch one digit while moving left
                    cmpa      #'0'      ; a lower delimiter precedes the token
                    bcs       ReturnParsedId ; finish conversion there
                    cmpa      #'9'      ; an upper delimiter also precedes the token
                    bhi       ReturnParsedId ; finish conversion there
                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       DigitCounter,u ; retain units remaining for this digit
                    ldd       #0        ; initialize this digit's contribution
AddDigitPlace       tst       DigitCounter,u ; has digit times place been accumulated?
                    beq       AccumulateIdDigit ; merge the completed contribution
                    addd      DecimalPlace,u ; add one unit of the current place
                    dec       DigitCounter,u ; consume one unit from the digit
                    bra       AddDigitPlace ; finish digit multiplication
AccumulateIdDigit   addd      ParsedAliasId,u ; include lower-order digits
                    std       ParsedAliasId,u ; retain the running ID value
                    lda       #10       ; multiply the place value by ten next
                    sta       DigitCounter,u ; count ten repeated additions
                    ldd       #0        ; initialize the next-place accumulator
ScaleIdPlace        tst       DigitCounter,u ; have all ten copies been added?
                    beq       AdvanceIdPlace ; publish the completed multiplier
                    addd      DecimalPlace,u ; add another old-place unit
                    dec       DigitCounter,u ; count down the multiply-by-ten loop
                    bra       ScaleIdPlace ; continue forming the next place
AdvanceIdPlace      std       DecimalPlace,u ; move one decimal column left
                    bra       ParsePreviousDigit ; continue toward the token start
ReturnParsedId      ldd       ParsedAliasId,u ; return the converted 16-bit user ID
                    puls      x         ; recover the pointer following the token
                    puls      pc,y      ; restore Y and return
* This unreachable byte sequence is valid 6809 code left in the original module.
* It renders the word at 3,U as five zero-padded decimal digits at X. For each
* decimal divisor it repeatedly subtracts the divisor and increments the output
* digit, then restores the final underflow and advances X. No live path calls it.
UnreferencedDecimalFormatter
                    fcb       $ED,$43   ; std 3,u: save the value to format
                    fcb       $86,$30   ; lda #'0': seed an ASCII digit
                    fcb       $A7,$84   ; sta ,x: initialize ten-thousands
                    fcb       $A7,$01   ; sta 1,x: initialize thousands
                    fcb       $A7,$02   ; sta 2,x: initialize hundreds
                    fcb       $A7,$03   ; sta 3,x: initialize tens
                    fcb       $A7,$04   ; sta 4,x: initialize units
                    fcb       $CC,$27,$10 ; ldd #10000: select ten-thousands
                    fcb       $ED,$47   ; std 7,u: publish the divisor
                    fcb       $EC,$43   ; ldd 3,u: recover the remainder
                    fcb       $17,$00,$29 ; lbsr formatter digit loop
                    fcb       $CC,$03,$E8 ; ldd #1000: select thousands
                    fcb       $ED,$47   ; std 7,u: publish the divisor
                    fcb       $EC,$43   ; ldd 3,u: recover the remainder
                    fcb       $8D,$20   ; bsr formatter digit loop
                    fcb       $CC,$00,$64 ; ldd #100: select hundreds
                    fcb       $ED,$47   ; std 7,u: publish the divisor
                    fcb       $EC,$43   ; ldd 3,u: recover the remainder
                    fcb       $8D,$17   ; bsr formatter digit loop
                    fcb       $CC,$00,$0A ; ldd #10: select tens
                    fcb       $ED,$47   ; std 7,u: publish the divisor
                    fcb       $EC,$43   ; ldd 3,u: recover the remainder
                    fcb       $8D,$0E   ; bsr formatter digit loop
                    fcb       $CC,$00,$01 ; ldd #1: select units
                    fcb       $ED,$47   ; std 7,u: publish the divisor
                    fcb       $EC,$43   ; ldd 3,u: recover the remainder
                    fcb       $8D,$05   ; bsr formatter digit loop
                    fcb       $86,$0D   ; lda #C$CR: terminate the digits
                    fcb       $A7,$84   ; sta ,x: append the terminator
                    fcb       $39       ; rts: return after all five places
FormatterDigitLoop  fcb       $A3,$47   ; subd 7,u: consume one divisor
                    fcb       $25,$04   ; bcs restore remainder on underflow
                    fcb       $6C,$84   ; inc ,x: count another divisor
                    fcb       $20,$F8   ; bra formatter digit loop
                    fcb       $E3,$47   ; addd 7,u: undo the underflow
                    fcb       $ED,$43   ; std 3,u: save remainder for next place
                    fcb       $30,$01   ; leax 1,x: select the next digit
                    fcb       $39       ; rts: process the next divisor
* Valid alias records always contain digits after the comma. On a malformed
* comma-then-CR record, this original path bypasses the saved-Y epilogue; the
* resulting stack imbalance appears to be a latent defect in the shipped code.
ReturnZeroId        ldd       #0        ; return zero when no decimal token is present
                    rts                 ; follow the original malformed-record exit

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
