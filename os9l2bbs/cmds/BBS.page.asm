**********************************************************************
* BBS.page - OS-9 Level 2 BBS command
*
* syntax: BBS.page
* purpose: resolve an alias, locate that user's active process, and write a
* page directly to the terminal used as the target process's standard output.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* decoded alias lookup, process discovery, and remote-terminal resolution.
**********************************************************************

                    nam       BBS.page
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ProcessDescriptor   rmb       512       ; f$gprdsc result for the candidate process
AliasPath           rmb       1         ; open path to /dd/bbs/BBS.alias
RemoteTerminalPath  rmb       1         ; open path to the target caller's device
CandidatePid        rmb       1         ; process ID currently being examined
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
CopiedPointer       rmb       2         ; pointer recovered while walking system tables
MappedPointer       rmb       2         ; translated path or device-table pointer
NameOffset          rmb       2         ; device-name offset recovered from its table
TargetUserId        rmb       2         ; user ID resolved from the requested alias
ParsedAliasId       rmb       2         ; numeric ID converted from an alias record
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
CurrentUserId       rmb       2         ; sender's OS-9 user ID
CopyScratch         rmb       64        ; cross-process/system-memory copy workspace
SystemDatImage      rmb       64        ; copied DAT image used for address translation
TargetDeviceName    rmb       65        ; high-bit device name converted to an OS-9 path
AliasRecord         rmb       200       ; target-alias record, later reused for page text
RequestedAlias      rmb       200       ; entered target name, later reused for sender alias
SenderAliasRecord   rmb       600       ; alias record belonging to the paging user
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.page/ ; os-9 module name
SystemDatSelector   fcb       0,0       ; zero DAT selector used for system-memory copies
AliasFilename       fcc       "/dd/bbs/BBS.alias" ; system-wide name-to-user-ID map
                    fcb       C$CR      ; terminate the path name
OfflineMessage      fcc       "User not currently on-line!" ; no matching process response
                    fcb       C$CR      ; terminate the response
UnknownAliasMessage fcc       "User not in the alias list!" ; alias lookup failure response
                    fcb       C$CR      ; terminate the response
TargetPrompt        fcc       "User name to page:" ; target-alias prompt without CR
SendingMessage      fcc       "Sending message now..." ; local delivery status
                    fcb       C$CR      ; terminate the status line
DeliveredMessage    fcc       "Message recieved by user" ; original delivery confirmation text
                    fcb       C$CR      ; terminate the confirmation
PageTextPrompt      fcc       "Enter message to send:" ; page-body prompt without CR
RemotePagePrefix    fcb       C$BELL,C$BELL,C$BELL,C$BELL ; attract the remote user's attention
                    fcc       "Page from " ; introduce the sender alias

start               leax      >TargetPrompt,pc ; ask which alias should receive the page
                    ldy       #18       ; write the fixed prompt without a terminator
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the target prompt
                    lbcs      ExitWithStatus ; propagate terminal output failure
                    leax      >RequestedAlias,u ; receive the requested display name
                    ldy       #200      ; bound the input by the available buffer
                    clra                ; select standard input
                    os9       I$ReadLn  ; capture the CR-terminated target alias
                    lbcs      ExitWithStatus ; propagate terminal input failure
                    leax      >AliasFilename,pc ; select the alias database
                    lda       #READ.    ; request sequential read access
                    os9       I$Open    ; open the alias database
                    lbcs      ExitWithStatus ; paging requires the alias file
                    sta       >AliasPath,u ; retain the path across both scans

* Find the requested alias case-insensitively. The database side is folded in
* place through the comma, while the entered name is folded as it is compared.
ReadTargetAlias     leax      >AliasRecord,u ; receive the next name,ID mapping
                    ldy       #200      ; bound the line by the available buffer
                    lda       >AliasPath,u ; select BBS.alias
                    os9       I$ReadLn  ; fetch the next mapping record
                    lbcs      ReportUnknownAlias ; eof means the target name is absent
                    leay      >RequestedAlias,u ; select the entered target name
FoldAliasRecord     lda       ,x        ; inspect the next database character
                    cmpa      #','      ; preserve the field separator
                    beq       CompareAliasNames ; the display-name field is folded
                    anda      #$DF      ; fold ASCII lowercase to uppercase
                    sta       ,x+       ; retain the folded database character
                    cmpa      #C$CR     ; malformed records may lack a comma
                    bne       FoldAliasRecord ; continue through the name field
