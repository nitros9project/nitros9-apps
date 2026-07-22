**********************************************************************
* Uloadx - OS-9 Level 2 BBS command
*
* Syntax: Uloadx [file]
* Purpose: Receive XMODEM blocks using one-byte checksums.
* Validates block numbers/checksums and handles retries, cancel, and EOT.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded frame acquisition, duplicate handling, and checksum validation.
**********************************************************************

                    nam       Uloadx
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
ReadyPollCounter    rmb       2
FrameBytesRemaining rmb       1
DestinationPathPointer rmb       2
FilenameBuffer      rmb       32
* 131 bytes received after SOH: sequence, complement, data, and checksum
ReceivedBlockNumber rmb       1
ReceivedInverseBlock rmb       1
ReceivedData        rmb       128
ReceivedChecksum    rmb       1
SavedTerminalOptions rmb       32        ; pristine packet restored on exit
RawTerminalOptions  rmb       1         ; separately fetched packet modified for transfer
RawTerminalOptionsTail rmb       431
size                equ       .         ; reserve the complete per-process workspace

name                fcs       /Uloadx/ ; publish the transfer-engine module name
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
                    leax      FilenameBuffer,u ; receive the pathname in private workspace
                    ldy       #32       ; cap the pathname at the allocated buffer size
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect a carriage-return-terminated pathname
CreateDestination   stx       DestinationPathPointer,u ; retain the pathname for abort cleanup
                    lda       #2        ; open the destination for update access
                    ldb       #27       ; create it with the package's original attributes
                    os9       I$Create  ; create or truncate the requested upload file
                    lbcs      ExitImmediately ; report the OS-9 creation error unchanged
                    sta       OutputPathNum,u ; remember the destination path number
                    clr       RetryCount,u ; begin with no unanswered NAK requests
                    clr       ExpectedBlockNumber,u ; arrange for the first accepted block to be one
                    clr       >ReceivedChecksum,u ; prepare the original $ff workspace sentinel
                    dec       >ReceivedChecksum,u ; preserve the receiver's initial checksum sentinel
                    leax      >ReadyText,pc ; announce that the receiver is ready
                    ldy       #200      ; allow I$WritLn to stop at the string terminator
                    lda       #1        ; send the notice to standard output
                    os9       I$WritLn  ; tell the remote side to begin transmission
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
SendNak             lda       #21       ; select the XMODEM NAK control byte
                    sta       ControlByte,u ; stage the byte in writable memory
                    leax      ControlByte,u ; point I$Write at the staged NAK
                    lda       #1        ; send the request on standard output
                    ldy       #1        ; transmit exactly one control byte
                    os9       I$Write   ; request the first block or retransmission
                    clr       ReadyPollCounter,u ; restart the frame-start timeout
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
                    bcc       ReadFrameStart ; consume the pending byte immediately
                    ldy       ReadyPollCounter,u ; advance the busy-poll timeout
                    leay      $01,y     ; count one unsuccessful readiness poll
                    sty       ReadyPollCounter,u ; preserve the accumulated delay
                    cmpy      #4096     ; decide when to solicit another frame
                    bcc       SendNak   ; resend NAK after the bounded polling interval
                    bra       WaitForFrameStart ; keep polling within this interval
ReadFrameStart      leax      ControlByte,u ; receive the protocol marker here
                    ldy       #1        ; read exactly one marker byte
                    clra                ; read from standard input
                    os9       I$Read    ; consume the waiting frame-start byte
                    lda       ControlByte,u ; classify the received protocol marker
                    cmpa      #1        ; test for SOH and a 128-byte data frame
                    beq       ReceiveDataFrame ; collect the remainder of an SOH frame
                    cmpa      #4        ; test for end-of-transmission
                    lbeq      FinishUpload ; acknowledge EOT and complete the file
                    cmpa      #24       ; test for the package's control-X cancellation
                    lbeq      AbortUpload ; discard the partial destination on cancellation
                    bra       WaitForFrameStart ; ignore noise until a recognized marker arrives
ReceiveDataFrame    leax      <ReceivedBlockNumber,u ; receive immediately after the consumed SOH
                    lda       #131      ; expect number, complement, 128 data bytes, and sum
                    sta       FrameBytesRemaining,u ; initialize the frame byte countdown
                    clr       ReadyPollCounter,u ; start a fresh inter-byte timeout
                    bsr       ReadFrameBytes ; gather the complete frame body
                    lbcs      SendNak   ; request retransmission after timeout or read failure
                    inc       ExpectedBlockNumber,u ; advance to the sequence number now expected
                    lbra      ValidateBlockSequence ; reject stale, skipped, or corrupt frames
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
                    clra                ; turn the SS.Ready count in B into a word
                    tfr       d,y       ; request exactly the reported available byte count
                    os9       I$Read    ; append available bytes at the current frame pointer
                    bcs       FrameReadFailed ; drain residual input after a path error
                    tfr       y,d       ; recover the number of bytes actually returned
                    leax      b,x       ; advance to the next free frame byte
                    lda       FrameBytesRemaining,u ; obtain the outstanding frame length
                    stb       FrameBytesRemaining,u ; preserve the actual read count temporarily
                    suba      FrameBytesRemaining,u ; subtract the received portion
                    sta       FrameBytesRemaining,u ; retain the outstanding byte count
                    bne       ReadFrameBytes ; continue until all 131 bytes are present
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
ValidateBlockSequence lda       <ReceivedBlockNumber,u ; fetch the sender's sequence number
                    inca                ; form the number following the received block
                    cmpa      ExpectedBlockNumber,u ; detect a repeat of the prior accepted block
                    lbeq      AcknowledgeDuplicate ; ack a duplicate without writing it twice
                    deca                ; restore the sequence number received on the wire
                    cmpa      ExpectedBlockNumber,u ; require the newly expected block number
                    beq       ValidateBlockComplement ; continue with header integrity checks
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; request the missing or correctly numbered frame
ValidateBlockComplement coma                ; derive the required one's-complement sequence byte
                    cmpa      <ReceivedInverseBlock,u ; verify the frame header pair
                    beq       ValidateChecksum ; checksum only a structurally valid frame
                    dec       ExpectedBlockNumber,u ; roll back the speculative sequence advance
                    lbra      SendNak   ; reject a corrupt block header
ValidateChecksum    leax      <ReceivedData,u ; begin at the 128-byte payload
                    ldb       #128      ; checksum every payload byte
                    clra                ; initialize the modulo-256 sum
SumNextDataByte     adda      ,x+       ; fold the next payload byte into the checksum
                    decb                ; count one byte included in the sum
                    bne       SumNextDataByte ; continue across the complete payload
                    cmpa      >ReceivedChecksum,u ; compare with the sender's checksum byte
                    beq       WriteAcceptedData ; commit only an intact new block
                    dec       ExpectedBlockNumber,u ; retry the same sequence number
                    lbra      SendNak   ; ask the sender to retransmit corrupt data
WriteAcceptedData   lda       OutputPathNum,u ; select the destination file
                    leax      <ReceivedData,u ; point at the verified payload
                    ldy       #128      ; preserve XMODEM's fixed block size
                    os9       I$Write   ; append the accepted block to the upload
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
                    ldx       DestinationPathPointer,u ; recover the original destination pathname
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
