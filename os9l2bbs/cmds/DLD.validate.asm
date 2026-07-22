**********************************************************************
* DLD.validate - OS-9 Level 2 BBS command
*
* Syntax: DLD.validate [directory]
* Purpose: Review uploads, collect descriptions/keywords, and publish accepted files.
* Updates DLD.lst, DLD.dsc, and DLD.key and may delete rejected files.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded validation review, publication, rejection, and editing flow.
**********************************************************************

                    nam       DLD.validate
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; define a program-object module
atrv                set       ReEnt+rev ; mark the module reentrant at revision one
rev                 set       $01       ; retain the original module revision

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

UnusedByte          rmb       1
DigitValue          rmb       1
DldListPathNum      rmb       1
KeywordPathNum      rmb       1
DescriptionPathNum  rmb       1
EditorInputByte     rmb       1
FilenameLength      rmb       1
EditorCarryLength   rmb       1
EditorCarryBuffer   rmb       80
TerminalOptions     rmb       32
NextCatalogOffsetHigh rmb       2
NextCatalogOffsetLow rmb       2
ResumeCatalogOffsetHigh rmb       2
ResumeCatalogOffsetLow rmb       2
RecordOffsetHigh    rmb       2
RecordOffsetLow     rmb       2
DescriptionLineCount rmb       1
DescriptionLineCountLow rmb       1
ListLineNumber      rmb       2
NumericValue        rmb       1
NumericValueLow     rmb       1
DecimalPlaceValue   rmb       2
SelectedLineNumber  rmb       2
LineNumberText      rmb       3
* one 16-byte DLD.key record
KeywordBuffer       rmb       12
KeywordCatalogOffsetHigh rmb       2
KeywordCatalogOffsetLow rmb       2
* one 96-byte DLD.lst record
DldFilename         rmb       27
FileSizeHigh        rmb       2
FileSizeLow         rmb       2
ValidationFlag      rmb       1
ShortDescription    rmb       64
LongDescriptionBuffer rmb       1
LongDescriptionBufferTail rmb       8399      ; completes 105 editable 80-byte lines
size                equ       .         ; reserve the complete per-process workspace

name                fcs       /DLD.validate/ ; publish the command name in the module header
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
LongDescriptionHeading fcb       $0A
                    fcb       $0A
                    fcc       "   Enter long description now          (Blank line ends)"
                    fcb       $0D
SeparatorLine       fcc       "----------------------------------------------------------------"
                    fcb       $0D
KeywordHeading      fcc       "     Enter file keywords now            (Blank line ends)"
                    fcb       $0D
KeywordPrompt       fcc       "Enter keyword:"
ReviewMenu          fcb       $0A
                    fcc       "[D]one [E]dit [C]ontinue or [L]ist"
                    fcb       $0D
EditLinePrompt      fcc       "Enter line #"
                    fcb       $0D
PromptMarker        fcb       $3E
PromptReturn        fcb       $0A
                    fcb       $0D
PendingHeading      fcb       $0A
                    fcc       "Programs to be validated"
                    fcb       $0D
ColumnHeading       fcc       "File name      Description"
                    fcb       $0D
TableSeparator      fcc       "----------------------------------------------------------------------------"
                    fcb       $0D
ActionPrompt        fcc       "[D]ownload, [V]alidate [K]ill or [N]ext:"
DldListName         fcc       "DLD.lst"
                    fcb       $0D
DescriptionFileName fcc       "DLD.dsc"
                    fcb       $0D
KeywordFileName     fcc       "DLD.key"
                    fcb       $0D
ColumnSpacing       fcc       "                                                                               "
ProtocolTitle       fcb       $0D
                    fcb       $0A
                    fcc       "Enter your download protocol"
                    fcb       $0D
ProtocolMenu        fcb       $0A
                    fcb       $0D
                    fcc       "[X] xmodem"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[C] xmodem (CRC)"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[Y] ymodem"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[Q] quit"
                    fcb       $0A
                    fcb       $0D
                    fcc       "Protocol?"
