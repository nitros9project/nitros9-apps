**********************************************************************
* DLD.read - OS-9 Level 2 BBS command
*
* Syntax: DLD.read [directory]
* Purpose: Display the long description for a selected download.
* Correlates DLD.lst with DLD.dsc.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded catalog filtering, record fields, and description offsets.
**********************************************************************

                    nam       DLD.read
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

CatalogPathNum      rmb       1
DescriptionPathNum  rmb       1
DescriptionLineBuffer rmb       80
RequestedFilename   rmb       27
* one 96-byte DLD.lst record: name, 32-bit DLD.dsc offset, publication flag,
* and the 64-byte short description
RecordFilename      rmb       27
DescriptionOffsetHigh rmb       2
DescriptionOffsetLow rmb       2
RecordPublishedFlag rmb       1
RecordShortDescription rmb       1
RecordShortDescriptionTail rmb       463       ; first 63 bytes complete the catalog record
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.read/ ; publish the command name in the module header
CatalogPath         fcc       "DLD.lst"
                    fcb       $0D       ; terminate the catalog pathname
DescriptionPath     fcc       "DLD.dsc"
                    fcb       $0D       ; terminate the long-description pathname
FilenamePrompt      fcc       "Enter filename to read:"
FilenameNotFoundText fcc       "Filename not found."
                    fcb       $0D       ; terminate the lookup-failure message
NameLabel           fcb       $0A
                    fcb       $0D
                    fcc       "Name:"
DescriptionLabel    fcc       "Desc:"
DisplayRule         fcc       "--------------------------------------------------------------"
                    fcb       $0D       ; terminate the description separator
* an optional argument changes the download-library directory before either
* database is opened; a bare invocation uses the caller's current directory.
start               lda       ,x        ; inspect the first command-line character
                    cmpa      #13       ; recognize an empty directory argument
                    beq       OpenDatabases ; retain the current directory when no path was supplied
                    lda       #1        ; select the execution directory as the new location
                    os9       I$ChgDir  ; enter the requested download-library directory
                    lbcs      ExitWithStatus ; return the directory error unchanged
OpenDatabases       leax      >CatalogPath,pc ; select the fixed-record catalog
                    lda       #1        ; request read access
                    os9       I$Open    ; open DLD.lst for the filename scan
                    lbcs      ExitWithStatus ; return if the catalog is unavailable
                    sta       CatalogPathNum,u ; retain the catalog path number
                    leax      >DescriptionPath,pc ; select the variable-length description file
                    lda       #1        ; request read access
                    os9       I$Open    ; open DLD.dsc for the eventual offset lookup
                    lbcs      ExitWithStatus ; return if descriptions are unavailable
                    sta       DescriptionPathNum,u ; retain the description path number

* normalize the requested name once, then compare it only with published
* 96-byte catalog records.  Catalog names are normalized during comparison.
PromptFilename      leax      >FilenamePrompt,pc ; prepare the lookup prompt
                    ldy       #23       ; write exactly the prompt text, which has no CR
                    lda       #1        ; direct the prompt to the terminal
                    os9       I$Write   ; leave the cursor ready for the user's response
                    leax      <RequestedFilename,u ; receive the requested catalog filename
                    ldy       #27       ; enforce the catalog filename-field limit
                    clra                ; select standard input
                    os9       I$ReadLn  ; read the CR-terminated lookup key
                    lbcs      PromptFilename ; retry after a terminal read error
                    cmpy      #1        ; treat a CR-only response as cancellation
                    lble      ExitSuccessfully ; leave quietly when no filename was entered
UppercaseInputCharacter lda       ,x        ; fetch one byte of the entered filename
                    anda      #223      ; fold ASCII lowercase letters to uppercase
                    sta       ,x+       ; replace the byte and advance through the input
                    cmpa      #13       ; detect the filename terminator
                    bne       UppercaseInputCharacter ; normalize the complete requested name
