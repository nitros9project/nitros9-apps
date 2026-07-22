**********************************************************************
* DLD.add - OS-9 Level 2 BBS command
*
* Syntax: DLD.add [directory]
* Purpose: Register a file copied into a download directory outside BBS.upload.
* Updates DLD.lst, DLD.dsc, and DLD.key.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded catalog allocation, metadata entry, and line-editor support.
**********************************************************************

                    nam       DLD.add
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; define a program-object module
atrv                set       ReEnt+rev ; mark the module reentrant at revision one
rev                 set       $01       ; retain the original module revision

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

EditorInputByte     rmb       1
DldListPathNum      rmb       1
KeywordPathNum      rmb       1
DescriptionPathNum  rmb       1
EditorCarryLength   rmb       1
EditorCarryBuffer   rmb       80
TerminalOptions     rmb       32
* one 96-byte DLD.lst record
DldFilename         rmb       27
DescriptionOffsetHigh rmb       2
DescriptionOffsetLow rmb       2
ValidationFlag      rmb       1
ShortDescription    rmb       64
* overlapping 96-byte catalog scan buffer
DldScanRecord       rmb       31
DldScanRecordTail   rmb       65
KeywordBuffer       rmb       12
KeywordCatalogOffsetHigh rmb       2
KeywordCatalogOffsetLow rmb       2
CatalogWriteOffsetHigh rmb       2
CatalogWriteOffsetLow rmb       3         ; first word is the low offset
DigitValue          rmb       1
DescriptionLineCount rmb       1
DescriptionLineCountLow rmb       1
ListLineNumber      rmb       2
NumericValue        rmb       1
NumericValueLow     rmb       1
DecimalPlaceValue   rmb       2
SelectedLineNumber  rmb       2
LineNumberText      rmb       3
LongDescriptionBuffer rmb       1
LongDescriptionBufferTail rmb       8399      ; completes 105 editable 80-byte lines
size                equ       .         ; reserve the complete per-process workspace

name                fcs       /DLD.add/ ; publish the command name in the module header
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
FilenamePrompt      fcc       "Enter filename to add:"
DldListName         fcc       "DLD.lst"
                    fcb       $0D
KeywordFileName     fcc       "DLD.key"
                    fcb       $0D
DescriptionFileName fcc       "DLD.dsc"
                    fcb       $0D
                    fcb       $0D
                    fcb       $0A
ShortDescriptionPrompt fcc       "Enter a one-line description of this file"
                    fcb       $0D
SeparatorLine       fcc       "----------------------------------------------------------------"
                    fcb       $0D
PromptMarker        fcb       $3E
                    fcb       $0D
KeywordHeading      fcc       "     Enter file keywords now            (Blank line ends)"
                    fcb       $0D
LongDescriptionHeading fcb       $0A
                    fcb       $0A
                    fcc       "   Enter long description now          (Blank line ends)"
                    fcb       $0D
KeywordPrompt       fcc       "Enter keyword:"
ReviewMenu          fcb       $0A
                    fcc       "[D]one [E]dit [C]ontinue or [L]ist"
                    fcb       $0D
PromptReturn        fcb       $0A
                    fcb       $0D
EditLinePrompt      fcc       "Enter line #"
                    fcb       $0D
EraseSequence       fcb       $08
                    fcb       $20
                    fcb       $08
* Open or create the three coordinated catalog streams in the selected directory.
start               lda       ,x        ; inspect the optional download-directory argument
                    cmpa      #13       ; recognize a bare invocation
                    beq       OpenCatalogFiles ; keep the current execution directory when absent
                    lda       #1        ; select execution-directory semantics
                    os9       I$ChgDir  ; enter the directory whose catalog is being extended
                    lbcs      ExitWithStatus ; preserve a directory-change failure
OpenCatalogFiles    leax      >DldListName,pc ; select the fixed-record master catalog
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open an existing DLD.lst
                    bcc       DldListReady ; retain the open path
                    cmpb      #216      ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing master catalog
                    lbcs      ExitWithStatus ; preserve a creation failure
