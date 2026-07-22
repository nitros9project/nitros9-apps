**********************************************************************
* BBS.mail.delete - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.delete
* Purpose: Delete selected private-mail records belonging to the current user.
* Data: BBS.mail and BBS.mail.inx in the mailroom.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded the compact-and-replace deletion transaction.
**********************************************************************

                    nam       BBS.mail.delete
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

* four mail-file paths and the privileged directory-edit path
IndexPathNum        rmb       1
BodyPathNum         rmb       1
ScratchIndexPathNum rmb       1
ScratchBodyPathArea rmb       3
DirectoryEntryNumber rmb       1
DirectoryPathArea   rmb       2
CallerUserId        rmb       2
* running 32-bit byte position in the compacted body file
NewBodyOffsetHigh   rmb       1
NewBodyOffsetHighLow rmb       1
NewBodyOffsetLow    rmb       1
NewBodyOffsetLowLow rmb       1
* only the first 32 bytes hold a directory entry; the original reserved more
DirectoryEntry      rmb       232
* index record zero: message count, body size, and retained header bytes
ScratchIndexHeader  rmb       2
HeaderBodyOffsetHigh rmb       2
HeaderBodyOffsetLowAndTail rmb       60
BodyLineBuffer      rmb       80
* one 64-byte mail record, ending with its two-byte recipient user ID
RecordBodyOffsetHigh rmb       2
RecordBodyOffsetLowAndFields rmb       60
RecipientUserId     rmb       2
UnusedTailBuffer    rmb       200
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.delete/ ; publish the command name in the module header
MailIndexPath       fcc       "BBS.mail.inx"
                    fcb       $0D       ; terminate the OS-9 pathname
MailBodyPath        fcc       "BBS.mail"
                    fcb       $0D       ; terminate the OS-9 pathname
UnusedMailHeaderText fcb       $0A       ; retained display text not referenced by this command
                    fcb       $0A
                    fcc       "From    :Left on :About   :"
                    fcb       $00
                    fcb       $09
                    fcc       "----------------------------------------------------------------------"
                    fcb       $0D
DeletingMailText    fcc       "Deleting mail..."
                    fcb       $0D       ; terminate the per-message progress line
PleaseWaitText      fcb       $0A
                    fcc       "One moment please..."
                    fcb       $0A
                    fcb       $0D       ; bracket the initial progress line with line feeds
ScratchIndexPath    fcc       "mail.scratch.inx"
                    fcb       $0D       ; terminate the temporary pathname
ScratchBodyPath     fcc       "mail.scratch"
                    fcb       $0D       ; terminate the temporary pathname
CurrentDirectoryPath fcb       $2E
                    fcb       $0D       ; encode the current directory as "." plus CR
UnusedRenameText    fcc       "Rename" ; retained text not referenced by this command
                    fcb       $0D

* scan the index and body streams together.  A surviving index record is
* rewritten with the current compacted-body offset before its body is copied.
start               os9       F$ID      ; obtain the caller identity that selects mail for deletion
                    sty       CallerUserId,u ; preserve the caller ID while running as user zero
                    ldy       #0        ; select the system user or the high half of a zero file offset
                    os9       F$SUser   ; apply the user ID prepared in y
                    leax      >PleaseWaitText,pc ; prepare the full-rebuild progress notice
                    ldy       #200      ; permit the complete status message
                    lda       #1        ; select terminal path one or read-only access for the pending call
                    os9       I$WritLn  ; write the prepared status or body line
                    leax      >MailIndexPath,pc ; select the authoritative mail index
                    lda       #1        ; select terminal path one or read-only access for the pending call
                    os9       I$Open    ; open the selected source or directory path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    sta       IndexPathNum,u ; retain the original index path
                    leax      >MailBodyPath,pc ; select the authoritative mail-body file
                    lda       #1        ; select terminal path one or read-only access for the pending call
                    os9       I$Open    ; open the selected source or directory path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    sta       BodyPathNum,u ; retain the original body path
                    leax      >ScratchIndexPath,pc ; select the replacement index file
                    lda       #2        ; request update access to a replacement file
                    ldb       #11       ; give the replacement the package data-file attributes
                    os9       I$Create  ; create or truncate the selected scratch file
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    sta       ScratchIndexPathNum,u ; retain the replacement-index path
                    leax      >ScratchBodyPath,pc ; select the replacement body file
                    lda       #2        ; request update access to a replacement file
                    ldb       #11       ; give the replacement the package data-file attributes
                    os9       I$Create  ; create or truncate the selected scratch file
                    sta       ScratchBodyPathArea,u ; retain the replacement-body path
                    clr       NewBodyOffsetHigh,u ; zero the most-significant byte of the new body position
                    clr       NewBodyOffsetHighLow,u ; zero the second byte of the new body position
                    clr       NewBodyOffsetLow,u ; zero the third byte of the new body position
                    clr       NewBodyOffsetLowLow,u ; zero the least-significant byte of the new body position
                    leax      >ScratchIndexHeader,u ; address record zero for its initial copy or final rewrite
                    ldy       #64       ; use the fixed index-record size
                    lda       IndexPathNum,u ; select the original index path
                    os9       I$Read    ; read the requested fixed-size record
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lda       ScratchIndexPathNum,u ; select the replacement index
                    os9       I$Write   ; write the prepared index or directory record