CompareAliasNames   leax      >AliasRecord,u ; restart at the folded database name
                    leay      >RequestedAlias,u ; restart at the entered name
CompareAliasByte    lda       ,y+       ; fetch the next requested-name character
                    cmpa      #C$CR     ; did the entered name end here?
                    beq       ConfirmAliasBoundary ; require the database name to end too
                    anda      #$DF      ; fold the requested character to uppercase
                    cmpa      ,x+       ; compare it with the folded database name
                    bne       ReadTargetAlias ; reject this record at the first mismatch
                    bra       CompareAliasByte ; continue through the requested name
ReportUnknownAlias  leax      >UnknownAliasMessage,pc ; explain the failed alias lookup
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; report that no such alias exists
                    lbra      ExitSuccess ; finish without an OS-9 error
ConfirmAliasBoundary
                    lda       ,x+       ; inspect the database byte following the match
                    cmpa      #','      ; was the full display name matched?
                    bne       ReadTargetAlias ; reject a matching prefix of a longer alias
                    lbsr      ParseDecimalId ; convert the target user ID after the comma
                    std       >TargetUserId,u ; retain it for process discovery
                    lda       >AliasPath,u ; select BBS.alias
                    pshs      u         ; preserve the workspace during the 32-bit seek
                    ldu       #0        ; set the high file-position word to zero
                    ldx       #0        ; set the low file-position word to zero
                    os9       I$Seek    ; rewind the database to resolve the sender
                    lbcs      ExitWithStatus ; propagate a seek failure
* Unlike the package's working rewind sequences, the shipped code never pulls
* the saved workspace pointer after this seek. Subsequent U-relative accesses
* therefore appear to use U=0. This likely explains a latent failure in paging;
* it is documented here but retained so the reconstructed binary stays exact.
                    os9       F$ID      ; obtain the paging user's OS-9 user ID
                    sty       >CurrentUserId,u ; retain it during the second alias scan
ReadSenderAlias     leax      >SenderAliasRecord,u ; receive the next name,ID mapping
                    ldy       #200      ; bound the line by the requested read size
                    lda       >AliasPath,u ; select BBS.alias
                    os9       I$ReadLn  ; fetch a possible sender record
                    lbcs      ExitWithStatus ; sender identity must exist in the database
FindSenderComma     lda       ,x+       ; scan the display-name field
                    cmpa      #','      ; has the numeric suffix begun?
                    bne       FindSenderComma ; continue to the field separator
                    lda       #C$CR     ; turn the comma into a name terminator
                    sta       -1,x      ; leave a printable sender alias in the buffer
                    lbsr      ParseDecimalId ; convert the numeric suffix at X
                    cmpd      >CurrentUserId,u ; does this record identify the sender?
                    bne       ReadSenderAlias ; continue through the alias database

* Scan all one-byte process IDs and compare the descriptor's P$User word with
* the target alias ID. PID zero is used as the wraparound/not-found sentinel.
                    clr       >CandidatePid,u ; begin just before process ID one
ScanNextProcess     lda       >CandidatePid,u ; recover the current candidate
                    inca                ; advance to the next process ID
                    sta       >CandidatePid,u ; retain it for F$GPrDsc
                    beq       ReportTargetOffline ; wraparound means no process matched
                    leax      ProcessDescriptor,u ; receive the candidate descriptor
                    os9       F$GPrDsc  ; inspect process A
                    bcs       ScanNextProcess ; skip unused process IDs
                    ldd       P$User,u  ; obtain the copied process's OS-9 user ID
                    cmpd      >TargetUserId,u ; does it belong to the requested alias?
                    bne       ScanNextProcess ; continue until that user is found
                    bra       TargetProcessFound ; resolve its standard-output device
ReportTargetOffline leax      >OfflineMessage,pc ; select the no-process response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; report that the alias is not logged in
                    lbra      ExitSuccess ; finish without an OS-9 error