DldListReady        sta       DldListPathNum,u ; retain the DLD.lst path number
                    leax      >KeywordFileName,pc ; select the keyword stream
                    lda       #2        ; request update access
                    os9       I$Open    ; open an existing DLD.key
                    bcc       KeywordFileReady ; retain the open path
                    cmpb      #216      ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing keyword stream
                    lbcs      ExitWithStatus ; preserve a creation failure
KeywordFileReady    sta       KeywordPathNum,u ; retain the DLD.key path number
                    leax      >DescriptionFileName,pc ; select the long-description stream
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open an existing DLD.dsc
                    bcc       DescriptionFileReady ; retain the open path
                    cmpb      #216      ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing description stream
                    lbcs      ExitWithStatus ; preserve a creation failure
DescriptionFileReady sta       DescriptionPathNum,u ; retain the DLD.dsc path number
                    leax      >FilenamePrompt,pc ; point at the filename prompt
                    ldy       #22       ; emit its exact byte count
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; ask which file should be registered
                    leax      <DldFilename,u ; receive the catalog filename field
                    ldy       #27       ; enforce the field's maximum length
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the CR-terminated filename
* First pass rejects a duplicate and remembers the append offset.
ScanDuplicateFilename lda       DldListPathNum,u ; select the master catalog
                    leax      >DldScanRecord,u ; receive one 96-byte record
                    ldy       #96       ; preserve the fixed catalog stride
                    os9       I$Read    ; fetch the next registered filename
                    bcs       DldListScanEnded ; distinguish end-of-file from a read error
                    leay      <DldFilename,u ; compare against the requested filename
CompareFilenameLoop lda       ,x+       ; fetch the next stored filename byte
                    cmpa      ,y+       ; compare it with the requested name
                    bne       ScanDuplicateFilename ; advance when the names differ
                    cmpa      #13       ; detect a complete matching filename
                    beq       DuplicateFound ; reject an existing catalog entry
                    bra       CompareFilenameLoop ; continue across the common prefix
DuplicateFound      ldb       #218      ; report the package's duplicate-name error
                    lbra      ExitWithStatus ; leave all catalogs unchanged
DldListScanEnded    cmpb      #211      ; accept only normal end-of-file
                    lbne      ExitWithStatus ; preserve an actual catalog read error
                    lda       DldListPathNum,u ; select DLD.lst
                    ldb       #5        ; request its current 32-bit position
stk_catalog_workspace equ       0         ; workspace u saved at the current stack top
                    pshs      u         ; preserve workspace while GetStat returns offset in u
                    os9       I$GetStt  ; obtain the append position after the last record
                    tfr       u,y       ; preserve the low offset word across stack restoration
                    puls      u         ; recover workspace access
                    stx       >CatalogWriteOffsetHigh,u ; save the append offset high word
                    sty       >CatalogWriteOffsetLow,u ; save the append offset low word
                    ldx       #0        ; clear the high rewind offset
                    pshs      u         ; preserve workspace during the seek
                    ldu       #0        ; clear the low rewind offset
                    os9       I$Seek    ; rewind DLD.lst for the reusable-slot pass
                    puls      u         ; recover workspace access
FindReusableRecord  lda       DldListPathNum,u ; select the rewound catalog
                    leax      >DldScanRecord,u ; receive the next record
                    ldy       #96       ; preserve the fixed record size
                    os9       I$Read    ; scan for a reusable slot
                    bcs       NoReusableRecord ; append when no reusable record exists
                    lda       >DldScanRecordTail,u ; inspect byte 31, the validation state
                    cmpa      #1        ; identify the package's reusable-slot marker
                    bne       FindReusableRecord ; skip active records
                    lda       DldListPathNum,u ; select the catalog stream
                    ldb       #5        ; request its current 32-bit position
stk_reuse_workspace equ       0         ; workspace u saved at the current stack top
                    pshs      u         ; preserve workspace while GetStat returns offset in u
                    os9       I$GetStt  ; obtain the position after the reusable record
                    tfr       u,d       ; move the low offset word for subtraction
                    subd      #96       ; back up to the beginning of the reusable record
                    bge       HaveDldWriteOffset ; retain the high word when no borrow occurs
                    leax      -$01,x    ; propagate the low-word borrow
