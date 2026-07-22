**********************************************************************
* bbs.pack - OS-9 Level 2 BBS command
*
* syntax: BBS.pack [directory]
* purpose: rewrite a message base and discard storage occupied by deleted messages.
* rebuilds BBS.msg and BBS.msg.inx as a consistent pair.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.pack
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

OldIndexPath        rmb       1         ; read path for the original BBS.msg.inx
OldMessagePath      rmb       1         ; read path for the original BBS.msg
NewIndexPath        rmb       1         ; output path for msg.scratch, the rebuilt index
NewMessagePath      rmb       1         ; output path for inx.scratch, the rebuilt body store
MessageListPath     rmb       1         ; update path for optional BBs.msg.lst
RenameDirectoryPath rmb       1         ; raw update path for the current directory
RenamePathReserved  rmb       2         ; unused remainder of the original path workspace
DeletedBeforeCount  rmb       2         ; deleted message numbers at or below a saved position
CallerUserId        rmb       2         ; original identity restored after privileged packing
NewBodyOffset       rmb       2         ; high word of the rebuilt body's 32-bit end offset
NewBodyOffsetLow    rmb       2         ; low word of the rebuilt body's end offset
MessageListRecord   rmb       2         ; leading word of one four-byte saved-position record
LastReadMessage     rmb       2         ; message number adjusted after compaction
DeletedNumberCursor rmb       2         ; next free word in DeletedMessageNumbers
CurrentMessageNumber rmb       2         ; original index-record number currently being scanned
DirectoryEntry      rmb       32        ; one raw 32-byte OS-9 directory entry
DirectoryEntryIndex rmb       1         ; one-based directory slot number during rename scans
DirectoryScanReserved rmb       231       ; retained tail of the original directory workspace
IndexHeader         rmb       2         ; packed high message number at header offset 0
PackedBodyEndHigh   rmb       2         ; rebuilt body EOF high word at header offset 2
PackedBodyEndLow    rmb       2         ; rebuilt body EOF low word at header offset 4
IndexHeaderReserved rmb       58        ; remaining bytes of the 64-byte index header
MessageLine         rmb       80        ; one CR-terminated message-body line
IndexRecord         rmb       2         ; packed body offset high word at record offset 0
PackedRecordBodyOffsetLow rmb       2         ; packed body offset low word at record offset 2
IndexRecordMetadata rmb       60        ; author, subject, timestamp, and user IDs
DeletedMessageNumbers rmb       400       ; up to 200 original message numbers removed by packing
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.pack/ ; os-9 module name
                    fcc       "Copyright (C) 1988" ; original embedded copyright notice
                    fcc       "By Keith Alphonso" ; original author credit
                    fcc       "Licenced to Alpha Software Technologies" ; original publisher credit and spelling
                    fcc       "All rights reserved" ; original rights notice
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
MessageFilename     fcc       "BBS.msg" ; original message-body store
                    fcb       C$CR      ; terminate the OS-9 pathname
IndexFilename       fcc       "BBS.msg.inx" ; original fixed-record index
                    fcb       C$CR      ; terminate the OS-9 pathname
MessageListFilename fcc       "BBs.msg.lst" ; optional per-user saved-message positions, original case retained
                    fcb       C$CR      ; terminate the OS-9 pathname
PleaseWaitMessage   fcb       C$LF      ; begin the progress notice on a fresh line
                    fcc       "One moment please..." ; packing startup notice
                    fcb       C$LF,C$CR ; leave a blank line after the notice
IndexScratchFilename fcc       "msg.scratch" ; temporary rebuilt index despite the historical name
                    fcb       C$CR      ; terminate the OS-9 pathname
MessageScratchFilename fcc       "inx.scratch" ; temporary rebuilt body store despite the historical name
                    fcb       C$CR      ; terminate the OS-9 pathname
CurrentDirectoryName fcc       "."       ; raw directory opened by the rename helper
                    fcb       C$CR      ; terminate the pathname