ReadNextIndexRecord leax      >RecordBodyOffsetHigh,u ; receive the next complete mail index record
                    ldy       #64       ; use the fixed index-record size
                    lda       IndexPathNum,u ; select the original index path
                    os9       I$Read    ; read the requested fixed-size record
                    bcs       FinishRebuild ; finalize when the original index reaches end-of-file
                    cmpy      #64       ; require a complete fixed-size index record
                    bne       FinishRebuild ; finalize the replacement files at source end or failure
                    ldd       >RecipientUserId,u ; fetch the recipient ID at the end of this record
                    cmpd      CallerUserId,u ; test whether the record belongs to the caller
                    beq       DiscardRecipientMail ; omit this caller-owned message
                    ldd       NewBodyOffsetHigh,u ; fetch the upper half of the compacted body position
                    std       >RecordBodyOffsetHigh,u ; relocate the survivor to its new body position
                    ldd       NewBodyOffsetLow,u ; fetch the lower half of the compacted body position
                    std       >RecordBodyOffsetLowAndFields,u ; complete the survivor replacement offset
                    lda       ScratchIndexPathNum,u ; select the replacement index
                    os9       I$Write   ; write the prepared index or directory record
* bodies end with a CR-only line.  Every copied byte advances a four-byte
* counter that becomes the next surviving record's replacement offset.
CopyKeptBodyLine    lda       BodyPathNum,u ; select the original body path
                    leax      >BodyLineBuffer,u ; use the shared line buffer for this message body
                    ldy       #80       ; bound a body-file line to the allocated buffer
                    os9       I$ReadLn  ; consume the next CR-terminated body line
                    bcs       FinishRebuild ; finalize if the original body stream ends unexpectedly
                    lda       ScratchBodyPathArea,u ; select the replacement body path
                    os9       I$WritLn  ; write the prepared status or body line
                    tfr       y,d       ; use the transferred line length to advance the body position
                    addd      NewBodyOffsetLow,u ; advance the low half of the compacted byte position
                    std       NewBodyOffsetLow,u ; retain the updated low half
                    bcc       CheckKeptBodyEnd ; continue without propagating a low-word carry
                    ldd       NewBodyOffsetHigh,u ; fetch the upper half of the compacted body position
                    addd      #1        ; propagate the low-half carry into the upper half
                    std       NewBodyOffsetHigh,u ; retain the updated upper half
CheckKeptBodyEnd    cmpy      #1        ; recognize the CR-only line that terminates a stored message
                    bhi       CopyKeptBodyLine ; copy through the message terminator
                    bra       ReadNextIndexRecord ; advance to the next mail record
* deleting a message means reducing record zero's count and consuming its body
* without copying it.  Sequential index/body ordering avoids a separate seek.
DiscardRecipientMail leax      >DeletingMailText,pc ; prepare feedback for a removed recipient message
                    ldy       #200      ; permit the complete status message
                    lda       #1        ; select terminal path one or read-only access for the pending call
                    os9       I$WritLn  ; write the prepared status or body line
                    ldd       >ScratchIndexHeader,u ; fetch the message count in replacement record zero
                    subd      #1        ; remove this recipient message from the count
                    std       >ScratchIndexHeader,u ; retain the reduced replacement message count
SkipDeletedBodyLine lda       BodyPathNum,u ; select the original body path
                    leax      >BodyLineBuffer,u ; use the shared line buffer for this message body
                    ldy       #80       ; bound a body-file line to the allocated buffer
                    os9       I$ReadLn  ; consume the next CR-terminated body line
                    bcs       FinishRebuild ; finalize if the discarded body is truncated
                    cmpy      #1        ; recognize the CR-only line that terminates a stored message
                    bhi       SkipDeletedBodyLine ; discard through the message terminator
                    lbra      ReadNextIndexRecord ; advance to the next mail record