HaveDldWriteOffset  tfr       d,u       ; install the calculated low seek word
                    ldy       stk_reuse_workspace,s ; recover workspace access without popping
                    lda       $01,y     ; recover the DLD.lst path number
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      ExitWithStatus ; preserve a seek failure
                    tfr       u,y       ; preserve the low reusable-record offset
                    puls      u         ; recover workspace access
                    stx       >CatalogWriteOffsetHigh,u ; record the chosen slot's high offset
                    sty       >CatalogWriteOffsetLow,u ; record the chosen slot's low offset
                    bra       CollectMetadata ; overwrite the reusable slot
NoReusableRecord    cmpb      #211      ; accept only normal end-of-file
                    lbne      ExitWithStatus ; preserve an actual scan error
CollectMetadata     leax      >ShortDescriptionPrompt,pc ; ask for the summary stored in DLD.lst
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; introduce the one-line description field
                    leax      >PromptMarker,pc ; place a marker on the input line
                    ldy       #1        ; emit only the marker byte
                    os9       I$Write   ; leave the cursor after the marker
                    leax      >ShortDescription,u ; receive the 64-byte summary field
                    ldy       #64       ; enforce the catalog field size
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the CR-terminated summary
                    lda       #255      ; select the manual-add validation state
                    sta       >ValidationFlag,u ; mark this catalog entry for later validation
                    leax      <DldFilename,u ; retain a pointer to the record while seeking
                    lda       DescriptionPathNum,u ; select DLD.dsc
                    ldb       #2        ; request the stream's current size
                    pshs      u         ; preserve workspace while GetStat returns size in x:u
                    os9       I$GetStt  ; obtain the description append offset
                    lbcs      ExitWithStatus ; preserve a size-query failure
                    os9       I$Seek    ; position DLD.dsc at its current end
                    lbcs      ExitWithStatus ; preserve a seek failure
                    tfr       u,y       ; preserve the low description offset
                    puls      u         ; recover workspace access
                    stx       >DescriptionOffsetHigh,u ; store the description pointer's high word
                    sty       >DescriptionOffsetLow,u ; store the description pointer's low word
                    ldy       #96       ; write one complete master-catalog record
                    leax      <DldFilename,u ; select the prepared record
                    lda       DldListPathNum,u ; select DLD.lst at the chosen slot
                    os9       I$Write   ; commit filename, description pointer, state, and summary
                    lda       KeywordPathNum,u ; select DLD.key
                    ldb       #2        ; request the stream's current size
                    pshs      u         ; preserve workspace while GetStat returns size in x:u
                    os9       I$GetStt  ; obtain the keyword append offset
                    lbcs      ExitWithStatus ; preserve a size-query failure
                    os9       I$Seek    ; position DLD.key at its current end
                    lbcs      ExitWithStatus ; preserve a seek failure
                    puls      u         ; recover workspace access
                    leax      >KeywordHeading,pc ; introduce repeated keyword entry
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; direct the heading to the terminal
                    os9       I$WritLn  ; introduce keyword entry
                    leax      >SeparatorLine,pc ; underline the keyword heading
                    ldy       #65       ; emit the complete separator including CR
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; display the section divider
                    ldd       >CatalogWriteOffsetHigh,u ; fetch the target DLD.lst record offset
                    std       >KeywordCatalogOffsetHigh,u ; attach its high word to each keyword
                    ldd       >CatalogWriteOffsetLow,u ; fetch the offset's low word
                    std       >KeywordCatalogOffsetLow,u ; complete the keyword-to-record link
PromptKeyword       leax      >KeywordPrompt,pc ; ask for the next search term
                    ldy       #14       ; emit the exact prompt length
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor on the keyword line
                    leax      >KeywordBuffer,u ; receive the 12-byte keyword field
                    ldy       #12       ; enforce the keyword field size
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect one CR-terminated keyword
                    lbcs      PromptKeyword ; retry after a terminal input error
                    cmpy      #1        ; recognize a blank line
                    lbls      BeginLongDescription ; end keyword entry on blank input
                    lda       KeywordPathNum,u ; select DLD.key
                    ldy       #16       ; write keyword plus four-byte catalog offset
                    os9       I$Write   ; append one keyword index record
                    bra       PromptKeyword ; accept another search term
