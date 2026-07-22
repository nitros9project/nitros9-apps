**********************************************************************
* DLD.search - OS-9 Level 2 BBS command
*
* Syntax: DLD.search [directory]
* Purpose: Search download keywords and report matching files.
* Correlates DLD.key entries with DLD.lst.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded keyword records, prefix matching, and catalog correlation.
**********************************************************************

                    nam       DLD.search
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

KeywordPathNum      rmb       1
CatalogPathNum      rmb       1
FilenameLength      rmb       1
AnyMatchFound       rmb       1
LastCatalogOffsetHigh rmb       2
LastCatalogOffsetLow rmb       2
SearchKeyword       rmb       27
* one 16-byte DLD.key record: a 12-byte keyword followed by a 32-bit DLD.lst offset
KeywordText         rmb       12
CatalogOffsetHigh   rmb       2
CatalogOffsetLow    rmb       2
* one 96-byte DLD.lst record begins with a 27-byte filename and a four-byte
* description offset; only its filename, publication flag, and summary are used
CatalogRecordStart  rmb       31
RecordPublishedFlag rmb       1
RecordShortDescription rmb       1
RecordShortDescriptionTail rmb       463       ; first 63 bytes complete the catalog record
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.search/ ; publish the command name in the module header
CatalogPath         fcc       "DLD.lst"
                    fcb       $0D       ; terminate the catalog pathname
KeywordIndexPath    fcc       "DLD.key"
                    fcb       $0D       ; terminate the keyword-index pathname
KeywordPrompt       fcc       "Enter keyword for search:"
NoFilesText         fcc       "No files found."
                    fcb       $0D       ; terminate the empty-result message
PaddingSpaces       fcc       "                                                                               "
                    fcb       $0D       ; supply column padding after short filenames
ResultsHeader       fcb       $0A
                    fcc       "File name      Description"
                    fcb       $0D       ; terminate the one-time result heading
ResultsRule         fcc       "--------------------------------------------------------------------------"
                    fcb       $0D       ; terminate the heading rule
* an optional argument selects the download-library directory.  The last
* displayed catalog offset begins at -1 so the first real record cannot collide.
start               clr       AnyMatchFound,u ; defer the result heading until the first match
                    lda       ,x        ; inspect the optional directory argument
                    cmpa      #13       ; recognize a bare invocation
                    beq       OpenIndexes ; retain the current directory when no path was supplied
                    lda       #1        ; select execution-directory semantics
                    os9       I$ChgDir  ; enter the requested download-library directory
                    lbcs      ExitWithStatus ; preserve a directory-change failure
OpenIndexes         ldd       #-1       ; create an impossible initial 32-bit catalog offset
                    std       LastCatalogOffsetLow,u ; initialize the duplicate filter's low word
                    std       LastCatalogOffsetHigh,u ; initialize its high word
                    leax      >CatalogPath,pc ; select the fixed-record download catalog
                    lda       #1        ; request read access
                    os9       I$Open    ; open DLD.lst for correlated record reads
                    lbcs      ExitWithStatus ; return if the catalog is unavailable
                    sta       CatalogPathNum,u ; retain the catalog path number
                    leax      >KeywordIndexPath,pc ; select the keyword-to-catalog index
                    lda       #1        ; request read access
                    os9       I$Open    ; open DLD.key for the sequential search
                    lbcs      ExitWithStatus ; return if the keyword index is unavailable
                    sta       KeywordPathNum,u ; retain the keyword-index path number

* each 16-byte keyword record carries a 12-byte CR-terminated keyword and the
* 32-bit byte offset of its corresponding record in DLD.lst.
PromptKeyword       leax      >KeywordPrompt,pc ; prepare the prefix-search prompt
                    ldy       #25       ; write the exact prompt without a line terminator
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor ready for the search text
                    leax      SearchKeyword,u ; receive the requested keyword prefix
                    ldy       #27       ; retain the original input limit
                    clra                ; select standard input
                    os9       I$ReadLn  ; read the CR-terminated prefix
                    lbcs      PromptKeyword ; retry after a terminal read error
ReadNextKeywordEntry leax      <KeywordText,u ; receive a complete keyword-index record
                    ldy       #16       ; use the fixed DLD.key record size
                    lda       KeywordPathNum,u ; select the sequential keyword stream
                    os9       I$Read    ; fetch the keyword and its catalog offset
                    lbcs      KeywordScanEnded ; classify end-of-file after the final keyword
                    ldd       <CatalogOffsetHigh,u ; fetch the candidate catalog offset high word
                    cmpd      LastCatalogOffsetHigh,u ; compare it with the last displayed record
                    bne       NormalizeEntryKeyword ; examine keywords for a different catalog record
                    ldd       <CatalogOffsetLow,u ; fetch the candidate offset low word
                    cmpd      LastCatalogOffsetLow,u ; complete the duplicate-offset test
                    bne       NormalizeEntryKeyword ; keep a different record even with equal high words
                    bra       ReadNextKeywordEntry ; suppress another keyword for the displayed record
NormalizeEntryKeyword pshs      x         ; preserve the start of the 16-byte keyword record
UppercaseKeywordCharacter lda       ,x        ; fetch one stored keyword byte
                    anda      #223      ; fold ASCII lowercase to uppercase in the work copy
                    sta       ,x+       ; retain the normalized byte and advance
                    cmpa      #13       ; detect the stored keyword terminator
                    bne       UppercaseKeywordCharacter ; normalize the complete stored keyword
                    puls      x         ; restore the keyword-record start after the temporary push
                    leay      SearchKeyword,u ; compare with the user's requested prefix
