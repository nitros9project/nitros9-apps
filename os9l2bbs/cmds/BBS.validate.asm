**********************************************************************
* BBS.validate - OS-9 Level 2 BBS command
*
* Syntax: BBS.validate
* Purpose: Review pending new-user data and create an accepted BBS.users record.
* Sysop workflow over new_user_file/new_user_log and BBS.users.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.validate
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare header, entry point, and workspace

UsersPath           rmb       1         ; update path for BBS.users
AliasPath           rmb       1         ; update path for bbs.alias
ConfirmationKey     rmb       1         ; one-byte Y/N response
AliasNumberEnd      rmb       2         ; insertion point for the shared user number
UsersRecord         rmb       80        ; beginning of the assembled BBS.users line
AliasRecord         rmb       1         ; alias line begins 80 bytes after UsersRecord
RecordWorkspaceTail rmb       479       ; shared tail for the two variable-length records
size                equ       .         ; total process workspace size

name                fcs       /BBS.validate/ ; module name exposed to OS-9
NamePrompt          fcc       "Enter new user's name:=====>" ; fixed-width field prompt
PasswordPrompt      fcc       "Enter new user's password:=>" ; fixed-width field prompt
ProgramPrompt       fcc       "Enter new user's program:==>" ; fixed-width field prompt
UserNumberPrompt    fcc       "Enter new user's number:===>" ; fixed-width field prompt
TimeLimitPrompt     fcc       "Enter new user's time limit>" ; fixed-width field prompt
AliasPrompt         fcc       "Enter new user's alias:====>" ; fixed-width field prompt
PreviewHeading      fcb       C$LF      ; separate the proposed record from entry
                    fcc       "New BBS.users line will read as follows:" ; preview explanation
                    fcb       C$CR      ; terminate the heading
ConfirmationPrompt  fcb       C$CR      ; finish the previewed record line
                    fcb       C$LF      ; begin the confirmation question
                    fcc       "Is this line correct? (Y/N):" ; request explicit approval
UsersFilename       fcc       "BBS.users" ; authentication database in the current directory
                    fcb       C$CR      ; terminate the pathname
AliasFilename       fcc       "/dd/bbs/bbs.alias" ; system-wide display-name map
                    fcb       C$CR      ; terminate the pathname
ResponseNewline     fcb       C$CR      ; move past the single-key response
                    fcb       C$LF      ; advance the terminal display
start               leax      >UsersFilename,pc ; locate the account database
                    lda       #UPDAT.   ; require append-capable access
                    os9       I$Open    ; use the existing BBS.users when present
                    bcc       UsersFileReady ; continue at UsersFileReady when carry confirms success or no unsigned overflow
                    cmpb      #E$PNNF   ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve any other open error
                    os9       F$ID      ; creation is restricted to the sysop
                    ldb       #E$FNA    ; prepare a meaningful non-sysop status
                    cmpy      #0        ; user zero owns the BBS databases
                    lbne      ExitWithStatus ; continue at ExitWithStatus when more data or a different case remains
                    ldb       #3        ; owner read/write attributes
                    os9       I$Create  ; initialize an empty BBS.users
                    lbcs      ExitWithStatus ; report creation failure
UsersFileReady      sta       UsersPath,u ; retain the account stream
                    leax      >AliasFilename,pc ; locate the alias database
                    lda       #UPDAT.   ; require append-capable access
                    os9       I$Open    ; use the existing bbs.alias when present
                    bcc       AliasFileReady ; continue at AliasFileReady when carry confirms success or no unsigned overflow
                    cmpb      #E$PNNF   ; create only when the file is absent
                    lbne      ExitWithStatus ; preserve any other open error
                    os9       F$ID      ; creation is restricted to the sysop
                    ldb       #E$FNA    ; prepare a meaningful non-sysop status
                    cmpy      #0        ; user zero owns the BBS databases
                    lbne      ExitWithStatus ; continue at ExitWithStatus when more data or a different case remains
                    ldb       #11       ; owner read/write and public read attributes
                    os9       I$Create  ; initialize an empty alias database
                    lbcs      ExitWithStatus ; report creation failure