BeginLongDescription leax      >LongDescriptionHeading,pc ; introduce the multiline description editor
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; direct the heading to the terminal
                    os9       I$WritLn  ; explain that a blank line ends entry
                    lbcs      ExitWithStatus ; preserve a heading-output failure
                    leax      >SeparatorLine,pc ; underline the description heading
                    ldy       #80       ; preserve the original overlong write bound
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ExitWithStatus ; preserve a separator-output failure
                    ldd       #0        ; initialize the 16-bit line count
                    std       >DescriptionLineCount,u ; begin before the first description line
                    sta       EditorCarryLength,u ; begin with no wrapped carry text
ReadDescriptionLines ldd       >DescriptionLineCount,u ; obtain the current line index
                    addd      #1        ; advance to the next 80-byte line slot
                    std       >DescriptionLineCount,u ; retain the new line count
                    cmpd      #99       ; reserve the editor's original maximum of 99 lines
                    bge       ReviewDescription ; stop when the buffer limit is reached
                    lbsr      ReadLongDescriptionLine ; edit one logical description line
                    cmpy      #1        ; detect a blank CR-only line
                    bls       ReviewDescription ; finish initial entry on blank input
                    bra       ReadDescriptionLines ; continue collecting description text
ReviewDescription   leax      >ReviewMenu,pc ; offer completion and revision actions
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
                    anda      #223      ; make the review menu case-insensitive
                    cmpa      #68       ; test for done
                    lbeq      FinishDescription ; commit the edited lines to DLD.dsc
                    cmpa      #69       ; test for edit
                    beq       EditDescription ; replace a selected line
                    cmpa      #67       ; test for continue
                    beq       ContinueDescription ; reopen entry at the current end
                    cmpa      #76       ; test for list
                    lbeq      ListDescription ; display all buffered lines
                    bra       ReviewDescription ; reject an unrecognized choice
ContinueDescription ldd       >DescriptionLineCount,u ; recover the line following the last entry
                    subd      #1        ; reopen the prior terminator slot
                    std       >DescriptionLineCount,u ; make continued input overwrite that blank line
                    bra       ReadDescriptionLines ; resume multiline entry
EditDescription     leax      >EditLinePrompt,pc ; ask which buffered line to replace
                    ldy       #200      ; allow I$WritLn to find the prompt terminator
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; request a line number
                    leax      >PromptMarker,pc ; place a marker before numeric input
                    ldy       #1        ; emit only the marker byte
                    os9       I$Write   ; leave the cursor on the response line
                    clra                ; read from standard input
                    leax      >LineNumberText,u ; receive up to two digits plus CR
                    ldy       #3        ; bound the line-number response
                    os9       I$ReadLn  ; collect the requested line number
                    lbsr      ParseDecimal ; convert its decimal digit run to D
                    cmpd      >DescriptionLineCount,u ; require an existing line index
                    lbcc      ReviewDescription ; abandon an out-of-range edit
                    std       >SelectedLineNumber,u ; retain the selected buffer slot
                    leax      >LineNumberText,u ; format the selected line's prefix
                    lbsr      FormatTwoDigit ; render D as two decimal digits
                    leax      >LineNumberText,u ; append punctuation to the rendered prefix
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; complete the displayed line-number prefix
                    ldy       #3        ; emit two digits and colon
                    lda       #1        ; direct the prefix to the terminal
                    os9       I$Write   ; label the existing selected line
                    ldd       >SelectedLineNumber,u ; recover the zero-based line index
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    lda       #80       ; convert line index to byte offset
                    mul                 ; form index times the fixed 80-byte stride
                    leax      d,x       ; address the selected line
                    ldy       #80       ; bound display at one line slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; show the text that will be edited
                    tfr       y,d       ; recover the displayed line length
                    stb       EditorCarryLength,u ; preserve its content for editor prefill
                    dec       EditorCarryLength,u ; exclude the terminating CR
                    leay      EditorCarryBuffer,u ; select the editor prefill buffer
CopyEditedLineToScratch lda       ,x+       ; copy the next existing character
                    sta       ,y+       ; append it to the prefill buffer
                    decb                ; count one copied character
                    bne       CopyEditedLineToScratch ; retain the entire existing line
                    ldd       >SelectedLineNumber,u ; supply the selected array index
                    bsr       ReadLongDescriptionLine ; re-edit that line in place
                    lbra      ReviewDescription ; return to the review menu
