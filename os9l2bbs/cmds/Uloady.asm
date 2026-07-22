**********************************************************************
* Uloady - OS-9 Level 2 BBS command
*
* Syntax: Uloady [file]
* Purpose: Receive 128-byte SOH or 1024-byte STX blocks.
* Negotiates checksum/CRC validation and handles retry, cancel, and EOT.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded mixed-size block reception and corrected the protocol description.
**********************************************************************

                    nam       Uloady
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; define a program-object module
atrv                set       ReEnt+rev ; mark the module reentrant at revision one
rev                 set       $01       ; retain the original module revision

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ControlByte         rmb       1
OutputPathNum       rmb       1
ExpectedBlockNumber rmb       1
RetryCount          rmb       1
ReadyPollCounter    rmb       1
ReadyPollCounterLow rmb       1
FrameBytesRemaining rmb       2
NegotiationCountdown rmb       2
CrcBytesRemaining   rmb       2
CrcBitsRemaining    rmb       2
CrcAccumulator      rmb       1
CrcAccumulatorLow   rmb       1
DestinationPathPointer rmb       2
FilenameBuffer      rmb       32
* Maximum frame body after SOH/STX: sequence pair, 1024 data bytes, and CRC
ReceivedBlockNumber rmb       1
ReceivedInverseBlock rmb       1
ReceivedData        rmb       128
ReceivedDataTail    rmb       896       ; payload tail, or small-frame check field at its start
LargeFrameCheckValue rmb       2
SavedTerminalOptions rmb       32        ; pristine packet restored on exit
RawTerminalOptions  rmb       1         ; separately fetched packet modified for transfer
RawTerminalOptionsTail rmb       431
size                equ       .         ; reserve the complete per-process workspace

name                fcs       /Uloady/ ; publish the mixed-size receiver module name
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved"
* Preserve the original high-bit bytes adjoining the embedded copyright notice.
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
ReadyText           fcc       "File open, ready to recieve..."
                    fcb       $0D       ; terminate the original misspelled ready notice
FilenamePrompt      fcc       "Enter filename to upload: "
AbortedText         fcc       "Upload aborted!"
                    fcb       $0D       ; terminate the abort notice
SuccessText         fcc       "Upload successful!"
                    fcb       $0D       ; terminate the success notice
start               pshs      x         ; preserve the caller's argument pointer for process lifetime
                    os9       F$ID      ; obtain this process ID for the priority request
                    ldb       #255      ; request the highest scheduler priority during transfer
                    os9       F$SPrior  ; minimize serial overrun risk while receiving frames
                    lda       ,x        ; inspect the first command-line character
                    cmpa      #13       ; distinguish an omitted filename from an argument
                    bne       CreateDestination ; use the supplied pathname when one is present
                    leax      >FilenamePrompt,pc ; point at the interactive filename prompt
                    ldy       #25       ; supply the prompt's exact byte count
                    lda       #1        ; direct the prompt to standard output
                    os9       I$Write   ; ask the caller where the upload should be stored
                    leax      <FilenameBuffer,u ; receive the pathname in private workspace
                    ldy       #32       ; cap the pathname at the allocated buffer size
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect a carriage-return-terminated pathname
CreateDestination   stx       <DestinationPathPointer,u ; retain the pathname for abort cleanup
                    lda       #2        ; open the destination for update access
                    ldb       #27       ; create it with the package's original attributes
                    os9       I$Create  ; create or truncate the requested upload file
                    lbcs      ExitImmediately ; report the OS-9 creation error unchanged
                    sta       OutputPathNum,u ; remember the destination path number
                    clr       RetryCount,u ; begin with no unanswered NAK requests
                    clr       ExpectedBlockNumber,u ; arrange for the first accepted block to be one
                    clr       >ReceivedDataTail,u ; prepare the small-frame check-field sentinel
                    dec       >ReceivedDataTail,u ; preserve the receiver's original $ff sentinel
                    leax      >ReadyText,pc ; announce that the receiver is ready
                    ldy       #200      ; allow I$WritLn to stop at the string terminator
                    lda       #1        ; send the notice to standard output
                    os9       I$WritLn  ; tell the remote side to begin transmission
                    lda       #6        ; allow six CRC-request negotiation passes
                    sta       NegotiationCountdown,u ; begin by requesting CRC-16 frames
                    leax      >SavedTerminalOptions,u ; choose pristine storage for the current options
                    clra                ; query standard input
                    clrb                ; select SS.Opt
                    os9       I$GetStt  ; preserve the terminal configuration for final restoration
                    lbcs      ExitImmediately ; stop if the terminal state cannot be saved
                    leax      >RawTerminalOptions,u ; fetch a second copy that may be altered
                    clra                ; query standard input
                    clrb                ; select SS.Opt
                    os9       I$GetStt  ; obtain a working terminal option packet
                    lbcs      ExitImmediately ; stop if raw-mode preparation is impossible
                    leax      >RawTerminalOptions,u ; recover the packet's post-header address
                    leax      -$20,x    ; address the beginning of the full option structure
