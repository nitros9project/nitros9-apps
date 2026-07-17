********************************************************************
* DMBACKUP - DeskMate 3 floppy-disk backup utility
*
* This source was reconstructed from the original Tandy binary.
* DeskMate's private service selectors are retained as inline bytes.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/16  Codex
* Disassembled and annotated from the original executable.
*

                    nam       DMBACKUP
                    ttl       DeskMate 3 floppy-disk backup utility

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00
edition             set       $7E

                    mod       eom,name,tylg,atrv,start,$7A91

name                fcs       /DMBACKUP/ ; OS-9 module name

* The edition byte doubles as the opcode for DeskMate's patched JMP vector.
start
DeskMateService     fcb       edition   ; $7E is both the edition and JMP opcode
                    fdb       $0000     ; DeskMate patches its dispatcher address here
                    sts       <$3D,u    ; preserve the caller's stack temporarily
                    leas      $7A90,u   ; move the stack to the top of our data area
                    leax      BackupIcon,pcr ; register the backup utility's icon resource
                    lbsr      DeskMateService ; invoke DeskMate service $07
                    fcb       $07       ; private DeskMate service selector
                    lbsr      DeskMateService ; invoke DeskMate service $06
                    fcb       $06       ; private DeskMate service selector
                    leax      ResourceEndPointer,pcr ; pass DeskMate's secondary resource pointer
                    lbsr      DeskMateService ; invoke DeskMate service $08
                    fcb       $08       ; private DeskMate service selector
                    lbra      Main      ; skip messages and enter the backup logic

SourceDevice        fcc       "/D0@ "   ; mutable source-device pathname template
                    fcb       $00
PromptSource        fcc       "Put source disk in drive 0"
                    fcb       $00
PromptDestination   fcc       "Put destination disk in drive 1"
                    fcb       $00
MessageWorking      fcc       "Working"
                    fcb       $00
MessageBadSectors   fcc       "Source disk bad sectors:"
                    fcb       $08,$00   ; reserve room for the formatted BCD count
ErrorWrite          fcc       "Can't WRITE to dest. disk."
                    fcb       $00
ErrorVerify         fcc       "Can't READ or VERIFY dest. disk."
                    fcb       $00
MessageVerifying    fcc       "Verifying destination disk."
                    fcb       $00
ErrorUnreliable     fcc       "Dest. disk NOT reliable !"
                    fcb       $00
MessageComplete     fcc       "Backup complete"
                    fcb       $00
ErrorOpenSource     fcc       "Can't OPEN source disk."
                    fcb       $00
ErrorOpenDest       fcc       "Can't OPEN destination disk."
                    fcb       $00
ErrorDestFormat     fcc       "Dest. disk initialized incorrectly"
NoErrorMessage      fcb       $00       ; empty message used for user cancellation
MenuName            fcc       "DMMENU"
                    fcb       C$CR
PromptReplace       fcc       "Replace DeskMate disk."
                    fcb       $00

* Direct-page workspace offsets used below:
*   <$00      saved data-area base
*   <$02      transfer size ($7400 bytes)
*   <$06      two-drive/single-drive mode flag
*   <$07      most recent OS-9 error
*   <$08      packed-BCD bad-sector count
*   <$0A      24-bit source-sector position
*   <$0D      DeskMate dialog row/position
*   <$0F      source path number
*   <$10      destination path number
*   <$13      destination drive digit
*   <$17      current transfer-buffer pointer
*   <$19      temporary count/pointer
*   <$1B      two ASCII digits
*   <$1D      constructed message buffer
*   <$3D      original caller stack pointer

Main                ldd       <$3D      ; recover the caller's original stack
                    pshs      d         ; retain it while clearing direct-page workspace
                    ldd       #$00FF    ; clear offsets $FF through $01
ClearDirectPage     clr       d,u       ; clear the selected workspace byte
                    subd      #$0001    ; move toward offset zero
                    bne       ClearDirectPage ; continue until all work bytes are clear
                    stu       <$00      ; remember the data-area base
                    puls      d         ; recover the caller's stack pointer
                    std       $3D,u     ; preserve it in cleared workspace
                    pshs      u         ; keep our data base across the final DeskMate exit
                    ldd       #$7400    ; transfer up to 116 sectors per batch
                    std       <$02      ; save byte count and sector-count high byte
                    lbsr      DeskMateService ; obtain DeskMate launch information
                    fcb       $4E       ; private DeskMate service selector
                    ldx       $16,y     ; point to the launch descriptor
                    lda       ,x        ; obtain the selected drive configuration
                    sta       <$19      ; retain it while constructing pathnames
                    leax      SourceDevice,pcr ; copy the source template into workspace
                    leay      <$11,u    ; destination pathname buffer
CopySourceName      lda       ,x+       ; fetch the next template byte
                    sta       ,y+       ; append it to the pathname buffer
                    bne       CopySourceName ; include the terminating NUL
                    dec       <$06      ; default to the two-drive configuration
                    lda       #'0       ; source is drive zero by default
                    cmpa      <$19      ; was drive zero selected?
                    beq       SourceNameReady ; retain the normal two-drive setup
                    inca                ; otherwise use drive one as the source
                    clr       <$06      ; mark the single/alternate-drive configuration