ListDescription     ldd       #0        ; restart listing at line zero
                    std       >DescriptionLineCount,u ; reuse the count as a listing cursor
ListEachLine        ldd       >DescriptionLineCount,u ; obtain the current listing index
                    addd      #1        ; advance to the next displayed line number
                    std       >DescriptionLineCount,u ; retain the listing cursor
                    leax      >LineNumberText,u ; prepare this listing prefix
                    lbsr      FormatTwoDigit ; render the current line number
                    leax      >LineNumberText,u ; append punctuation to the prefix
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; replace the formatter's CR with colon
                    lda       #1        ; direct the prefix to the terminal
                    ldy       #3        ; emit two digits and colon
                    os9       I$Write   ; label the line being displayed
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    ldd       >DescriptionLineCount,u ; recover the current line number
                    lda       #80       ; convert it to an array byte offset
                    mul                 ; form line number times 80
                    leax      d,x       ; address the line to display
                    ldy       #80       ; bound the display at one array slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; display until its stored CR
                    cmpy      #1        ; detect the blank terminator line
                    bhi       ListEachLine ; continue while displayed content remains
                    lbra      ReviewDescription ; return after the complete listing
* Edit one 80-byte array slot. D supplies its zero-based line index.
ReadLongDescriptionLine leax      >LineNumberText,u ; prepare the displayed line prefix
                    pshs      d         ; preserve the array index across formatting
                    lbsr      FormatTwoDigit ; render the line number as two digits
                    leax      >LineNumberText,u ; append punctuation to the formatted prefix
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; replace the formatter's CR with colon
                    lda       #1        ; direct the prefix to the terminal
                    ldy       #3        ; emit two digits and colon
                    os9       I$Write   ; label the interactive line
                    lbcs      ExitWithStatus ; preserve a terminal-output failure
                    leax      EditorCarryBuffer,u ; select any text wrapped from the prior line
                    ldb       EditorCarryLength,u ; obtain its byte count
                    clra                ; extend the count to a word
                    tfr       d,y       ; use that count for terminal prefill output
                    lda       #1        ; direct retained text to the terminal
                    os9       I$Write   ; prefill the interactive line display
                    puls      d         ; recover the array index
                    lda       #80       ; convert it to an array byte offset
                    mul                 ; form index times the fixed line stride
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    leax      d,x       ; address the target line slot
                    leay      EditorCarryBuffer,u ; point at wrapped or prefilled text
                    ldb       #80       ; track remaining capacity in the destination line
                    lda       EditorCarryLength,u ; determine whether prefill text exists
                    beq       NoCarryText ; enter the editor with an empty line
                    sta       >NumericValue,u ; use the numeric scratch word as copy count
CopyCarryText       lda       ,y+       ; fetch the next prefill byte
                    sta       ,x+       ; seed it into the target line
                    decb                ; reduce remaining line capacity
                    dec       >NumericValue,u ; count one prefill byte copied
                    bne       CopyCarryText ; copy all retained text
NoCarryText         clra                ; extend remaining capacity to a word
                    tfr       d,y       ; pass capacity in Y to the line editor
                    lbsr      EditLine  ; accept interactive edits at X
                    rts                 ; return the edited line length in Y
FinishDescription   lda       #0        ; begin writing with the first stored line
                    sta       >ListLineNumber,u ; initialize the output line counter
WriteDescriptionLines lda       >ListLineNumber,u ; obtain the prior output line
                    inca                ; advance to the next line slot
                    sta       >ListLineNumber,u ; retain output progress
                    cmpa      >DescriptionLineCountLow,u ; stop after the final buffered line
                    bhi       ExitSuccessfully ; finish when every line was written
                    ldb       #80       ; convert the line number to a byte offset
                    mul                 ; form line number times the 80-byte stride
                    leax      >LongDescriptionBuffer,u ; start at the line array
                    leax      d,x       ; address the next output line
                    ldy       #80       ; bound output at one array slot
                    lda       DescriptionPathNum,u ; select DLD.dsc
                    os9       I$WritLn  ; append one CR-terminated description line
                    lbcs      ExitWithStatus ; preserve a description write failure
                    cmpy      #1        ; detect the blank terminator line
                    bls       ExitSuccessfully ; stop at the end of the logical description
                    tfr       y,d       ; preserve the original harmless length transfer
                    bra       WriteDescriptionLines ; append the next buffered line