AliasFileReady      sta       AliasPath,u ; retain the alias stream

* Position both update streams at end-of-file before collecting input.  SS.Size
* returns the 32-bit length in X:U, which I$Seek consumes directly.
                    lda       UsersPath,u ; select BBS.users
                    ldb       #SS.Size  ; request its append offset
                    pshs      u         ; free U for the low position word
                    os9       I$GetStt  ; obtain the current file length
                    lbcs      ExitWithStatus ; continue at ExitWithStatus when carry reports an error or unsigned overflow
                    os9       I$Seek    ; establish the account append position
                    lbcs      ExitWithStatus ; continue at ExitWithStatus when carry reports an error or unsigned overflow
                    puls      u         ; recover the workspace pointer
                    lda       AliasPath,u ; select bbs.alias
                    ldb       #SS.Size  ; request its append offset
                    pshs      u         ; free U for the low position word
                    os9       I$GetStt  ; obtain the current file length
                    lbcs      ExitWithStatus ; continue at ExitWithStatus when carry reports an error or unsigned overflow
                    os9       I$Seek    ; establish the alias append position
                    lbcs      ExitWithStatus ; continue at ExitWithStatus when carry reports an error or unsigned overflow
                    puls      u         ; recover the workspace pointer
PromptForAccount    leax      >NamePrompt,pc ; begin a fresh candidate record
                    ldy       #28       ; every field prompt is 28 bytes
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    leax      UsersRecord,u ; write the name at the record start
                    clra                ; read from standard input
                    ldy       #80       ; cap this field at one input line
                    os9       I$ReadLn  ; retain the returned byte count in Y
                    pshs      x         ; preserve the field's starting address
FoldNameLoop        lda       ,x        ; inspect the next name byte
                    cmpa      #'a       ; bytes below lowercase need no folding
                    bcs       StoreNameByte ; continue at StoreNameByte when carry reports an error or unsigned overflow
                    anda      #$DF      ; normalize lowercase ASCII for login matching
StoreNameByte       sta       ,x+       ; replace the byte and advance
                    cmpa      #C$CR     ; process through the line terminator
                    bne       FoldNameLoop ; continue at FoldNameLoop when more data or a different case remains
                    puls      x         ; recover the name's starting address
                    tfr       y,d       ; use its actual input length
                    leax      d,x       ; advance to the byte after the name
                    lda       #','      ; account records use comma-delimited fields
                    sta       -1,x      ; replace the name's carriage return
                    pshs      x         ; retain the next free record byte

                    leax      >PasswordPrompt,pc ; request the account password
                    ldy       #28       ; write the fixed-width prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    puls      x         ; append after the name delimiter
                    ldy       #80       ; cap this field at one input line
                    clra                ; read from standard input
                    os9       I$ReadLn  ; append password and carriage return
                    pshs      x         ; preserve the field's starting address
FoldPasswordLoop    lda       ,x        ; inspect the next password byte
                    cmpa      #'a       ; bytes below lowercase need no folding
                    bcs       StorePasswordByte ; continue at StorePasswordByte when carry reports an error or unsigned overflow
                    anda      #$DF      ; match BBS.login's uppercase comparison form