SourceNameReady     sta       -$04,y    ; replace the drive digit in the copied pathname
                    lbsr      DeskMateService ; display the backup application's dialog
                    fcb       $3F       ; private DeskMate service selector
                    lbsr      DeskMateService ; query the dialog position
                    fcb       $0C       ; private DeskMate service selector
                    stx       <$0D      ; save the returned dialog coordinates
                    clra                ; use the default dialog column
                    clrb                ; use the default dialog style
                    leax      PromptSource,pcr ; prompt for the source disk
                    lbsr      DeskMateService ; display the prompt
                    fcb       $0A       ; private DeskMate service selector
                    tst       <$06      ; are separate source and destination drives used?
                    bne       SourceConfirmed ; skip the extra control setup
                    ldd       <$0D      ; position a confirmation line below the dialog
                    inca                ; advance one row
                    lbsr      DeskMateService ; position the prompt cursor
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; default prompt option
                    clrb                ; default prompt flags
                    lbsr      DeskMateService ; prepare the confirmation control
                    fcb       $0A       ; private DeskMate service selector
SourceConfirmed     lbsr      ConfirmDisk ; wait for Enter or Break
                    leax      NoErrorMessage,pcr ; cancellation displays no error text
                    cmpa      #C$Quit   ; did the user press Break?
                    lbeq      Finish    ; cancel the operation cleanly
                    lbsr      DeskMateService ; clear the confirmation dialog
                    fcb       $3F       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    leax      MessageWorking,pcr ; show the activity message
                    lbsr      DeskMateService ; display "Working"
                    fcb       $0A       ; private DeskMate service selector

                    lda       #READ.    ; open the source disk for reading
                    leax      SourceDevice,pcr ; point to the source pathname
                    os9       I$Open    ; open the raw source device
                    leax      ErrorOpenSource,pcr ; prepare the source-open error
                    lbcs      Finish    ; report an open failure
                    sta       <$0F      ; save the source path number
                    leax      $0100,u   ; use the transfer buffer for the sector-zero read
                    ldy       #$0100    ; read one sector
                    os9       I$Read    ; obtain the source disk descriptor sector
                    leax      ErrorOpenSource,pcr ; prepare a source-read error
                    lbcs      CloseSource ; close anything already open

                    lda       #UPDAT.   ; open the destination for update
                    leax      <$11,u    ; point to the destination pathname
                    os9       I$Open    ; open the raw destination device
                    leax      ErrorOpenDest,pcr ; prepare the destination-open error
                    lbcs      CloseSource ; close the source after a failure
                    sta       <$10      ; save the destination path number
                    lda       #$FF      ; request destination-disk confirmation
                    lbsr      PromptForDisk ; prompt and wait for the destination disk

                    lda       <$10      ; select the destination path
                    leax      $0200,u   ; read its descriptor into a second sector buffer
                    ldy       #$0100    ; read exactly one sector
                    os9       I$Read    ; obtain the destination disk descriptor
                    leax      ErrorDestFormat,pcr ; prepare the format error
                    lbcs      CloseBoth ; reject an unreadable destination

                    pshs      u,x       ; preserve the data base and buffer pointer
                    ldx       #$0000    ; seek to logical sector zero
                    leau      ,x        ; provide the high half of the 32-bit position
                    os9       I$Seek    ; rewind the destination path
                    puls      u,x       ; restore our working registers
                    lbcs      CloseBoth ; report a seek failure

* Check that the destination geometry is at least as large as the source.
                    leax      $0100,u   ; point to the source descriptor sector
                    ldd       $0101,x   ; load destination total-sector low word
                    subd      $01,x     ; subtract source total-sector low word
                    lda       $0100,x   ; load destination total-sector high byte
                    sbca      ,x        ; include the source high byte in the comparison
                    bcc       DestinationLargeEnough ; accept equal or larger media
                    leax      ErrorDestFormat,pcr ; report incompatible geometry
                    lbra      CloseBoth ; close both raw devices

DestinationLargeEnough
                    lda       <$10      ; select the destination path
                    ldy       #$0100    ; write one descriptor sector
                    os9       I$Write   ; initialize its sector zero from the source buffer
                    leax      ErrorWrite,pcr ; prepare the write error
                    lbcs      CloseBoth ; stop if sector zero cannot be written
                    inc       <$0C      ; source-sector position now begins at sector one

* Enable retry behavior in DeskMate's working-status structure.
                    ldb       #SS.Opt   ; fetch path options
                    leax      <$1D,u    ; use the local option buffer
                    os9       I$GetStt  ; read current destination options
                    ldb       #$01      ; enable the required retry flag
                    stb       $08,x     ; update its option byte
                    ldb       #SS.Opt   ; write the modified options
                    os9       I$SetStt  ; install the destination options