* Disable terminal editing and signal characters so protocol bytes arrive verbatim.
                    clr       <$002B,x  ; disable the first configured control-character action
                    clr       <$002C,x  ; disable the next configured control-character action
                    clr       <$002E,x  ; prevent another driver-interpreted control byte
                    clr       <$002F,x  ; prevent another driver-interpreted control byte
                    clr       <$0030,x  ; prevent another driver-interpreted control byte
                    clr       <$0031,x  ; prevent another driver-interpreted control byte
                    clr       <$0038,x  ; disable an extended terminal control binding
                    clr       <$0039,x  ; disable an extended terminal control binding
                    clr       <$0024,x  ; disable an input translation option
                    clr       <$002D,x  ; disable another configured control-character action
                    clr       <$0027,x  ; disable an input editing option
                    clr       <$0028,x  ; disable an input editing option
                    clr       <$0029,x  ; disable an input editing option
                    clra                ; apply options to standard input
                    clrb                ; select SS.Opt
                    leax      >RawTerminalOptions,u ; point at the working option packet
                    os9       I$SetStt  ; put the terminal into binary-safe receive mode
SendHandshake       tst       NegotiationCountdown,u ; decide whether CRC negotiation remains active
                    beq       SendNak   ; fall back to the one-byte checksum request
                    dec       NegotiationCountdown,u ; consume one CRC negotiation pass
                    lda       #67       ; select ASCII C to request CRC-16 framing
                    sta       ControlByte,u ; stage the CRC request in writable memory
                    bra       TransmitHandshake ; send the selected negotiation byte
SendNak             lda       #21       ; select the XMODEM NAK control byte
                    sta       ControlByte,u ; stage the byte in writable memory
TransmitHandshake   leax      ControlByte,u ; point I$Write at the staged request
                    lda       #1        ; send the request on standard output
                    ldy       #1        ; transmit exactly one control byte
                    os9       I$Write   ; request CRC traffic, checksum traffic, or retransmission
                    clr       ReadyPollCounter,u ; restart the frame-start timeout
                    clr       ReadyPollCounterLow,u ; clear the low half of the timeout word
                    lda       RetryCount,u ; obtain the number of consecutive requests
                    inca                ; count this NAK attempt
                    sta       RetryCount,u ; retain the updated retry count
                    cmpa      #10       ; enforce the original ten-attempt limit
                    bcs       WaitForFrameStart ; continue while retry capacity remains
                    ldb       #1        ; return a generic failure after repeated silence
                    lbra      ExitWithStatus ; restore the terminal and terminate
WaitForFrameStart   clra                ; poll standard input
                    ldb       #1        ; select SS.Ready
                    os9       I$GetStt  ; determine whether a frame-start byte is available
                    bcc       ReadFrameStart ; consume the pending marker immediately
                    ldy       ReadyPollCounter,u ; advance the word-sized readiness timeout
                    leay      $01,y     ; count one poll without input
                    sty       ReadyPollCounter,u ; preserve the timeout progress
                    cmpy      #5376     ; periodically repeat protocol negotiation
                    bcc       SendHandshake ; send C or NAK after the polling interval
                    bra       WaitForFrameStart ; keep polling within this interval
