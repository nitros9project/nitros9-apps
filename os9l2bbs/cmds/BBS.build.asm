**********************************************************************
* BBS.build - OS-9 Level 2 BBS command
*
* Syntax: BBS.build <file>
* Purpose: Create a text file with the BBS interactive line editor.
* The editor supports list, edit, continue, done, and abort operations.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Enabled echo and automatic linefeed on redirected interactive input.
**********************************************************************

                    nam       BBS.build
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $02       ; interactive terminal-options revision

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

OutputPathNum       rmb       2
DigitValue          rmb       1
EditorInputByte     rmb       1
EditorCarryLength   rmb       1
OutputNamePtr       rmb       2
DescriptionLineCount rmb       1
DescriptionLineCountLow rmb       1
ListLineNumber      rmb       2
NumericValue        rmb       1
NumericValueLow     rmb       1
DecimalPlaceValue   rmb       2
SelectedLineNumber  rmb       2
LineNumberText      rmb       3
EditorCarryBuffer   rmb       80
TerminalOptionScratch rmb       32
LongDescriptionBuffer rmb       1
LongDescriptionBufferTail rmb       8199
TerminalOptions     rmb       32        ; keep the SS.Opt packet last to preserve workspace offsets
size                equ       .

name                fcs       /BBS.build/
                    fcc       "Copyright (C) 1988"
                    fcc       "By Keith Alphonso"
                    fcc       "Licenced to Alpha Software Technologies"
                    fcc       "All rights reserved"
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
MessageEntryPrompt  fcb       $0A
                    fcb       $0A
                    fcc       "    Please enter message now            (Blank line ends)"
                    fcb       $0D
MessageRule         fcc       "----------------------------------------------------------------"
                    fcb       $0D
CompositionPrompt   fcb       $0A
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist"
                    fcb       $0D
EditLinePrompt      fcc       "Enter line #"
                    fcb       $0D
PromptMarker        fcc       ">"
PromptReturn        fcb       $0A
                    fcb       $0D
EraseSequence       fcb       $08
                    fcb       $20
                    fcb       $08

start               lbsr      InitializeTerminalInput ; configure the stdin supplied by Shellplus </1
                    stx       OutputNamePtr,u ; retain output name ptr
                    lda       #2        ; request write access for the new text file
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the requested output file
                    lbcs      ErrExit   ; select err exit when carry reports an error or underflow
                    sta       OutputPathNum,u ; retain output path num
                    leax      >MessageEntryPrompt,pc ; select message entry prompt
                    ldy       #200      ; let WritLn stop at the embedded CR
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ErrExit   ; select err exit when carry reports an error or underflow
                    leax      >MessageRule,pc ; select message rule
                    ldy       #80       ; preserve the original overlong write bound
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ErrExit   ; select err exit when carry reports an error or underflow
                    ldd       #0        ; initialize description line count to 0
                    std       DescriptionLineCount,u ; retain description line count
                    sta       EditorCarryLength,u ; begin with no wrapped carry text
ReadDescriptionLines ldd       DescriptionLineCount,u ; recover description line count
                    addd      #1        ; advance to the next 80-byte line slot
                    std       DescriptionLineCount,u ; retain description line count
                    cmpd      #99       ; stop before the 100-line editor limit
                    bge       PromptCompositionAction ; continue with prompt composition action at or above the signed limit
                    lbsr      ReadLongDescriptionLine ; edit one logical description line
                    cmpy      #1        ; detect a blank CR-only line
                    bls       PromptCompositionAction ; ask again at prompt composition action
                    bra       ReadDescriptionLines ; continue collecting description text