ExitSuccessfully    clrb                ; report successful catalog addition
ExitWithStatus      os9       F$Exit    ; return success or the preserved OS-9 status
* In-place 80-column editor. X is insertion pointer and Y is remaining capacity.
EditLine            lbsr      DisableAutoEcho ; echo is handled explicitly for editing keys
                    ldb       EditorCarryLength,u ; include wrapped or prefilled characters
                    leay      b,y       ; reconstruct the slot's original total capacity
stk_editor_capacity equ       0         ; original capacity saved at the current stack top
                    pshs      y         ; retain the left boundary test for deletion
                    negb                ; form the negative prefill length
                    sex                 ; extend it for 16-bit capacity adjustment
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
                    cmpy      stk_editor_capacity,s ; enforce the left edge
                    bhi       RejectDeleteAtStart ; refuse deletion before the buffer start
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
                    cmpy      stk_editor_capacity,s ; test whether the left edge was crossed
                    bhi       RejectDeleteAtStart ; finish clearing at the buffer start
                    pshs      y,x       ; protect state during visual erase
                    leax      >EraseSequence,pc ; choose backspace-space-backspace
                    ldy       #3        ; emit the complete erase sequence
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; erase one displayed character
                    puls      y,x       ; recover updated state
                    leax      -$01,x    ; move the insertion pointer left
                    cmpy      stk_editor_capacity,s ; see whether the entire line is gone
                    lbhi      ReadEditorChar ; resume input once clearing is complete
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
stk_editor_remaining equ       0         ; current remaining capacity at stack top
                    pshs      y         ; expose remaining capacity for subtraction
                    subd      stk_editor_remaining,s ; calculate bytes consumed
                    leas      $02,s     ; discard the temporary remaining-capacity word
                    tfr       d,y       ; return the accepted line length in Y
                    leay      $01,y     ; include the stored CR terminator
                    lbsr      EnableAutoEcho ; restore normal terminal echo
                    rts                 ; return the completed line and its length
* Original unreachable bytes between the normal and full-buffer returns.
                    fcc       "50"
EditorBufferFull    puls      d         ; recover the original capacity
stk_full_remaining  equ       0         ; exhausted remaining capacity at stack top
                    pshs      y         ; expose remaining capacity for length arithmetic
                    subd      stk_full_remaining,s ; calculate the entered character count
                    leas      $02,s     ; discard the temporary stack word
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
                    incb                ; count one character for carryover
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
                    stb       EditorCarryLength,u ; retain the wrapped suffix length
                    leay      EditorCarryBuffer,u ; select carryover storage
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
                    leax      <TerminalOptions,u ; receive the standard-input option packet
                    clra                ; select standard input
                    ldb       #0        ; select SS.Opt
                    os9       I$GetStt  ; fetch the current terminal options
                    leax      -$20,x    ; address the packet's base
                    clr       <$0024,x  ; disable automatic input echo
                    leax      <$0020,x  ; restore the option-packet pointer expected by OS-9
                    os9       I$SetStt  ; apply explicit-echo editing mode
                    puls      pc,y,x,d  ; restore registers and return
EnableAutoEcho      pshs      y,x,d     ; preserve the caller's working registers
                    leax      <TerminalOptions,u ; receive the standard-input option packet
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
* Parse the first decimal digit run at X; return -1 when CR arrives first.
ParseDecimal        pshs      y         ; preserve the caller's y
FindFirstDigit      lda       ,x+       ; scan the next response byte
                    cmpa      #13       ; stop when no digit run was present
                    lbeq      NoDecimalDigits ; report an invalid line number
                    cmpa      #48       ; ignore bytes below ASCII zero
                    bcs       FindFirstDigit ; continue searching
                    cmpa      #57       ; ignore bytes above ASCII nine
                    bhi       FindFirstDigit ; continue searching
                    leax      -$01,x    ; return to the first digit