XmodemProgram       fcc       "dloadx"
                    fcb       $0D
XmodemCrcProgram    fcc       "dloadxc"
                    fcb       $0D
YmodemProgram       fcc       "dloady"
                    fcb       $0D
UnusedYmodemBatchProgram fcc       "dloadyb" ; retained name has no dispatch choice
                    fcb       $0D
ShortDescriptionPrompt fcb       $0A
                    fcc       "Enter a one line description"
                    fcb       $0D
DeletePrompt        fcc       "Delete file? (Y/N):"
EraseSequence       fcb       $08
                    fcb       $20
                    fcb       $08
start               lda       ,x        ; inspect the optional download-directory argument
                    cmpa      #13       ; recognize a bare invocation
                    beq       OpenSupportFiles ; use the current data directory when no path was supplied
                    lda       #1        ; select execution-directory semantics
                    os9       I$ChgDir  ; enter the directory whose catalog is being extended
                    lbcs      ExitWithStatus ; preserve a directory-change failure
OpenSupportFiles    leax      >KeywordFileName,pc ; select the keyword stream
                    lda       #2        ; request update access
                    os9       I$Open    ; open an existing DLD.key
                    bcc       KeywordFileReady ; continue with the existing index
                    cmpb      #216      ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing keyword stream
                    lbcs      ExitWithStatus ; preserve a creation failure
KeywordFileReady    sta       KeywordPathNum,u ; retain the DLD.key path number
                    leax      >DescriptionFileName,pc ; select the long-description stream
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open an existing DLD.dsc
                    bcc       DescriptionFileReady ; continue with the existing description stream
                    cmpb      #216      ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing description stream
                    lbcs      ExitWithStatus ; preserve a creation failure
DescriptionFileReady sta       DescriptionPathNum,u ; retain the DLD.dsc path number
                    leax      >PendingHeading,pc ; introduce the pending-upload table
                    ldy       #200      ; let WritLn stop at the embedded CR
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >ColumnHeading,pc ; identify the two displayed catalog fields
                    ldy       #200      ; let WritLn stop at the embedded CR
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >TableSeparator,pc ; underline the table heading
                    ldy       #200      ; let WritLn stop at the embedded CR
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldx       #0        ; begin scanning DLD.lst at byte zero
                    stx       <NextCatalogOffsetHigh,u ; clear the next-record high word
                    stx       <NextCatalogOffsetLow,u ; clear the next-record low word
                    stx       <ResumeCatalogOffsetHigh,u ; initialize the rewrite cursor
                    stx       <ResumeCatalogOffsetLow,u ; initialize its low word
                    leax      >DldListName,pc ; select the master download catalog
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open DLD.lst for scanning and record updates
                    lbcs      ExitWithStatus ; preserve an open failure
                    sta       DldListPathNum,u ; retain the DLD.lst path number
ReadNextCatalogRecord ldd       <NextCatalogOffsetHigh,u ; snapshot this record's high offset word
                    std       >RecordOffsetHigh,u ; preserve it for keyword index records
                    ldd       <NextCatalogOffsetLow,u ; snapshot this record's low offset word
                    std       >RecordOffsetLow,u ; complete the keyword backlink
                    lda       DldListPathNum,u ; select DLD.lst
                    pshs      u         ; protect the workspace pointer from I$Seek
                    ldx       <NextCatalogOffsetHigh,u ; supply the next record's high offset word
                    ldu       <NextCatalogOffsetLow,u ; supply its low offset word
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; recover the workspace pointer
                    leax      >DldFilename,u ; receive one complete master record
                    ldy       #96       ; preserve the fixed catalog stride
                    os9       I$Read    ; fetch the next registered filename
                    lbcs      CatalogReadEnded ; distinguish EOF from a real read error
                    pshs      u         ; protect the workspace pointer from GetStat
                    ldb       #5        ; request its current 32-bit position
                    os9       I$GetStt  ; obtain the append position after the last record
                    tfr       u,y       ; preserve the low offset word across stack restoration
                    puls      u         ; recover workspace access
                    stx       <NextCatalogOffsetHigh,u ; retain the following record's high offset
                    sty       <NextCatalogOffsetLow,u ; retain its low offset
                    tst       >ValidationFlag,u ; examine this upload's publication state
                    lbne      AdvanceToNextRecord ; silently rewrite and skip nonpending records
                    clrb                ; begin measuring the CR-terminated filename
                    leax      >DldFilename,u ; scan the catalog's 27-byte name field
