**********************************************************************
* Dloadx - OS-9 Level 2 BBS command
*
* Syntax: Dloadx [file]
* Purpose: Send 128-byte XMODEM blocks with one-byte checksums.
* Handles ACK/NAK, retry, cancel, end-of-transfer, and timeout state.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded checksum-XMODEM framing, handshake, and terminal handling.
**********************************************************************

                    nam       Dloadx
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

SourcePathNum       rmb       1
ReceiverByte        rmb       1
SizeShiftCounter    rmb       2
DecimalRemainder    rmb       2
DecimalDivisor      rmb       2
BlockCountText      rmb       10
* contiguous 132-byte checksum-XMODEM packet
PacketStart         rmb       1
BlockNumber         rmb       1
InverseBlockNumber  rmb       1
PacketData          rmb       128
PacketChecksum      rmb       1
FilenameBuffer      rmb       32
FilenamePointer     rmb       2
TerminalOptions     rmb       1         ; 32-byte ss.opt packet begins here
TerminalOptionsTail rmb       231
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloadx/ ; publish the transfer-engine module name
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved"

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
FilenamePrompt      fcc       "Enter filename to download-->"
FilenamePromptLength fcb       $00       ; high byte of the 16-bit prompt length
                    fcb       $1D       ; low byte selects all 29 prompt characters
ReadyText           fcc       "File open, ready to send..."
                    fcb       $0D       ; terminate the ready notice
SuccessText         fcc       "File transfer successful"
                    fcb       $0D       ; terminate the success notice
FailureText         fcc       "File transfer unsuccessful"
                    fcb       $0D       ; terminate the failure notice
AbortText           fcc       "Press <CTRL><X> to abort"
                    fcb       $0D       ; terminate the abort notice
EndOfTransferByte   fcb       $04       ; checksum-XMODEM EOT marker
BlankLine           fcb       $0A
                    fcb       $0D
BlockCountLabel     fcc       "Total number of blocks to download:"
* save standard-input options and clear option byte four while protocol bytes
* are exchanged.  The retained packet is later reused to restore that byte.
ConfigureTerminalInput leax      >TerminalOptions,u ; receive the 32-byte ss.opt packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$GetStt  ; preserve the caller's terminal configuration
                    leax      -$20,x    ; use the original packet-relative addressing pattern
                    clr       <$0024,x  ; clear option byte four for raw protocol input
                    leax      >TerminalOptions,u ; select the modified options packet
                    clra                ; target standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply raw-input behavior
                    rts                 ; return with the saved packet in workspace

* collect a filename when the child received an empty command line, configure
* raw input, open the file, and derive a displayed 128-byte block count.
start               lda       ,x        ; inspect the first command-line character
                    cmpa      #13       ; recognize the CR-only parameter from BBS.download
                    bne       OpenSourceFile ; use a supplied pathname directly
                    leax      >FilenamePrompt,pc ; prepare the inline filename prompt
                    ldy       >FilenamePromptLength,pc ; load its adjacent 16-bit length
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor ready for input
                    leax      >FilenameBuffer,u ; receive the requested source pathname
                    ldy       #32       ; enforce the allocated filename limit
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect the CR-terminated filename
OpenSourceFile      stx       >FilenamePointer,u ; preserve the selected pathname across setup
                    lbsr      ConfigureTerminalInput ; switch standard input to protocol mode
                    lda       #1        ; request read access to the source
                    ldx       >FilenamePointer,u ; recover the selected pathname
                    os9       I$Open    ; open the download source
                    lbcs      ExitWithStatus ; restore terminal input before returning the error
                    sta       SourcePathNum,u ; retain the source path number
                    leax      >BlockCountLabel,pc ; prepare the transfer-size caption
                    ldy       #35       ; write its exact unterminated length
                    lda       #1        ; direct the caption to the terminal
                    os9       I$Write   ; leave the cursor ready for the decimal count
                    lda       SourcePathNum,u ; select the source file
                    ldb       #2        ; request SS.Size
                    pshs      u         ; preserve workspace u while GetStat returns size in x:u
                    os9       I$GetStt  ; obtain the 32-bit source length
                    tfr       u,y       ; retain the low size word outside u
                    puls      u         ; recover the workspace pointer
                    lda       #7        ; divide the 32-bit x:y size by 128
                    sta       SizeShiftCounter,u ; count seven cross-word right shifts