ReadFrameStart      leax      ControlByte,u ; receive the protocol marker here
                    ldy       #1        ; read exactly one marker byte
                    clra                ; read from standard input
                    os9       I$Read    ; consume the waiting frame-start byte
                    lda       ControlByte,u ; classify the received protocol marker
                    cmpa      #1        ; test for SOH and a 128-byte data frame
                    beq       ReceiveSmallFrame ; collect the remainder of a 128-byte SOH frame
                    cmpa      #2        ; test for STX and a 1024-byte data frame
                    beq       ReceiveLargeFrame ; collect the remainder of a 1K frame
                    cmpa      #4        ; test for end-of-transmission
                    lbeq      FinishUpload ; acknowledge EOT and complete the file
                    cmpa      #24       ; test for the package's control-X cancellation
                    lbeq      AbortUpload ; discard the partial destination on cancellation
                    bra       WaitForFrameStart ; ignore noise until a recognized marker arrives
ReceiveLargeFrame   leax      <ReceivedBlockNumber,u ; receive immediately after the consumed STX
                    tst       NegotiationCountdown,u ; choose the check field implied by negotiation state
                    beq       SelectLargeChecksumLength ; expect one check byte after fallback
                    ldy       #1028     ; include sequence pair, 1K data, and two CRC bytes
                    bra       ReadLargeFrameBody ; use the CRC frame-body length
SelectLargeChecksumLength ldy       #1027     ; include sequence pair, 1K data, and checksum
ReadLargeFrameBody  sty       FrameBytesRemaining,u ; initialize the frame byte countdown
                    clr       ReadyPollCounter,u ; start a fresh inter-byte timeout
                    clr       ReadyPollCounterLow,u ; clear the low half of the timeout word
                    bsr       ReadFrameBytes ; gather the complete frame body
                    lbcs      SendNak   ; request retransmission after timeout or read failure
                    inc       ExpectedBlockNumber,u ; advance to the sequence number now expected
                    lbra      ValidateLargeBlockSequence ; validate the completed 1K frame
ReceiveSmallFrame   leax      <ReceivedBlockNumber,u ; receive immediately after the consumed SOH
                    tst       NegotiationCountdown,u ; choose the check field implied by negotiation state
                    beq       SelectSmallChecksumLength ; expect one check byte after fallback
                    ldy       #132      ; include sequence pair, 128 data, and two CRC bytes
                    bra       ReadSmallFrameBody ; use the CRC frame-body length
SelectSmallChecksumLength ldy       #131      ; include sequence pair, 128 data, and checksum
ReadSmallFrameBody  sty       FrameBytesRemaining,u ; initialize the frame byte countdown
                    clr       ReadyPollCounter,u ; restart the word-sized inter-byte timeout
                    clr       ReadyPollCounterLow,u ; clear the low half of the timeout word
                    bsr       ReadFrameBytes ; gather the complete small frame body
                    lbcs      SendNak   ; request retransmission after timeout or read failure
                    inc       ExpectedBlockNumber,u ; advance to the sequence number now expected
                    lbra      ValidateSmallBlockSequence ; validate the completed 128-byte frame
* Read the requested remainder of a frame, preserving X as the advancing destination.
ReadFrameBytes      clra                ; poll standard input
                    ldb       #1        ; select SS.Ready
                    os9       I$GetStt  ; discover how many serial bytes can be read
                    bcc       InputReady ; read the available portion of the frame
                    ldy       ReadyPollCounter,u ; advance the inter-byte timeout
                    leay      $01,y     ; count one poll with no available data
                    sty       ReadyPollCounter,u ; retain the timeout progress
                    cmpy      #4096     ; bound the wait for the next frame byte
                    bhi       FrameReadTimeout ; return carry set after prolonged silence
                    bra       ReadFrameBytes ; continue polling for the frame remainder
InputReady          clr       ReadyPollCounter,u ; restart the timeout after receiving progress
                    clr       ReadyPollCounterLow,u ; clear the low half of the timeout word
                    clra                ; turn the SS.Ready count in B into a word
                    tfr       d,y       ; request exactly the reported available byte count
                    os9       I$Read    ; append available bytes at the current frame pointer
                    bcs       FrameReadFailed ; drain residual input after a path error
                    tfr       y,d       ; recover the number of bytes actually returned
                    leax      d,x       ; advance to the next free frame byte
                    ldd       FrameBytesRemaining,u ; obtain the outstanding frame length
                    sty       FrameBytesRemaining,u ; preserve the actual read count temporarily
                    subd      FrameBytesRemaining,u ; subtract the received portion
                    std       FrameBytesRemaining,u ; retain the outstanding byte count
                    bne       ReadFrameBytes ; continue until the selected frame body is complete
                    rts                 ; return carry clear with a complete frame body