FindFilenameEnd     lda       ,x+       ; consume one filename byte
                    cmpa      #13       ; stop at the OS-9 string terminator
                    beq       DisplayFilename ; use B as the visible name length
                    incb                ; count one printable filename byte
                    bra       FindFilenameEnd ; continue through the name field
DisplayFilename     stb       FilenameLength,u ; retain the argument length for a downloader child
                    clra                ; widen the byte count for I$Write
                    tfr       d,y       ; pass the exact filename length in Y
                    leax      >DldFilename,u ; point at the filename field
                    lda       #1        ; direct the row to the terminal
                    os9       I$Write   ; print the name without its terminating CR
                    ldb       #15       ; align descriptions at display column sixteen
                    subb      FilenameLength,u ; determine the required padding
                    blt       DisplaySummary ; omit padding for unusually long names
                    clra                ; widen the padding count for I$Write
                    tfr       d,y       ; pass the padding length in Y
                    lda       #1        ; direct padding to the terminal
                    leax      >ColumnSpacing,pc ; use the static run of spaces
                    os9       I$Write   ; advance to the description column
DisplaySummary      leax      >ShortDescription,u ; select the catalog summary field
                    ldy       #65       ; bound the 64-byte field plus terminator
                    lda       #1        ; direct the completed row to the terminal
                    os9       I$WritLn  ; display the pending upload's summary
PromptValidationAction leax      >ActionPrompt,pc ; offer review actions for this upload
                    ldy       #40       ; emit the fixed-length prompt
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor on the choice line
                    leax      EditorInputByte,u ; receive one menu keystroke
                    ldy       #1        ; accept exactly one byte
                    clra                ; read standard input
                    os9       I$Read    ; wait for the operator's action
                    leax      >ProtocolTitle,pc ; reuse its leading CR to end the prompt
                    ldy       #1        ; emit only that CR byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; advance after the entered choice
                    lda       EditorInputByte,u ; recover the raw action key
                    anda      #223      ; fold lowercase ASCII to uppercase
                    cmpa      #'V       ; publish this pending upload
                    lbeq      ValidateSelectedFile ; collect catalog metadata
                    cmpa      #'D       ; test-download the upload first
                    lbeq      DownloadSelectedFile ; choose a transfer protocol
                    cmpa      #'N       ; leave this upload pending
                    lbeq      AdvanceToNextRecord ; continue with the next record
                    cmpa      #'K       ; reject and remove the upload
                    lbeq      KillSelectedFile ; confirm deletion
                    lbra      PromptValidationAction ; reprompt after an unknown key