* record zero is corrected only after compaction, then the old pair is removed.
* the scratch files remain recoverable until both new streams have closed.
FinishRebuild       ldd       NewBodyOffsetHigh,u ; fetch the upper half of the compacted body position
                    std       >HeaderBodyOffsetHigh,u ; store the compacted body length high word in record zero
                    ldd       NewBodyOffsetLow,u ; fetch the lower half of the compacted body position
                    std       >HeaderBodyOffsetLowAndTail,u ; store the compacted body length low word in record zero
                    pshs      u         ; preserve the workspace pointer during a 32-bit seek
                    lda       ScratchIndexPathNum,u ; select the replacement index
                    ldx       #0        ; set the seek offset high word to zero
                    ldu       #0        ; initialize the remaining half of the 32-bit seek offset
                    os9       I$Seek    ; position the path at the computed 32-bit offset
                    puls      u         ; recover the workspace pointer after the seek
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    leax      >ScratchIndexHeader,u ; address record zero for its initial copy or final rewrite
                    ldy       #64       ; use the fixed index-record size
                    lda       ScratchIndexPathNum,u ; select the replacement index
                    os9       I$Write   ; write the prepared index or directory record
                    lda       IndexPathNum,u ; select the original index path
                    os9       I$Close   ; close the selected transaction path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lda       BodyPathNum,u ; select the original body path
                    os9       I$Close   ; close the selected transaction path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lda       ScratchIndexPathNum,u ; select the replacement index
                    os9       I$Close   ; close the selected transaction path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lda       ScratchBodyPathArea,u ; select the replacement body path
                    os9       I$Close   ; close the selected transaction path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    leax      >MailIndexPath,pc ; select the authoritative mail index
                    os9       I$Delete  ; unlink the selected original after rebuilding it
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    leax      >MailBodyPath,pc ; select the authoritative mail-body file
                    os9       I$Delete  ; unlink the selected original after rebuilding it
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lbsr      InstallScratchFiles ; install both completed scratch files under their final names
                    clrb                ; report a successful completed transaction
ExitWithStatus      pshs      b         ; preserve the final status while restoring the caller identity
                    ldy       CallerUserId,u ; restore the original user ID
                    os9       F$SUser   ; apply the user ID prepared in y
                    puls      b         ; recover the status saved across user restoration
                    os9       F$Exit    ; return the preserved transaction status
* OS-9 has no rename service here.  Open the directory in update mode, locate
* each scratch entry, overwrite its 29-byte name field, and write the entry back.
InstallScratchFiles leax      >CurrentDirectoryPath,pc ; open the containing directory for direct entry updates
                    lda       #131      ; request directory-update access
                    os9       I$Open    ; open the selected source or directory path
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    sta       DirectoryPathArea,u ; retain the directory path number
                    clr       DirectoryEntryNumber,u ; begin after the dot entry at directory slot one
ReadNextDirectoryEntry pshs      u         ; preserve the workspace pointer while forming a 32-bit seek offset
                    lda       DirectoryEntryNumber,u ; fetch the directory slot currently being examined
                    inca                ; advance to the next 32-byte directory slot
                    sta       DirectoryEntryNumber,u ; retain the slot number for seeking and rewriting
                    ldb       #32       ; convert the slot number to a byte offset
                    mul                 ; form the directory entry offset in d
                    tfr       d,x       ; move the 16-bit offset toward the OS-9 32-bit seek pair
                    lda       DirectoryPathArea,u ; select the open directory stream
                    ldu       #0        ; initialize the remaining half of the 32-bit seek offset
                    exg       x,u       ; place the small offset in the low word of x:u
                    os9       I$Seek    ; position the path at the computed 32-bit offset
                    puls      u         ; recover the workspace pointer after the seek
                    leax      DirectoryEntry,u ; receive or rewrite one 32-byte directory entry
                    ldy       #32       ; use the fixed OS-9 directory-entry size
                    lda       DirectoryPathArea,u ; select the open directory stream
                    os9       I$Read    ; read the requested fixed-size record
                    bcs       DirectoryScanEnded ; finish when the directory stream reaches end-of-file
                    leay      >ScratchIndexPath,pc ; compare this entry with the scratch-index name
                    leax      DirectoryEntry,u ; receive or rewrite one 32-byte directory entry