CopyBatch           clra                ; prompt for the source disk
                    lbsr      PromptForDisk ; wait until the selected source is ready
                    lda       <$02      ; number of full sectors in one transfer batch
                    sta       <$19      ; initialize the sector loop count
                    leax      $0100,u   ; begin filling the transfer buffer
                    stx       <$17      ; save its current write pointer

ReadSector          lda       <$0F      ; select the source path
                    ldy       #$0100    ; request one sector
                    os9       I$Read    ; read the next source sector
                    bcc       CountSector ; continue normally after a successful read
                    stb       <$07      ; retain the read error
                    cmpb      #E$EOF    ; did the source run out of sectors?
                    lbeq      WriteBatch ; finish the partially filled final batch
                    lda       <$09      ; increment the packed-BCD bad-sector count
                    adda      #$01      ; add one to the low two digits
                    daa                 ; normalize the result as packed BCD
                    sta       <$09      ; save the low digits
                    bcc       CountSector ; no carry into the upper digits
                    lda       <$08      ; load the upper packed-BCD digits
                    adda      #$01      ; propagate the carry
                    daa                 ; normalize the upper digits
                    sta       <$08      ; save the complete count

CountSector         ldd       <$0B      ; load the low 16 bits of source position
                    addd      #$0001    ; advance one logical sector
                    std       <$0B      ; save the updated low word
                    bcc       RetryBadSector ; no carry into the high byte
                    inc       <$0A      ; advance the high sector byte

RetryBadSector      tst       <$07      ; did the preceding read fail?
                    beq       AdvanceBuffer ; no retry seek is necessary
                    pshs      u,x       ; preserve the data base and transfer pointer
                    ldx       <$0A      ; load the upper sector-position bytes
                    lda       <$0C      ; load the low position byte
                    clrb                ; form the 32-bit seek position in X:U
                    tfr       d,u       ; move its low word into U
                    lda       <$0F      ; select the source path
                    os9       I$Seek    ; skip over the unreadable source sector
                    puls      u,x       ; restore the transfer context
                    clr       <$07      ; clear the handled read error

AdvanceBuffer       ldx       <$17      ; load the current transfer pointer
                    leax      $0100,x   ; reserve the next sector slot
                    stx       <$17      ; save the advanced pointer
                    dec       <$19      ; count down sectors in this batch
                    bne       ReadSector ; fill the complete batch if possible

WriteBatch          lda       #$FF      ; prompt for the destination disk
                    lbsr      PromptForDisk ; wait until it is ready
                    ldd       <$17      ; calculate bytes accumulated in the batch
                    leax      $0100,u   ; point to the beginning of the transfer buffer
                    stx       <$17      ; reset the pointer for the next batch
                    subd      <$17      ; D = bytes currently buffered
                    beq       CheckForMore ; skip an empty final write
                    tfr       d,y       ; pass the byte count to OS-9
                    lda       <$10      ; select the destination path
                    os9       I$Write   ; write the completed batch
                    leax      ErrorWrite,pcr ; prepare the write error
                    lbcs      CloseBoth ; abort on a destination failure

CheckForMore        lda       <$07      ; inspect the saved source status
                    cmpa      #E$EOF    ; was the final source sector reached?
                    lbne      CopyBatch ; continue with the next transfer batch

                    lbsr      DeskMateService ; clear the working dialog
                    fcb       $3F       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    leax      MessageVerifying,pcr ; announce the verification pass
                    lbsr      DeskMateService ; display the verification message
                    fcb       $0A       ; private DeskMate service selector
                    lda       <$10      ; select the destination path
                    os9       I$Close   ; close its write/update handle
                    lda       #READ.    ; reopen the destination read-only
                    leax      <$11,u    ; point to the destination pathname
                    os9       I$Open    ; open it for the verification scan
                    leax      ErrorOpenDest,pcr ; prepare a reopen error
                    bcs       CloseBoth ; report failure
                    sta       <$10      ; save the verification path

VerifyDestination   leax      $0100,u   ; reuse the transfer buffer
                    ldy       <$02      ; read a full transfer-sized block
                    os9       I$Read    ; scan the destination media
                    bcc       VerifyDestination ; continue until EOF or an error
                    leax      ErrorVerify,pcr ; prepare a verification error
                    cmpb      #E$EOF    ; EOF means the entire disk was readable
                    bne       CloseBoth ; report any other read error
                    clrb                ; successful completion status
                    leax      MessageComplete,pcr ; display the success message

CloseBoth           pshs      b         ; preserve status across I$Close
                    lda       <$10      ; close the destination path
                    os9       I$Close   ; release it
                    puls      b         ; restore status
CloseSource         pshs      b         ; preserve status across the second close
                    lda       <$0F      ; close the source path
                    os9       I$Close   ; release it
                    puls      b         ; restore final status