ValidateSelectedFile leax      >ShortDescriptionPrompt,pc ; ask for the summary stored in DLD.lst
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$WritLn  ; introduce the one-line description field
                    leax      >PromptMarker,pc ; place a marker on the input line
                    ldy       #1        ; emit only the marker byte
                    lda       #1        ; direct the prompt marker to the terminal
                    os9       I$Write   ; leave the cursor after the marker
                    leax      >ShortDescription,u ; receive the 64-byte summary field
                    ldy       #64       ; enforce the catalog field size
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the CR-terminated summary
                    lda       #255      ; select the published-record state
                    sta       >ValidationFlag,u ; remove this entry from the pending queue
                    lda       DescriptionPathNum,u ; select DLD.dsc
                    ldb       #2        ; request the stream's current size
                    pshs      u         ; preserve workspace while GetStat returns size in x:u
                    os9       I$GetStt  ; obtain the description append offset
                    lbcs      ExitWithStatus ; preserve a size-query failure
                    os9       I$Seek    ; position DLD.dsc at its current end
                    lbcs      ExitWithStatus ; preserve a seek failure
                    tfr       u,y       ; preserve the low description offset
                    puls      u         ; recover workspace access
                    stx       >FileSizeHigh,u ; repurpose the field as DLD.dsc offset high word
                    sty       >FileSizeLow,u ; store the description offset low word
                    lda       DldListPathNum,u ; select DLD.lst
                    pshs      u         ; protect the workspace pointer from I$Seek
                    ldx       <ResumeCatalogOffsetHigh,u ; seek to this record's rewrite cursor
                    ldu       <ResumeCatalogOffsetLow,u ; supply its low offset word
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; recover the workspace pointer
                    leax      >DldFilename,u ; select the updated master record
                    ldy       #96       ; write one complete master-catalog record
                    lda       DldListPathNum,u ; select DLD.lst at the chosen slot
                    os9       I$Write   ; commit filename, description pointer, state, and summary
                    pshs      u         ; protect the workspace pointer from GetStat
                    ldb       #5        ; request the post-write file position
                    os9       I$GetStt  ; obtain the cursor following this record
                    tfr       u,y       ; preserve the low offset word
                    puls      u         ; recover workspace access
                    stx       <ResumeCatalogOffsetHigh,u ; retain the next rewrite high word
                    sty       <ResumeCatalogOffsetLow,u ; retain its low word
                    lbra      CollectKeywords ; build search metadata for the published file
CatalogReadEnded    cmpb      #211      ; recognize the original OS-9 EOF status
                    lbne      ExitWithStatus ; preserve any other read failure
                    lda       DldListPathNum,u ; select DLD.lst
                    ldb       #2        ; request SetStat size
                    pshs      u         ; protect workspace while U carries the low size word
                    ldx       <ResumeCatalogOffsetHigh,u ; supply the last rewritten boundary
                    ldu       <ResumeCatalogOffsetLow,u ; supply its low word
                    os9       I$SetStt  ; truncate stale records beyond that boundary
                    puls      u         ; recover the workspace pointer
                    lbra      ExitSuccessfully ; finish after compacting the catalog
CollectKeywords     lda       KeywordPathNum,u ; select DLD.key
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
                    ldd       >RecordOffsetHigh,u ; recover this DLD.lst record's offset
                    std       >KeywordCatalogOffsetHigh,u ; attach its high word to each keyword
                    ldd       >RecordOffsetLow,u ; recover its low offset word
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
                    lbls      BeginLongDescription ; a blank keyword ends index entry
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
                    ldd       #0        ; clear the 16-bit line counter
                    std       >DescriptionLineCount,u ; begin before the first description line
                    sta       EditorCarryLength,u ; begin with no wrapped carry text
ReadDescriptionLines ldd       >DescriptionLineCount,u ; recover the number of occupied slots
                    addd      #1        ; advance to the next 80-byte line slot
                    std       >DescriptionLineCount,u ; retain the new line count
                    cmpd      #99       ; reserve space below the 105-line buffer limit
                    bge       ReviewDescription ; force review before the buffer can overflow
                    lbsr      ReadLongDescriptionLine ; edit one logical description line
                    cmpy      #1        ; detect a blank CR-only line
                    bls       ReviewDescription ; a blank line ends initial entry
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
                    anda      #223      ; mask a using #223
                    cmpa      #68       ; test for done
                    lbeq      FinishDescription ; commit the edited lines to DLD.dsc
                    cmpa      #69       ; test for edit
                    beq       EditDescription ; replace a selected line
                    cmpa      #67       ; test for continue
                    beq       ContinueDescription ; reopen entry at the current end
                    cmpa      #76       ; test for list
                    lbeq      ListDescription ; display all buffered lines
                    bra       ReviewDescription ; reject an unrecognized choice