PromptCompositionAction leax      >CompositionPrompt,pc ; select composition prompt
                    ldy       #200      ; allow I$WritLn to find the menu terminator
                    lda       #1        ; direct the menu to the terminal
                    os9       I$WritLn  ; display the review choices
                    leax      >PromptMarker,pc ; place a marker before the one-key choice
                    ldy       #1        ; emit only the marker byte
                    os9       I$Write   ; leave the cursor after the marker
                    leax      EditorInputByte,u ; receive the review menu keystroke
                    clra                ; read from standard input
                    ldy       #1        ; accept exactly one choice byte
                    os9       I$Read    ; wait for the review action
                    leax      >PromptReturn,pc ; advance the terminal after the choice
                    ldy       #1        ; emit one line-control byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; move below the entered choice
                    lda       EditorInputByte,u ; recover the raw choice
                    anda      #223      ; fold lowercase ASCII to uppercase
                    cmpa      #'A       ; test for abort
                    lbeq      AbortAndDelete ; select abort and delete when the requested case matches
                    cmpa      #68       ; test for done
                    lbeq      CommitFile ; select commit file when the requested case matches
                    cmpa      #69       ; test for edit
                    beq       EditDescription ; replace a selected line
                    cmpa      #67       ; test for continue
                    beq       ContinueDescription ; reopen entry at the current end
                    cmpa      #76       ; test for list
                    beq       ListDescription ; enter list description when the terminating condition is met
                    bra       PromptCompositionAction ; continue with prompt composition action

ContinueDescription ldd       DescriptionLineCount,u ; recover description line count
                    subd      #1        ; reopen the prior terminator slot
                    std       DescriptionLineCount,u ; retain description line count
                    bra       ReadDescriptionLines ; resume multiline entry

EditDescription     leax      >EditLinePrompt,pc ; ask which buffered line to replace
                    ldy       #200      ; allow I$WritLn to find the prompt terminator
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; request a line number
                    leax      >PromptMarker,pc ; place a marker before numeric input
                    ldy       #1        ; emit only the marker byte
                    os9       I$Write   ; leave the cursor on the response line
                    clra                ; read from standard input
                    leax      <LineNumberText,u ; select line number text
                    ldy       #3        ; bound the line-number response
                    os9       I$ReadLn  ; collect the requested line number
                    lbsr      ParseDecimal ; convert its decimal digit run to D
                    cmpd      DescriptionLineCount,u ; test against description line count
                    lbcc      PromptCompositionAction ; ask again at prompt composition action
                    std       SelectedLineNumber,u ; retain selected line number
                    leax      <LineNumberText,u ; select line number text
                    lbsr      FormatTwoDigit ; render D as two decimal digits
                    leax      <LineNumberText,u ; select line number text
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; complete the displayed line-number prefix
                    ldy       #3        ; emit two digits and colon
                    lda       #1        ; direct the prefix to the terminal
                    os9       I$Write   ; label the existing selected line
                    ldd       SelectedLineNumber,u ; recover selected line number
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    lda       #80       ; convert line index to byte offset
                    mul                 ; form the byte-product in D
                    leax      d,x       ; address the selected line
                    ldy       #80       ; bound display at one line slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; show the text that will be edited
                    tfr       y,d       ; recover the displayed line length
                    stb       EditorCarryLength,u ; retain editor carry length
                    dec       EditorCarryLength,u ; exclude the terminating CR
                    leay      <EditorCarryBuffer,u ; select editor carry buffer
CopyEditedLineToScratch lda       ,x+       ; consume the next byte while copy edited line to scratch
                    sta       ,y+       ; append it to the prefill buffer
                    decb                ; count one copied character
                    bne       CopyEditedLineToScratch ; retain the entire existing line
                    ldd       SelectedLineNumber,u ; recover selected line number
                    bsr       ReadLongDescriptionLine ; re-edit that line in place
                    lbra      PromptCompositionAction ; continue with prompt composition action

ListDescription     ldd       #0        ; initialize description line count to 0
                    std       DescriptionLineCount,u ; retain description line count
