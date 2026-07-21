**********************************************************************
* dld.unvalidate - OS-9 Level 2 BBS command
*
* syntax: DLD.unvalidate [directory]
* purpose: remove validation from an existing download-library entry.
* updates DLD.lst without transferring or deleting the payload file.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.unvalidate
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ListPath            rmb       1         ; update-mode path for DLD.lst
ListPathPad         rmb       1         ; unused byte retained from the original word allocation
RecordPositionHigh  rmb       2         ; high word of the current record's file offset
RecordPositionLow   rmb       2         ; low word of the current record's file offset
PositionWorkspace   rmb       80        ; retained gap after the saved 32-bit position
RequestedFilename   rmb       27        ; uppercase cr-terminated name entered by the operator
RecordFilename      rmb       31        ; cr-terminated filename at record offset 0
RecordValidated     rmb       1         ; $FF exposes the record; zero hides it
RecordDescription   rmb       64        ; cr-terminated one-line description at offset 32
ReservedWorkspace   rmb       400       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /DLD.unvalidate/ ; os-9 module name
ListFilename        fcc       "DLD.lst" ; 96-byte download-library record stream
                    fcb       C$CR      ; terminate the OS-9 pathname
LegacyDescriptionFilename fcc "DLD.dsc" ; retained unreferenced pathname from the original module
                    fcb       C$CR      ; terminate the legacy pathname
FilenamePrompt      fcc       "Enter filename to unvalidate:" ; operator input prompt
NotFoundMessage     fcc       "Filename not found." ; emitted when no validated entry matches
                    fcb       C$CR      ; terminate the status line
LegacyDisplayData   fcb       C$LF,C$CR ; retained unreferenced formatting data
                    fcc       "Name:Desc:--------------------------------------------------------------" ; legacy table heading
                    fcb       C$CR      ; terminate the legacy heading
SuccessMessage      fcc       "File unvalidated." ; confirms that the visibility flag was cleared
                    fcb       C$CR      ; terminate the status line

start               lda       ,x        ; inspect the optional directory argument
                    cmpa      #C$CR     ; a bare parameter line keeps the current directory
                    beq       OpenListForUpdate ; skip directory setup when none was supplied
                    lda       #READ.    ; select data-directory mode for I$ChgDir
                    os9       I$ChgDir  ; make the requested library directory current
                    lbcs      ExitWithStatus ; return directory errors unchanged
OpenListForUpdate   leax      >ListFilename,pc ; select DLD.lst in that directory
                    lda       #UPDAT.   ; the validation byte must be rewritten in place
                    os9       I$Open    ; open the fixed-record list
                    lbcs      ExitWithStatus ; return open errors unchanged
                    sta       ListPath,u ; retain the update path

PromptForFilename   leax      >FilenamePrompt,pc ; ask which public entry should be hidden
                    ldy       #29       ; write the prompt without a line terminator
                    lda       #1        ; target standard output
                    os9       I$Write   ; leave the cursor ready for input
                    leax      <RequestedFilename,u ; receive the requested filename
                    ldy       #27       ; respect the historical input-buffer bound
                    clra                ; select standard input
                    os9       I$ReadLn  ; collect a CR-terminated name
                    lbcs      PromptForFilename ; retry terminal read failures
                    cmpy      #1        ; a CR-only response cancels the command
                    lble      ExitSuccess ; leave without modifying DLD.lst
UppercaseRequestedName lda    ,x        ; normalize the next input byte in place
                    anda      #$DF      ; make comparison ASCII case-insensitive
                    sta       ,x+       ; retain the canonical byte and advance
                    cmpa      #C$CR     ; stop after normalizing the terminator
                    bne       UppercaseRequestedName ; process the complete entered name

* save each record's starting offset before reading it. Only currently validated
* records participate in the filename comparison.
ScanNextRecord      lda       ListPath,u ; select DLD.lst
                    ldb       #SS.Pos   ; request the current 32-bit stream position
                    pshs      u         ; protect workspace U while it receives the low word
                    os9       I$GetStt  ; return the next record position in X:U
                    lbcs      ExitWithStatus ; preserve positioning failures
                    tfr       u,y       ; move the low word out of U before restoring workspace
                    puls      u         ; recover the program data pointer
                    stx       RecordPositionHigh,u ; retain the position's high word
                    sty       RecordPositionLow,u ; retain the position's low word
                    leax      <RecordFilename,u ; receive one complete list record
                    lda       ListPath,u ; restore the update path
                    ldy       #96       ; enforce the fixed record boundary
                    clrb                ; default the error/status register for the read
                    os9       I$Read    ; fetch filename, visibility flag, and description
                    lbcs      HandleSearchEnd ; distinguish eof from real errors
                    tst       >RecordValidated,u ; consider only entries visible to callers
                    beq       ScanNextRecord ; skip already-unvalidated records
                    leay      <RequestedFilename,u ; compare against canonical operator input
CompareFilename     lda       ,y        ; inspect the next requested-name byte
                    cmpa      #C$CR     ; matching all entered bytes is sufficient
                    beq       ClearValidationFlag ; the requested prefix matched this record
                    lda       ,x+       ; fetch the corresponding stored filename byte
                    anda      #$DF      ; compare it without regard to case
                    cmpa      ,y+       ; require the same canonical character
                    bne       ScanNextRecord ; try the next visible record on mismatch
                    bra       CompareFilename ; compare through the requested-name CR

HandleSearchEnd     cmpb      #E$EOF    ; normal eof means the filename was absent
                    lbne      ExitWithStatus ; preserve other list-read errors
                    leax      >NotFoundMessage,pc ; select the unsuccessful-search notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; report that no validated entry matched
                    lbra      ExitSuccess ; absence is not treated as an OS-9 error

* clear the flag in the buffered record, seek back to its saved boundary, and replace
* all 96 bytes so the filename and description remain byte-for-byte intact.
ClearValidationFlag clr      >RecordValidated,u ; hide the matched entry
                    ldx       RecordPositionHigh,u ; load the saved offset's high word
                    lda       ListPath,u ; select DLD.lst
                    pshs      u         ; protect workspace U while it becomes the low word
                    ldu       RecordPositionLow,u ; complete the 32-bit record offset
                    os9       I$Seek    ; return to the matched record's first byte
                    lbcs      ExitWithStatus ; preserve seek failures
                    puls      u         ; recover the workspace pointer
                    leax      <RecordFilename,u ; select the modified record buffer
                    ldy       #96       ; rewrite exactly one list record
                    lda       ListPath,u ; restore the update path
                    os9       I$Write   ; commit the cleared visibility flag
                    leax      >SuccessMessage,pc ; select the confirmation notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; confirm the metadata update
ExitSuccess         clrb                ; report cancellation, absence, or success cleanly
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
