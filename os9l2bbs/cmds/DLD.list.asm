**********************************************************************
* dld.list - OS-9 Level 2 BBS command
*
* syntax: DLD.list [directory]
* purpose: list validated downloads and their one-line descriptions.
* reads DLD.lst in the selected directory.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.list
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ListPath            rmb       1         ; sequential path for DLD.lst
FilenameLength      rmb       1         ; visible filename width used for column padding
HeaderPrinted       rmb       1         ; nonzero after the first validated entry
RecordFilename      rmb       31        ; cr-terminated filename at record offset 0
RecordValidated     rmb       1         ; $FF exposes the record; zero hides it
RecordDescription   rmb       64        ; cr-terminated one-line description at offset 32
ReservedWorkspace   rmb       400       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /DLD.list/ ; os-9 module name
ListFilename        fcc       "DLD.lst" ; 96-byte download-library record stream
                    fcb       C$CR      ; terminate the OS-9 pathname
NoFilesMessage      fcc       "No files found." ; shown when no validated record is encountered
                    fcb       C$CR      ; terminate the status line
ColumnPadding       fcc       "                                                                               " ; spaces between columns
                    fcb       C$CR      ; retain the original padding terminator
ListHeading         fcc       "File name      Description" ; two-column heading
                    fcb       C$CR      ; terminate the heading
HeadingRule         fcc       "--------------------------------------------------------------------------" ; underline for the heading
                    fcb       C$CR      ; terminate the rule

start               clr       HeaderPrinted,u ; defer headings until a visible record exists
                    lda       ,x        ; inspect the optional directory argument
                    cmpa      #C$CR     ; a bare parameter line keeps the current directory
                    beq       OpenDownloadList ; skip directory setup when no argument was supplied
                    lda       #READ.    ; select data-directory mode for I$ChgDir
                    os9       I$ChgDir  ; make the requested library directory current
                    lbcs      ExitWithStatus ; return directory errors unchanged
OpenDownloadList    leax      >ListFilename,pc ; select DLD.lst in that directory
                    lda       #READ.    ; listing never modifies library metadata
                    os9       I$Open    ; open the fixed-record list
                    lbcs      ExitWithStatus ; return open errors unchanged
                    sta       ListPath,u ; retain the sequential list path

* stop immediately when the caller types ahead; otherwise scan for the next record
* whose validation byte is $FF. Hidden records never cause headings to be printed.
ScanNextRecord      clra                ; poll standard input
                    ldb       #SS.Ready ; ask whether a key is waiting
                    os9       I$GetStt  ; allow long listings to be interrupted
                    lbcc      ListingComplete ; leave the pending byte for the caller
                    lda       ListPath,u ; select DLD.lst
                    leax      RecordFilename,u ; receive one complete library record
                    ldy       #96       ; enforce filename/flag/description record boundaries
                    os9       I$Read    ; fetch the next download entry
                    lbcs      HandleListEnd ; distinguish normal eof from other errors
                    lda       <RecordValidated,u ; inspect its visibility flag
                    cmpa      #$FF      ; only validated uploads are public
                    bne       ScanNextRecord ; silently skip hidden entries
                    tst       HeaderPrinted,u ; determine whether columns are already labeled
                    bne       WriteListEntry ; avoid repeating headings
                    leax      >ListHeading,pc ; select the column labels
                    ldy       #200      ; let I$WritLn stop at their CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; print the heading above the first result
                    leax      >HeadingRule,pc ; select its underline
                    ldy       #200      ; let I$WritLn stop at the rule's CR
                    os9       I$WritLn  ; separate headings from data rows
                    lda       #$FF      ; mark the one-time heading operation complete
                    sta       HeaderPrinted,u ; also records that at least one file exists

* write the CR-terminated filename without its CR, pad through column 15, then let
* I$WritLn terminate the row using the description stored at record offset 32.
WriteListEntry      clrb                ; begin measuring the visible filename at zero
                    leax      RecordFilename,u ; scan the record's first field
MeasureFilename     lda       ,x+       ; inspect the next filename byte
                    cmpa      #C$CR     ; stop before its field terminator
                    beq       FilenameMeasured ; b now contains the display width
                    incb                ; account for one visible character
                    bra       MeasureFilename ; continue through the filename field
FilenameMeasured    stb       FilenameLength,u ; retain the width for column padding
                    clra                ; zero-extend it for I$Write
                    tfr       d,y       ; supply the exact filename length
                    leax      RecordFilename,u ; select the filename's first byte
                    lda       #1        ; target standard output
                    os9       I$Write   ; emit the filename without a newline
                    ldb       #15       ; descriptions begin at display column 15
                    subb      FilenameLength,u ; derive the number of intervening spaces
                    blt       WriteDescription ; long filenames need no padding
                    clra                ; zero-extend the padding length
                    tfr       d,y       ; supply it to I$Write
                    lda       #1        ; retain standard output as the destination
                    leax      >ColumnPadding,pc ; select a reusable run of spaces
                    os9       I$Write   ; align the description column
WriteDescription    leax      <RecordDescription,u ; select the record's final field
                    ldy       #65       ; bound its 64 bytes plus CR convention
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; finish the row with the one-line description
                    lbra      ScanNextRecord ; seek another visible entry

HandleListEnd       cmpb      #E$EOF    ; eof is successful completion
                    bne       ExitWithStatus ; preserve other read errors
                    tst       HeaderPrinted,u ; determine whether any validated file was shown
                    bne       ListingComplete ; headings imply at least one result
                    leax      >NoFilesMessage,pc ; select the empty-library notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain why no table followed
ListingComplete     clrb                ; report normal eof, interruption, or an empty list
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