FrameReadTimeout    lda       #255      ; choose a value whose rotate forces carry
                    rola                ; signal timeout to the caller through carry
                    rts                 ; let the caller request retransmission
FrameReadFailed     pshs      x         ; preserve the current frame destination while draining
                    ldx       #60       ; wait one second for residual serial bytes to arrive
                    os9       F$Sleep   ; give the sender time to finish its damaged frame
                    puls      x         ; recover the frame destination pointer
                    clra                ; poll standard input
                    ldb       #1        ; select SS.Ready
                    os9       I$GetStt  ; measure bytes left from the failed frame
                    clra                ; extend the available-byte count to a word
                    tfr       d,y       ; use the count as the discard read length
                    os9       I$Read    ; consume residual bytes before sending NAK
                    lda       #255      ; choose a value whose rotate forces carry
                    rola                ; report the failed read to the caller
                    rts                 ; resume at the retransmission path
ValidateSmallBlockSequence lda       <ReceivedBlockNumber,u ; fetch the sender's sequence number
                    inca                ; form the number following the received block
                    cmpa      ExpectedBlockNumber,u ; detect a repeat of the prior accepted block
                    lbeq      AcknowledgeDuplicate ; ack a duplicate without writing it twice
                    deca                ; restore the sequence number received on the wire
                    cmpa      ExpectedBlockNumber,u ; require the newly expected block number
                    beq       ValidateSmallBlockComplement ; continue with header integrity checks
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; request the missing or correctly numbered frame
ValidateSmallBlockComplement coma                ; derive the required one's-complement sequence byte
                    cmpa      <ReceivedInverseBlock,u ; verify the frame header pair
                    beq       ValidateSmallIntegrity ; validate the negotiated check field next
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; reject a corrupt block header
ValidateSmallIntegrity leax      <ReceivedData,u ; begin at the 128-byte payload
                    tst       NegotiationCountdown,u ; select CRC or checksum validation
                    bne       ValidateSmallCrc ; compute CRC-16 while negotiation remains active
                    ldb       #128      ; checksum every payload byte
                    clra                ; initialize the modulo-256 sum
SumSmallDataByte    adda      ,x+       ; fold the next payload byte into the checksum
                    decb                ; count one byte included in the sum
                    bne       SumSmallDataByte ; continue across the 128-byte payload
                    cmpa      >ReceivedDataTail,u ; compare with the small frame's check byte
                    lbeq      WriteSmallData ; commit an intact checksum-mode block
                    dec       ExpectedBlockNumber,u ; retry the same sequence number
                    lbra      SendNak   ; request retransmission of corrupt data
ValidateSmallCrc    ldy       #128      ; process every small-frame payload byte
                    sty       CrcBytesRemaining,u ; initialize the outer CRC loop
                    clra                ; initialize the high accumulator byte
                    clrb                ; initialize the low accumulator byte
                    std       CrcAccumulator,u ; start with a zero CRC remainder
SmallCrcNextByte    lda       ,x+       ; obtain the next payload byte
                    clrb                ; position it in the high half of D
                    eora      CrcAccumulator,u ; inject the byte into the current remainder
                    eorb      CrcAccumulatorLow,u ; retain the accumulator's low byte
                    std       CrcAccumulator,u ; save the injected remainder
                    lda       #8        ; process all eight bits of this byte
                    sta       CrcBitsRemaining,u ; initialize the inner CRC loop
SmallCrcNextBit     ldd       CrcAccumulator,u ; recover the current 16-bit remainder
                    bita      #128      ; test the bit leaving the high end
                    beq       ShiftSmallCrc ; shift without feedback when that bit is clear
                    aslb                ; shift the remainder's low byte left
                    rola                ; carry the low-byte bit into the high byte
                    eora      #16       ; apply polynomial $1021 high byte
                    eorb      #33       ; apply polynomial $1021 low byte
                    std       CrcAccumulator,u ; retain the feedback-adjusted remainder
                    bra       CountSmallCrcBit ; finish this input-bit iteration
ShiftSmallCrc       aslb                ; shift the remainder's low byte left
                    rola                ; complete the plain 16-bit left shift
                    std       CrcAccumulator,u ; retain the shifted remainder
