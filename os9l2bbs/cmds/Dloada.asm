**********************************************************************
* Dloada - OS-9 Level 2 BBS command
*
* Syntax: Dloada [file]
* Purpose: Send a file as unframed ASCII data.
* Transfer engine selected by BBS.download.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded start gating, line transfer, and inter-line abort polling.
**********************************************************************

                    nam       Dloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

SourcePathNum       rmb       1
FilenameBuffer      rmb       32
TransferBuffer      rmb       1         ; also receives the single-byte abort poll
TransferBufferTail  rmb       599
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloada/ ; publish the transfer-engine module name
FilenamePrompt      fcc       "Enter filename to Download-->"
AbortNotice         fcc       "Press <SPACE> to abort"
                    fcb       $0D       ; terminate the abort instruction
BeginNotice         fcc       "Press <ENTER> to begin"
                    fcb       $0D       ; terminate the start instruction
StartControlByte    fcb       $18       ; emit ctrl-x immediately before file data
ExitSpaceByte       fcb       $20       ; emit a final space on every exit path

* first treat the command line as a pathname.  If it cannot be opened, prompt
* for a replacement name and propagate failure from that second attempt.
start               lda       #1        ; request read access to the supplied pathname
                    os9       I$Open    ; try the filename already addressed by x
                    bcs       PromptFilename ; interactively recover from a missing argument or bad path
                    bra       FileReady ; retain the successfully opened source
PromptFilename      leax      >FilenamePrompt,pc ; prepare the inline filename prompt
                    ldy       #29       ; write its exact unterminated length
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor ready for input
                    leax      FilenameBuffer,u ; receive a replacement pathname
                    ldy       #32       ; enforce the allocated filename limit
                    clra                ; select standard input
                    os9       I$ReadLn  ; read the CR-terminated filename
                    leax      FilenameBuffer,u ; select the entered pathname
                    lda       #1        ; request read access
                    os9       I$Open    ; open the interactively selected source
                    lbcs      ExitWithStatus ; preserve the open error if recovery fails
FileReady           sta       SourcePathNum,u ; retain the source-file path number
                    leax      >AbortNotice,pc ; prepare the transfer cancellation instruction
                    ldy       #200      ; allow I$WritLn to stop at its CR
                    lda       #1        ; direct instructions to the terminal
                    os9       I$WritLn  ; explain the space-bar abort key
                    leax      >BeginNotice,pc ; prepare the explicit start instruction
                    ldy       #200      ; allow I$WritLn to stop at its CR
                    os9       I$WritLn  ; require confirmation before sending file bytes

* wait indefinitely for enter; space cancels cleanly and every other byte is
* ignored.  The historical ctrl-x byte marks the beginning of outbound data.
WaitForStart        leax      <TransferBuffer,u ; reuse the first transfer byte for keyboard input
                    ldy       #1        ; read one decision byte
                    clra                ; select standard input
                    os9       I$Read    ; wait for the user's start or abort key
                    lda       <TransferBuffer,u ; inspect the received byte
                    cmpa      #32       ; recognize space as cancellation
                    lbeq      TransferComplete ; leave without transmitting source data
                    cmpa      #13       ; recognize carriage return as confirmation
                    bne       WaitForStart ; ignore unrelated input
                    leax      >StartControlByte,pc ; select the historical ctrl-x transfer marker
                    ldy       #1        ; send only that marker byte
                    os9       I$Write   ; announce the start to the receiving terminal

* transfer CR-terminated source lines.  After each complete line, SS.Ready
* polls standard input without blocking; a queued space aborts between lines.
SendNextLine        lda       SourcePathNum,u ; select the source file
                    leax      <TransferBuffer,u ; receive the next outbound line
                    ldy       #200      ; limit each line read to the active buffer window
                    os9       I$ReadLn  ; fetch through the source carriage return
                    bcs       TransferComplete ; treat source EOF or read failure as completion
                    lda       #1        ; select terminal output
                    os9       I$WritLn  ; transmit the complete source line
                    clra                ; select standard input for the readiness query
                    ldb       #1        ; request the ready-byte count
                    os9       I$GetStt  ; test whether an abort key is waiting
                    bcs       SendNextLine ; continue immediately when no input is queued
                    ldy       #1        ; consume exactly one queued key
                    leax      <TransferBuffer,u ; reuse the transfer buffer for the key
                    os9       I$Read    ; remove the queued byte from terminal input
                    lda       ,x        ; inspect the possible abort key
                    cmpa      #32       ; recognize only space as an inter-line abort
                    bne       SendNextLine ; discard other queued keys and keep sending
TransferComplete    clrb                ; make EOF and user cancellation successful
ExitWithStatus      pshs      b         ; preserve success or the earlier open error during cleanup
                    leax      >ExitSpaceByte,pc ; select the historical trailing space
                    ldy       #1        ; emit exactly one cleanup byte
                    lda       #1        ; direct cleanup to the terminal
                    os9       I$Write   ; leave the receiver with the expected trailing space
                    puls      b         ; restore the final process status
                    os9       F$Exit    ; return success or the preserved open failure

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