LegacyRenameText    fcc       "Rename" ; retained unreferenced text from the original module
                    fcb       C$CR      ; terminate the legacy text
PackingMessageNotice fcc       "Packing message..." ; shown once for every removed record
                    fcb       C$CR      ; terminate the status line

start               lda       ,x        ; inspect the optional board-directory argument
                    cmpa      #C$CR     ; a bare parameter line keeps the current directory
                    beq       InitializePack ; skip directory setup when no argument was supplied
                    lda       #READ.    ; select data-directory mode for I$ChgDir
                    os9       I$ChgDir  ; make the requested board directory current
                    lbcs      ExitRestoringUser ; return directory errors unchanged

* packing requires privileged access because it replaces the live message files and
* rewrites raw directory entries during the final rename.
InitializePack      leax      >DeletedMessageNumbers,u ; initialize the removed-number array
                    stx       <DeletedNumberCursor,u ; no deleted numbers have been recorded yet
                    clr       <CurrentMessageNumber,u ; clear the scan counter's high byte
                    clr       <CurrentMessageNumber+1,u ; clear the scan counter's low byte
                    os9       F$ID      ; obtain the caller's OS-9 user ID in Y
                    sty       CallerUserId,u ; retain it for credential restoration
                    ldy       #0        ; select the superuser identity
                    os9       F$SUser   ; gain replacement and raw-directory access
                    clr       DeletedBeforeCount+1,u ; initialize the adjustment count's low byte
                    clr       DeletedBeforeCount,u ; initialize its high byte
                    leax      >PleaseWaitMessage,pc ; select the startup notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; tell the operator that compaction has begun

* the misleading historical scratch names are crossed: msg.scratch receives the new
* index, while inx.scratch receives the compacted message bodies.
                    leax      >IndexFilename,pc ; select the old fixed-record index
                    lda       #READ.    ; scan without modifying the original
                    os9       I$Open    ; open BBS.msg.inx
                    lbcs      ExitRestoringUser ; restore credentials after open failures
                    sta       OldIndexPath,u ; retain the original index path
                    leax      >MessageFilename,pc ; select the old body store
                    lda       #READ.    ; bodies are copied sequentially
                    os9       I$Open    ; open BBS.msg
                    lbcs      ExitRestoringUser ; restore credentials after open failures
                    sta       OldMessagePath,u ; retain the original body path
                    leax      >IndexScratchFilename,pc ; select msg.scratch
                    lda       #WRITE.   ; create it as the new index output
                    ldb       #11       ; preserve the original file-attribute byte
                    os9       I$Create  ; create or replace the index scratch file
                    lbcs      ExitRestoringUser ; stop before touching the originals on failure
                    sta       NewIndexPath,u ; retain the rebuilt-index path
                    leax      >MessageScratchFilename,pc ; select inx.scratch
                    lda       #WRITE.   ; create it as the new body output
                    ldb       #11       ; preserve the original file-attribute byte
                    os9       I$Create  ; create or replace the body scratch file
                    sta       NewMessagePath,u ; retain the rebuilt-body path

* initialize the packed body position and copy the old header as a placeholder.
                    clr       NewBodyOffset,u ; terminate the compacted body at its new end
                    clr       NewBodyOffset+1,u ; clear body EOF byte one
                    clr       NewBodyOffsetLow,u ; clear body EOF byte two
                    clr       NewBodyOffsetLow+1,u ; clear body EOF byte three
                    leax      >IndexHeader,u ; receive the complete old index header
                    ldy       #64       ; preserve its fixed size
                    lda       OldIndexPath,u ; select the original index
                    os9       I$Read    ; load header state and high-water mark
                    lbcs      ExitRestoringUser ; abort on a missing or damaged header
                    lda       NewIndexPath,u ; select the rebuilt index
                    os9       I$Write   ; reserve its header at offset zero

