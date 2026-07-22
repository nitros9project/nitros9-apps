**********************************************************************
* Dloadxc - OS-9 Level 2 BBS command
*
* Syntax: Dloadxc [file]
* Purpose: Send XMODEM blocks protected by CRC-16.
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
* Decoded negotiated checksum/CRC framing and CRC-16 generation.
**********************************************************************

                    nam       Dloadxc
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
UseChecksumFlag     rmb       1         ; nonzero for checksum, zero for CRC-16
CrcByteCounter      rmb       1
CrcBitCounterArea   rmb       2
SizeShiftCounter    rmb       1
DecimalRemainder    rmb       2
DecimalDivisor      rmb       2
BlockCountText      rmb       10
* contiguous checksum/CRC XMODEM frame
PacketStart         rmb       1
BlockNumber         rmb       1
InverseBlockNumber  rmb       1
PacketData          rmb       128
PacketCheckHigh     rmb       1         ; checksum byte or CRC high byte
PacketCheckLow      rmb       1         ; crc low byte, omitted in checksum mode
FilenameBuffer      rmb       32
FilenamePointer     rmb       2
TerminalOptions     rmb       1         ; 32-byte ss.opt packet begins here
TerminalOptionsTail rmb       231
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloadxc/ ; publish the transfer-engine module name
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
FilenamePromptLength fcb       $00
                    fcb       $1D
ReadyText           fcc       "File open, ready to send..."
                    fcb       $0D
SuccessText         fcc       "File transfer successful"
                    fcb       $0D
FailureText         fcc       "File transfer unsuccessful"
                    fcb       $0D
AbortText           fcc       "Press <CTRL><X> to abort"
                    fcb       $0D
EndOfTransferByte   fcb       $04
BlankLine           fcb       $0A
                    fcb       $0D
BlockCountLabel     fcc       "Total number of blocks to download:"
* default to checksum mode until the receiver explicitly requests CRC-16, then
* preserve and modify standard-input options for raw protocol bytes.
ConfigureTerminalInput lda       #255      ; default to checksum framing until the receiver requests CRC-16
                    sta       UseChecksumFlag,u ; retain the negotiated protection mode
                    leax      >TerminalOptions,u ; select the saved 32-byte ss.opt packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$GetStt  ; preserve the caller's terminal configuration
                    leax      -$20,x    ; use the original packet-relative addressing pattern
                    clr       <$0024,x  ; clear option byte four for raw protocol input
                    leax      >TerminalOptions,u ; select the saved 32-byte ss.opt packet
                    clra                ; target standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply raw-input behavior
                    rts                 ; return with the saved packet in workspace
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
* "C" negotiates CRC-16, NAK accepts checksum fallback, and ctrl-x cancels.
WaitForReceiverStart leax      ReceiverByte,u ; receive one receiver-control byte
                    ldy       #1        ; read exactly one byte
                    clra                ; select standard input
                    os9       I$Read    ; wait synchronously for receiver negotiation
                    lda       ReceiverByte,u ; classify the received control byte
                    cmpa      #67       ; recognize the receiver CRC-mode request
                    beq       SelectCrcMode ; clear the checksum fallback flag
                    cmpa      #24       ; ctrl-x cancels before the first packet
                    lbeq      TransferFailed ; report the cancelled transfer
                    cmpa      #21       ; nak requests checksum-XMODEM startup
                    bne       WaitForReceiverStart ; ignore all other negotiation bytes
                    bra       InitializePacket ; initialize the common SOH and block-number header
SelectCrcMode       clr       UseChecksumFlag,u ; select two-byte CRC-16 framing
InitializePacket    lda       #1        ; initialize SOH and block number one
                    sta       <PacketStart,u ; place SOH at packet byte zero
                    sta       <BlockNumber,u ; number the first packet one
                    coma                ; form the required ones-complement block number
                    sta       <InverseBlockNumber,u ; complete the three-byte packet header
ReadNextBlock       leax      <PacketData,u ; receive data directly into the packet body
                    ldy       #128      ; request one XMODEM data block
                    lda       SourcePathNum,u ; select the source file
                    os9       I$Read    ; fill as much of the next packet as remains
                    lbcs      SourceReadEnded ; finish normally only when the read status is EOF
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
* checksum mode sums data modulo 256.  CRC mode applies polynomial $1021 to
* each of the 1024 data bits, starting from a zero remainder.
PacketDataReady     tst       UseChecksumFlag,u ; choose the negotiated frame-check algorithm
                    beq       ComputeCrc16 ; generate the two-byte CRC when requested
                    clr       >PacketCheckHigh,u ; initialize the one-byte checksum
                    ldb       #128      ; sum every data byte exactly once
SumNextDataByte     lda       ,x+       ; fetch the next packet data byte
                    adda      >PacketCheckHigh,u ; add to a using >PacketCheckHigh,u
                    sta       >PacketCheckHigh,u ; retain the running frame check
                    decb                ; account for one summed byte
                    bne       SumNextDataByte ; cover the complete data field
                    bra       FrameCheckReady ; transmit the completed checksum byte
ComputeCrc16        ldd       #0        ; initialize the CRC-16 remainder
                    std       >PacketCheckHigh,u ; retain the 16-bit CRC remainder
                    lda       #128      ; cover all 128 data bytes
                    sta       CrcByteCounter,u ; cover all 128 packet data bytes
CrcNextDataByte     lda       ,x+       ; fetch the next packet data byte
                    clrb                ; place the injected data byte in the high half of d
                    eora      >PacketCheckHigh,u ; inject the data byte into the CRC high byte
                    eorb      >PacketCheckLow,u ; combine it with the low remainder byte
                    std       >PacketCheckHigh,u ; retain the 16-bit CRC remainder
                    lda       #8        ; process eight bits from this data byte
                    sta       CrcBitCounterArea,u ; process eight bits for this data byte