Finish              stb       <$07      ; retain the final error number
                    lbsr      DeskMateService ; clear the current dialog
                    fcb       $3F       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    lbsr      DeskMateService ; reset the message area
                    fcb       $0A       ; private DeskMate service selector
                    ldd       <$08      ; check the packed-BCD bad-sector count
                    beq       ShowFinalStatus ; skip count formatting when it is zero
                    lbsr      ConvertBadCount ; convert both packed-BCD bytes to ASCII
                    leax      <$1D,u    ; construct the bad-sector message
                    leay      MessageBadSectors,pcr ; point to its fixed text
CopyBadMessage      lda       ,y+       ; fetch the next message byte
                    sta       ,x+       ; append it to the local buffer
                    bne       CopyBadMessage ; copy through the NUL terminator
                    ldd       <$19      ; fetch the first two converted digits
                    std       -$01,x    ; overwrite the NUL with those digits
                    ldd       <$1B      ; fetch the remaining two digits
                    std       $01,x     ; append them after the first pair
                    clr       $03,x     ; terminate the expanded string
                    ldd       <$0D      ; position the bad-sector message
                    inca                ; advance one row
                    lbsr      DeskMateService ; set the dialog position
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    leax      <$1D,u    ; point to the constructed message
                    lbsr      DeskMateService ; display the bad-sector count
                    fcb       $0A       ; private DeskMate service selector

ShowFinalStatus     tst       <$07      ; did the operation end with an error?
                    beq       PromptForReplacement ; skip reliability warning on success
                    ldd       <$0D      ; position the warning below the dialog
                    adda      #$02      ; move down two rows
                    lbsr      DeskMateService ; set the warning position
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    leax      ErrorUnreliable,pcr ; select the reliability warning
                    lbsr      DeskMateService ; display it
                    fcb       $0A       ; private DeskMate service selector

PromptForReplacement
                    ldd       <$0D      ; position the final instruction
                    adda      #$03      ; move down three rows
                    lbsr      DeskMateService ; set its dialog position
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    leax      PromptReplace,pcr ; ask for the DeskMate system disk
                    lbsr      DeskMateService ; display the replacement prompt
                    fcb       $0A       ; private DeskMate service selector
                    ldd       <$0D      ; position the acknowledgement control
                    adda      #$04      ; move down four rows
                    lbsr      DeskMateService ; set the control position
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; configure the final confirmation control
                    clrb                ; clear its secondary option
                    lbsr      DeskMateService ; create the control
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      WaitForRelease ; wait for input to settle
                    ldb       #$80      ; request a blocking input event
                    lbsr      DeskMateService ; read the acknowledgement
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      DeskMateService ; close the final dialog
                    fcb       $45       ; private DeskMate service selector
                    puls      u         ; restore the data-area base
                    lds       <$3D,u    ; restore the caller's original stack
                    lbsr      DeskMateService ; return to the DeskMate menu
                    fcb       $57       ; private non-returning DeskMate selector

                    zmb       $14       ; original alignment/padding before helpers

* Convert the packed-BCD count in D into four ASCII digits.
ConvertBadCount     pshs      b         ; retain the low packed-BCD byte
                    bsr       ConvertBcdByte ; convert the high byte
                    std       <$19      ; save its two ASCII digits
                    puls      a         ; convert the retained low byte next
ConvertBcdByte      tfr       a,b       ; copy the packed byte for its low nibble
                    lsra                ; shift the high nibble toward bit zero
                    lsra
                    lsra
                    lsra
                    andb      #$0F      ; isolate the low BCD digit
                    addd      #$3030    ; convert both digits to ASCII
                    std       <$1B      ; save the most recently converted pair
                    rts                 ; return both ASCII digits in D

* Present source/destination prompts and normalize Enter/Break input.
ConfirmDisk         pshs      y,x,d     ; preserve the caller's working registers
stk_saved_d         equ       0         ; saved D after PSHS Y,X,D
stk_saved_x         equ       2         ; saved X
stk_saved_y         equ       4         ; saved Y
stk_return          equ       6         ; return address
                    ldd       <$0D      ; position the first confirmation line
                    adda      #$03      ; move below the main dialog
                    lbsr      DeskMateService ; set the dialog position
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$01      ; configure the first control
                    clrb                ; clear its secondary option
                    lbsr      DeskMateService ; create the first control
                    fcb       $0A       ; private DeskMate service selector
                    ldd       <$0D      ; position the second control
                    adda      #$04      ; move down four rows
                    lbsr      DeskMateService ; set its position
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$02      ; configure the second control
                    clrb                ; clear its secondary option
                    lbsr      DeskMateService ; create the second control
                    fcb       $0A       ; private DeskMate service selector
                    bsr       WaitForRelease ; discard any prior held key/button
ReadConfirmation    ldb       #$80      ; request a blocking input event
                    lbsr      DeskMateService ; read an event
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #C$CR     ; accept Enter directly
                    beq       ConfirmationDone
                    cmpa      #C$Quit   ; accept Break directly
                    beq       ConfirmationDone
                    lbsr      DeskMateService ; query pointing-device selection
                    fcb       $45       ; private DeskMate service selector
                    cmpb      #$01      ; was the expected control selected?
                    bne       ReadConfirmation ; ignore unrelated events
                    lda       #C$Quit   ; default a pointing selection to cancel
                    cmpy      #$0004    ; was the affirmative control selected?
                    bcc       ConfirmationDone ; retain cancel for the other control
                    lda       #C$CR     ; convert the affirmative choice to Enter