TargetProcessFound  lbsr      ResolveTargetDevice ; derive a path name from P$Path+1
                    leax      >PageTextPrompt,pc ; ask for the page body
                    ldy       #22       ; write the fixed prompt without a terminator
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the page-text prompt
                    leax      >AliasRecord,u ; reuse the alias buffer for the page text
                    ldy       #200      ; allow a CR-terminated one-line page
                    clra                ; select standard input
                    os9       I$ReadLn  ; capture the page body
                    lbcs      ExitWithStatus ; propagate terminal input failure
                    leax      >SendingMessage,pc ; select the local status line
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; announce that delivery is starting
                    lda       #'/'      ; convert the copied device name into a path
                    sta       >TargetDeviceName,u ; prefix it with the root separator
                    leax      >TargetDeviceName,u ; select the target terminal name
                    lda       #WRITE.   ; request output access to its device
                    os9       I$Open    ; open the other caller's standard-output terminal
                    lbcs      ExitWithStatus ; propagate device-open failure
                    sta       >RemoteTerminalPath,u ; retain the remote path number
                    leax      >RemotePagePrefix,pc ; select bells and "Page from "
                    ldy       #14       ; write the fixed remote prefix
                    lda       >RemoteTerminalPath,u ; target the other caller's terminal
                    os9       I$Write   ; ring and introduce the sender
                    leax      >SenderAliasRecord,u ; select the CR-terminated sender alias
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; identify who sent the page
                    leax      >AliasRecord,u ; select the entered page body
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       >RemoteTerminalPath,u ; target the other caller's terminal
                    os9       I$WritLn  ; deliver the page text
                    lbcs      ExitWithStatus ; propagate remote output failure
                    leax      >DeliveredMessage,pc ; select the local confirmation
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; confirm successful delivery
                    lbra      ExitSuccess ; finish after the one-shot page

* OS-9 exposes only a system path number in the target descriptor's P$Path+1
* entry. This routine follows Level 2 system tables with F$CpyMem to recover
* the device descriptor and its high-bit-terminated module name.
ResolveTargetDevice leax      >SystemDatSelector,pc ; select the system DAT context
                    tfr       x,d       ; supply the system DAT selector to F$CpyMem
                    ldx       #76       ; read the system pointer stored at logical $004C
                    ldy       #2        ; copy one 16-bit pointer
                    pshs      u         ; preserve this process's workspace
                    leau      >CopyScratch,u ; receive the system pointer
                    os9       F$CpyMem  ; fetch it through the system DAT context
                    lbcs      ExitWithStatus ; propagate a cross-memory failure
                    puls      u         ; recover the workspace pointer
                    leax      >SystemDatSelector,pc ; select system memory again
                    tfr       x,d       ; supply its DAT selector
                    ldx       >CopyScratch,u ; follow the recovered system pointer
                    ldy       #64       ; copy one complete DAT image
                    pshs      u         ; preserve this process's workspace
                    leau      >CopyScratch,u ; receive the translation image
                    os9       F$CpyMem  ; copy the system mapping information
                    puls      u         ; recover the workspace pointer

                    leax      >CopyScratch,u ; use the copied DAT image as source context
                    tfr       x,d       ; supply that image to F$CpyMem
                    ldx       #136      ; read its logical pointer at offset $0088
                    ldy       #2        ; copy one 16-bit pointer
                    pshs      u         ; preserve this process's workspace
                    leau      >CopiedPointer,u ; receive the referenced table pointer
                    os9       F$CpyMem  ; fetch the pointer through the copied mapping
                    lbcs      ExitWithStatus ; propagate a cross-memory failure
                    puls      u         ; recover the workspace pointer
                    leax      >CopyScratch,u ; reuse the copied translation image
                    tfr       x,d       ; supply it as the source DAT context
                    ldx       >CopiedPointer,u ; select the referenced table
                    ldy       #64       ; copy its 64-byte translation image
                    pshs      u         ; preserve this process's workspace
                    leau      >SystemDatImage,u ; receive the path-table mapping
                    os9       F$CpyMem  ; copy the mapping needed below
                    lbcs      ExitWithStatus ; propagate a cross-memory failure
                    puls      u         ; recover the workspace pointer