ListEachLine        ldd       DescriptionLineCount,u ; recover description line count
                    addd      #1        ; advance to the next displayed line number
                    std       DescriptionLineCount,u ; retain description line count
                    leax      <LineNumberText,u ; select line number text
                    lbsr      FormatTwoDigit ; render the current line number
                    leax      <LineNumberText,u ; select line number text
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; replace the formatter's CR with colon
                    lda       #1        ; direct the prefix to the terminal
                    ldy       #3        ; emit two digits and colon
                    os9       I$Write   ; label the line being displayed
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    ldd       DescriptionLineCount,u ; recover description line count
                    lda       #80       ; convert it to an array byte offset
                    mul                 ; form the byte-product in D
                    leax      d,x       ; address the line to display
                    ldy       #80       ; bound the display at one array slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; display until its stored CR
                    cmpy      #1        ; detect the blank terminator line
                    bhi       ListEachLine ; continue list each line while the range test permits it
                    lbra      PromptCompositionAction ; continue with prompt composition action

ReadLongDescriptionLine leax      <LineNumberText,u ; select line number text
                    pshs      d         ; preserve the array index across formatting
                    lbsr      FormatTwoDigit ; render the line number as two digits
                    leax      <LineNumberText,u ; select line number text
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; replace the formatter's CR with colon
                    lda       #1        ; direct the prefix to the terminal
                    ldy       #3        ; emit two digits and colon
                    os9       I$Write   ; label the interactive line
                    lbcs      ErrExit   ; select err exit when carry reports an error or underflow
                    leax      <EditorCarryBuffer,u ; select editor carry buffer
                    ldb       EditorCarryLength,u ; obtain its byte count
                    clra                ; extend the count to a word
                    tfr       d,y       ; use that count for terminal prefill output
                    lda       #1        ; direct retained text to the terminal
                    os9       I$Write   ; prefill the interactive line display
                    puls      d         ; recover the array index
                    lda       #80       ; convert it to an array byte offset
                    mul                 ; form the byte-product in D
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    leax      d,x       ; address the target line slot
                    leay      <EditorCarryBuffer,u ; select editor carry buffer
                    ldb       #80       ; track remaining capacity in the destination line
                    lda       EditorCarryLength,u ; determine whether prefill text exists
                    beq       NoCarryText ; enter the editor with an empty line
                    sta       NumericValue,u ; retain numeric value
CopyCarryText       lda       ,y+       ; fetch the next prefill byte
                    sta       ,x+       ; seed it into the target line
                    decb                ; reduce remaining line capacity
                    dec       NumericValue,u ; consume one numeric value
                    bne       CopyCarryText ; copy all retained text
NoCarryText         clra                ; extend remaining capacity to a word
                    tfr       d,y       ; pass capacity in Y to the line editor
                    lbsr      EditLine  ; accept interactive edits at X
                    rts                 ; return the edited line length in Y

CommitFile          lda       #0        ; begin writing with the first stored line
                    sta       ListLineNumber,u ; retain list line number
WriteDescriptionLines lda       ListLineNumber,u ; recover the output line index
                    inca                ; advance to the next line slot
                    sta       ListLineNumber,u ; retain list line number
                    cmpa      DescriptionLineCountLow,u ; test against description line count low
                    bhi       Exit      ; finish the command successfully
                    ldb       #80       ; convert the line number to a byte offset
                    mul                 ; form the byte-product in D
                    leax      >LongDescriptionBuffer,u ; start at the line array
                    leax      d,x       ; address the next output line
                    ldy       #80       ; bound output at one array slot
                    lda       OutputPathNum,u ; recover output path num
                    os9       I$WritLn  ; append one CR-terminated description line
                    lbcs      ErrExit   ; select err exit when carry reports an error or underflow
                    cmpy      #1        ; detect the blank terminator line
                    bls       Exit      ; finish the command successfully
                    tfr       y,d       ; preserve the original harmless length transfer
                    bra       WriteDescriptionLines ; append the next buffered line

Exit                clrb                ; report successful validation processing
ErrExit             os9       F$Exit    ; return success or the preserved OS-9 status

