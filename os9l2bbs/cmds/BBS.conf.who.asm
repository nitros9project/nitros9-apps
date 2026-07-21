**********************************************************************
* BBS.conf.who - OS-9 Level 2 BBS command
*
* syntax: BBS.conf.who
* purpose: list users registered in the shared conference module.
* Conf.dat holds twenty 3-byte participant records. Each occupied record
* contains the OS-9 user ID plus one; zero marks a vacated slot and $FFFF
* marks the unused end of the compact table.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* decoded the conference roster and alias-resolution logic.
**********************************************************************

                    nam       BBS.conf.who
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

AliasPath           rmb       1         ; open path to /dd/bbs/BBS.alias
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
TargetAliasId       rmb       2         ; participant ID after removing the stored plus-one bias
ParsedAliasId       rmb       2         ; numeric ID converted from an alias-file record
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
LinkedModuleAddress rmb       2         ; linked module pointer required by f$unlink
ConferenceData      rmb       2         ; execution/data address of Conf.dat's shared bytes
AliasRecord         rmb       200       ; one name,ID line read from BBS.alias
DisplayName         rmb       600       ; alias name copied without its numeric suffix
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.conf.who/ ; os-9 module name
ConfDataName        fcc       "Conf.dat" ; shared conference data module
                    fcb       C$CR      ; terminate the module name
AliasFilename       fcc       "/dd/bbs/BBS.alias" ; system-wide name-to-user-ID map
                    fcb       C$CR      ; terminate the path name
EmptyMessage        fcc       "No one is in conference" ; shown when Conf.dat is not linked
                    fcb       C$CR      ; terminate the status line
RosterHeading       fcc       "These people are in conference" ; active-conference heading
                    fcb       C$CR      ; terminate the heading line
RosterDivider       fcc       "------------------------------" ; visual separator
                    fcb       C$CR      ; terminate the divider line

start               leax      >ConfDataName,pc ; select the shared data module
                    lda       #65       ; require a data/object module
                    pshs      u         ; preserve this process's workspace pointer
                    os9       F$Link    ; access the conference state if it exists
                    lbcs      ReportEmptyConference ; an unlinked module means nobody has joined
                    tfr       u,d       ; retain the module pointer used by F$UnLink
                    puls      u         ; recover this process's workspace pointer
                    std       LinkedModuleAddress,u ; remember the linked module header
                    sty       ConferenceData,u ; remember the shared data-area address
                    leax      >RosterHeading,pc ; introduce the active roster
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; print the roster heading
                    leax      >RosterDivider,pc ; select the visual separator
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; underline the heading
                    ldx       ConferenceData,u ; begin with participant slot zero

* Participant records are {biased user ID word, notification byte}. The first
* untouched $FFFF record terminates the roster; zero records are vacated holes.
ScanParticipant     ldd       ,x++      ; fetch the stored user ID and advance past it
                    cmpd      #-1       ; is this the first never-used slot?
                    beq       FinishRoster ; stop at the compact table terminator
                    leax      1,x       ; skip this participant's notification byte
                    cmpd      #0        ; has this slot been vacated?
                    beq       ScanParticipant ; ignore holes left by departing users
                    pshs      x         ; preserve the next participant slot
                    subd      #1        ; recover the actual OS-9 user ID
                    lbsr      PrintAliasForId ; resolve and print this participant
                    puls      x         ; recover the next participant slot
                    bra       ScanParticipant ; continue through the roster

FinishRoster        clrb                ; prepare a successful status
                    pshs      u         ; preserve the workspace while unlinking
                    ldu       LinkedModuleAddress,u ; select the Conf.dat module header
                    os9       F$UnLink  ; release this process's link to shared state
                    puls      u         ; recover the workspace pointer
                    clrb                ; report successful completion
                    os9       F$Exit    ; return to the invoking process

ReportEmptyConference
                    leax      >EmptyMessage,pc ; explain why no roster is available
                    lda       #1        ; target standard output
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; report that no conference exists
                    clrb                ; treat an empty conference as success
                    os9       F$Exit    ; return to the invoking process

* Resolve D through BBS.alias. Records use "display name,numeric user ID".
* The original routine opens a fresh path for each participant and relies on
* process exit to close those paths.
PrintAliasForId     std       TargetAliasId,u ; retain the participant ID during file reads
                    leax      >AliasFilename,pc ; select the alias database
                    lda       #READ.    ; request sequential read access
                    os9       I$Open    ; open a fresh alias-file path
                    lbcs      ExitWithStatus ; abort the listing if the database is unavailable
                    sta       AliasPath,u ; retain the path number