ConfirmationDone    sta       stk_saved_d,s ; replace saved A with the normalized result
                    puls      pc,y,x,d  ; restore registers and return the result in A

* Prompt for a disk when operating with a single interchangeable drive.
PromptForDisk       pshs      y,x,d     ; preserve caller registers and the prompt selector
stk_prompt          equ       0         ; saved D; A distinguishes source/destination
                    tst       <$06      ; are two physical drives available?
                    beq       DiskPromptDone ; no swapping is required with two drives
                    leax      PromptSource,pcr ; default to the source-disk prompt
                    tst       stk_prompt,s ; did the caller request the destination?
                    beq       ShowDiskPrompt ; source request is already selected
                    leay      PromptDestination,pcr ; copy the mutable destination prompt
                    leax      <$1D,u    ; into the local message buffer
                    stx       <$19      ; remember the buffer start
CopyDestPrompt      lda       ,y+       ; fetch the next prompt byte
                    sta       ,x+       ; append it to the local buffer
                    bne       CopyDestPrompt ; include the NUL terminator
                    lda       <$13      ; fetch the current destination drive digit
                    sta       -$02,x    ; patch it into the copied prompt
                    ldx       <$19      ; restore the prompt start
ShowDiskPrompt      lbsr      DeskMateService ; clear the current dialog
                    fcb       $3F       ; private DeskMate service selector
                    clra                ; default dialog column
                    clrb                ; default dialog flags
                    lbsr      DeskMateService ; prepare the disk prompt
                    fcb       $0A       ; private DeskMate service selector
                    ldd       <$0D      ; position its confirmation control
                    adda      #$04      ; move down four rows
                    lbsr      DeskMateService ; set the control position
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; configure the confirmation control
                    clrb                ; clear its secondary option
                    lbsr      DeskMateService ; create the control
                    fcb       $0A       ; private DeskMate service selector
                    bsr       WaitForRelease ; discard held input
                    ldb       #$80      ; request a blocking acknowledgement
                    lbsr      DeskMateService ; wait for it
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      DeskMateService ; close the disk prompt
                    fcb       $45       ; private DeskMate service selector
DiskPromptDone      puls      pc,y,x,d  ; restore the caller's context

* Wait until DeskMate reports that no key or pointer button remains held.
WaitForRelease      pshs      y,x,d     ; preserve the caller's registers
WaitReleaseLoop     clrb                ; request a nonblocking input poll
                    lbsr      DeskMateService ; read current input state
                    fcb       $1D       ; private DeskMate service selector
                    tsta                ; is an input event still active?
                    bne       WaitReleaseLoop ; wait for complete release
                    lbsr      DeskMateService ; finish the input transaction
                    fcb       $45       ; private DeskMate service selector
                    puls      pc,y,x,d  ; restore registers and return