DivideSizeBy128     tfr       x,d       ; move the high size word into the shift pair
                    lsra                ; shift the most-significant byte right
                    rorb                ; carry into the high word's low byte
                    tfr       d,x       ; retain the shifted high word
                    tfr       y,d       ; move the low size word into the shift pair
                    rora                ; carry the high word's low bit into the low word
                    rorb                ; complete this 32-bit right shift
                    tfr       d,y       ; retain the shifted low word
                    dec       SizeShiftCounter,u ; account for one factor of two
                    bne       DivideSizeBy128 ; repeat until the size has been divided by 128
                    tfr       y,d       ; format the low 16 bits of the quotient
                    leax      BlockCountText,u ; select the five-digit output field
                    addd      #1        ; display one padded final block beyond the quotient
                    lbsr      FormatDecimalNumber ; render the count as five decimal digits
                    leax      BlockCountText,u ; select the rendered count
                    ldy       #5        ; omit its trailing carriage return
                    lda       #1        ; direct the count to the terminal
                    os9       I$Write   ; complete the transfer-size line
                    leax      >BlankLine,pc ; select the following line break
                    ldy       #1        ; let WritLn stop at the CR in the two-byte sequence
                    lda       #1        ; direct spacing to the terminal
                    os9       I$WritLn  ; emit the leading line-feed byte before instructions
                    leax      >AbortText,pc ; prepare the sender-abort instruction
                    ldy       #200      ; allow WritLn to stop at its CR
                    lda       #1        ; direct the notice to the terminal
                    os9       I$WritLn  ; identify ctrl-x as cancellation
                    leax      >ReadyText,pc ; prepare the ready notice
                    ldy       #200      ; allow WritLn to stop at its CR
                    lda       #1        ; direct the notice to the terminal
                    os9       I$WritLn  ; announce that receiver negotiation may begin
* checksum-XMODEM begins only after the receiver sends NAK.  Ctrl-X cancels;
* unrelated negotiation bytes are ignored without a retry limit or timeout.
WaitForReceiverStart leax      ReceiverByte,u ; receive one receiver-control byte
                    ldy       #1        ; read exactly one byte
                    clra                ; select standard input
                    os9       I$Read    ; wait synchronously for receiver negotiation
                    lda       ReceiverByte,u ; classify the received control byte
                    cmpa      #24       ; ctrl-x cancels before the first packet
                    lbeq      TransferFailed ; report the cancelled transfer
                    cmpa      #21       ; nak requests checksum-XMODEM startup
                    bne       WaitForReceiverStart ; ignore all other negotiation bytes
                    lda       #1        ; initialize SOH and block number one
                    sta       <PacketStart,u ; place SOH at packet byte zero
                    sta       <BlockNumber,u ; number the first packet one
                    coma                ; form the required ones-complement block number
                    sta       <InverseBlockNumber,u ; complete the three-byte packet header

* read 128 source bytes per packet.  A short final read is padded with zeroes,
* then all 128 data bytes are summed modulo 256 for the trailing checksum.
ReadNextBlock       leax      <PacketData,u ; receive data directly into the packet body
                    ldy       #128      ; request one XMODEM data block
                    lda       SourcePathNum,u ; select the source file
                    os9       I$Read    ; fill as much of the next packet as remains
                    bcs       SourceReadEnded ; distinguish source EOF from other failures
                    cmpy      #128      ; determine whether this block is complete
                    beq       PacketDataReady ; checksum a full source block immediately
                    tfr       y,d       ; convert the short byte count to an index
                    leax      d,x       ; address the first unused packet byte
                    clra                ; use zero as the historical padding byte
PadPartialBlock     sta       ,x+       ; pad one missing data position
                    leay      $01,y     ; include it in the packet byte count
                    cmpy      #128      ; detect a completely padded data field
                    bcs       PadPartialBlock ; fill through all 128 packet bytes
                    leax      <PacketData,u ; return to the start of packet data