ReadNextAlias       leax      AliasRecord,u ; receive one mapping record
                    ldy       #200      ; bound the read by the available buffer
                    lda       AliasPath,u ; select the alias-file path
                    os9       I$ReadLn  ; fetch the next name,ID line
                    lbcs      ExitWithStatus ; abort on eof or an I/O error
FindAliasComma      lda       ,x+       ; scan through the display name
                    cmpa      #','      ; has the numeric suffix begun?
                    bne       FindAliasComma ; continue to the field separator
                    lbsr      ParseDecimalId ; convert the numeric suffix at X
                    cmpd      TargetAliasId,u ; does this record identify the participant?
                    bne       ReadNextAlias ; continue through the alias database
                    leax      AliasRecord,u ; return to the display-name field
                    leay      >DisplayName,u ; build a CR-terminated output line
CopyDisplayName     lda       ,x+       ; fetch the next name character
                    cmpa      #','      ; has the numeric suffix been reached?
                    beq       TerminateDisplayName ; finish the printable name
                    sta       ,y+       ; append the character to the output buffer
                    bra       CopyDisplayName ; continue through the name field
TerminateDisplayName
                    lda       #C$CR     ; terminate the copied display name
                    sta       ,y        ; make it suitable for I$WritLn
                    leax      >DisplayName,u ; select the resolved participant name
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; add the participant to the roster
                    rts                 ; resume scanning shared participant slots

* Convert the first decimal token at or after X. The parser scans to the token's
* end, walks its digits backward, and forms the value with repeated addition.
ParseDecimalId      pshs      y         ; preserve the caller's Y register
FindFirstDigit      lda       ,x+       ; scan toward a numeric alias ID
                    cmpa      #C$CR     ; does the record contain no decimal token?
                    lbeq      RejectMissingId ; reject the malformed alias record
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

* This unreferenced formatter converts D to five zero-padded digits at X. It is
* intact in the shipped module but no live path calls it.
UnusedDecimalFormatter
                    std       ParsedAliasId,u ; retain the value as a changing remainder
                    lda       #'0'      ; seed all five output positions with zero
                    sta       ,x        ; initialize ten-thousands
                    sta       1,x       ; initialize thousands
                    sta       2,x       ; initialize hundreds
                    sta       3,x       ; initialize tens
                    sta       4,x       ; initialize units
                    ldd       #10000    ; select the ten-thousands divisor
                    std       DecimalPlace,u ; publish the divisor
                    ldd       ParsedAliasId,u ; recover the current remainder
                    lbsr      FormatOneDigit ; consume ten-thousands
                    ldd       #1000     ; select the thousands divisor
                    std       DecimalPlace,u ; publish the divisor
                    ldd       ParsedAliasId,u ; recover the current remainder
                    bsr       FormatOneDigit ; consume thousands
                    ldd       #100      ; select the hundreds divisor
                    std       DecimalPlace,u ; publish the divisor
                    ldd       ParsedAliasId,u ; recover the current remainder
                    bsr       FormatOneDigit ; consume hundreds
                    ldd       #10       ; select the tens divisor
                    std       DecimalPlace,u ; publish the divisor
                    ldd       ParsedAliasId,u ; recover the current remainder
                    bsr       FormatOneDigit ; consume tens
                    ldd       #1        ; select the units divisor
                    std       DecimalPlace,u ; publish the divisor
                    ldd       ParsedAliasId,u ; recover the current remainder
                    bsr       FormatOneDigit ; consume units
                    lda       #C$CR     ; terminate the five-digit result
                    sta       ,x        ; make the result suitable for I$WritLn
                    rts                 ; return after all five places
FormatOneDigit      subd      DecimalPlace,u ; consume one unit of this place
                    bcs       SaveDigitRemainder ; stop when the subtraction underflows
                    inc       ,x        ; count another unit in the ASCII digit
                    bra       FormatOneDigit ; continue until the divisor no longer fits
SaveDigitRemainder  addd      DecimalPlace,u ; undo the final underflow
                    std       ParsedAliasId,u ; carry the remainder into the next place
                    leax      1,x       ; select the next output digit
                    rts                 ; resume the fixed sequence of divisors

RejectMissingId     lda       #1        ; preserve the original malformed-record status
                    bra       ExitWithStatus ; abort instead of accepting a missing ID
                    fcb       $5F       ; unreachable CLRB opcode retained from the original
ExitWithStatus      os9       F$Exit    ; return status B from the failing OS-9 call

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
