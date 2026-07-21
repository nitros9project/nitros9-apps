**********************************************************************
* bbs.form - OS-9 Level 2 BBS command
*
* syntax: BBS.form <form> <output>
* purpose: prompt for every field in a form definition and write the collected answers.
* used by new-user and other configurable data-entry workflows.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
*          2026/07/21  Codex
* enabled echo and automatic linefeed on redirected interactive input.
**********************************************************************

                    nam       BBS.Form
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $02       ; interactive terminal-options revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

OutputPath          rmb       1         ; append/create path for completed form records
FormPath            rmb       1         ; sequential input path for the form definition
ConfirmationKey     rmb       1         ; one-byte answer to the final correctness question
FormArgument        rmb       2         ; start of the first command-line pathname
AnswerCursor        rmb       2         ; next free byte in the assembled prompt/answer record
ReservedFormWorkspace rmb       400       ; retained gap in the original workspace layout
AnswersStart        rmb       1         ; first byte of the 7,780-byte response buffer
AnswerBufferTail    rmb       7779      ; remainder of the response buffer
TerminalOptions     rmb       32        ; SS.Opt packet kept last to preserve existing workspace offsets
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.Form/ ; os-9 module name
RecordSeparator     fcc       "------------------------------------------" ; separates appended submissions
                    fcb       C$CR      ; make the separator writable as a line
ConfirmationPrompt  fcc       "Is all information correct?" ; final review question
PromptNewline       fcb       C$LF,C$CR ; move below the one-byte confirmation response

* split the two pathnames in place. X lands on the output pathname after the space.
start               lbsr      InitializeTerminalInput ; configure the stdin supplied by Shellplus </1
                    stx       FormArgument,u ; retain the form-definition pathname
FindOutputArgument  lda       ,x+       ; scan the first pathname for its separator
                    cmpa      #C$SPAC   ; recognize the start of argument two
                    bne       FindOutputArgument ; continue through the form pathname
                    lda       #C$CR     ; terminate argument one for I$Open
                    sta       -1,x      ; replace the separating space in the parameter block

* append to an existing results file, or create it when this is the first submission.
                    lda       #WRITE.   ; request the historical output access mode
                    os9       I$Open    ; open the output pathname now at X
                    lbcs      CreateOutputFile ; create it when no writable file exists
                    sta       OutputPath,u ; retain the existing results path
                    ldb       #SS.Size  ; obtain its 32-bit length for append positioning
                    pshs      u         ; protect the workspace while U holds the low size word
                    os9       I$GetStt  ; return the output size in X:U
                    os9       I$Seek    ; position after all previous submissions
                    puls      u         ; recover the workspace pointer
                    bra       OpenFormDefinition ; begin reading the form
CreateOutputFile    ldb       #27       ; preserve the original output attribute byte
                    os9       I$Create  ; create a new results file using mode A
                    lbcs      ExitWithStatus ; return creation errors unchanged
                    sta       OutputPath,u ; retain the new results path

OpenFormDefinition  ldx       FormArgument,u ; recover the now CR-terminated form pathname
                    lda       #READ.    ; definitions are never modified
                    os9       I$Open    ; open the prompt stream
                    lbcs      ExitWithStatus ; return definition-file errors unchanged
                    sta       FormPath,u ; retain the sequential form path
                    leax      >AnswersStart,u ; begin assembling the combined record
                    stx       AnswerCursor,u ; initialize the next-free-byte pointer