AbortAndDelete      lda       OutputPathNum,u ; recover output path num
                    os9       I$Close   ; close the selected path
                    ldx       OutputNamePtr,u ; recover output name ptr
                    lda       #1        ; supply 1 as the control, count, or argument value required here
                    os9       I$Delete  ; delete the path named at X
                    bcs       ErrExit   ; select err exit when carry reports an error or underflow
                    bra       Exit      ; continue with exit

EditLine            lbsr      DisableAutoEcho ; take control of character echoing
                    ldb       EditorCarryLength,u ; include wrapped or prefilled characters
                    leay      b,y       ; reconstruct the slot's original total capacity
stk_editor_capacity equ       0
                    pshs      y         ; retain the line's total editable capacity
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; restore remaining capacity after prefill
                    clr       EditorCarryLength,u ; consume the prefill state
                    cmpy      #0        ; detect an already full line
                    lbeq      FinishEditedLine ; terminate it without reading more input
                    pshs      y,x       ; preserve insertion state while padding
                    lda       #13       ; use CR as the unused-slot sentinel
PadEditorBuffer     sta       ,x+       ; mark the next unused character position
                    leay      -$01,y    ; count one padded byte
                    bne       PadEditorBuffer ; initialize the entire unused tail
                    puls      y,x       ; restore insertion pointer and capacity
ReadEditorChar      pshs      y,x       ; protect editor state during terminal I/O
                    leax      EditorInputByte,u ; receive one keystroke in workspace
                    ldy       #1        ; request exactly one byte
                    clra                ; read from standard input
                    os9       I$Read    ; wait for the next editing command or character
                    bcs       IgnoreEditorInput ; ignore transient terminal read errors
                    lda       EditorInputByte,u ; classify the received byte
                    cmpa      #1        ; ctrl-A advances through existing text
                    beq       HandleCursorRight ; reveal the next stored character
                    cmpa      #8        ; backspace deletes one character
                    beq       HandleBackspace ; erase when not at the left boundary
                    cmpa      #24       ; ctrl-X clears backward to the line start
                    beq       HandleCtrlX ; repeat the backspace action
                    cmpa      #13       ; carriage return accepts the current line
                    lbeq      AcceptEditedLine ; terminate the buffer and return its length
                    cmpa      #32       ; reject other control characters
                    bcs       IgnoreEditorInput ; wait for another meaningful byte
                    lda       #1        ; echo printable input to the terminal
                    os9       I$Write   ; display the staged input byte
                    puls      y,x       ; recover insertion state
                    lda       EditorInputByte,u ; recover the accepted printable byte
                    sta       ,x+       ; append it to the line buffer
                    leay      -$01,y    ; consume one byte of remaining capacity
                    lbeq      EditorBufferFull ; wrap cleanly when column 80 is filled
                    bra       ReadEditorChar ; continue interactive entry

IgnoreEditorInput   puls      y,x       ; discard I/O-temporary state
                    bra       ReadEditorChar ; wait for another key

HandleCursorRight   puls      y,x       ; recover current insertion state
                    leay      -$01,y    ; reserve one more displayed character
                    beq       EditorAtRightEdge ; refuse motion beyond column 80
                    lda       ,x+       ; inspect the next preexisting character
                    cmpa      #13       ; stop at the stored line terminator
                    beq       CursorReachedReturn ; leave the cursor before the CR
                    pshs      y,x       ; preserve advanced editor state during echo
                    leax      -$01,x    ; point at the character just traversed
                    ldy       #1        ; echo exactly that character
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; visually advance through existing text
                    bra       HandleCursorRight ; recover state through the common path

CursorReachedReturn leax      -$01,x    ; back up over the unconsumed terminator
EditorAtRightEdge   leay      $01,y     ; undo the speculative capacity decrement
                    lbra      ReadEditorChar ; resume input at the valid cursor position