* index and body files are parallel streams: every record corresponds to one body
* terminated by a CR-only line. Live records receive the new packed body offset.
ReadNextIndexRecord ldd       <CurrentMessageNumber,u ; advance the original record number
                    addd      #1        ; account for the next record after the header
                    std       <CurrentMessageNumber,u ; retain it for deletion bookkeeping
                    leax      >IndexRecord,u ; receive one complete index record
                    ldy       #64       ; enforce the fixed record boundary
                    lda       OldIndexPath,u ; select the original index
                    os9       I$Read    ; fetch the record parallel to the next body
                    lbcs      FinalizePackedFiles ; eof finishes the compaction pass
                    cmpy      #64       ; reject a partial trailing record
                    lbne      FinalizePackedFiles ; finalize only complete records
                    ldd       >IndexRecord,u ; inspect the body-offset high word
                    cmpd      #$FFFF    ; recognize the deletion tombstone
                    beq       SkipDeletedMessage ; omit this record and its body
                    ldd       NewBodyOffset,u ; fetch the packed body's current high word
                    std       >IndexRecord,u ; replace the record's old body offset
                    ldd       NewBodyOffsetLow,u ; fetch the packed body's current low word
                    std       >PackedRecordBodyOffsetLow,u ; complete the new 32-bit offset
                    lda       NewIndexPath,u ; select the rebuilt index
                    os9       I$Write   ; append the relocated live record
CopyLiveMessageLine lda       OldMessagePath,u ; select the original body stream
                    leax      >MessageLine,u ; receive one CR-terminated body line
                    ldy       #80       ; retain the historical physical-line bound
                    os9       I$ReadLn  ; copy the next line of this live message
                    bcs       FinalizePackedFiles ; a damaged body ends packing
                    lda       NewMessagePath,u ; select the rebuilt body stream
                    os9       I$WritLn  ; append the line verbatim
                    tfr       y,d       ; convert the written length to offset arithmetic
                    addd      NewBodyOffsetLow,u ; advance the packed body's low word
                    std       NewBodyOffsetLow,u ; retain the new low word
                    bcc       BodyOffsetUpdated ; avoid a high-word update without carry
                    ldd       NewBodyOffset,u ; recover the packed offset's high word
                    addd      #1        ; propagate low-word overflow
                    std       NewBodyOffset,u ; retain the complete 32-bit position
BodyOffsetUpdated   cmpy      #1        ; a CR-only line terminates one stored message
                    bhi       CopyLiveMessageLine ; copy the rest of this live body
                    bra       ReadNextIndexRecord ; relocate the following index record

* remember every removed original message number for BBs.msg.lst correction, reduce
* the packed high message count, and consume the deleted body without copying it.
SkipDeletedMessage  ldx       <DeletedNumberCursor,u ; select the next array slot
                    ldd       <CurrentMessageNumber,u ; fetch the deleted original number
                    std       ,x++      ; append it to the removal list
                    stx       <DeletedNumberCursor,u ; preserve the next free slot
                    leax      >PackingMessageNotice,pc ; select the per-removal notice
                    ldy       #200      ; let I$WritLn stop at its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; report progress for this tombstone
                    ldd       >IndexHeader,u ; recover the packed high message number
                    subd      #1        ; one fewer record will survive
                    std       >IndexHeader,u ; publish the reduced count
SkipDeletedBodyLine lda       OldMessagePath,u ; select the original body stream
                    leax      >MessageLine,u ; discard into the shared line buffer
                    ldy       #80       ; retain the historical physical-line bound
                    os9       I$ReadLn  ; consume one line without writing it
                    bcs       FinalizePackedFiles ; a damaged body ends packing
                    cmpy      #1        ; recognize the CR-only body terminator
                    bhi       SkipDeletedBodyLine ; discard all remaining message lines
                    lbra      ReadNextIndexRecord ; inspect the next index record