CountSmallCrcBit    dec       CrcBitsRemaining,u ; count one payload bit processed
                    bne       SmallCrcNextBit ; complete all eight bits of this byte
                    ldy       CrcBytesRemaining,u ; obtain the remaining small payload count
                    leay      -$01,y    ; count one payload byte processed
                    sty       CrcBytesRemaining,u ; retain the outer-loop count
                    bne       SmallCrcNextByte ; continue across all 128 payload bytes
                    ldd       CrcAccumulator,u ; recover the calculated CRC-16
                    cmpd      >ReceivedDataTail,u ; compare with the small frame's two CRC bytes
                    beq       WriteSmallData ; commit an intact CRC-mode block
                    dec       ExpectedBlockNumber,u ; retry the same sequence number
                    lbra      SendNak   ; ask the sender to retransmit corrupt data
WriteSmallData      lda       OutputPathNum,u ; select the destination file
                    leax      <ReceivedData,u ; point at the verified payload
                    ldy       #128      ; preserve XMODEM's fixed block size
                    os9       I$Write   ; append the accepted block to the upload
                    lbra      SendAck   ; acknowledge successful persistence
ValidateLargeBlockSequence lda       <ReceivedBlockNumber,u ; fetch the sender's sequence number
                    inca                ; form the number following the received block
                    cmpa      ExpectedBlockNumber,u ; detect a repeat of the prior accepted block
                    lbeq      AcknowledgeDuplicate ; ack a duplicate without writing it twice
                    deca                ; restore the sequence number received on the wire
                    cmpa      ExpectedBlockNumber,u ; require the newly expected block number
                    beq       ValidateLargeBlockComplement ; continue with header integrity checks
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; request the missing or correctly numbered frame
ValidateLargeBlockComplement coma                ; derive the required one's-complement sequence byte
                    cmpa      <ReceivedInverseBlock,u ; verify the frame header pair
                    beq       ValidateLargeIntegrity ; validate the negotiated check field next
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; reject a corrupt block header
ValidateLargeIntegrity leax      <ReceivedData,u ; begin at the 1024-byte payload
                    tst       NegotiationCountdown,u ; select CRC or checksum validation
                    bne       ValidateLargeCrc ; compute CRC-16 while negotiation remains active
                    ldy       #1024     ; checksum every large-frame payload byte
                    clra                ; initialize the modulo-256 sum
SumLargeDataByte    adda      ,x+       ; fold the next payload byte into the checksum
                    leay      -$01,y    ; count one byte included in the sum
                    bne       SumLargeDataByte ; continue across the 1024-byte payload
                    cmpa      >LargeFrameCheckValue,u ; compare with the transmitted checksum
                    lbeq      WriteSmallData ; preserve the original checksum-mode 128-byte write path
                    dec       ExpectedBlockNumber,u ; retry the same sequence number
                    lbra      SendNak   ; request retransmission of corrupt data
ValidateLargeCrc    ldy       #1024     ; process every large-frame payload byte
                    sty       CrcBytesRemaining,u ; initialize the outer CRC loop
                    clra                ; initialize the high accumulator byte
                    clrb                ; initialize the low accumulator byte
                    std       CrcAccumulator,u ; start with a zero CRC remainder
LargeCrcNextByte    lda       ,x+       ; obtain the next payload byte
                    clrb                ; position it in the high half of D
                    eora      CrcAccumulator,u ; inject the byte into the current remainder
                    eorb      CrcAccumulatorLow,u ; retain the accumulator's low byte
                    std       CrcAccumulator,u ; save the injected remainder
                    lda       #8        ; process all eight bits of this byte
                    sta       CrcBitsRemaining,u ; initialize the inner CRC loop
LargeCrcNextBit     ldd       CrcAccumulator,u ; recover the current 16-bit remainder
                    bita      #128      ; test the bit leaving the high end
                    beq       ShiftLargeCrc ; shift without feedback when that bit is clear
                    aslb                ; shift the remainder's low byte left
                    rola                ; carry the low-byte bit into the high byte
                    eora      #16       ; apply polynomial $1021 high byte
                    eorb      #33       ; apply polynomial $1021 low byte
                    std       CrcAccumulator,u ; retain the feedback-adjusted remainder
                    bra       CountLargeCrcBit ; finish this input-bit iteration