FindDigitRunEnd     lda       ,x+       ; locate the byte following the digit run
                    cmpa      #48       ; stop below ASCII zero
                    bcs       ParseDigitRun ; convert the complete run
                    cmpa      #57       ; stop above ASCII nine
                    bhi       ParseDigitRun ; convert the complete run
                    bra       FindDigitRunEnd ; continue across decimal digits
ParseDigitRun       pshs      x         ; retain the caller's post-run pointer
                    leax      -$01,x    ; begin with the least-significant digit
                    clr       >NumericValue,u ; initialize the high result byte
                    clr       >NumericValueLow,u ; initialize the low result byte
                    ldd       #1        ; begin at the units place
                    std       >DecimalPlaceValue,u ; retain the current power of ten
AccumulatePreviousDigit lda       ,-x       ; fetch the preceding digit right-to-left
                    cmpa      #48       ; finish before the digit run
                    bcs       ReturnNumericValue ; return the accumulated value
                    cmpa      #57       ; guard the upper digit boundary
                    bhi       ReturnNumericValue ; return the accumulated value
                    suba      #48       ; convert ASCII to a value from zero through nine
                    sta       >DigitValue,u ; retain this digit as an addition count
                    ldd       #0        ; initialize digit times place
MultiplyDigitByPlace tst       >DigitValue,u ; determine whether all additions are complete
                    beq       AddDigitValue ; merge this digit's contribution
                    addd      >DecimalPlaceValue,u ; add one copy of the current place
                    dec       >DigitValue,u ; count one copy
                    bra       MultiplyDigitByPlace ; implement digit multiplication by addition
AddDigitValue       addd      >NumericValue,u ; merge the digit into the accumulated result
                    std       >NumericValue,u ; retain the new numeric value
                    lda       #10       ; prepare to multiply the place by ten
                    sta       >DigitValue,u ; reuse the digit counter for ten additions
                    ldd       #0        ; initialize the next place value
MultiplyPlaceByTen  tst       >DigitValue,u ; determine whether ten copies were added
                    beq       SaveNextDecimalPlace ; retain the next power of ten
                    addd      >DecimalPlaceValue,u ; add one copy of the prior place
                    dec       >DigitValue,u ; count one copy
                    bra       MultiplyPlaceByTen ; complete multiplication by ten
SaveNextDecimalPlace std       >DecimalPlaceValue,u ; retain the next decimal place
                    bra       AccumulatePreviousDigit ; consume the next digit to the left
ReturnNumericValue  ldd       >NumericValue,u ; return the converted value in D
                    puls      x         ; restore the caller's post-run pointer
                    puls      pc,y      ; restore y and return
* Render the low two decimal digits of D at X, followed by CR.
FormatTwoDigit      pshs      y         ; preserve the caller's y
                    std       >NumericValue,u ; retain the value being formatted
                    lda       #48       ; initialize both output digits to ASCII zero
                    sta       ,x        ; seed the tens digit
                    sta       $01,x     ; seed the units digit
                    ldd       #10       ; select the tens divisor
                    std       >DecimalPlaceValue,u ; retain it for repeated subtraction
                    ldd       >NumericValue,u ; recover the remaining value
                    bsr       EmitDecimalDigit ; count tens into the first digit
                    ldd       #1        ; select the units divisor
                    std       >DecimalPlaceValue,u ; retain it for repeated subtraction
                    ldd       >NumericValue,u ; recover the remaining value
                    bsr       EmitDecimalDigit ; count units into the second digit
                    lda       #13       ; terminate the formatted prefix
                    sta       ,x        ; append CR after the two digits
                    puls      pc,y      ; restore y and return
EmitDecimalDigit    subd      >DecimalPlaceValue,u ; remove one divisor unit
                    bcs       RestoreDivisionRemainder ; stop when subtraction underflows
                    inc       ,x        ; increment this ASCII output digit
                    bra       EmitDecimalDigit ; count another divisor unit
RestoreDivisionRemainder addd      >DecimalPlaceValue,u ; undo the underflowing subtraction
                    std       >NumericValue,u ; retain the remainder for the next digit
                    leax      $01,x     ; advance to the next output position
                    rts                 ; return the remainder in workspace
NoDecimalDigits     ldd       #-1       ; signal that no decimal run was found
                    puls      pc,y      ; restore y and return

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