StorePasswordByte   sta       ,x+       ; replace the byte and advance
                    cmpa      #C$CR     ; process through the line terminator
                    bne       FoldPasswordLoop ; continue at FoldPasswordLoop when more data or a different case remains
                    puls      x         ; recover the password's start
                    tfr       y,d       ; use its actual input length
                    leax      d,x       ; advance to the next free record byte
                    lda       #','      ; delimit the password field
                    sta       -1,x      ; replace its carriage return
                    pshs      x         ; retain the next free account byte
                    leax      >ProgramPrompt,pc ; request the login command or script
                    ldy       #28       ; write the fixed-width prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    puls      x         ; append after the password delimiter
                    clra                ; read from standard input
                    ldy       #80       ; cap this field at one input line
                    os9       I$ReadLn  ; append the configured program
                    tfr       y,d       ; use its actual input length
                    leax      d,x       ; advance to the next free account byte
                    lda       #','      ; delimit the program field
                    sta       -1,x      ; replace its carriage return
                    pshs      x         ; retain the account insertion point

                    leax      >AliasPrompt,pc ; collect the independent display name
                    ldy       #28       ; write the fixed-width prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    leax      <AliasRecord,u ; begin the bbs.alias record
                    ldy       #80       ; cap the alias at one input line
                    clra                ; read from standard input
                    os9       I$ReadLn  ; store alias and carriage return
                    tfr       y,d       ; use its actual input length
                    leax      d,x       ; advance beyond the alias
                    lda       #','      ; alias records use alias,user-number
                    sta       -1,x      ; replace the alias carriage return
                    stx       AliasNumberEnd,u ; remember where its number belongs

                    leax      >UserNumberPrompt,pc ; request the shared OS-9 user ID
                    ldy       #28       ; write the fixed-width prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    puls      x         ; append the number to BBS.users
                    ldy       #80       ; cap the numeric field at one input line
                    clra                ; read from standard input
                    os9       I$ReadLn  ; retain the carriage return for alias output
                    ldy       AliasNumberEnd,u ; append the same number after alias comma
CopyUserNumberToAlias
                    lda       ,x+       ; copy the next number byte
                    sta       ,y+       ; append it to the alias record
                    cmpa      #C$CR     ; include the terminating carriage return
                    bne       CopyUserNumberToAlias ; continue at CopyUserNumberToAlias when more data or a different case remains
                    lda       #','      ; authentication records have one final optional field
                    sta       -1,x      ; replace its user-number terminator
                    pshs      x         ; retain the time-limit insertion point

                    leax      >TimeLimitPrompt,pc ; request daily minutes or zero
                    ldy       #28       ; write the fixed-width prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    puls      x         ; append after the user-number delimiter
                    ldy       #80       ; cap the final field at one input line
                    clra                ; read from standard input
                    os9       I$ReadLn  ; leave its CR as the record terminator
                    leax      >PreviewHeading,pc ; introduce the proposed account line
                    ldy       #200      ; let I$WritLn find the embedded terminator
                    lda       #1        ; display it on standard output
                    os9       I$WritLn
                    leax      UsersRecord,u ; show exactly what BBS.login will parse
                    ldy       #200      ; bound the variable-length record preview
                    os9       I$WritLn
                    leax      >ConfirmationPrompt,pc ; request approval without a trailing CR
                    ldy       #30       ; write the complete fixed prompt
                    lda       #1        ; display it on standard output
                    os9       I$Write
                    leax      ConfirmationKey,u ; receive one decision character
                    ldy       #1        ; do not wait for a complete line
                    clra                ; read from standard input
                    os9       I$Read
                    leax      >ResponseNewline,pc ; move output beyond the response
                    ldy       #1        ; line output stops on the first carriage return
                    lda       #1        ; target standard output
                    os9       I$WritLn
                    lda       ConfirmationKey,u ; normalize the operator's answer
                    anda      #$DF      ; accept lowercase as uppercase
                    cmpa      #'Y       ; only an explicit yes commits the records
                    lbne      PromptForAccount ; discard both buffers and start over

                    lda       UsersPath,u ; append to the authentication database
                    leax      UsersRecord,u ; select the approved account line
                    ldy       #81       ; bound the write beyond its expected maximum
                    os9       I$WritLn  ; stop at the time-limit carriage return
                    lbcs      ExitWithStatus ; report a partial account update
                    lda       AliasPath,u ; append to the alias database
                    leax      <AliasRecord,u ; select alias,user-number
                    ldy       #81       ; bound the write beyond its expected maximum
                    os9       I$WritLn  ; stop at the copied number's carriage return
                    lbcs      ExitWithStatus ; report a partial alias update
                    clrb                ; both related records were accepted
ExitWithStatus      os9       F$Exit    ; return B as the process status

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