HandleBackspace     puls      y,x       ; recover current insertion state
                    leay      $01,y     ; reclaim one byte of line capacity
                    cmpy      stk_editor_capacity,s ; test against the original left edge
                    bhi       RejectDeleteAtStart ; select reject delete at start above the unsigned boundary
                    pshs      y,x       ; protect updated state during terminal erase
                    leax      >EraseSequence,pc ; choose backspace-space-backspace
                    ldy       #3        ; emit the full visual erase sequence
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; remove one displayed character
                    puls      y,x       ; recover updated editor state
                    leax      -$01,x    ; move the insertion pointer left one byte
                    lbra      ReadEditorChar ; continue editing

RejectDeleteAtStart leay      -$01,y    ; undo the invalid capacity increment
                    lbra      ReadEditorChar ; ignore deletion at the left edge

HandleCtrlX         puls      y,x       ; recover current insertion state
                    leay      $01,y     ; reclaim one byte as for backspace
                    cmpy      stk_editor_capacity,s ; test against the original left edge
                    bhi       RejectDeleteAtStart ; select reject delete at start above the unsigned boundary
                    pshs      y,x       ; protect state during visual erase
                    leax      >EraseSequence,pc ; choose backspace-space-backspace
                    ldy       #3        ; emit the complete erase sequence
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; erase one displayed character
                    puls      y,x       ; recover updated state
                    leax      -$01,x    ; move the insertion pointer left
                    cmpy      stk_editor_capacity,s ; see whether the left edge was reached
                    lbhi      ReadEditorChar ; continue read editor char while the range test permits it
                    pshs      y,x       ; recreate the I/O-state shape for another erase
                    bra       HandleCtrlX ; continue clearing toward the left edge

AcceptEditedLine    puls      y,x       ; recover state from the input read
FinishEditedLine    lda       #13       ; terminate the edited line with CR
                    sta       ,x+       ; store the logical line terminator
                    pshs      y,x       ; protect final editor state during output
                    leax      >PromptReturn,pc ; move the terminal to a fresh line
                    ldy       #1        ; output only the leading line-control byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; finish the interactive edit display
                    puls      y,x       ; recover final state
                    puls      d         ; recover the original capacity
stk_editor_remaining equ       0
                    pshs      y         ; expose remaining capacity for subtraction
                    subd      stk_editor_remaining,s ; derive bytes used from total minus remaining
                    leas      $02,s     ; discard the temporary remaining-capacity word
                    tfr       d,y       ; return the accepted line length in Y
                    leay      $01,y     ; include the stored CR terminator
                    lbsr      EnableAutoEcho ; restore normal terminal echo
                    rts                 ; return the completed line and its length

                    fcc       "50"

EditorBufferFull    puls      d         ; recover the original capacity
stk_full_remaining  equ       0
                    pshs      y         ; expose remaining capacity for length arithmetic
                    subd      stk_full_remaining,s ; derive the filled line length
                    leas      $02,s     ; discard the temporary remaining-capacity word
                    addd      #1        ; include the position following the full line
                    tfr       d,y       ; scan backward across the entered text
                    clrb                ; count characters moved to the next line
TrimTrailingSpaces  leay      -$01,y    ; count one candidate character from the right
                    beq       PrintTrimmedLine ; emit an unsplittable full line
                    lda       ,-x       ; inspect the previous entered character
                    cmpa      #32       ; search for the last word boundary
                    beq       SplitAtSpace ; wrap the suffix after that space
                    pshs      y,x       ; protect scan state during visual erase
                    leax      >EraseSequence,pc ; choose backspace-space-backspace
                    ldy       #3        ; emit one visual deletion
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; erase the suffix character from the display
                    incb                ; count one byte moved to carryover
                    puls      y,x       ; recover the backward scan
                    bra       TrimTrailingSpaces ; keep searching for a space

PrintTrimmedLine    lda       #13       ; terminate the full unsplittable line
                    sta       <$004F,x  ; place CR at its fixed final column
                    ldy       #200      ; allow I$WritLn to find that terminator
                    lda       #1        ; direct the completed line to the terminal
                    os9       I$WritLn  ; advance after automatic line completion
                    puls      y         ; discard the saved original capacity
                    rts                 ; return with no carryover text