ContinueDescription ldd       >DescriptionLineCount,u ; recover the buffered-line count
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
                    cmpd      >DescriptionLineCount,u ; require an existing line below the terminator
                    lbcc      ReviewDescription ; reject the terminator or an out-of-range line
                    std       >SelectedLineNumber,u ; retain the selected buffer slot
                    leax      >LineNumberText,u ; format the selected line's prefix
                    lbsr      FormatTwoDigit ; render D as two decimal digits
                    leax      >LineNumberText,u ; append punctuation to the rendered prefix
                    lda       #58       ; select the colon separator
                    sta       $02,x     ; complete the displayed line-number prefix
                    ldy       #3        ; emit two digits and colon
                    lda       #1        ; direct the prefix to the terminal
                    os9       I$Write   ; label the existing selected line
                    ldd       >SelectedLineNumber,u ; recover the zero-based array index
                    leax      >LongDescriptionBuffer,u ; start at the description array
                    lda       #80       ; convert line index to byte offset
                    mul                 ; convert the line index to an 80-byte offset
                    leax      d,x       ; address the selected line
                    ldy       #80       ; bound display at one line slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; show the text that will be edited
                    tfr       y,d       ; recover the displayed line length
                    stb       EditorCarryLength,u ; use the displayed length as editor prefill size
                    dec       EditorCarryLength,u ; exclude the terminating CR
                    leay      EditorCarryBuffer,u ; select the editor prefill buffer
CopyEditedLineToScratch lda       ,x+       ; fetch one byte from the selected line
                    sta       ,y+       ; append it to the prefill buffer
                    decb                ; count one copied character
                    bne       CopyEditedLineToScratch ; retain the entire existing line
                    ldd       >SelectedLineNumber,u ; restore its zero-based array index
                    bsr       ReadLongDescriptionLine ; re-edit that line in place
                    lbra      ReviewDescription ; return to the review menu
ListDescription     ldd       #0        ; restart the listing before line one
                    std       >DescriptionLineCount,u ; reuse the count as a listing cursor
ListEachLine        ldd       >DescriptionLineCount,u ; recover the listing cursor
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
                    ldd       >DescriptionLineCount,u ; recover the current array index
                    lda       #80       ; convert it to an array byte offset
                    mul                 ; convert the line index to an 80-byte offset
                    leax      d,x       ; address the line to display
                    ldy       #80       ; bound the display at one array slot
                    lda       #1        ; direct the line to the terminal
                    os9       I$WritLn  ; display until its stored CR
                    cmpy      #1        ; detect the blank terminator line
                    bhi       ListEachLine ; continue until the blank terminator slot
                    lbra      ReviewDescription ; return after the complete listing
ReadLongDescriptionLine leax      >LineNumberText,u ; select the three-byte line prefix
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
                    mul                 ; convert the line index to an 80-byte offset
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
WriteDescriptionLines lda       >ListLineNumber,u ; recover the output line index
                    inca                ; advance to the next line slot
                    sta       >ListLineNumber,u ; retain output progress
                    cmpa      >DescriptionLineCountLow,u ; stop after the final buffered line
                    bhi       ReturnToCatalogScan ; stop after the final buffered line
                    ldb       #80       ; convert the line number to a byte offset
                    mul                 ; convert the line index to an 80-byte offset
                    leax      >LongDescriptionBuffer,u ; start at the line array
                    leax      d,x       ; address the next output line
                    ldy       #80       ; bound output at one array slot
                    lda       DescriptionPathNum,u ; select DLD.dsc
                    os9       I$WritLn  ; append one CR-terminated description line
                    lbcs      ExitWithStatus ; preserve a description write failure
                    cmpy      #1        ; detect the blank terminator line
                    bls       ReturnToCatalogScan ; stop after writing the blank terminator
                    tfr       y,d       ; preserve the original harmless length transfer
                    bra       WriteDescriptionLines ; append the next buffered line