* P$Path+1 is the target process's standard-output system path number. Its top
* six bits select a DAT entry; the low two bits select a 64-byte slot.
                    ldb       <P$Path+1,u ; obtain the target's system path number
                    lsrb                ; divide by four to select its DAT entry
                    lsrb                ; finish extracting the upper six bits
                    leax      >SystemDatImage,u ; select the copied path-table DAT image
                    lda       b,x       ; obtain the block mapped for this path group
                    pshs      a         ; preserve the logical-address high byte
                    ldb       <P$Path+1,u ; recover the complete system path number
                    andb      #3        ; isolate its slot within the mapped block
                    lda       #64       ; each path slot occupies 64 bytes
                    mul                 ; form the slot offset in D
                    puls      a         ; restore the mapped block as the high byte
                    addb      #3        ; select the path descriptor's pointer field
                    tfr       d,x       ; address that field in mapped system memory
                    leay      >CopyScratch,u ; select the system translation image
                    tfr       y,d       ; supply it as the source DAT context
                    ldy       #2        ; copy one 16-bit pointer
                    pshs      u         ; preserve this process's workspace
                    leau      >MappedPointer,u ; receive the path descriptor pointer
                    os9       F$CpyMem  ; translate the system path-table entry
                    puls      u         ; recover the workspace pointer

                    ldx       >MappedPointer,u ; follow the path descriptor pointer
                    leax      4,x       ; select its device-table pointer
                    leay      >CopyScratch,u ; select the system translation image
                    tfr       y,d       ; supply it as the source DAT context
                    ldy       #2        ; copy one 16-bit pointer
                    pshs      u         ; preserve this process's workspace
                    leau      >MappedPointer,u ; replace it with the device-table pointer
                    os9       F$CpyMem  ; follow the path into the device table
                    puls      u         ; recover the workspace pointer

                    leax      >CopyScratch,u ; select the system translation image
                    tfr       x,d       ; supply it as the source DAT context
                    ldx       >MappedPointer,u ; select the device-table entry
                    leax      4,x       ; locate its device-name offset
                    ldy       #2        ; copy one 16-bit offset
                    pshs      u         ; preserve this process's workspace
                    leau      >NameOffset,u ; receive the module-relative name offset
                    os9       F$CpyMem  ; fetch the device-name location
                    puls      u         ; recover the workspace pointer
                    ldx       >MappedPointer,u ; return to the device-table base
                    ldd       >NameOffset,u ; obtain its name offset
                    leax      d,x       ; select the high-bit-terminated device name
                    leay      >CopyScratch,u ; select the system translation image
                    tfr       y,d       ; supply it as the source DAT context
                    ldy       #64       ; allow a complete device name
                    pshs      u         ; preserve this process's workspace
                    leau      >TargetDeviceName+1,u ; leave byte zero for the leading slash
                    os9       F$CpyMem  ; copy the remote terminal's device name
                    puls      u         ; recover the workspace pointer
                    leax      >TargetDeviceName+1,u ; scan the copied OS-9 module name
FindDeviceNameEnd   lda       ,x+       ; fetch the next high-bit-terminated byte
                    bpl       FindDeviceNameEnd ; continue until the final character
                    anda      #$7F      ; remove the OS-9 name terminator bit
                    sta       -1,x      ; preserve the final device-name character
                    lda       #C$CR     ; terminate the path for I$Open
                    sta       ,x        ; finish the remote terminal path name
                    rts                 ; return with TargetDeviceName ready

ExitSuccess         clrb                ; report successful command completion
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

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
                    clr       >ParsedAliasId,u ; clear the high result byte
                    clr       >ParsedAliasId+1,u ; clear the low result byte
                    ldd       #1        ; seed the rightmost decimal place as units
                    std       >DecimalPlace,u ; retain the current place multiplier
ParsePreviousDigit  lda       ,-x       ; fetch one digit while moving left
                    cmpa      #'0'      ; a lower delimiter precedes the token
                    bcs       ReturnParsedId ; finish conversion there
                    cmpa      #'9'      ; an upper delimiter also precedes the token
                    bhi       ReturnParsedId ; finish conversion there
                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       >DigitCounter,u ; retain units remaining for this digit
                    ldd       #0        ; initialize this digit's contribution
AddDigitPlace       tst       >DigitCounter,u ; has digit times place been accumulated?
                    beq       AccumulateIdDigit ; merge the completed contribution
                    addd      >DecimalPlace,u ; add one unit of the current place
                    dec       >DigitCounter,u ; consume one unit from the digit
                    bra       AddDigitPlace ; finish digit multiplication