CrcNextBit          lda       >PacketCheckHigh,u ; test the remainder high bit for polynomial feedback
                    bita      #128      ; test selected bits in a using #128
                    beq       CrcShiftOnly ; omit polynomial feedback when the outgoing bit is clear
                    ldd       >PacketCheckHigh,u ; fetch the complete CRC remainder
                    aslb                ; shift the CRC remainder toward its outgoing bit
                    rola                ; complete the 16-bit left shift through carry
                    eora      #16       ; apply the high byte of polynomial $1021
                    eorb      #33       ; apply the low byte of polynomial $1021
                    std       >PacketCheckHigh,u ; retain the 16-bit CRC remainder
                    bra       CrcBitComplete ; join the common bit-counter path
CrcShiftOnly        aslb                ; shift the CRC remainder toward its outgoing bit
                    rola                ; complete the 16-bit left shift through carry
                    std       >PacketCheckHigh,u ; retain the 16-bit CRC remainder
CrcBitComplete      dec       CrcBitCounterArea,u ; account for one processed bit
                    bne       CrcNextBit ; complete all eight bits of this data byte
                    dec       CrcByteCounter,u ; account for one protected data byte
                    bne       CrcNextDataByte ; process every byte in the packet body
                    ldd       >PacketCheckHigh,u ; fetch the complete CRC remainder
FrameCheckReady     leax      <PacketStart,u ; select the contiguous packet frame
                    tst       UseChecksumFlag,u ; choose the negotiated frame-check algorithm
                    beq       UseCrcFrameLength ; include both CRC bytes in the transmitted frame
                    ldy       #132      ; include the header, data, and checksum
                    bra       TransmitPacket ; use the common frame write
UseCrcFrameLength   ldy       #133      ; send header, data, and the two-byte CRC
TransmitPacket      lda       #1        ; direct the frame to the communications path
                    os9       I$Write   ; transmit one checksum-XMODEM packet
                    leax      ReceiverByte,u ; receive its acknowledgment
                    ldy       #1        ; read one receiver-control byte
                    clra                ; select standard input
                    os9       I$Read    ; wait synchronously for the packet response
                    lda       ReceiverByte,u ; classify the response
                    cmpa      #21       ; nak requests the identical packet again
                    beq       FrameCheckReady ; resend the unchanged protected frame after NAK
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
                    lbra      ReadNextBlock ; fetch data for the next acknowledged block
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
RestoreTerminalInput leax      >TerminalOptions,u ; select the saved 32-byte ss.opt packet
                    leax      -$20,x    ; reproduce its original packet-relative indexing
                    lda       #1        ; restore option byte four to one
                    sta       <$0024,x  ; re-enable the terminal behavior disabled at startup
                    leax      >TerminalOptions,u ; select the saved 32-byte ss.opt packet
                    clra                ; target standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply the restored terminal configuration
                    rts                 ; return to status-preserving exit cleanup

* unreachable 6809 decimal-parser image retained byte-for-byte from the original
* module. It scans an ASCII digit run and accumulates a 16-bit value by repeated
* addition; no live branch or call enters it.
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
                    fcc       "oGoH"
                    fcb       $CC
                    fcb       $00
                    fcb       $01
                    fcb       $ED
                    fcb       $49
                    fcb       $A6
                    fcb       $82
                    fcb       $81
                    fcc       "0%."
                    fcb       $81
                    fcc       /9"*/
                    fcb       $80
                    fcb       $30
                    fcb       $A7
                    fcb       $45
                    fcb       $CC
                    fcb       $00
                    fcb       $00
                    fcc       "mE'"
                    fcb       $06
                    fcb       $E3
                    fcc       "IjE "
                    fcb       $F6
                    fcb       $E3
                    fcb       $47
                    fcb       $ED
                    fcb       $47
                    fcb       $86
                    fcb       $0A
                    fcb       $A7
                    fcb       $45
                    fcb       $CC
                    fcb       $00
                    fcb       $00
                    fcc       "mE'"
                    fcb       $06
                    fcb       $E3
                    fcc       "IjE "
                    fcb       $F6
                    fcb       $ED
                    fcb       $49
                    fcb       $20
                    fcb       $CC
                    fcb       $EC
                    fcb       $47
                    fcb       $35
                    fcb       $10
                    fcb       $35
                    fcb       $A0
FormatDecimalNumber std       DecimalRemainder,u ; retain the unformatted block count
                    lda       #48       ; seed each display column with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       $01,x     ; initialize the thousands column
                    sta       $02,x     ; initialize the hundreds column
                    sta       $03,x     ; initialize the tens column
                    sta       $04,x     ; initialize the ones column
                    ldd       #10000    ; select the ten-thousands place
                    std       DecimalDivisor,u ; publish the ten-thousands divisor
                    ldd       DecimalRemainder,u ; recover the current decimal remainder
                    lbsr      EmitDecimalDigit ; count ten-thousands by subtraction
                    ldd       #1000     ; select the thousands place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current decimal remainder
                    bsr       EmitDecimalDigit ; count thousands by subtraction
                    ldd       #100      ; select the hundreds place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current decimal remainder
                    bsr       EmitDecimalDigit ; count hundreds by subtraction
                    ldd       #10       ; select the tens place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current decimal remainder
                    bsr       EmitDecimalDigit ; count tens by subtraction
                    ldd       #1        ; select the ones place
                    std       DecimalDivisor,u ; publish its divisor
                    ldd       DecimalRemainder,u ; recover the current decimal remainder
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