ReadNextCatalogRecord leax      <RecordFilename,u ; receive a record at its filename field
                    lda       CatalogPathNum,u ; select the fixed-record catalog
                    ldy       #96       ; request one complete DLD.lst record
                    clrb                ; clear a stale error before the catalog read
                    os9       I$Read    ; fetch the next filename and its metadata
                    lbcs      CatalogScanEnded ; distinguish catalog end from other errors
                    tst       >RecordPublishedFlag,u ; exclude records not approved for download
                    beq       ReadNextCatalogRecord ; continue until a published record appears
                    leay      <RequestedFilename,u ; compare against the normalized lookup key
CompareFilenameCharacter lda       ,y        ; inspect the next requested-name byte
                    cmpa      #13       ; a complete requested name establishes a match
                    beq       DisplayMatchedRecord ; display the selected published record
                    lda       ,x+       ; fetch the corresponding catalog-name byte
                    anda      #223      ; make the catalog comparison case-insensitive
                    cmpa      ,y+       ; require this character to match the request
                    bne       ReadNextCatalogRecord ; reject the record on its first mismatch
                    bra       CompareFilenameCharacter ; compare through the requested-name CR
CatalogScanEnded    cmpb      #211      ; recognize OS-9 end-of-file as an unsuccessful search
                    lbne      ExitWithStatus ; preserve any actual catalog I/O error
                    leax      >FilenameNotFoundText,pc ; prepare the normal lookup-failure message
                    ldy       #200      ; permit the complete CR-terminated text
                    lda       #1        ; direct the result to the terminal
                    os9       I$WritLn  ; report that no published filename matched
                    lbra      ExitSuccessfully ; make a missing name a successful command result

* show the fixed fields, then use the record's 32-bit DLD.dsc offset to stream
* the long description through its CR-only terminating line.
DisplayMatchedRecord leax      >NameLabel,pc ; prepare the leading name caption
                    ldy       #7        ; include its opening line spacing and five-byte label
                    lda       #1        ; direct record output to the terminal
                    os9       I$Write   ; print the caption without scanning for CR
                    leax      <RecordFilename,u ; select the matched record's name field
                    ldy       #30       ; allow the name field and its terminator
                    os9       I$WritLn  ; display the catalog filename
                    leax      >DescriptionLabel,pc ; prepare the short-description caption
                    ldy       #5        ; write the five-byte caption exactly
                    os9       I$Write   ; keep the description on the same display line
                    leax      >RecordShortDescription,u ; select the record's 64-byte summary field
                    ldy       #65       ; allow the complete summary and its terminator
                    os9       I$WritLn  ; display the one-line summary
                    leax      >DisplayRule,pc ; prepare the long-description separator
                    ldy       #65       ; allow the full separator line
                    os9       I$WritLn  ; separate fixed metadata from the long text
                    lda       DescriptionPathNum,u ; select DLD.dsc
                    ldx       >DescriptionOffsetHigh,u ; load the offset's most-significant word
                    pshs      u         ; preserve the workspace pointer during the 32-bit seek
                    ldu       >DescriptionOffsetLow,u ; complete the record-supplied x:u offset
                    os9       I$Seek    ; position DLD.dsc at this file's long description
                    puls      u         ; recover the module workspace pointer
DisplayNextDescriptionLine lda       DescriptionPathNum,u ; continue reading from DLD.dsc
                    leax      DescriptionLineBuffer,u ; receive one long-description line
                    ldy       #200      ; retain the original generous read bound
                    os9       I$ReadLn  ; read through the next carriage return
                    lbcs      ExitWithStatus ; return a truncated-description error
                    lda       #1        ; direct the recovered line to the terminal
                    os9       I$WritLn  ; reproduce the stored description line
                    cmpy      #1        ; identify the CR-only description terminator
                    bgt       DisplayNextDescriptionLine ; continue while the line has content
                    leax      >DisplayRule,pc ; prepare a closing separator
                    ldy       #65       ; allow the complete rule
                    lda       #1        ; select terminal output
                    os9       I$WritLn  ; close the description display
ExitSuccessfully    clrb                ; report normal cancellation, match, or miss
ExitWithStatus      os9       F$Exit    ; return the selected status to the caller

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