ReturnToCatalogScan lbra      ReadNextCatalogRecord ; resume validation at the saved catalog cursor
DownloadSelectedFile leax      >ProtocolMenu,pc ; offer the installed download protocols
                    ldy       #63       ; emit the fixed menu and prompt
                    lda       #1        ; direct the menu to the terminal
                    os9       I$Write   ; leave the cursor after “Protocol?”
                    leax      EditorInputByte,u ; receive one protocol key
                    ldy       #1        ; accept exactly one byte
                    clra                ; read standard input
                    os9       I$Read    ; wait for the operator's choice
                    leax      >ProtocolTitle,pc ; reuse its leading CR as a newline
                    ldy       #1        ; emit only that control byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; move below the entered choice
                    lda       EditorInputByte,u ; recover the raw protocol key
                    anda      #223      ; fold lowercase ASCII to uppercase
                    cmpa      #'X       ; test for checksum XMODEM
                    beq       SelectXmodem ; launch dloadx
                    cmpa      #'C       ; test for CRC XMODEM
                    beq       SelectXmodemCrc ; launch dloadxc
                    cmpa      #'Y       ; test for YMODEM
                    beq       SelectYmodem ; launch dloady
                    cmpa      #'Q       ; allow the validator to exit from this menu
                    lbeq      ExitSuccessfully ; return without changing the record
                    bra       DownloadSelectedFile ; reprompt after an unknown key
SelectXmodem        leax      >XmodemProgram,pc ; select the checksum downloader
                    bra       ForkSelectedDownload ; use the shared child launcher
SelectXmodemCrc     leax      >XmodemCrcProgram,pc ; select the CRC downloader
                    bra       ForkSelectedDownload ; use the shared child launcher
SelectYmodem        leax      >YmodemProgram,pc ; select the YMODEM downloader
                    bra       ForkSelectedDownload ; use the shared child launcher
* Preserve four unreachable bytes embedded in the original executable.
                    fcb       $30
                    fcb       $8D
                    fcb       $FB
                    fcb       $35
ForkSelectedDownload ldb       FilenameLength,u ; recover the child's filename argument length
                    incb                ; include the terminating carriage return
                    clra                ; widen the byte count
                    tfr       d,y       ; pass the parameter length in Y
                    lda       #17       ; inherit standard paths and allocate child memory
                    ldb       #3        ; use the original three-page allocation request
                    pshs      u         ; preserve workspace across the child process
                    leau      >DldFilename,u ; pass the selected filename as its parameter
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      ExitWithStatus ; preserve a fork failure
                    clrb                ; wait for any child process
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      ExitWithStatus ; preserve a wait failure
                    puls      u         ; recover workspace access
                    tstb                ; inspect the downloader's exit status
                    lbne      DownloadSelectedFile ; let the operator retry another protocol
AdvanceToNextRecord lda       DldListPathNum,u ; select DLD.lst
                    pshs      u         ; protect the workspace pointer from I$Seek
                    ldx       <ResumeCatalogOffsetHigh,u ; seek to the current compaction cursor
                    ldu       <ResumeCatalogOffsetLow,u ; supply its low word
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; recover the workspace pointer
                    leax      >DldFilename,u ; select the record being compacted
                    ldy       #96       ; preserve the fixed record stride
                    os9       I$Write   ; copy it to the current output cursor
                    pshs      u         ; protect workspace during GetStat
                    ldb       #5        ; request the new compaction cursor
                    os9       I$GetStt  ; obtain the post-write file position
                    tfr       u,y       ; preserve its low word
                    puls      u         ; recover workspace access
                    stx       <ResumeCatalogOffsetHigh,u ; retain the next output high word
                    sty       <ResumeCatalogOffsetLow,u ; retain its low word
                    lbra      ReadNextCatalogRecord ; scan the next original record