ShiftLargeCrc       aslb                ; shift the remainder's low byte left
                    rola                ; complete the plain 16-bit left shift
                    std       CrcAccumulator,u ; retain the shifted remainder
CountLargeCrcBit    dec       CrcBitsRemaining,u ; count one payload bit processed
                    bne       LargeCrcNextBit ; complete all eight bits of this byte
                    ldy       CrcBytesRemaining,u ; obtain the remaining payload count
                    leay      -$01,y    ; count one payload byte processed
                    sty       CrcBytesRemaining,u ; retain the outer-loop count
                    bne       LargeCrcNextByte ; continue across all 1024 payload bytes
                    ldd       CrcAccumulator,u ; recover the calculated CRC-16
                    cmpd      >LargeFrameCheckValue,u ; compare with the transmitted two-byte CRC
                    beq       WriteLargeData ; commit an intact CRC-mode block
                    dec       ExpectedBlockNumber,u ; retry the same sequence number
                    lbra      SendNak   ; request retransmission of corrupt data
WriteLargeData      lda       OutputPathNum,u ; select the destination file
                    leax      <ReceivedData,u ; point at the verified 1K payload
                    ldy       #1024     ; preserve the large frame's fixed data size
                    os9       I$Write   ; append the accepted 1K block to the upload
                    bra       SendAck   ; acknowledge successful persistence
AcknowledgeDuplicate dec       ExpectedBlockNumber,u ; retain the next expected new sequence
SendAck             ldx       #10       ; delay briefly before the response byte
                    os9       F$Sleep   ; accommodate the original sender's pacing
                    lda       #6        ; select the XMODEM ACK control byte
                    sta       ControlByte,u ; stage ACK in writable memory
                    lda       #1        ; send the response on standard output
                    leax      ControlByte,u ; point at the staged ACK
                    ldy       #1        ; transmit exactly one response byte
                    os9       I$Write   ; accept the current frame
                    clr       RetryCount,u ; successful traffic resets the retry budget
                    lbra      WaitForFrameStart ; await the next frame or EOT
FinishUpload        lda       #6        ; select ACK for the EOT response
                    sta       ControlByte,u ; stage the final acknowledgement
                    lda       #1        ; send it on standard output
                    leax      ControlByte,u ; point at the staged ACK
                    ldy       #1        ; transmit one protocol byte
                    os9       I$Write   ; confirm end-of-transmission
                    lda       OutputPathNum,u ; select the completed destination
                    os9       I$Close   ; flush and close the uploaded file
                    lbsr      RestoreTerminalOptions ; return the console to cooked operation
                    leax      >SuccessText,pc ; point at the completion notice
                    ldy       #200      ; allow I$WritLn to find its terminator
                    lda       #1        ; write the notice to standard output
                    os9       I$WritLn  ; report successful completion to the caller
                    clrb                ; return a successful process status
ExitWithStatus      pshs      b         ; protect the intended exit status
                    lbsr      RestoreTerminalOptions ; make all ordinary exits terminal-safe
                    puls      b         ; recover the process status
ExitImmediately     os9       F$Exit    ; terminate with B as the OS-9 status
AbortUpload         bsr       RestoreTerminalOptions ; restore cooked input before printing
                    leax      >AbortedText,pc ; point at the cancellation notice
                    ldy       #200      ; allow I$WritLn to find its terminator
                    lda       #1        ; write the notice to standard output
                    os9       I$WritLn  ; tell the caller that the transfer was cancelled
                    lda       OutputPathNum,u ; select the partial destination
                    os9       I$Close   ; release it before deletion
                    ldx       <DestinationPathPointer,u ; recover the original destination pathname
                    os9       I$Delete  ; remove the incomplete upload
                    lbcs      ExitWithStatus ; propagate an OS-9 deletion failure
                    ldb       #1        ; otherwise report explicit cancellation
                    bra       ExitWithStatus ; restore state and terminate
RestoreTerminalOptions leax      >SavedTerminalOptions,u ; point at the pristine option packet
                    clra                ; restore options on standard input
                    clrb                ; select SS.Opt
                    os9       I$SetStt  ; restore the caller's terminal configuration
                    rts                 ; return to the selected exit or completion path

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