CompareSearchPrefix lda       ,y+       ; fetch the next requested-prefix byte
                    cmpa      #13       ; the request ending first establishes a prefix match
                    beq       KeywordMatched ; resolve the record referenced by this keyword
                    anda      #223      ; make the user's side case-insensitive as well
                    cmpa      ,x+       ; require the next stored keyword byte to match
                    bne       ReadNextKeywordEntry ; reject this keyword at its first mismatch
                    bra       CompareSearchPrefix ; compare until the requested prefix ends
KeywordScanEnded    cmpb      #211      ; recognize OS-9 end-of-file as normal search completion
                    lbne      ExitWithStatus ; preserve an actual keyword-index error
                    tst       AnyMatchFound,u ; determine whether a result heading was emitted
                    lbne      ExitSuccessfully ; finish quietly after one or more matches
                    leax      >NoFilesText,pc ; prepare the empty-result message
                    ldy       #200      ; permit the complete CR-terminated line
                    lda       #1        ; direct the result to the terminal
                    os9       I$WritLn  ; report that no published catalog record matched
                    lbra      ExitSuccessfully ; make an empty search a successful command result

* resolve a matching keyword through its x:u catalog offset.  Keyword hits for
* unpublished records are ignored, and the result heading is printed only once.
KeywordMatched      pshs      u         ; preserve the workspace pointer while u holds an offset word
                    lda       CatalogPathNum,u ; select DLD.lst before repurposing u
                    ldx       <CatalogOffsetHigh,u ; load the catalog offset high word
                    ldu       <CatalogOffsetLow,u ; complete the 32-bit x:u seek position
                    os9       I$Seek    ; position DLD.lst at the referenced record
                    lbcs      ExitWithStatus ; exit directly because u no longer addresses workspace
                    puls      u         ; recover the workspace pointer after a successful seek
                    leax      <CatalogRecordStart,u ; receive the referenced catalog record
                    ldy       #96       ; use the fixed DLD.lst record size
                    lda       CatalogPathNum,u ; select the positioned catalog stream
                    os9       I$Read    ; fetch filename, flags, and short description
                    lbcs      ExitWithStatus ; preserve a truncated or unreadable record error
                    tst       <RecordPublishedFlag,u ; hide entries not approved for download
                    lbeq      ReadNextKeywordEntry ; resume the keyword scan for an unpublished hit
                    tst       AnyMatchFound,u ; determine whether this is the first visible result
                    bne       DisplayResultLine ; omit repeated heading output after the first result
                    leax      >ResultsHeader,pc ; prepare the column headings
                    ldy       #200      ; permit the complete heading line
                    lda       #1        ; direct the heading to the terminal
                    os9       I$WritLn  ; identify the filename and description columns
                    leax      >ResultsRule,pc ; prepare the heading underline
                    ldy       #200      ; permit the complete rule
                    os9       I$WritLn  ; separate headings from result rows
                    lda       #255      ; mark the heading and first match as emitted
                    sta       AnyMatchFound,u ; suppress both the heading and no-files message later

* pad filenames shorter than 15 characters so every short description begins
* in the same column; longer names flow directly into their description.
DisplayResultLine   clrb                ; begin the filename length at zero
                    leax      <CatalogRecordStart,u ; scan from the catalog filename field
CountFilenameCharacters lda       ,x+       ; consume the next filename byte
                    cmpa      #13       ; stop at its CR terminator
                    beq       FilenameLengthReady ; convert the completed count to output widths
                    incb                ; count one visible filename character
                    bra       CountFilenameCharacters ; scan the remainder of the name
FilenameLengthReady stb       FilenameLength,u ; retain the length for the padding calculation
                    clra                ; widen the byte count in b to a word in d
                    tfr       d,y       ; use the filename length as the raw-write count
                    leax      <CatalogRecordStart,u ; return to the filename field start
                    lda       #1        ; direct the result row to the terminal
                    os9       I$Write   ; print the filename without its CR terminator
                    ldb       #15       ; define the short-description column
                    subb      FilenameLength,u ; calculate the number of intervening spaces
                    blt       WriteShortDescription ; skip padding when the filename exceeds the column
                    clra                ; widen the nonnegative padding count
                    tfr       d,y       ; use it as the raw-write length
                    lda       #1        ; keep output on the terminal
                    leax      >PaddingSpaces,pc ; select enough leading spaces for the column gap
                    os9       I$Write   ; advance to the description column
WriteShortDescription leax      <RecordShortDescription,u ; select the record's 64-byte summary field
                    ldy       #65       ; allow the summary and its terminator
                    lda       #1        ; direct the remainder of the row to the terminal
                    os9       I$WritLn  ; display the summary and end the result row
                    ldd       <CatalogOffsetHigh,u ; fetch the offset of the record just displayed
                    std       LastCatalogOffsetHigh,u ; remember its high word for duplicate suppression
                    ldd       <CatalogOffsetLow,u ; fetch the displayed offset low word
                    std       LastCatalogOffsetLow,u ; complete the remembered 32-bit offset
                    lbra      ReadNextKeywordEntry ; continue searching for distinct matching records
ExitSuccessfully    clrb                ; report a normal completed or empty search
ExitWithStatus      os9       F$Exit    ; return success or the preserved OS-9 error

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