* finish the rebuilt header with the packed body EOF, then replace the old pair only
* after every scratch write has completed.
FinalizePackedFiles ldd       NewBodyOffset,u ; fetch the rebuilt body's high EOF word
                    std       >PackedBodyEndHigh,u ; store it at header offset two
                    ldd       NewBodyOffsetLow,u ; fetch the rebuilt body's low EOF word
                    std       >PackedBodyEndLow,u ; store it at header offset four
                    pshs      u         ; protect workspace U while forming offset zero
                    lda       NewIndexPath,u ; select the rebuilt index
                    ldx       #0        ; supply zero as the seek high word
                    ldu       #0        ; supply zero as the seek low word
                    os9       I$Seek    ; return to the placeholder header
                    puls      u         ; recover the workspace pointer
                    lbcs      ExitRestoringUser ; preserve seek errors and restore credentials
                    leax      >IndexHeader,u ; select the finalized 64-byte header
                    ldy       #64       ; overwrite exactly its reserved block
                    lda       NewIndexPath,u ; select the rebuilt index
                    os9       I$Write   ; publish the reduced count and packed EOF

* close all four streams before deleting the originals. The scratch files are renamed
* by editing their raw directory entries because this OS-9 environment lacks a rename call.
                    lda       OldIndexPath,u ; select the original index
                    os9       I$Close   ; release it before deletion
                    lbcs      ExitRestoringUser ; preserve close failures
                    lda       OldMessagePath,u ; select the original body store
                    os9       I$Close   ; release it before deletion
                    lbcs      ExitRestoringUser ; preserve close failures
                    lda       NewIndexPath,u ; select the rebuilt index
                    os9       I$Close   ; flush and release it before renaming
                    lbcs      ExitRestoringUser ; preserve close failures
                    lda       NewMessagePath,u ; select the rebuilt body store
                    os9       I$Close   ; flush and release it before renaming
                    lbcs      ExitRestoringUser ; preserve close failures
                    leax      >IndexFilename,pc ; select the old index pathname
                    os9       I$Delete  ; remove BBS.msg.inx
                    lbcs      ExitRestoringUser ; stop if replacement cannot proceed safely
                    leax      >MessageFilename,pc ; select the old body pathname
                    os9       I$Delete  ; remove BBS.msg
                    lbcs      ExitRestoringUser ; stop if replacement cannot proceed safely
                    leax      >IndexScratchFilename,pc ; identify msg.scratch as the rename source
                    leay      >IndexFilename,pc ; supply BBS.msg.inx as its replacement name
                    lbsr      RenameScratchFile ; rewrite the directory entry in place
                    leax      >MessageScratchFilename,pc ; identify inx.scratch as the source
                    leay      >MessageFilename,pc ; supply BBS.msg as its replacement name
                    lbsr      RenameScratchFile ; rewrite the directory entry in place

* if BBs.msg.lst exists, reduce every saved message position by the number of removed
* original messages at or below it. Each list record is four bytes; only its final word
* is rewritten.
                    leax      >MessageListFilename,pc ; select the optional saved-position file
                    lda       #UPDAT.   ; corrections are performed in place
                    os9       I$Open    ; open BBs.msg.lst when present
                    lbcs      FinishListAdjustment ; absence does not make packing fail
                    sta       MessageListPath,u ; retain the shared read/write path
AdjustNextListRecord lda       MessageListPath,u ; select the saved-position stream
                    leax      <MessageListRecord,u ; receive one four-byte record
                    ldy       #4        ; preserve its fixed record boundary
                    os9       I$Read    ; load the leading word and last-read message
                    lbcs      FinishListAdjustment ; eof completes the optional correction pass
                    leax      >DeletedMessageNumbers,u ; scan removed original numbers from the start
                    clr       DeletedBeforeCount+1,u ; reset the low byte of the 16-bit count