AccumulateIdDigit   addd      >ParsedAliasId,u ; include lower-order digits
                    std       >ParsedAliasId,u ; retain the running ID value
                    lda       #10       ; multiply the place value by ten next
                    sta       >DigitCounter,u ; count ten repeated additions
                    ldd       #0        ; initialize the next-place accumulator
ScaleIdPlace        tst       >DigitCounter,u ; have all ten copies been added?
                    beq       AdvanceIdPlace ; publish the completed multiplier
                    addd      >DecimalPlace,u ; add another old-place unit
                    dec       >DigitCounter,u ; count down the multiply-by-ten loop
                    bra       ScaleIdPlace ; continue forming the next place
AdvanceIdPlace      std       >DecimalPlace,u ; move one decimal column left
                    bra       ParsePreviousDigit ; continue toward the token start
ReturnParsedId      ldd       >ParsedAliasId,u ; return the converted 16-bit user ID
                    puls      x         ; recover the pointer following the token
                    puls      pc,y      ; restore Y and return

* This unreferenced formatter converts D to five zero-padded digits at X. It is
* stored as raw machine code in the shipped module and no live path calls it.
UnusedDecimalFormatter
                    fcb       $ED,$C9,$02,$0C ; std >ParsedAliasId,u: save the value
                    fcb       $86,$30   ; lda #'0': seed an ASCII digit
                    fcb       $A7,$84   ; sta ,x: initialize ten-thousands
                    fcb       $A7,$01   ; sta 1,x: initialize thousands
                    fcb       $A7,$02   ; sta 2,x: initialize hundreds
                    fcb       $A7,$03   ; sta 3,x: initialize tens
                    fcb       $A7,$04   ; sta 4,x: initialize units
                    fcb       $CC,$27,$10 ; ldd #10000: select ten-thousands
                    fcb       $ED,$C9,$02,$0E ; std >DecimalPlace,u: publish divisor
                    fcb       $EC,$C9,$02,$0C ; ldd >ParsedAliasId,u: recover remainder
                    fcb       $17,$00,$39 ; lbsr formatter digit loop
                    fcb       $CC,$03,$E8 ; ldd #1000: select thousands
                    fcb       $ED,$C9,$02,$0E ; std >DecimalPlace,u: publish divisor
                    fcb       $EC,$C9,$02,$0C ; ldd >ParsedAliasId,u: recover remainder
                    fcb       $8D,$2C   ; bsr formatter digit loop
                    fcb       $CC,$00,$64 ; ldd #100: select hundreds
                    fcb       $ED,$C9,$02,$0E ; std >DecimalPlace,u: publish divisor
                    fcb       $EC,$C9,$02,$0C ; ldd >ParsedAliasId,u: recover remainder
                    fcb       $8D,$1F   ; bsr formatter digit loop
                    fcb       $CC,$00,$0A ; ldd #10: select tens
                    fcb       $ED,$C9,$02,$0E ; std >DecimalPlace,u: publish divisor
                    fcb       $EC,$C9,$02,$0C ; ldd >ParsedAliasId,u: recover remainder
                    fcb       $8D,$12   ; bsr formatter digit loop
                    fcb       $CC,$00,$01 ; ldd #1: select units
                    fcb       $ED,$C9,$02,$0E ; std >DecimalPlace,u: publish divisor
                    fcb       $EC,$C9,$02,$0C ; ldd >ParsedAliasId,u: recover remainder
                    fcb       $8D,$05   ; bsr formatter digit loop
                    fcb       $86,$0D   ; lda #C$CR: terminate the digits
                    fcb       $A7,$84   ; sta ,x: append the terminator
                    fcb       $39       ; rts: return after all five places
FormatterDigitLoop  fcb       $A3,$C9,$02,$0E ; subd >DecimalPlace,u: consume divisor
                    fcb       $25,$04   ; bcs restore remainder on underflow
                    fcb       $6C,$84   ; inc ,x: count another divisor
                    fcb       $20,$F6   ; bra formatter digit loop
                    fcb       $E3,$C9,$02,$0E ; addd >DecimalPlace,u: undo underflow
                    fcb       $ED,$C9,$02,$0C ; std >ParsedAliasId,u: save remainder
                    fcb       $30,$01   ; leax 1,x: select the next digit
                    fcb       $39       ; rts: process the next divisor

RejectMissingId     ldb       #1        ; preserve the original malformed-record status
                    lbra      ExitWithStatus ; terminate instead of accepting a missing ID

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
