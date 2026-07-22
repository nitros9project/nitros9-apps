**********************************************************************
* Uloada - OS-9 Level 2 BBS command
*
* Syntax: Uloada [file]
* Purpose: Receive an ASCII upload until the protocol terminating character.
* Transfer engine selected by BBS.upload.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded character capture, line prompting, and terminal control keys.
**********************************************************************

                    nam       Uloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

OutputPathNum       rmb       1
FilenameBuffer      rmb       200
InputByte           rmb       1
UnusedTailBuffer    rmb       599
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloada/ ; publish the transfer-engine module name
FilenamePrompt      fcc       "Enter filename to upload"
TransferInstructions fcc       "Press <CTRL><T> to terminal upload"
                    fcb       $0A
                    fcb       $0D
                    fcc       "Press <CTRL><X> to cancel"
                    fcb       $0A
                    fcb       $0D       ; terminate the two-line control-key notice
LinePrompt          fcb       $0A
                    fcb       $3A       ; prompt each incoming line with line feed and colon

* use a command-line filename when supplied; otherwise collect one from the
* terminal.  Creation truncates an existing file and returns a read/write path.
start               lda       ,x        ; inspect the first pathname character
                    cmpa      #13       ; recognize an empty child command line
                    bne       CreateOutputFile ; use the caller-supplied filename directly
                    leax      >FilenamePrompt,pc ; prepare the inline filename prompt
                    ldy       #24       ; write the exact unterminated prompt
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor ready for input
                    leax      FilenameBuffer,u ; receive the destination pathname
                    ldy       #200      ; retain the original generous filename limit
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect the CR-terminated filename
                    leax      FilenameBuffer,u ; select the interactively entered pathname
CreateOutputFile    lda       #3        ; request read/write access to the new file
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create or truncate the upload destination
                    lbcs      ExitWithStatus ; return the create failure unchanged
                    sta       OutputPathNum,u ; retain the destination path number
                    leax      >TransferInstructions,pc ; prepare the completion and cancel keys
                    ldy       #63       ; write the full two-line instruction block
                    lda       #1        ; direct instructions to the terminal
                    os9       I$Write   ; explain ctrl-t completion and ctrl-x cancellation
                    leax      >LinePrompt,pc ; prepare the first terminal-upload prompt
                    ldy       #2        ; emit its line feed and colon
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; mark the start of captured text

* poll SS.Ready, consume one terminal byte, and append it immediately.  Ctrl-T
* ends successfully; ctrl-X exits with status one and leaves the partial file.
WaitForInput        clra                ; select standard input for the readiness query
                    ldb       #1        ; request the ready-byte count
                    os9       I$GetStt  ; avoid blocking inside the subsequent read
                    bcs       WaitForInput ; continue polling until a byte is available
                    ldy       #1        ; consume exactly one terminal byte
                    leax      >InputByte,u ; receive it in the single-byte work area
                    os9       I$Read    ; remove the available byte from terminal input
                    lda       ,x        ; classify the byte before storing it
                    cmpa      #20       ; ctrl-t terminates a completed terminal upload
                    beq       CompleteUpload ; omit the control byte and report success
                    cmpa      #24       ; ctrl-x cancels the upload
                    beq       CancelUpload ; omit the control byte and report status one
                    lda       OutputPathNum,u ; select the upload destination
                    os9       I$Write   ; append the ordinary byte exactly as received
                    lda       ,x        ; recover the captured byte after the path write
                    cmpa      #13       ; detect the end of an entered text line
                    beq       PromptNextLine ; display another line marker after CR
                    bra       WaitForInput ; capture the next byte without extra terminal output
PromptNextLine      leax      >LinePrompt,pc ; select the line-feed-and-colon marker
                    ldy       #2        ; write both marker bytes
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; identify the beginning of another captured line
                    bra       WaitForInput ; resume character capture
CancelUpload        lda       #1        ; return the package's cancellation status
                    bra       ExitWithStatus ; leave the partial destination in place
CompleteUpload      clrb                ; report a ctrl-t-terminated upload as successful
ExitWithStatus      os9       F$Exit    ; return success, cancellation, or a create error

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