CountDeletedBefore  ldd       ,x++      ; fetch the next removed original message number
                    cmpd      <LastReadMessage,u ; compare it with this user's saved position
                    bhi       ContinueDeletedCount ; do not count deletions above that position
                    inc       DeletedBeforeCount+1,u ; account for a deletion at or below it
ContinueDeletedCount cmpx      <DeletedNumberCursor,u ; test against the array's exclusive end
                    bcs       CountDeletedBefore ; examine every recorded deletion
                    ldd       <LastReadMessage,u ; recover the old saved position
                    subd      DeletedBeforeCount,u ; renumber it for the compacted index
                    std       <LastReadMessage,u ; retain the corrected value
                    lda       MessageListPath,u ; select BBs.msg.lst
                    ldb       #SS.Pos   ; obtain the position after the four-byte record
                    pshs      u         ; protect workspace U while it holds the low offset word
                    os9       I$GetStt  ; return the current file position in X:U
                    leau      -2,u      ; rewind to the record's final word
                    os9       I$Seek    ; position at LastReadMessage
                    puls      u         ; recover the workspace pointer
                    leax      <LastReadMessage,u ; select the corrected word only
                    ldy       #2        ; preserve the leading list-record word
                    os9       I$Write   ; replace the saved message position
                    bra       AdjustNextListRecord ; correct the following user record
FinishListAdjustment clrb                ; report successful packing even without a list file
ExitRestoringUser   pshs      b         ; protect the pending exit status
                    ldy       CallerUserId,u ; recover the original process identity
                    os9       F$SUser   ; drop temporary superuser privileges
                    puls      b         ; recover the packing status
                    os9       F$Exit    ; return it to the invoking process
* rename both scratch files by scanning raw 32-byte directory entries. OS-9 directory
* names terminate by setting bit 7 on the final character rather than storing CR.
* the routine ignores its nominal X/Y arguments and recognizes both scratch names itself.
RenameScratchFile   leax      >CurrentDirectoryName,pc ; select the current directory
                    lda       #$83      ; request raw update access to a directory path
                    os9       I$Open    ; open '.' as a fixed-record stream
                    lbcs      ExitRestoringUser ; preserve raw-directory open errors
                    sta       RenameDirectoryPath,u ; retain the directory path
                    clr       <DirectoryEntryIndex,u ; begin before directory slot one
ReadNextDirectoryEntry pshs      u         ; protect workspace U while it becomes a seek offset
                    lda       <DirectoryEntryIndex,u ; recover the current one-byte slot index
                    inca                ; advance to the next directory entry
                    sta       <DirectoryEntryIndex,u ; retain the slot being inspected
                    ldb       #32       ; directory entries occupy 32 bytes
                    mul                 ; convert the slot index to a byte offset
                    tfr       d,x       ; stage the 16-bit product for X:U
                    lda       RenameDirectoryPath,u ; select the raw directory
                    ldu       #0        ; provide a zero high word before exchanging
                    exg       x,u       ; place offset zero in X and the product in U
                    os9       I$Seek    ; position at the selected raw entry
                    puls      u         ; recover the workspace pointer
                    leax      <DirectoryEntry,u ; receive the complete entry
                    ldy       #32       ; preserve the directory record boundary
                    lda       RenameDirectoryPath,u ; select the raw directory
                    os9       I$Read    ; load its name and descriptor-sector bytes
                    bcs       EndDirectoryScan ; eof or error ends this rename invocation
                    leay      >IndexScratchFilename,pc ; compare against msg.scratch
                    leax      <DirectoryEntry,u ; begin at the raw entry name
CompareIndexScratchName lda       ,x+       ; fetch the next high-bit-terminated entry byte
                    bmi       IndexScratchNameMatched ; validate its final character separately
                    cmpa      ,y+       ; require the corresponding scratch-name byte
                    bne       TryMessageScratchName ; fall back to the other scratch name
                    bra       CompareIndexScratchName ; compare through the name terminator