* each definition line is copied into the result buffer, shown without its CR, and
* followed in place by the caller's CR-terminated answer. This preserves prompt context
* in the output record instead of saving a bare sequence of answers.
ReadNextPrompt      lda       FormPath,u ; select the form definition
                    ldx       AnswerCursor,u ; append at the current result-buffer end
                    ldy       #200      ; cap each individual prompt line
                    os9       I$ReadLn  ; copy the next prompt into the result buffer
                    lbcs      ConfirmAnswers ; eof completes one review pass
                    leay      -1,y      ; omit the stored CR from terminal output
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the prompt without moving to another line
                    tfr       y,d       ; convert the visible prompt length to an offset
                    leax      d,x       ; overwrite its buffered CR with the forthcoming answer
                    ldy       #200      ; cap the caller's response line
                    clra                ; select standard input
                    os9       I$ReadLn  ; append the answer, including its CR
                    tfr       y,d       ; convert the answer length to an offset
                    leax      d,x       ; advance beyond the completed prompt/answer pair
                    stx       AnswerCursor,u ; retain the next append position
                    bra       ReadNextPrompt ; ask the next form question

ConfirmAnswers      leax      >ConfirmationPrompt,pc ; ask whether the assembled record is correct
                    ldy       #27       ; write the visible question without a terminator
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor ready for a one-key answer
                    leax      ConfirmationKey,u ; receive that answer
                    clra                ; select standard input
                    ldy       #1        ; consume exactly one key
                    os9       I$Read    ; read without requiring a full line
                    leax      >PromptNewline,pc ; restore a clean terminal line
                    ldy       #2        ; emit LF followed by CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; move below the confirmation response
                    lda       ConfirmationKey,u ; inspect the caller's choice
                    anda      #$DF      ; compare ASCII without regard to case
                    cmpa      #'Y'      ; only yes commits the record
                    beq       AppendCompletedRecord ; all other keys restart the form

* retry from the beginning without touching the output file.
                    leax      >AnswersStart,u ; discard the in-memory draft logically
                    stx       AnswerCursor,u ; reset the append pointer
                    lda       FormPath,u ; select the definition stream
                    pshs      u         ; protect the workspace while U becomes an offset
                    ldu       #0        ; form offset zero's low word
                    ldx       #0        ; form offset zero's high word
                    os9       I$Seek    ; rewind the form to its first prompt
                    lbcs      ExitWithStatus ; return a rewind failure
                    puls      u         ; recover the workspace pointer
                    lbra      ReadNextPrompt ; collect a replacement response set

* write exactly the bytes accumulated between AnswersStart and AnswerCursor, then
* append a visual separator so multiple submissions remain readable.
AppendCompletedRecord leax      >AnswersStart,u ; select the completed response record
                    pshs      x         ; retain its start while calculating its length
                    ldd       AnswerCursor,u ; recover the exclusive end address
                    subd      ,s        ; derive the accumulated byte count
                    tfr       d,y       ; supply that count to I$Write
                    puls      x         ; recover the record start
                    lda       OutputPath,u ; select the append-positioned results file
                    os9       I$Write   ; commit the prompt/answer record
                    leax      >RecordSeparator,pc ; delimit it from the next submission
                    ldy       #200      ; let I$WritLn stop at the separator's CR
                    os9       I$WritLn  ; append the separator to the same output path
                    clrb                ; report successful collection
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

* Enable the SCF behavior required for form answers and confirmation input.
InitializeTerminalInput
                    pshs      y,x,d     ; preserve the caller's startup registers
                    leax      >TerminalOptions,u ; select the local terminal-option packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt terminal options
                    os9       I$GetStt  ; copy the current path options into the packet
                    bcs       InitializeTerminalDone ; tolerate stdin paths that are not SCF devices
                    lda       #1        ; select the enabled value for both options
                    sta       PD.EKO-PD.OPT,x ; make typed form responses visible
                    sta       PD.ALF-PD.OPT,x ; advance after echoed carriage returns
                    leax      >TerminalOptions,u ; resubmit the modified packet
                    clra                ; update standard input
                    clrb                ; select SS.Opt terminal options
                    os9       I$SetStt  ; install the interactive input settings
InitializeTerminalDone
                    puls      pc,y,x,d  ; restore the caller and continue

                    emod      ;         append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end       ;         finish this assembly unit