PacketDataReady     clr       >PacketChecksum,u ; initialize the modulo-256 checksum
                    ldb       #128      ; sum every data byte exactly once
SumNextDataByte     lda       ,x+       ; fetch the next packet data byte
                    adda      >PacketChecksum,u ; accumulate it modulo 256
                    sta       >PacketChecksum,u ; retain the running checksum
                    decb                ; account for one summed byte
                    bne       SumNextDataByte ; cover the complete data field

* transmit SOH, block number, complement, data, and checksum as one 132-byte
* write.  NAK repeats unchanged bytes; ACK advances; ctrl-x cancels.
SendPacket          leax      <PacketStart,u ; select the contiguous packet frame
                    ldy       #132      ; include the header, data, and checksum
                    lda       #1        ; direct the frame to the communications path
                    os9       I$Write   ; transmit one checksum-XMODEM packet
                    leax      ReceiverByte,u ; receive its acknowledgment
                    ldy       #1        ; read one receiver-control byte
                    clra                ; select standard input
                    os9       I$Read    ; wait synchronously for the packet response
                    lda       ReceiverByte,u ; classify the response
                    cmpa      #21       ; nak requests the identical packet again
                    beq       SendPacket ; retry without rereading or renumbering
                    cmpa      #6        ; ack accepts this packet
                    beq       PacketAccepted ; advance to the next source block
                    cmpa      #24       ; ctrl-x cancels the transfer
                    beq       TransferFailed ; display the failure result
                    lda       #1        ; use status one for any unknown response
                    bra       ExitWithStatus ; restore terminal input and return immediately
PacketAccepted      lda       <BlockNumber,u ; fetch the acknowledged block number
                    inca                ; advance modulo 256
                    sta       <BlockNumber,u ; number the next packet
                    coma                ; form its required complement
                    sta       <InverseBlockNumber,u ; keep the packet header self-checking
                    bra       ReadNextBlock ; fetch the following source data

* normal source EOF is followed by EOT and a mandatory ACK.  Unlike packet
* NAK handling, an unacknowledged EOT is not retried.
SourceReadEnded     cmpb      #211      ; recognize OS-9 end-of-file as transfer completion
                    lbne      ExitWithStatus ; propagate an actual source read error
                    leax      >EndOfTransferByte,pc ; select the EOT marker
                    ldy       #1        ; send exactly one control byte
                    lda       #1        ; direct EOT to the communications path
                    os9       I$Write   ; terminate the packet stream
                    leax      ReceiverByte,u ; receive the final acknowledgment
                    ldy       #1        ; read one control byte
                    clra                ; select standard input
                    os9       I$Read    ; wait for the receiver's EOT response
                    lda       ReceiverByte,u ; classify the final response
                    cmpa      #6        ; require ACK to declare success
                    bne       TransferFailed ; treat every other response as failure
                    leax      >SuccessText,pc ; prepare the completion message
                    ldy       #200      ; allow WritLn to stop at its CR
                    lda       #1        ; direct the message to the terminal
                    os9       I$WritLn  ; report a receiver-acknowledged transfer
                    bra       ExitAfterMessage ; share successful status setup
TransferFailed      leax      >FailureText,pc ; prepare the failure message
                    ldy       #200      ; allow WritLn to stop at its CR
                    lda       #1        ; direct the message to the terminal
                    os9       I$WritLn  ; report cancellation or handshake failure
ExitAfterMessage    clrb                ; historical message paths both return status zero
ExitWithStatus      pshs      b         ; preserve the selected status during terminal cleanup
                    bsr       RestoreTerminalInput ; restore the modified terminal option byte
                    puls      b         ; recover the final process status
                    os9       F$Exit    ; return success or the preserved I/O error
RestoreTerminalInput leax      >TerminalOptions,u ; address the saved ss.opt packet
                    leax      -$20,x    ; reproduce its original packet-relative indexing
                    lda       #1        ; restore option byte four to one
                    sta       <$0024,x  ; re-enable the terminal behavior disabled at startup
                    leax      >TerminalOptions,u ; select the restored options packet
                    clra                ; target standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply the restored terminal configuration
                    rts                 ; return to status-preserving exit cleanup