TryMessageScratchName leax      <DirectoryEntry,u ; restart at the raw entry name
                    leay      >MessageScratchFilename,pc ; compare against inx.scratch
CompareMessageScratchName lda       ,x+       ; fetch the next high-bit-terminated entry byte
                    bmi       MessageScratchNameMatched ; validate its final character separately
                    cmpa      ,y+       ; require the corresponding scratch-name byte
                    bne       ContinueDirectoryScan ; unrelated entry; scan the next slot
                    bra       CompareMessageScratchName ; compare through the name terminator
ContinueDirectoryScan bra       ReadNextDirectoryEntry ; inspect the following directory slot
EndDirectoryScan    cmpb      #E$EOF    ; eof is normal after a rename or full scan
                    lbne      ExitRestoringUser ; preserve other raw-directory errors
                    lda       RenameDirectoryPath,u ; select the raw directory path
                    os9       I$Close   ; release it before returning to the packer
                    rts                 ; finish this rename invocation
IndexScratchNameMatched anda      #$7F      ; remove the directory end marker for comparison
                    cmpa      ,y+       ; require the final msg.scratch character
                    bne       TryMessageScratchName ; reject a shorter prefix match
                    lda       ,y+       ; inspect the source pathname byte after the match
                    cmpa      #C$CR     ; require the whole scratch name to end here
                    bne       TryMessageScratchName ; reject a longer source name
                    leax      <DirectoryEntry,u ; overwrite the raw name field
                    leay      >IndexFilename,pc ; rename this entry BBS.msg.inx
                    bra       CopyReplacementName ; share directory-name encoding
MessageScratchNameMatched anda      #$7F      ; remove the directory end marker for comparison
                    cmpa      ,y+       ; require the final inx.scratch character
                    bne       ContinueDirectoryScan ; reject a shorter prefix match
                    lda       #C$CR     ; compare against the source pathname terminator
                    cmpa      ,y+       ; require the whole scratch name to end here
                    bne       ContinueDirectoryScan ; reject a longer source name
                    leax      <DirectoryEntry,u ; overwrite the raw name field
                    leay      >MessageFilename,pc ; rename this entry BBS.msg
CopyReplacementName lda       ,y+       ; fetch the next permanent-name character
                    cmpa      #C$CR     ; stop before the OS-9 pathname terminator
                    beq       WriteRenamedEntry ; encode the raw directory terminator
                    sta       ,x+       ; copy the character into the entry name
                    bra       CopyReplacementName ; copy the complete replacement name
WriteRenamedEntry   lda       ,-x       ; recover the final copied name character
                    ora       #$80      ; set its raw-directory end marker
                    sta       ,x        ; publish the encoded final character
                    lda       <DirectoryEntryIndex,u ; recover the matching directory slot
                    ldb       #32       ; convert it back to a byte offset
                    mul                 ; form the 16-bit slot position
                    tfr       d,x       ; stage the low offset word
                    lda       RenameDirectoryPath,u ; select the raw directory
                    ldb       #SS.Pos   ; preserve the historical status-code setup
                    pshs      u         ; protect workspace U while it becomes an offset
                    ldu       #0        ; provide a zero high word before exchanging
                    exg       x,u       ; form the 32-bit slot offset in X:U
                    os9       I$Seek    ; return to the matching entry boundary
                    lbcs      ExitRestoringUser ; preserve raw-directory seek errors
                    puls      u         ; recover the workspace pointer
                    leax      <DirectoryEntry,u ; select the renamed raw entry
                    ldy       #32       ; rewrite exactly one directory record
                    lda       RenameDirectoryPath,u ; select the raw directory
                    os9       I$Write   ; commit the new high-bit-terminated name
                    ldb       #E$EOF    ; reuse the normal scan-completion path
                    lbra      EndDirectoryScan ; close the directory and return
OpaqueTrailer       fcb       $16,$FF,$40 ; unreachable bytes preserved from the original module

                    emod      ;         append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end       ;         finish this assembly unit