* The remaining bytes are DeskMate bitmap/control resources, not executable code.
ResourcePrefix      fcb       $28,$80   ; resource header immediately before the icon bitmap
BackupIcon
                    fcb       $3F,$F0,$F0,$3C,$F0,$00,$F0,$00,$F0,$3C,$3F,$F0 ; DeskMate bitmap/control resource bytes
                    fcb       $03,$C0,$0F,$00,$00,$00,$F0,$3C,$00,$00,$00,$00 ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$3F,$F0,$00,$00,$00,$F0,$0F,$00 ; continued resource data
                    fcb       $3F,$F0,$F0,$3C,$FF,$FC,$F0,$00,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $03,$00,$0C,$C0,$3F,$F0,$00,$3C,$3F,$FC,$F0,$3C ; continued resource data
                    fcb       $3F,$FC,$00,$00,$F0,$3C,$00,$00,$3F,$F0,$00,$3C ; continued resource data
                    fcb       $3F,$FC,$F0,$3C,$3F,$FC,$00,$00,$3C,$00,$03,$C0 ; continued resource data
                    fcb       $3F,$F0,$00,$3C,$3F,$FC,$F0,$3C,$3F,$FC,$00,$00 ; continued resource data
                    fcb       $0F,$C0,$3C,$F0,$0F,$F0,$00,$3C,$3F,$FC,$F0,$3C ; continued resource data
                    fcb       $3F,$FC,$00,$00,$00,$00,$00,$00,$3F,$FC,$F0,$00 ; continued resource data
                    fcb       $F0,$00,$3F,$FC,$03,$C0,$0F,$00,$03,$00,$0C,$C0 ; continued resource data
                    fcb       $3F,$F0,$F0,$3C,$FF,$FC,$F0,$00,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $F0,$3C,$00,$00,$3F,$F0,$F0,$3C,$FF,$FC,$F0,$00 ; continued resource data
                    fcb       $3F,$F0,$00,$00,$3C,$00,$03,$C0,$3F,$F0,$F0,$3C ; continued resource data
                    fcb       $FF,$FC,$F0,$00,$3F,$F0,$00,$00,$00,$00,$3C,$3C ; continued resource data
                    fcb       $00,$00,$03,$C0,$03,$C0,$03,$C0,$03,$C0,$00,$00 ; continued resource data
                    fcb       $03,$C0,$0C,$30,$00,$00,$03,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$0F,$F0,$3C,$3C,$3C,$3C,$3C,$F0 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3C,$F0,$F0,$00,$F0,$3C,$03,$00 ; continued resource data
                    fcb       $0F,$C0,$3C,$F0,$F0,$3C,$FF,$FC,$F0,$3C,$00,$00 ; continued resource data
                    fcb       $0F,$C0,$3C,$F0,$0F,$C0,$3C,$F0,$F0,$3C,$FF,$FC ; continued resource data
                    fcb       $F0,$3C,$00,$00,$00,$F0,$0F,$00,$00,$00,$3F,$F0 ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$3F,$F0,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $3C,$FC,$03,$C3,$3F,$FF,$C3,$C0,$3F,$FF,$00,$00 ; continued resource data
                    fcb       $03,$FF,$0F,$F0,$3C,$F0,$F0,$FF,$FF,$F0,$F0,$F0 ; continued resource data
                    fcb       $F0,$FF,$00,$00,$03,$00,$0C,$C0,$00,$00,$3F,$F0 ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$3F,$F0,$00,$00,$00,$00,$F0,$3C ; continued resource data
                    fcb       $00,$00,$3F,$F0,$F0,$3C,$F0,$3C,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$3F,$F0,$F0,$3C,$FF,$FC,$F0,$3C ; continued resource data
                    fcb       $3F,$F0,$00,$00,$03,$00,$0C,$C0,$00,$00,$F0,$3C ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$3F,$F0,$00,$00,$3C,$00,$03,$C0 ; continued resource data
                    fcb       $00,$00,$F0,$3C,$F0,$3C,$F0,$3C,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $3F,$F0,$F0,$3C,$F0,$3C,$FF,$FC,$F0,$3C,$F0,$3C ; continued resource data
                    fcb       $3F,$F0,$00,$00,$F0,$3C,$3F,$F0,$F0,$3C,$F0,$3C ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$3F,$F0,$00,$00,$F0,$3C,$00,$00 ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$F0,$3C,$F0,$3C,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $3F,$FC,$F0,$00,$3F,$F0,$F0,$3C,$3F,$F0,$00,$3C ; continued resource data
                    fcb       $FF,$F0,$00,$00,$0F,$F0,$3C,$3C,$3C,$00,$FF,$C0 ; continued resource data
                    fcb       $3C,$00,$3F,$3C,$F3,$F0,$00,$00,$0F,$00,$0F,$00 ; continued resource data
                    fcb       $FF,$F0,$0F,$00,$0F,$00,$00,$00,$FF,$F0,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$3C,$0F,$F0,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$F0,$03,$CC,$0F,$00,$0F,$00 ; continued resource data
                    fcb       $FF,$C0,$3C,$00,$3C,$00,$F0,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $0F,$C0,$0F,$C0,$0F,$C0,$03,$00,$03,$00,$00,$00 ; continued resource data
                    fcb       $03,$00,$00,$00,$3C,$F0,$3C,$F0,$0C,$C0,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3C,$F0 ; continued resource data
                    fcb       $FF,$FC,$3C,$F0,$FF,$FC,$3C,$F0,$00,$00,$00,$00 ; continued resource data
                    fcb       $03,$C0,$0F,$FC,$33,$C0,$0F,$F0,$03,$CC,$3F,$F0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$0F,$0C,$0F,$3C,$00,$F0,$03,$C0 ; continued resource data
                    fcb       $0F,$3C,$0C,$3C,$00,$00,$00,$00,$0F,$C0,$3C,$F0 ; continued resource data
                    fcb       $0F,$C0,$3F,$C0,$F0,$FC,$F3,$F0,$3F,$3C,$00,$00 ; continued resource data
                    fcb       $03,$C0,$00,$C0,$03,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$F0,$03,$C0,$0F,$00,$0F,$00 ; continued resource data
                    fcb       $0F,$00,$03,$C0,$00,$F0,$00,$00,$0F,$00,$03,$C0 ; continued resource data
                    fcb       $00,$F0,$00,$F0,$00,$F0,$03,$C0,$0F,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$03,$C0,$33,$CC,$0F,$F0,$33,$CC,$03,$C0 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$03,$C0,$03,$C0,$3F,$FC ; continued resource data
                    fcb       $03,$C0,$03,$C0,$00,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$0F,$00,$03,$00,$0C,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$0F,$F0,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$0F,$00,$0F,$00,$00,$00,$00,$0C,$00,$3C ; continued resource data
                    fcb       $00,$F0,$03,$C0,$0F,$00,$3C,$00,$30,$00,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$FC,$3F,$FC,$3F,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$03,$C0,$0F,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$03,$C0,$0F,$F0,$00,$00,$0F,$F0,$3C,$3C ; continued resource data
                    fcb       $00,$3C,$00,$F0,$03,$C0,$3F,$00,$3F,$FC,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$00,$3C,$03,$F0,$00,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$F0,$03,$F0,$0C,$F0,$3C,$F0 ; continued resource data
                    fcb       $FF,$FC,$00,$F0,$00,$F0,$00,$00,$3F,$FC,$3C,$00 ; continued resource data
                    fcb       $3F,$F0,$3C,$3C,$00,$3C,$3C,$FC,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$00,$3F,$F0,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$3F,$FC,$00,$3C,$00,$F0,$03,$C0 ; continued resource data
                    fcb       $0F,$00,$3C,$00,$3C,$00,$00,$00,$0F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$0F,$F0,$3C,$3C,$3C,$3C,$0F,$F0,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$3C,$0F,$FC,$00,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$00,$00,$00,$0F,$00,$0F,$00 ; continued resource data
                    fcb       $00,$00,$0F,$00,$0F,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $0F,$00,$00,$00,$0F,$00,$03,$00,$0C,$00,$00,$00 ; continued resource data
                    fcb       $00,$F0,$03,$C0,$0F,$00,$3C,$00,$0F,$00,$03,$C0 ; continued resource data
                    fcb       $00,$F0,$00,$00,$00,$00,$00,$00,$0F,$F0,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$00,$00,$00,$3C,$00,$0F,$00 ; continued resource data
                    fcb       $03,$C0,$00,$F0,$03,$C0,$0F,$00,$3C,$00,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$00,$3C,$00,$F0,$03,$C0,$00,$00 ; continued resource data
                    fcb       $03,$C0,$00,$00,$0F,$F0,$30,$0C,$C3,$FC,$C3,$3C ; continued resource data
                    fcb       $C3,$F0,$30,$00,$0F,$F0,$00,$00,$03,$C0,$0F,$F0 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3F,$FC,$3C,$3C,$3C,$3C,$00,$00 ; continued resource data
                    fcb       $3F,$F0,$3C,$3C,$3C,$3C,$3F,$F0,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3F,$F0,$00,$00,$0F,$F0,$3C,$3C,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$00,$3C,$3C,$0F,$F0,$00,$00,$3F,$C0,$3C,$F0 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3C,$3C,$3C,$F0,$3F,$C0,$00,$00 ; continued resource data
                    fcb       $3F,$FC,$3C,$00,$3C,$00,$3F,$F0,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3F,$FC,$00,$00,$3F,$FC,$3C,$00,$3C,$00,$3F,$F0 ; continued resource data
                    fcb       $3C,$00,$3C,$00,$3C,$00,$00,$00,$0F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$00,$3C,$FC,$3C,$3C,$3C,$3C,$0F,$F0,$00,$00 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3C,$3C,$3F,$FC,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$00,$00,$0F,$F0,$03,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$03,$C0,$0F,$F0,$00,$00,$03,$FC,$00,$F0 ; continued resource data
                    fcb       $00,$F0,$00,$F0,$00,$F0,$3C,$F0,$0F,$C0,$00,$00 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3C,$F0,$3F,$C0,$3C,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$00,$00,$3C,$00,$3C,$00,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$00,$3C,$00,$3F,$FC,$00,$00,$F0,$3C,$FF,$FC ; continued resource data
                    fcb       $FF,$FC,$F3,$3C,$F0,$3C,$F0,$3C,$F0,$3C,$00,$00 ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3F,$3C,$3F,$FC,$3C,$FC,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$00,$00,$0F,$F0,$3C,$3C,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$0F,$F0,$00,$00,$3F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$3F,$F0,$3C,$00,$3C,$00,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3F,$F0 ; continued resource data
                    fcb       $0F,$3C,$00,$00,$3F,$F0,$3C,$3C,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3F,$F0,$3C,$F0,$3C,$3C,$00,$00,$0F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$00,$0F,$F0,$00,$3C,$3C,$3C,$0F,$F0,$00,$00 ; continued resource data
                    fcb       $3F,$FC,$03,$C0,$03,$C0,$03,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$0F,$F0,$00,$00,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$0F,$F0,$0F,$F0,$03,$C0,$00,$00 ; continued resource data
                    fcb       $F0,$3C,$F0,$3C,$F0,$3C,$F3,$3C,$FF,$FC,$FF,$FC ; continued resource data
                    fcb       $F0,$3C,$00,$00,$3C,$3C,$3C,$3C,$0F,$F0,$03,$C0 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3C,$3C,$00,$00,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$0F,$F0,$03,$C0,$03,$C0,$03,$C0,$00,$00 ; continued resource data
                    fcb       $3F,$FC,$00,$3C,$00,$F0,$03,$C0,$0F,$00,$3C,$00 ; continued resource data
                    fcb       $3F,$FC,$00,$00,$0F,$F0,$0F,$00,$0F,$00,$0F,$00 ; continued resource data
                    fcb       $0F,$00,$0F,$00,$0F,$F0,$00,$00,$30,$00,$3C,$00 ; continued resource data
                    fcb       $0F,$00,$03,$C0,$00,$F0,$00,$3C,$00,$0C,$00,$00 ; continued resource data
                    fcb       $03,$FC,$00,$3C,$00,$3C,$00,$3C,$00,$3C,$00,$3C ; continued resource data
                    fcb       $03,$FC,$00,$00,$00,$C0,$03,$F0,$0F,$3C,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC ; continued resource data
                    fcb       $03,$C0,$03,$00,$00,$C0,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$00,$00,$00,$00,$0F,$F0,$00,$3C ; continued resource data
                    fcb       $0F,$FC,$3C,$3C,$0F,$FC,$00,$00,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$00,$3F,$F0,$3C,$3C,$3C,$3C,$3F,$F0,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$0F,$F0,$3C,$3C,$3C,$00,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$3C,$00,$3C,$00,$3C,$0F,$FC ; continued resource data
                    fcb       $3C,$3C,$3C,$3C,$0F,$FC,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $0F,$F0,$3C,$3C,$3F,$FC,$3C,$00,$0F,$F0,$00,$00 ; continued resource data
                    fcb       $00,$F0,$03,$C0,$03,$C0,$03,$C0,$0F,$F0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$00,$00,$00,$00,$0F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$0F,$FC,$00,$3C,$0F,$F0,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$00,$3F,$F0,$3C,$3C,$3C,$3C,$3C,$3C,$00,$00 ; continued resource data
                    fcb       $00,$00,$03,$C0,$00,$00,$03,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$00,$00,$00,$F0,$00,$00,$00,$F0 ; continued resource data
                    fcb       $00,$F0,$00,$F0,$00,$F0,$0F,$C0,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$3C,$3C,$F0,$3F,$C0,$3C,$F0,$3C,$3C,$00,$00 ; continued resource data
                    fcb       $03,$C0,$03,$C0,$03,$C0,$03,$C0,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$00,$00,$00,$00,$00,$3C,$F0,$FF,$FC ; continued resource data
                    fcb       $FF,$FC,$F3,$3C,$F0,$3C,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $3C,$F0,$3F,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$0F,$F0,$3C,$3C,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$00,$00,$00,$3F,$F0,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$3F,$F0,$3C,$00,$3C,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $0F,$FC,$3C,$3C,$3C,$3C,$0F,$FC,$00,$3C,$00,$3C ; continued resource data
                    fcb       $00,$00,$00,$00,$3C,$F0,$3F,$3C,$3C,$00,$3C,$00 ; continued resource data
                    fcb       $3C,$00,$00,$00,$00,$00,$00,$00,$0F,$F0,$3C,$00 ; continued resource data
                    fcb       $0F,$F0,$00,$3C,$3F,$F0,$00,$00,$03,$C0,$03,$C0 ; continued resource data
                    fcb       $0F,$F0,$03,$C0,$03,$C0,$03,$C0,$00,$F0,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $0F,$F0,$00,$00,$00,$00,$00,$00,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $0C,$30,$0F,$F0,$03,$C0,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $F0,$3C,$F3,$3C,$FF,$FC,$FF,$FC,$3C,$F0,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$3C,$3C,$0F,$F0,$03,$C0,$0F,$F0 ; continued resource data
                    fcb       $3C,$3C,$00,$00,$00,$00,$00,$00,$3C,$3C,$3C,$3C ; continued resource data
                    fcb       $3C,$3C,$0F,$FC,$00,$3C,$0F,$F0,$00,$00,$00,$00 ; continued resource data
                    fcb       $3F,$FC,$00,$F0,$03,$C0,$0F,$00,$3F,$FC,$00,$00 ; continued resource data
                    fcb       $00,$3C,$00,$F0,$00,$F0,$03,$C0,$00,$F0,$00,$F0 ; continued resource data
                    fcb       $00,$3C,$00,$00,$03,$C0,$03,$C0,$03,$C0,$00,$00 ; continued resource data
                    fcb       $00,$00,$03,$C0,$03,$C0,$03,$C0,$0F,$00,$03,$C0 ; continued resource data
                    fcb       $03,$C0,$00,$F0,$03,$C0,$03,$C0,$0F,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$0F,$0C,$3C,$F0,$00,$00,$00,$00,$00,$00 ; continued resource data
                    fcb       $00,$00,$00,$00,$CC,$CC,$33,$33,$CC,$CC,$33,$33 ; continued resource data
                    fcb       $CC,$CC,$33,$33,$CC,$CC,$33,$33,$28,$01 ; continued resource data
ResourceEndPointer  equ       *         ; secondary resource address passed during startup
FinalResourceData
                    fcb       $CC,$CC,$33,$33,$CC,$CC,$33,$33,$CC,$CC,$33,$33 ; DeskMate bitmap/control resource bytes
                    fcb       $CC,$CC,$33,$33 ; continued resource data

                    emod
eom                 equ       *
                    end