* unreachable 6809 decimal-parser image retained byte-for-byte from the original
* module.  No live branch or call enters it.  The encoded routine scans forward
* to a run of ASCII digits, walks that run backward, and builds a 16-bit value by
* repeated addition.  Its temporaries overlap SizeShiftCounter, DecimalRemainder,
* and DecimalDivisor, which are otherwise used by the live formatter below.
EmbeddedDecimalParser fcb       $34       ; encoded pshs y parser prologue
                    fcb       $20
                    fcb       $A6
                    fcb       $80
                    fcb       $81
                    fcb       $30
                    fcb       $25
                    fcb       $FA
                    fcb       $81
                    fcb       $39
                    fcb       $22
                    fcb       $F6
                    fcb       $30
                    fcb       $1F
                    fcb       $A6
                    fcb       $80
                    fcb       $81
                    fcb       $30
                    fcb       $25
                    fcb       $06
                    fcb       $81
                    fcb       $39
                    fcb       $22
                    fcb       $02
                    fcb       $20
                    fcb       $F4
                    fcb       $34
                    fcb       $10
                    fcb       $30
                    fcb       $1F
                    fcc       "oDoE"
                    fcb       $CC
                    fcb       $00
                    fcb       $01
                    fcb       $ED
                    fcb       $46
                    fcb       $A6
                    fcb       $82
                    fcb       $81
                    fcc       "0%."
                    fcb       $81
                    fcc       /9"*/
                    fcb       $80
                    fcb       $30
                    fcb       $A7
                    fcb       $43
                    fcb       $CC
                    fcb       $00
                    fcb       $00
                    fcc       "mC'"
                    fcb       $06
                    fcb       $E3
                    fcc       "FjC "
                    fcb       $F6
                    fcb       $E3
                    fcb       $44
                    fcb       $ED
                    fcb       $44
                    fcb       $86
                    fcb       $0A
                    fcb       $A7
                    fcb       $43
                    fcb       $CC
                    fcb       $00
                    fcb       $00
                    fcc       "mC'"
                    fcb       $06
                    fcb       $E3
                    fcc       "FjC "
                    fcb       $F6
                    fcb       $ED
                    fcb       $46
                    fcb       $20
                    fcb       $CC
                    fcb       $EC
                    fcb       $44
                    fcb       $35
                    fcb       $10
                    fcb       $35
                    fcb       $A0
* convert unsigned d to five zero-padded ASCII digits followed by CR at x.
* repeated subtraction avoids division support and leaves x after the result.
FormatDecimalNumber std       DecimalRemainder,u ; retain the unformatted block count
                    lda       #48       ; seed each display column with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       $01,x     ; initialize the thousands column
                    sta       $02,x     ; initialize the hundreds column
                    sta       $03,x     ; initialize the tens column
                    sta       $04,x     ; initialize the ones column
                    ldd       #10000    ; begin with the highest supported place
                    std       DecimalDivisor,u ; publish the ten-thousands divisor
                    ldd       DecimalRemainder,u ; recover the current remainder
                    lbsr      EmitDecimalDigit ; count ten-thousands by subtraction
                    ldd       #1000     ; select the thousands place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; count thousands by subtraction
                    ldd       #100      ; select the hundreds place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; count hundreds by subtraction
                    ldd       #10       ; select the tens place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current remainder
                    bsr       EmitDecimalDigit ; count tens by subtraction
                    ldd       #1        ; select the ones place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the final remainder
                    bsr       EmitDecimalDigit ; emit the ones digit
                    lda       #13       ; terminate the numeric field with CR
                    sta       ,x        ; append the terminator after five digits
                    rts                 ; return with the formatted field complete
EmitDecimalDigit    subd      DecimalDivisor,u ; test another unit of this decimal place
                    bcs       DecimalDigitComplete ; stop before the remainder underflows
                    inc       ,x        ; advance this ASCII digit by one
                    bra       EmitDecimalDigit ; count additional units of the same place
DecimalDigitComplete addd      DecimalDivisor,u ; undo the subtraction that underflowed
                    std       DecimalRemainder,u ; retain the remainder for the next place
                    leax      $01,x     ; advance to the following output digit
                    rts                 ; return with d and workspace holding the remainder

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