SplitAtSpace        lda       #13       ; terminate the line at the word boundary
                    sta       ,x+       ; replace the separating space with CR
                    pshs      y,x       ; preserve split position and return length
                    stb       EditorCarryLength,u ; retain editor carry length
                    leay      <EditorCarryBuffer,u ; select editor carry buffer
CopyRemainder       lda       ,x+       ; fetch the next wrapped character
                    sta       ,y+       ; append it to carryover storage
                    decb                ; count one suffix byte copied
                    bne       CopyRemainder ; preserve the complete wrapped word
                    leax      >PromptReturn,pc ; advance the terminal after wrapping
                    ldy       #1        ; emit one line-control byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; begin the next visual line
                    puls      y,x       ; recover split state
                    lbsr      EnableAutoEcho ; restore normal terminal input behavior
                    rts                 ; return the shortened line and carryover suffix

DisableAutoEcho     pshs      y,x,d     ; preserve the caller's working registers
                    leax      <TerminalOptionScratch,u ; select terminal option scratch
                    clra                ; select standard input
                    ldb       #0        ; select SS.Opt
                    os9       I$GetStt  ; fetch the current terminal options
                    leax      -$20,x    ; address the packet's base
                    clr       <$0024,x  ; disable automatic input echo
                    leax      <$0020,x  ; restore the option-packet pointer expected by OS-9
                    os9       I$SetStt  ; apply explicit-echo editing mode
                    puls      pc,y,x,d  ; restore registers and return

EnableAutoEcho      pshs      y,x,d     ; preserve the caller's working registers
                    leax      <TerminalOptionScratch,u ; select terminal option scratch
                    clra                ; select standard input
                    ldb       #0        ; select SS.Opt
                    os9       I$GetStt  ; fetch the current terminal options
                    leax      -$20,x    ; address the packet's base
                    lda       #1        ; select enabled echo
                    sta       <$0024,x  ; restore automatic input echo
                    leax      <$0020,x  ; restore the OS-9 option-packet pointer
                    clra                ; apply options to standard input
                    os9       I$SetStt  ; return the terminal to normal echo behavior
                    puls      pc,y,x,d  ; restore registers and return

ParseDecimal        pshs      y         ; preserve the caller's y
FindFirstDigit      lda       ,x+       ; scan the next response byte
                    cmpa      #13       ; stop when no digit run was present
                    lbeq      NoDecimalDigits ; report an invalid line number
                    cmpa      #48       ; ignore bytes below ASCII zero
                    bcs       FindFirstDigit ; continue searching
                    cmpa      #57       ; ignore bytes above ASCII nine
                    bhi       FindFirstDigit ; continue find first digit while the range test permits it
                    leax      -$01,x    ; return to the first digit
FindDigitRunEnd     lda       ,x+       ; locate the byte following the digit run
                    cmpa      #48       ; stop below ASCII zero
                    bcs       ParseDigitRun ; convert the complete run
                    cmpa      #57       ; stop above ASCII nine
                    bhi       ParseDigitRun ; continue parse digit run while the range test permits it
                    bra       FindDigitRunEnd ; continue across decimal digits

ParseDigitRun       pshs      x         ; retain the caller's post-run pointer
                    leax      -$01,x    ; begin with the least-significant digit
                    clr       NumericValue,u ; initialize numeric value
                    clr       NumericValueLow,u ; initialize numeric value low
                    ldd       #1        ; initialize decimal place value to 1
                    std       DecimalPlaceValue,u ; retain decimal place value