KillSelectedFile    leax      >DeletePrompt,pc ; request confirmation before rejection
                    ldy       #19       ; emit the fixed prompt
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; leave the cursor on the response line
                    leax      EditorInputByte,u ; receive one confirmation key
                    ldy       #1        ; accept exactly one byte
                    clra                ; read standard input
                    os9       I$Read    ; wait for confirmation
                    leax      >PromptReturn,pc ; select the newline byte
                    ldy       #1        ; emit one control byte
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; advance after the entered response
                    lda       EditorInputByte,u ; recover the raw confirmation key
                    anda      #223      ; fold lowercase ASCII to uppercase
                    cmpa      #'Y       ; delete only after explicit confirmation
                    lbne      AdvanceToNextRecord ; leave the upload pending otherwise
                    leax      >DldFilename,u ; select the uploaded file itself
                    os9       I$Delete  ; delete the path named at X
                    lda       #1        ; select the rejected/deleted state
                    sta       >ValidationFlag,u ; prevent this record from reappearing as pending
                    lda       DldListPathNum,u ; select DLD.lst
                    pshs      u         ; protect workspace during I$Seek
                    ldx       <ResumeCatalogOffsetHigh,u ; seek to the current compaction cursor
                    ldu       <ResumeCatalogOffsetLow,u ; supply its low word
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; recover workspace access
                    leax      >DldFilename,u ; select the rejected catalog record
                    ldy       #96       ; preserve the fixed record stride
                    lda       DldListPathNum,u ; restore the catalog path number
                    os9       I$Write   ; retain the tombstone during compaction
                    pshs      u         ; protect workspace during GetStat
                    ldb       #5        ; request the post-write cursor
                    os9       I$GetStt  ; obtain the next output position
                    tfr       u,y       ; preserve its low word
                    puls      u         ; recover workspace access
                    stx       <ResumeCatalogOffsetHigh,u ; retain the next output high word
                    sty       <ResumeCatalogOffsetLow,u ; retain its low word
                    lbra      ReadNextCatalogRecord ; continue scanning pending uploads
ExitSuccessfully    clrb                ; report successful validation processing
ExitWithStatus      os9       F$Exit    ; return success or the preserved OS-9 status
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
                    bhi       RejectDeleteAtStart ; refuse deletion before the prefill boundary
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
                    bhi       RejectDeleteAtStart ; stop when all entered text is erased
                    pshs      y,x       ; protect state during visual erase
                    leax      >EraseSequence,pc ; choose backspace-space-backspace
                    ldy       #3        ; emit the complete erase sequence
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; erase one displayed character
                    puls      y,x       ; recover updated state
                    leax      -$01,x    ; move the insertion pointer left
                    cmpy      stk_editor_capacity,s ; see whether the left edge was reached
                    lbhi      ReadEditorChar ; resume input once the line is empty
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
ParseDecimal        pshs      y         ; preserve the caller's y
FindFirstDigit      lda       ,x+       ; scan the next response byte
                    cmpa      #13       ; stop when no digit run was present
                    lbeq      NoDecimalDigits ; report an invalid line number
                    cmpa      #48       ; ignore bytes below ASCII zero
                    bcs       FindFirstDigit ; continue searching
                    cmpa      #57       ; ignore bytes above ASCII nine
                    bhi       FindFirstDigit ; continue searching past nondigits
                    leax      -$01,x    ; return to the first digit
FindDigitRunEnd     lda       ,x+       ; locate the byte following the digit run
                    cmpa      #48       ; stop below ASCII zero
                    bcs       ParseDigitRun ; convert the complete run
                    cmpa      #57       ; stop above ASCII nine
                    bhi       ParseDigitRun ; convert when the digit run ends
                    bra       FindDigitRunEnd ; continue across decimal digits