CompareScratchIndexName lda       ,x+       ; consume the next high-bit-terminated directory-name byte
                    bmi       ScratchIndexNameEnded ; validate the scratch-index name terminator
                    cmpa      ,y+       ; compare this directory-name byte with the expected name
                    bne       TryScratchBodyName ; test this entry against the other scratch name
                    bra       CompareScratchIndexName ; compare the next scratch-index character
TryScratchBodyName  leax      DirectoryEntry,u ; restart comparison at the entry's first name byte
                    leay      >ScratchBodyPath,pc ; compare this entry with the scratch-body name
CompareScratchBodyName lda       ,x+       ; consume the next high-bit-terminated directory-name byte
                    bmi       ScratchBodyNameEnded ; validate the scratch-body name terminator
                    cmpa      ,y+       ; compare this directory-name byte with the expected name
                    bne       AdvanceDirectoryScan ; reject this unrelated directory entry
                    bra       CompareScratchBodyName ; compare the next scratch-body character
AdvanceDirectoryScan bra       ReadNextDirectoryEntry ; advance to the following directory slot
DirectoryScanEnded  cmpb      #211      ; treat OS-9 end-of-file as normal directory completion
                    lbne      ExitWithStatus ; restore the caller and return the OS-9 failure
                    lda       DirectoryPathArea,u ; select the open directory stream
                    os9       I$Close   ; close the selected transaction path
                    rts                 ; return after both scratch names have been installed
ScratchIndexNameEnded anda      #127      ; remove OS-9 high-bit termination before the final comparison
                    cmpa      ,y+       ; compare this directory-name byte with the expected name
                    bne       TryScratchBodyName ; test this entry against the other scratch name
                    lda       ,y+       ; inspect the source-name byte following the matched final character
                    cmpa      #13       ; require the expected name to end at carriage return
                    bne       TryScratchBodyName ; test this entry against the other scratch name
                    leax      DirectoryEntry,u ; receive or rewrite one 32-byte directory entry
                    leay      >MailIndexPath,pc ; replace the scratch-index name with the authoritative name
                    bra       WriteOriginalName ; copy the authoritative name into this entry
ScratchBodyNameEnded anda      #127      ; remove OS-9 high-bit termination before the final comparison
                    cmpa      ,y+       ; compare this directory-name byte with the expected name
                    bne       AdvanceDirectoryScan ; reject this unrelated directory entry
                    lda       #13       ; prepare the CR expected after the scratch-body name
                    cmpa      ,y+       ; compare this directory-name byte with the expected name
                    bne       AdvanceDirectoryScan ; reject this unrelated directory entry
                    leax      DirectoryEntry,u ; receive or rewrite one 32-byte directory entry
                    leay      >MailBodyPath,pc ; replace the scratch-body name with the authoritative name
WriteOriginalName   lda       ,y+       ; fetch one byte of the authoritative filename
                    cmpa      #13       ; require the expected name to end at carriage return
                    beq       CommitRenamedEntry ; terminate and rewrite the renamed directory entry
                    sta       ,x+       ; copy one authoritative-name character into the entry
                    bra       WriteOriginalName ; copy the authoritative name into this entry
CommitRenamedEntry  lda       ,-x       ; return to the final copied filename character
                    ora       #128      ; apply OS-9 high-bit filename termination
                    sta       ,x        ; commit the terminated final character in memory
                    lda       DirectoryEntryNumber,u ; fetch the directory slot currently being examined
                    ldb       #32       ; convert the slot number to a byte offset
                    mul                 ; form the directory entry offset in d
                    tfr       d,x       ; move the 16-bit offset toward the OS-9 32-bit seek pair
                    lda       DirectoryPathArea,u ; select the open directory stream
                    ldb       #5        ; retain the historical value even though I$Seek ignores b
                    pshs      u         ; preserve the workspace pointer during a 32-bit seek
                    ldu       #0        ; initialize the remaining half of the 32-bit seek offset
                    exg       x,u       ; place the small offset in the low word of x:u
                    os9       I$Seek    ; position the path at the computed 32-bit offset
                    lbcs      ExitWithStatus ; restore the caller and return the OS-9 failure
                    puls      u         ; recover the workspace pointer after the seek
                    leax      DirectoryEntry,u ; receive or rewrite one 32-byte directory entry
                    ldy       #32       ; use the fixed OS-9 directory-entry size
                    lda       DirectoryPathArea,u ; select the open directory stream
                    os9       I$Write   ; write the prepared index or directory record
                    lbra      ReadNextDirectoryEntry ; advance to the following directory slot

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