AccumulatePreviousDigit lda       ,-x       ; recover
                    cmpa      #48       ; finish before the digit run
                    bcs       ReturnNumericValue ; return the accumulated value
                    cmpa      #57       ; guard the upper digit boundary
                    bhi       ReturnNumericValue ; select return numeric value above the unsigned boundary
                    suba      #48       ; subtract from a using #48
                    sta       DigitValue,u ; retain the remaining multiplier count
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
MultiplyDigitByPlace tst       DigitValue,u ; test whether all copies were accumulated
                    beq       AddDigitValue ; merge this digit's contribution
                    addd      DecimalPlaceValue,u ; add to d using DecimalPlaceValue,u
                    dec       DigitValue,u ; consume one multiplier unit
                    bra       MultiplyDigitByPlace ; implement digit multiplication by addition

AddDigitValue       addd      NumericValue,u ; add to d using NumericValue,u
                    std       NumericValue,u ; retain numeric value
                    lda       #10       ; prepare to multiply the place by ten
                    sta       DigitValue,u ; set the repeated-addition count
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
MultiplyPlaceByTen  tst       DigitValue,u ; test whether ten copies were accumulated
                    beq       SaveNextDecimalPlace ; retain the next power of ten
                    addd      DecimalPlaceValue,u ; add to d using DecimalPlaceValue,u
                    dec       DigitValue,u ; consume one of the ten copies
                    bra       MultiplyPlaceByTen ; complete multiplication by ten

SaveNextDecimalPlace std       DecimalPlaceValue,u ; retain decimal place value
                    bra       AccumulatePreviousDigit ; consume the next digit to the left
ReturnNumericValue  ldd       NumericValue,u ; recover numeric value
                    puls      x         ; restore the caller's post-run pointer
                    puls      pc,y      ; restore y and return

FormatTwoDigit      pshs      y         ; preserve the caller's y
                    std       NumericValue,u ; retain numeric value
                    lda       #48       ; initialize both output digits to ASCII zero
                    sta       ,x        ; seed the tens digit
                    sta       $01,x     ; seed the units digit
                    ldd       #10       ; select the line-feed control byte
                    std       DecimalPlaceValue,u ; retain decimal place value
                    ldd       NumericValue,u ; recover numeric value
                    bsr       EmitDecimalDigit ; count tens into the first digit
                    ldd       #1        ; initialize decimal place value to 1
                    std       DecimalPlaceValue,u ; retain decimal place value
                    ldd       NumericValue,u ; recover numeric value
                    bsr       EmitDecimalDigit ; count units into the second digit
                    lda       #13       ; terminate the formatted prefix
                    sta       ,x        ; append CR after the two digits
                    puls      pc,y      ; restore y and return

EmitDecimalDigit    subd      DecimalPlaceValue,u ; subtract from d using DecimalPlaceValue,u
                    bcs       RestoreDivisionRemainder ; stop when subtraction underflows
                    inc       ,x        ; increment this ASCII output digit
                    bra       EmitDecimalDigit ; count another divisor unit

RestoreDivisionRemainder addd      DecimalPlaceValue,u ; add to d using DecimalPlaceValue,u
                    std       NumericValue,u ; retain numeric value
                    leax      $01,x     ; advance to the next output position
                    rts                 ; return the remainder in workspace

NoDecimalDigits     ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,y      ; restore y and return

* Enable the SCF behavior required by the interactive line editor.
InitializeTerminalInput
                    pshs      y,x,d     ; preserve the caller's startup registers
                    leax      >TerminalOptions,u ; select the local terminal-option packet
                    clra                ; select standard input
                    clrb                ; request SS.Opt terminal options
                    os9       I$GetStt  ; copy the current path options into the packet
                    bcs       InitializeTerminalDone ; tolerate stdin paths that are not SCF devices
                    lda       #1        ; select the enabled value for both options
                    sta       PD.EKO-PD.OPT,x ; make typed editor input visible
                    sta       PD.ALF-PD.OPT,x ; advance after echoed carriage returns
                    leax      >TerminalOptions,u ; resubmit the modified packet
                    clra                ; update standard input
                    clrb                ; select SS.Opt terminal options
                    os9       I$SetStt  ; install the interactive input settings
InitializeTerminalDone
                    puls      pc,y,x,d  ; restore the caller and continue

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