ParseDigitRun       pshs      x         ; retain the caller's post-run pointer
                    leax      -$01,x    ; begin with the least-significant digit
                    clr       >NumericValue,u ; initialize the high result byte
                    clr       >NumericValueLow,u ; initialize the low result byte
                    ldd       #1        ; begin at the units place
                    std       >DecimalPlaceValue,u ; retain the current power of ten
AccumulatePreviousDigit lda       ,-x       ; fetch the next digit from right to left
                    cmpa      #48       ; finish before the digit run
                    bcs       ReturnNumericValue ; return the accumulated value
                    cmpa      #57       ; guard the upper digit boundary
                    bhi       ReturnNumericValue ; finish at the left edge of the run
                    suba      #'0       ; convert ASCII to a binary digit
                    sta       DigitValue,u ; retain the remaining multiplier count
                    ldd       #0        ; clear this digit's contribution
MultiplyDigitByPlace tst       DigitValue,u ; test whether all copies were accumulated
                    beq       AddDigitValue ; merge this digit's contribution
                    addd      >DecimalPlaceValue,u ; add one copy of the current place
                    dec       DigitValue,u ; consume one multiplier unit
                    bra       MultiplyDigitByPlace ; implement digit multiplication by addition
AddDigitValue       addd      >NumericValue,u ; merge the digit into the accumulated result
                    std       >NumericValue,u ; retain the new numeric value
                    lda       #10       ; prepare to multiply the place by ten
                    sta       DigitValue,u ; set the repeated-addition count
                    ldd       #0        ; clear the next place accumulator
MultiplyPlaceByTen  tst       DigitValue,u ; test whether ten copies were accumulated
                    beq       SaveNextDecimalPlace ; retain the next power of ten
                    addd      >DecimalPlaceValue,u ; add one copy of the prior place
                    dec       DigitValue,u ; consume one of the ten copies
                    bra       MultiplyPlaceByTen ; complete multiplication by ten
SaveNextDecimalPlace std       >DecimalPlaceValue,u ; retain the next decimal place
                    bra       AccumulatePreviousDigit ; consume the next digit to the left
ReturnNumericValue  ldd       >NumericValue,u ; return the parsed 16-bit value
                    puls      x         ; restore the caller's post-run pointer
                    puls      pc,y      ; restore y and return
FormatTwoDigit      pshs      y         ; preserve the caller's y
                    std       >NumericValue,u ; retain the value being formatted
                    lda       #48       ; initialize both output digits to ASCII zero
                    sta       ,x        ; seed the tens digit
                    sta       $01,x     ; seed the units digit
                    ldd       #10       ; select the tens divisor
                    std       >DecimalPlaceValue,u ; retain it for repeated subtraction
                    ldd       >NumericValue,u ; recover the original value
                    bsr       EmitDecimalDigit ; count tens into the first digit
                    ldd       #1        ; select the units divisor
                    std       >DecimalPlaceValue,u ; retain it for repeated subtraction
                    ldd       >NumericValue,u ; continue with the tens remainder
                    bsr       EmitDecimalDigit ; count units into the second digit
                    lda       #13       ; terminate the formatted prefix
                    sta       ,x        ; append CR after the two digits
                    puls      pc,y      ; restore y and return
EmitDecimalDigit    subd      >DecimalPlaceValue,u ; remove one divisor unit
                    bcs       RestoreDivisionRemainder ; stop when subtraction underflows
                    inc       ,x        ; increment this ASCII output digit
                    bra       EmitDecimalDigit ; count another divisor unit
RestoreDivisionRemainder addd      >DecimalPlaceValue,u ; undo the subtraction that crossed zero
                    std       >NumericValue,u ; retain the remainder for the next digit
                    leax      $01,x     ; advance to the next output position
                    rts                 ; return the remainder in workspace
NoDecimalDigits     ldd       #-1       ; return an out-of-range sentinel
                    puls      pc,y      ; restore y and return

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
