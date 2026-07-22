**********************************************************************
* New_user - OS-9 Level 2 BBS command
*
* Syntax: New_user
* Purpose: Collect a prospective caller registration for later sysop validation.
* Uses new_user_form/new_user_message and writes pending-user files.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded the registration application and separated linked runtime support.
*          2026/07/21  Codex
* Decoded compiler startup, relocation, stack guards, and process exit.
*          2026/07/21  Codex
* Decoded stream-slot allocation and low-level OS-9 file wrappers.
*          2026/07/21  Codex
* Decoded mode parsing and fopen/fdopen/freopen stream construction.
*          2026/07/21  Codex
* Decoded buffered stream initialization, refill, flush, and close paths.
**********************************************************************

                    nam       New_user
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

* the compiler keeps its global/runtime state relative to Y.  The registration
* application owns six consecutive 80-byte input fields at the end of that area.
RuntimeInputStream  equ       $000E     ; standard-input stream descriptor
RuntimeOutputStream equ       $001B     ; standard-output stream descriptor
RuntimeInitialStack equ       $019D     ; stack pointer captured at process startup
RuntimeSeekHigh     equ       $01A1     ; high word of the last seek result
RuntimeSeekLow      equ       $01A3     ; low word of the last seek result
RuntimeHeapEnd      equ       $01A9     ; first byte unavailable to heap allocation
RuntimeStackLowWater equ       $01AB     ; deepest stack address validated so far
RuntimeErrorCode    equ       $01AD     ; last library or OS-9 error code

OpenModeRead        equ       $0001     ; permit reads
OpenModeWrite       equ       $0002     ; permit writes
OpenModeUpdate      equ       $0003     ; permit both reads and writes
OpenModeExecute     equ       $0004     ; permit execution access
OpenModeDirectory   equ       $0080     ; request OS-9 directory access
ApplicantName       equ       $01AF     ; caller's real name
ApplicantCity       equ       $01FF     ; caller's city
ApplicantState      equ       $024F     ; caller's state
ApplicantPhone      equ       $029F     ; caller's telephone number
ApplicantAlias      equ       $02EF     ; requested BBS alias
ApplicantPassword   equ       $033F     ; requested BBS password

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       338       ; reserve 338 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       58        ; reserve 58 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       1418      ; reserve 1418 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

* compiler stream descriptor layout; each entry occupies thirteen bytes
StreamCursor        equ       WorkByte_001 ; next buffered byte or write position
StreamBufferStart   equ       WorkWord_001 ; first byte in the assigned buffer
StreamBufferEnd     equ       WorkWord_002 ; byte just beyond the assigned buffer
StreamFlags         equ       WorkWord_003 ; access and buffering state bits
StreamPath          equ       WorkWord_004 ; underlying OS-9 path number
StreamPushbackByte  equ       WorkByte_003 ; one-byte ungetc storage
StreamBufferSize    equ       WorkWord_005 ; capacity of the assigned buffer
StreamDescriptorSize equ       WorkBuffer_001 ; distance between descriptor entries

StreamReadable      equ       $0001     ; reads are permitted
StreamWritable      equ       $0002     ; writes are permitted
StreamUnbuffered    equ       $0004     ; use the descriptor's one-byte fallback
StreamHasBuffer     equ       $0008     ; descriptor has multi-byte buffer storage
StreamAtEof         equ       $0010     ; the last refill reached end-of-file
StreamIoError       equ       $0020     ; the last transfer failed
StreamLineBuffered  equ       $0040     ; transfer carriage-return-terminated lines
StreamFullyBuffered equ       $0080     ; transfer ordinary fixed-size blocks
StreamWriting       equ       $0100     ; the current buffer contains output
StreamInitialized   equ       $8000     ; buffering policy and storage are ready

name                fcs       /New_user/ ; module name exposed to OS-9
                    fcb       $01       ; compiler startup-format version byte
CopyInitializerBytes lda       ,y+       ; copy one byte from the packed initializer image
                    sta       ,u+       ; install it in the process workspace
                    leax      -$01,x    ; count down the current initialized block
                    bne       CopyInitializerBytes ; continue until the block length reaches zero
                    rts                 ; return to the startup dispatcher
start               pshs      y         ; preserve OS-9's parameter length
                    pshs      u         ; preserve the process workspace base
                    clra                ; prepare a zero byte and a 256-byte loop count
                    clrb                ; prepare a zero byte and a 256-byte loop count
ClearDirectPage     sta       ,u+       ; clear the first workspace page
                    decb                ; advance the modulo-256 clear count
                    bne       ClearDirectPage ; clear all 256 direct-page bytes
                    ldx       ,s        ; recover the original workspace base
                    leau      ,x        ; begin initialized data at the workspace base
                    leax      >$03AB,x  ; compute the end of the compiler's initialized/global area
                    pshs      x         ; retain the workspace-clear boundary
                    leay      >RuntimeInitializerImage,pc ; select the packed initializer and relocation image
                    ldx       ,y++      ; read the next initialized block length
                    beq       InitializeSecondDataBlock ; skip an empty first initialized block
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    ldu       $02,s     ; recover the process workspace base beneath the boundary
InitializeSecondDataBlock leau      >WorkByte_002,u ; advance to the second initialized-data destination
                    ldx       ,y++      ; read the next initialized block length
                    beq       ClearRemainingWorkspace ; skip an empty second initialized block
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    clra                ; prepare a zero byte and a 256-byte loop count
ClearRemainingWorkspace cmpu      ,s        ; test whether initialized data reached the global-area end
                    beq       ApplyCodeRelocations ; begin relocation after all remaining BSS is zeroed
                    sta       ,u+       ; install it in the process workspace
                    bra       ClearRemainingWorkspace ; clear another uninitialized workspace byte
ApplyCodeRelocations ldu       $02,s     ; restore the workspace base for relocation
                    ldd       ,y++      ; read the next relocation-table byte length
                    beq       ApplyDataRelocations ; skip an empty code-reference relocation table
                    leax      >0,pc     ; use the module base as the relocation delta
                    lbsr      ApplyRelocationTable ; adjust every address named by this table
ApplyDataRelocations ldd       ,y++      ; read the workspace-reference table length
                    beq       ParseCommandLine ; begin argument parsing when no data relocations remain
                    leax      WorkByte_001,u ; use the process data base as the relocation delta
                    lbsr      ApplyRelocationTable ; adjust every address named by this table
ParseCommandLine    leas      $04,s     ; discard saved startup registers and initializer boundary
                    puls      x         ; recover the OS-9 parameter length
                    stx       >WorkWord_007,u ; retain the original parameter length
                    sty       >WorkWord_006,u ; seed argv with the program-name pointer
                    ldd       #1        ; begin argc with the implicit program name
                    std       >WorkByte_004,u ; seed argc with the implicit program-name argument
                    leay      >WorkBuffer_002,u ; select storage for the argv pointer vector
                    leax      ,s        ; point at OS-9's CR-terminated parameter text
                    lda       ,x+       ; prime the argument scanner with its first byte
ParseNextArgument   ldb       >WorkBuffer_003,u ; recover the current argument count
                    cmpb      #29       ; reserve the thirtieth argv slot for termination
                    beq       InvokeRegistration ; stop parsing at the argument-vector capacity or CR
SkipArgumentDelimiters cmpa      #13       ; recognize the OS-9 parameter terminator
                    beq       InvokeRegistration ; stop parsing at the argument-vector capacity or CR
                    cmpa      #32       ; treat spaces as argument separators
                    beq       ConsumeArgumentDelimiter ; skip a separating space
                    cmpa      #44       ; also accept commas as argument separators
                    bne       CheckQuotedArgument ; classify the first nonseparator byte
ConsumeArgumentDelimiter lda       ,x+       ; advance beyond the current separator
                    bra       SkipArgumentDelimiters ; discard consecutive spaces and commas
CheckQuotedArgument cmpa      #34       ; recognize a double-quoted argument
                    beq       RecordQuotedArgument ; begin a double-quoted argument
                    cmpa      #39       ; also recognize a single-quoted argument
                    bne       RecordBareArgument ; use ordinary delimiter rules otherwise
RecordQuotedArgument stx       ,y++      ; record the first byte inside the quotes as argv
                    inc       >WorkBuffer_003,u ; count the newly discovered argument
                    pshs      a         ; retain the opening quote as the required closer
ScanQuotedArgument  lda       ,x+       ; consume the next quoted byte
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       TerminateQuotedArgument ; terminate an unmatched quote at end-of-line
                    cmpa      ,s        ; test for the matching quote character
                    bne       ScanQuotedArgument ; keep delimiters literal while inside quotes
TerminateQuotedArgument puls      b         ; discard the saved quote character
                    clr       -$01,x    ; replace the closing delimiter with a C-string NUL
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       InvokeRegistration ; stop parsing at the argument-vector capacity or CR
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ParseNextArgument ; look for another argument
RecordBareArgument  leax      -$01,x    ; rewind to include the first unquoted byte
                    stx       ,y++      ; append the argument pointer to argv
                    leax      $01,x     ; resume scanning after its first byte
                    inc       >WorkBuffer_003,u ; count the newly discovered argument
ScanBareArgument    cmpa      #13       ; test the current unquoted byte for termination
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    cmpa      #32       ; treat spaces as argument separators
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    cmpa      #44       ; also accept commas as argument separators
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ScanBareArgument ; consume another ordinary argument byte
TerminateBareArgument clr       -$01,x    ; convert its delimiter to a C-string NUL
                    bra       ParseNextArgument ; look for another argument
InvokeRegistration  leax      >WorkWord_006,u ; pass the completed argv vector to the application
                    pshs      x         ; pass argv through the compiler calling convention
                    ldd       >WorkByte_004,u ; pass the completed argc value
                    pshs      d         ; pass argc beside argv
                    leay      WorkByte_001,u ; establish the compiler global-data base
                    bsr       InitializeRuntimeBounds ; initialize heap and stack collision guards
                    lbsr      RegistrationMain ; run the decoded new-user application
                    clr       ,-s       ; push a zero process exit status
                    clr       ,-s       ; push a zero process exit status
                    lbsr      ExitProcess ; flush runtime state and terminate successfully
InitializeRuntimeBounds leax      >$03AB,y  ; place the heap ceiling after compiler globals
                    stx       >RuntimeHeapEnd,y ; record the heap/stack collision boundary
                    sts       >RuntimeInitialStack,y ; retain the startup stack for diagnostics
                    sts       >RuntimeStackLowWater,y ; initialize or update the deepest validated stack address
                    ldd       #-126     ; require the startup routine's maximum stack allowance
CheckStackSpace     leax      d,s       ; project the requested stack growth below the current S
                    cmpx      >RuntimeStackLowWater,y ; compare with the deepest range checked earlier
                    bcc       StackSpaceAvailable ; return when no new low-water check is needed
                    cmpx      >RuntimeHeapEnd,y ; keep projected stack above compiler globals and heap
                    bcs       AbortStackOverflow ; abort rather than corrupt process data
                    stx       >RuntimeStackLowWater,y ; remember the newly validated low-water address
StackSpaceAvailable rts                 ; return with the requested stack range validated
StackOverflowMessage fcc       "**** STACK OVERFLOW ****" ; fatal compiler-runtime stack diagnostic
                    fcb       C$CR      ; terminate the diagnostic for I$WritLn
AbortStackOverflow  leax      <StackOverflowMessage,pc ; select the fatal stack diagnostic
                    ldb       #E$MemFul ; original runtime reports the collision as memory full
                    pshs      b         ; pass that status to the nonreturning exit wrapper
                    lda       #2        ; write the diagnostic on standard error
                    ldy       #100      ; bound output beyond the fixed message length
                    os9       I$WritLn  ; display the fatal diagnostic through its carriage return
                    clr       ,-s       ; widen the one-byte status to a compiler word
                    lbsr      ExitWithStackStatus ; terminate immediately with E$MemFul
                    ldd       >RuntimeInitialStack,y ; recover the startup stack address
                    subd      >RuntimeStackLowWater,y ; return peak stack consumption in D
                    rts                 ; return to the diagnostic caller

* encoded compiler helper: LDD >RuntimeStackLowWater,Y; SUBD
* >RuntimeHeapEnd,Y; RTS.  The original disassembly retained these bytes as data.
MeasureAvailableStack
                    fcb       $EC,$A9,$01,$AB ; load the recorded low-water address
                    fcb       $A3,$A9,$01,$A9 ; subtract the heap collision boundary
                    fcb       $39       ; return the available gap in D
ApplyRelocationTable
stk_reloc_table_end equ       0         ; packed table end after both temporary pushes
stk_reloc_delta     equ       2         ; code or data base after both temporary pushes
stk_reloc_return    equ       4         ; caller return address after both pushes
                    pshs      x         ; preserve the selected relocation delta
                    leax      d,y       ; locate the end of the packed word-offset table
                    leax      d,x       ; account for the table's own displacement encoding
                    pshs      x         ; retain the computed table end
RelocateNextWord    ldd       ,y++      ; read the next workspace word offset
                    leax      d,u       ; locate the word requiring relocation
                    ldd       ,x        ; recover its link-time relative value
                    addd      $02,s     ; add the selected module or data base
                    std       ,x        ; install the runtime absolute address
                    cmpy      ,s        ; test for the end of the relocation table
                    bne       RelocateNextWord ; relocate every listed word
                    leas      $04,s     ; release the table end and relocation delta
                    rts                 ; return to the startup dispatcher
RegistrationMain
stk_confirmation    equ       0         ; normalized Y/N response after local allocation
stk_log_stream      equ       1         ; append stream pointer after local allocation
stk_saved_u         equ       3         ; caller's U after local allocation
                    pshs      u         ; preserve the caller frame while the registration program runs
                    ldd       #-77      ; require enough stack headroom for the application frame
                    lbsr      CheckStackSpace ; reject a stack that cannot hold the form workflow
                    leas      -$03,s    ; allocate confirmation byte and output-stream pointer
                    leax      >AppendMode,pc ; select append mode so prior requests remain intact
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldx       $0B,s     ; recover the compiler argv vector
                    ldd       $02,x     ; select argv[1], the pending-user log pathname
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      OpenFileStream ; open the caller-supplied log for append
                    leas      $04,s     ; discard two word-sized library arguments
                    std       $01,s     ; retain the stream pointer in the local frame
                    bne       RegistrationFileReady ; continue only with a valid stream
                    ldd       >RuntimeErrorCode,y ; recover the library error associated with the failed open
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >CannotOpenMessage,pc ; select the human-readable failure reason
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      AbortCannotOpen ; print the diagnostic and terminate with the saved error
                    leas      $04,s     ; discard two word-sized library arguments
RegistrationFileReady ldd       #78       ; seed a non-Y answer so the form runs at least once
                    lbra      NormalizeConfirmation ; enter the common confirmation test
CollectRegistration leax      >RegistrationIntro,pc ; select the registration requirements heading
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >AccuracyPrompt,pc ; select the request for accurate caller information
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >FalseInfoWarning,pc ; select the validation warning shown before the form
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >FormDivider,pc ; select the visual separator before the entry fields
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >NamePrompt,pc ; select the real-name prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >CityPrompt,pc ; select the city prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >StatePrompt,pc ; select the state prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >PhonePrompt,pc ; select the telephone prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >AliasPrompt,pc ; select the requested-alias prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >PasswordPrompt,pc ; select the requested-password prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >RegistrationSummaryFormat,pc ; select the name and alias preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LocationSummaryFormat,pc ; select the city and state preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >PhoneSummaryFormat,pc ; select the telephone preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >PasswordSummaryFormat,pc ; select the password preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ConfirmationPrompt,pc ; select the confirmation question
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >RuntimeOutputStream,y ; select the standard-input stream
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      FlushStream ; flush pending terminal output before reading one byte
                    leas      $02,s     ; discard one word-sized library argument
                    ldd       #1        ; request exactly one confirmation character
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; address the local confirmation byte
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    clra                ; form standard-input path zero for the raw read
                    clrb                ; form standard-input path zero for the raw read
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ReadBytes ; read the single confirmation byte without waiting for a line
                    leas      $06,s     ; discard three word-sized library arguments
                    ldb       ,s        ; recover the confirmation character
                    clra                ; form standard-input path zero for the raw read
                    andb      #223      ; fold a lowercase response to uppercase
NormalizeConfirmation stb       ,s        ; store the normalized confirmation in the local frame
                    ldb       ,s        ; recover the confirmation character
                    cmpb      #89       ; accept only an explicit Y
                    lbne      CollectRegistration ; repeat the entire form after any other response
                    leax      >SavingMessage,pc ; select the saving-status message
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >LogHeading,pc ; select the pending-user record heading
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >LogDivider,pc ; select the pending-user record separator
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogNameFormat,pc ; select the real-name record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogCityFormat,pc ; select the city record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogStateFormat,pc ; select the state record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogPhoneFormat,pc ; select the telephone record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogAliasFormat,pc ; select the alias record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogPasswordFormat,pc ; select the password record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >LogBlankLine,pc ; select the record-ending blank line
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ThankYouMessage,pc ; select the completion notice
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leas      $03,s     ; release the application locals
                    puls      pc,u      ; restore the caller frame and return
AbortCannotOpen     pshs      u         ; preserve the caller frame for fatal error reporting
                    ldd       #-72      ; require stack headroom for formatted error output
                    lbsr      CheckStackSpace ; reject a stack that cannot hold the form workflow
                    ldd       $04,s     ; recover the diagnostic string argument
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >StringLineFormat,pc ; select the single-string diagnostic format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    ldd       $06,s     ; recover the saved error status
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ExitProcess ; terminate with the open failure status
                    leas      $02,s     ; discard one word-sized library argument
                    puls      pc,u      ; restore the caller frame and return
AppendMode          fcb       $61       ; ascii "a" selects append mode
                    fcb       $00       ; terminate the compiler-runtime C string
CannotOpenMessage   fcc       "Cannot open file" ; file-open failure text
                    fcb       $00       ; terminate the compiler-runtime C string
RegistrationIntro   fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "To be validated on this system you must enter the following information" ; registration introduction
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
AccuracyPrompt      fcc       "Please enter the information as correctly as possible" ; accuracy reminder
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
FalseInfoWarning    fcc       "any false information will result in your not being validated" ; validation warning
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
FormDivider         fcc       "-------------------------------------------------------------------------" ; form separator
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
NamePrompt          fcc       "Enter your name:==============>" ; real-name prompt
                    fcb       $00       ; terminate the compiler-runtime C string
CityPrompt          fcc       "Enter your city:==============>" ; city prompt
                    fcb       $00       ; terminate the compiler-runtime C string
StatePrompt         fcc       "Enter your state:=============>" ; state prompt
                    fcb       $00       ; terminate the compiler-runtime C string
PhonePrompt         fcc       "Enter your phone #:===========>" ; telephone prompt
                    fcb       $00       ; terminate the compiler-runtime C string
AliasPrompt         fcc       "Enter your alias (if any):====>" ; alias prompt
                    fcb       $00       ; terminate the compiler-runtime C string
PasswordPrompt      fcc       "Enter your desired password:==>" ; password prompt
                    fcb       $00       ; terminate the compiler-runtime C string
RegistrationSummaryFormat fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "You are %s alias %s" ; name/alias preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LocationSummaryFormat fcc       "Calling from %s, %s" ; city/state preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
PhoneSummaryFormat  fcc       "Phone #%s" ; telephone preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
PasswordSummaryFormat fcc       "Password:%s" ; password preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
ConfirmationPrompt  fcc       "Is this information correct?" ; confirmation question
                    fcb       $00       ; terminate the compiler-runtime C string
SavingMessage       fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "One moment please..." ; saving-status text
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogHeading          fcc       "New user log" ; pending-user record heading
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogDivider          fcc       "-----------------------------------------------------" ; pending-user record separator
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogNameFormat       fcc       "User name       :%s" ; real-name log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogCityFormat       fcc       "City            :%s" ; city log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogStateFormat      fcc       "State           :%s" ; state log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogPhoneFormat      fcc       "Phone #         :%s" ; telephone log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogAliasFormat      fcc       "Desired alias   :%s" ; alias log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogPasswordFormat   fcc       "Desired password:%s" ; password log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogBlankLine        fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
ThankYouMessage     fcc       "Thank you, the sysop will validate you as soon as possible." ; registration completion text
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
StringLineFormat    fcb       $25       ; begin the %s conversion
                    fcb       $73       ; complete the %s conversion
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
AllocateStreamSlot
stk_alloc_saved_u   equ       0         ; caller's U after the entry push
stk_alloc_return    equ       2         ; caller return address
                    pshs      u         ; preserve the caller's descriptor pointer
                    leau      >RuntimeInputStream,y ; select the first of sixteen stream descriptors
ScanStreamSlots     ldd       StreamFlags,u ; inspect this descriptor's state flags
                    clra                ; isolate its low-byte open/read bits
                    andb      #3
                    lbeq      ReturnFreeStreamSlot ; reuse an inactive descriptor
                    leau      StreamDescriptorSize,u ; advance by one descriptor structure
                    pshs      u         ; compare the candidate with the table end
                    leax      >$00DE,y  ; point just beyond the final descriptor
                    cmpx      ,s++
                    bhi       ScanStreamSlots ; inspect another in-range slot
                    ldd       #E$PthFul ; report exhaustion of runtime stream slots
                    std       >RuntimeErrorCode,y
                    lbra      StreamSetupFailed
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
InitializeStreamDescriptor
stk_init_saved_u    equ       0         ; caller's U after the entry push
stk_init_return     equ       2         ; caller return address
stk_init_path       equ       4         ; path number supplied by OS-9
stk_init_mode       equ       6         ; mode-string pointer
stk_init_stream     equ       8         ; supplied descriptor or null
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $08,s     ; reuse a caller-supplied stream when present
                    bne       HaveStreamDescriptor
                    bsr       AllocateStreamSlot ; otherwise claim an inactive table entry
                    tfr       d,u       ; use the allocator's descriptor pointer
HaveStreamDescriptor
                    stu       -$02,s    ; mirror the pointer in the compiler spill slot and set Z
                    beq       StreamSetupFailed ; propagate table exhaustion as null
                    ldd       $04,s     ; attach the already-open OS-9 path
                    std       StreamPath,u
                    ldx       $06,s     ; inspect the textual access mode
                    ldb       $01,x     ; a plus in either modifier position means update access
                    cmpb      #'+'
                    beq       MarkStreamForUpdate
                    ldx       $06,s
                    ldb       $02,x
                    cmpb      #'+'
                    bne       MarkSingleDirection
MarkStreamForUpdate
                    ldd       StreamFlags,u ; retain buffering state already assigned to the slot
                    orb       #OpenModeUpdate ; allow both buffered reads and writes
                    bra       FinishStreamDescriptor
MarkSingleDirection
                    ldd       StreamFlags,u ; preserve all unrelated stream state bits
                    pshs      d         ; hold those bits while deriving the access direction
                    ldb       [<$08,s]  ; recover the mode string after the temporary push
                    cmpb      #'r'
                    beq       SelectReadDirection
                    ldb       [<$08,s]
                    cmpb      #'d'      ; directory streams are read-only
                    bne       SelectWriteDirection
SelectReadDirection
                    ldd       #OpenModeRead
                    bra       MergeStreamDirection
SelectWriteDirection
                    ldd       #OpenModeWrite ; append and write modes produce output streams
MergeStreamDirection
                    ora       ,s+       ; restore the existing high flag byte
                    orb       ,s+       ; merge the access bits into its low byte
FinishStreamDescriptor
                    std       StreamFlags,u
                    ldd       StreamBufferStart,u ; calculate the boundary of any assigned buffer
                    addd      StreamBufferSize,u
                    std       StreamBufferEnd,u
                    std       StreamCursor,u ; an empty stream begins at that boundary
ReturnFreeStreamSlot
                    tfr       u,d       ; return the available descriptor pointer
                    puls      pc,u
StreamSetupFailed   clra                ; return a null descriptor pointer
                    clrb                ; complete the null return value
                    puls      pc,u
OpenPathFromMode
stk_mode_flags      equ       0         ; access mode assembled for OS-9
stk_mode_result     equ       2         ; returned path number
stk_mode_saved_u    equ       4         ; caller's U after local allocation
stk_mode_return     equ       6         ; caller return address
stk_mode_name       equ       8         ; pathname pointer
stk_mode_string     equ       10        ; pointer to the C mode string
                    pshs      u         ; preserve U while it carries the pathname
                    ldu       $04,s     ; keep the pathname ready for OS-9 wrappers
                    leas      -$04,s    ; reserve access flags and path-result locals
                    clra                ; clear the access-mode high byte
                    clrb                ; begin with no access bits
                    std       ,s        ; begin with no access bits selected
                    ldx       $0A,s     ; inspect the first optional mode character
                    ldb       $01,x
                    sex                 ; widen it for the compiler's switch sequence
                    tfr       d,x
                    bra       DecodeModeModifier
DecodeExecuteModifier
                    ldx       $0A,s     ; an x modifier requests OS-9 execute access
                    ldb       $02,x
                    cmpb      #'+'      ; x+ combines execute with read/write access
                    bne       SelectExecuteMode
                    ldd       #OpenModeRead+OpenModeWrite+OpenModeExecute
                    bra       SaveOpenMode
SelectExecuteMode   ldd       #OpenModeExecute
                    bra       SaveOpenMode
DecodeUpdateModifier
                    ldd       #OpenModeUpdate
SaveOpenMode        std       ,s
                    bra       DecodePrimaryMode
RejectModeModifier  leax      $04,s     ; preserve the compiler-generated frame adjustment
                    lbra      RestoreModeParserFrame
DecodeModeModifier  stx       -$02,s    ; retain the widened switch value in its spill slot
                    beq       DecodePrimaryMode ; an absent modifier leaves the mode at zero
                    cmpx      #'x'
                    beq       DecodeExecuteModifier
                    cmpx      #'+'
                    beq       DecodeUpdateModifier
                    bra       RejectModeModifier
DecodePrimaryMode   ldb       [<$0A,s]  ; dispatch on the leading mode character
                    sex
                    tfr       d,x
                    lbra      SelectPrimaryMode
SelectReadMode      ldd       ,s
                    orb       #OpenModeRead ; ensure r includes read access
                    bra       OpenSelectedPath
SelectAppendMode    ldd       ,s
                    orb       #OpenModeWrite ; append requires write access
                    pshs      d
                    pshs      u
                    lbsr      OpenPath  ; preserve existing contents when the file exists
                    leas      $04,s
                    std       $02,s
                    cmpd      #-1
                    beq       CreateAppendPath ; create the file when opening it fails
                    ldd       #2        ; seek relative to end-of-file
                    pshs      d
                    clra
                    clrb
                    pshs      d         ; append adds a zero 32-bit offset
                    pshs      d
                    ldd       $08,s     ; recover the opened path number
                    pshs      d
                    lbsr      SeekPath
                    leas      $08,s
                    bra       ReturnModePath
CreateAppendPath    ldd       ,s
                    orb       #OpenModeWrite
                    pshs      d
                    pshs      u
                    lbsr      CreateOrTruncatePath ; create an initially empty target
                    bra       SaveModePath
SelectDirectoryMode
                    ldd       ,s
                    orb       #OpenModeDirectory+OpenModeRead ; directory records are read-only
OpenSelectedPath    pshs      d
                    pshs      u
                    lbsr      OpenPath
SaveModePath        leas      $04,s
                    std       $02,s     ; retain the path while unwinding locals
                    bra       ReturnModePath
RestoreModeParserFrame
                    leas      -$04,x    ; reconstruct the parser's original local stack
InvalidModeString   ldd       #E$BMode  ; publish the compiler runtime's bad-mode error
                    std       >RuntimeErrorCode,y
                    clra
                    clrb                ; preserve the original runtime's anomalous zero result
                    bra       FinishModeOpen
SelectPrimaryMode   cmpx      #'r'
                    lbeq      SelectReadMode
                    cmpx      #'a'
                    lbeq      SelectAppendMode
                    cmpx      #'w'
                    beq       CreateAppendPath ; write mode always truncates or creates
                    cmpx      #'d'
                    beq       SelectDirectoryMode
                    bra       InvalidModeString
ReturnModePath      ldd       $02,s
FinishModeOpen      leas      $04,s     ; release access and result locals
                    puls      pc,u
* encoded fdopen-style entry point: attach a supplied OS-9 path to a free stream.
AttachExistingPathStream
                    fcb       $34,$40   ; preserve U
                    fcb       $4F,$5F   ; select a null descriptor for allocation
                    fcb       $34,$06   ; pass the null descriptor
                    fcb       $EC,$68   ; recover the mode-string pointer
                    fcb       $34,$06   ; pass the mode string
                    fcb       $EC,$68   ; recover the caller's path number
                    fcb       $34,$06   ; pass the path number
                    fcb       $16,$00,$4B ; join AttachOpenedPath
OpenFileStream
stk_fopen_saved_u   equ       0         ; caller's U after the entry push
stk_fopen_return    equ       2         ; caller return address
stk_fopen_name      equ       4         ; pathname pointer
stk_fopen_mode      equ       6         ; mode-string pointer
                    pshs      u         ; preserve U while it carries the opened path
                    ldd       $06,s     ; pass the textual mode
                    pshs      d
                    ldd       $06,s     ; pass the pathname after the first push
                    pshs      d
                    lbsr      OpenPathFromMode ; translate the mode and obtain an OS-9 path
                    leas      $04,s
                    tfr       d,u       ; retain the path while building its descriptor
                    cmpu      #-1
                    bne       PathOpenSucceeded
                    clra
                    clrb                ; fopen-style failure returns a null stream
                    bra       ReturnOpenStream
PathOpenSucceeded   clra
                    clrb                ; request allocation of a new descriptor
                    bra       AttachOpenedPath
* encoded freopen-style entry point: close a stream, reopen a pathname, then
* initialize the caller's original descriptor around the replacement path.
ReopenFileStream
                    fcb       $34,$40   ; preserve U
                    fcb       $EC,$68   ; recover the stream being replaced
                    fcb       $34,$06   ; pass it to CloseStream
                    fcb       $17,$06,$A3 ; close and release its current path
                    fcb       $32,$62   ; discard the close argument
                    fcb       $EC,$66   ; recover the replacement mode string
                    fcb       $34,$06   ; pass the mode string
                    fcb       $EC,$66   ; recover the replacement pathname
                    fcb       $34,$06   ; pass the pathname
                    fcb       $17,$FE,$F4 ; open the replacement OS-9 path
                    fcb       $32,$64   ; discard both open arguments
                    fcb       $1F,$03   ; retain the returned path in U
                    fcb       $EF,$7E   ; spill U below S and expose its sign
                    fcb       $2C,$04   ; continue when the path is nonnegative
                    fcb       $4F,$5F   ; return a null stream after open failure
                    fcb       $20,$0F   ; join ReturnOpenStream
                    fcb       $EC,$68   ; reuse the caller's original descriptor
AttachOpenedPath    pshs      d         ; pass the supplied or null descriptor
                    ldd       $08,s     ; recover and pass the mode string
                    pshs      d
                    pshs      u         ; pass the opened OS-9 path
                    lbsr      InitializeStreamDescriptor
                    leas      $06,s
ReturnOpenStream    puls      pc,u
ReadInputLine       pshs      u,d       ; save u,d on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    bra       Branch_055 ; continue execution at Branch_055
Branch_056          ldd       ,s        ; load d from the current stack frame at ,s
                    stb       ,u+       ; store b at ,u+
Branch_055          leax      >RuntimeInputStream,y ; form the address >RuntimeInputStream,y in x
                    pshs      x         ; save x on the stack
                    lbsr      ReadStreamCharacter ; call subroutine ReadStreamCharacter
                    leas      $02,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #13       ; compare d with #13 and set the condition codes
                    beq       Branch_057 ; branch when the values are equal or the result is zero; target Branch_057
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_056 ; branch when the values differ or the result is nonzero; target Branch_056
Branch_057          ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_058 ; branch when the values differ or the result is nonzero; target Branch_058
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_059 ; continue execution at Branch_059
Branch_058          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       StreamCursor,u ; store b at StreamCursor,u
                    ldd       $06,s     ; load d from the current stack frame at $06,s
Branch_059          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2|" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $19       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "03_" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $2F       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "?2b" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $EC       ; store byte data
                    fcc       "h2d5" ; store literal character data
                    fcb       $C0       ; store byte data
PrintFormatted      pshs      u         ; save u on the stack
                    leax      >RuntimeOutputStream,y ; form the address >RuntimeOutputStream,y in x
                    stx       >$038F,y  ; store x at >$038F,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       Branch_060 ; continue execution at Branch_060
WriteFormattedStream pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >$038F,y  ; store d at >$038F,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
Branch_060          pshs      d         ; save d on the stack
                    leax      >Data_008,pc ; form the address >Data_008,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_022 ; call subroutine Routine_022
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcc       "0h4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0C       ; store byte data
                    fcc       "2fO_" ; store literal character data
                    fcb       $E7       ; store byte data
                    fcb       $B9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Routine_022         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       Branch_061 ; continue execution at Branch_061
Branch_062          ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      Branch_063 ; branch when the values are equal or the result is zero; target Branch_063
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_061          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       Branch_062 ; branch when the values differ or the result is nonzero; target Branch_062
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_064 ; branch when the values differ or the result is nonzero; target Branch_064
                    ldd       #1        ; set d to the constant 1
                    std       >$03A5,y  ; store d at >$03A5,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_065 ; continue execution at Branch_065
Branch_064          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$03A5,y  ; store d at >$03A5,y
Branch_065          ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       Branch_066 ; branch when the values differ or the result is nonzero; target Branch_066
                    ldd       #48       ; set d to the constant 48
                    bra       Branch_067 ; continue execution at Branch_067
Branch_066          ldd       #32       ; set d to the constant 32
Branch_067          std       >$03A7,y  ; store d at >$03A7,y
                    bra       Branch_068 ; continue execution at Branch_068
Branch_069          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_023 ; call subroutine Routine_023
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
Branch_068          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_069 ; branch when the values differ or the result is nonzero; target Branch_069
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       Branch_070 ; branch when the values differ or the result is nonzero; target Branch_070
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_071 ; continue execution at Branch_071
Branch_072          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_023 ; call subroutine Routine_023
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_071          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_072 ; branch when the values differ or the result is nonzero; target Branch_072
                    bra       Branch_073 ; continue execution at Branch_073
Branch_070          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_073          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_074 ; continue execution at Branch_074
Branch_075          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    bra       Branch_076 ; continue execution at Branch_076
Branch_077          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_025 ; call subroutine Routine_025
Branch_076          std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_078 ; continue execution at Branch_078
Branch_079          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    pshs      d         ; save d on the stack
                    ldx       <$0017,s  ; load x from the current stack frame at <$0017,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    lbra      Branch_080 ; continue execution at Branch_080
Branch_081          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    lbra      Branch_080 ; continue execution at Branch_080
Branch_082          ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       Branch_083 ; branch when the values differ or the result is nonzero; target Branch_083
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_083          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_084 ; continue execution at Branch_084
Branch_085          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      Branch_086 ; continue execution at Branch_086
Branch_087          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_088 ; branch when the values are equal or the result is zero; target Branch_088
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_089 ; continue execution at Branch_089
Branch_090          ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       Branch_091 ; branch when the values are equal or the result is zero; target Branch_091
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
Branch_089          ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_090 ; branch when the values differ or the result is nonzero; target Branch_090
Branch_091          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_092 ; continue execution at Branch_092
Branch_088          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       Branch_084 ; continue execution at Branch_084
Branch_093          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_094 ; continue execution at Branch_094
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
Branch_094          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
Branch_080          leas      $04,s     ; adjust the system stack pointer
Branch_084          pshs      d         ; save d on the stack
Branch_078          ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $06,s     ; adjust the system stack pointer
Branch_092          lbra      Branch_061 ; continue execution at Branch_061
Branch_095          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
Branch_086          pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_061 ; continue execution at Branch_061
Branch_074          cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      Branch_075 ; branch when the values are equal or the result is zero; target Branch_075
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_077 ; branch when the values are equal or the result is zero; target Branch_077
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_079 ; branch when the values are equal or the result is zero; target Branch_079
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      Branch_079 ; branch when the values are equal or the result is zero; target Branch_079
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_081 ; branch when the values are equal or the result is zero; target Branch_081
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      Branch_085 ; branch when the values are equal or the result is zero; target Branch_085
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_087 ; branch when the values are equal or the result is zero; target Branch_087
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      Branch_093 ; branch when the values are equal or the result is zero; target Branch_093
                    bra       Branch_095 ; continue execution at Branch_095
Branch_063          leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_024         pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       Branch_096 ; branch when the signed value is greater than or equal; target Branch_096
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       Branch_097 ; branch when the signed value is greater than or equal; target Branch_097
                    leax      >Text_025,pc ; form the address >Text_025,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_032 ; call subroutine Routine_032
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_098 ; continue execution at Branch_098
Branch_097          ldd       #45       ; set d to the constant 45
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_096          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_099 ; continue execution at Branch_099
Routine_027         pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_100 ; continue execution at Branch_100
Branch_101          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
Branch_100          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       Branch_101 ; branch when the signed value is less; target Branch_101
                    leax      >$0001,y  ; form the address >$0001,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       Branch_102 ; continue execution at Branch_102
Branch_103          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_104          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       Branch_103 ; branch when the signed value is greater than or equal; target Branch_103
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    beq       Branch_105 ; branch when the values are equal or the result is zero; target Branch_105
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_105          ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_106 ; branch when the values are equal or the result is zero; target Branch_106
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
Branch_106          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_102          ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$0009,y  ; compare d with >$0009,y and set the condition codes
                    bne       Branch_104 ; branch when the values differ or the result is nonzero; target Branch_104
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       StreamCursor,u ; store b at StreamCursor,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_025         pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
Branch_107          ldd       $06,s     ; load d from the current stack frame at $06,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #7        ; mask b using #7
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bne       Branch_107 ; branch when the values differ or the result is nonzero; target Branch_107
                    bra       Branch_108 ; continue execution at Branch_108
Branch_109          ldb       StreamCursor,u ; load b from StreamCursor,u
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_108          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_109 ; branch when the unsigned value is lower or equal; target Branch_109
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
Branch_099          leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
Branch_098          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_026         pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
Branch_110          ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       Branch_111 ; branch when the signed value is less than or equal; target Branch_111
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       Branch_112 ; branch when the values are equal or the result is zero; target Branch_112
                    ldd       #65       ; set d to the constant 65
                    bra       Branch_113 ; continue execution at Branch_113
Branch_112          ldd       #97       ; set d to the constant 97
Branch_113          addd      #-10      ; add to d using #-10
                    bra       Branch_114 ; continue execution at Branch_114
Branch_111          ldd       #48       ; set d to the constant 48
Branch_114          addd      ,s++      ; add to d using ,s++
                    stb       ,u+       ; store b at ,u+
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    anda      #15       ; mask a using #15
                    std       $08,s     ; store d in the current stack frame at $08,s
                    bne       Branch_110 ; branch when the values differ or the result is nonzero; target Branch_110
                    bra       Branch_115 ; continue execution at Branch_115
Branch_116          ldb       StreamCursor,u ; load b from StreamCursor,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
Branch_115          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_116 ; branch when the unsigned value is lower or equal; target Branch_116
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      Branch_117 ; continue execution at Branch_117
Routine_029         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       Branch_118 ; branch when the values differ or the result is nonzero; target Branch_118
                    bra       Branch_119 ; continue execution at Branch_119
Branch_120          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_119          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_120 ; branch when the signed value is greater; target Branch_120
                    bra       Branch_118 ; continue execution at Branch_118
Branch_121          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_118          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_121 ; branch when the values differ or the result is nonzero; target Branch_121
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       Branch_122 ; branch when the values are equal or the result is zero; target Branch_122
                    bra       Branch_123 ; continue execution at Branch_123
Branch_124          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_123          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_124 ; branch when the signed value is greater; target Branch_124
Branch_122          puls      pc,u      ; restore pc,u and return to the caller
Routine_031         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_033 ; call subroutine Routine_033
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       Branch_125 ; branch when the values differ or the result is nonzero; target Branch_125
                    bra       Branch_126 ; continue execution at Branch_126
Branch_127          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_126          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_127 ; branch when the signed value is greater; target Branch_127
                    bra       Branch_125 ; continue execution at Branch_125
Branch_128          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_125          ldb       StreamCursor,u ; load b from StreamCursor,u
                    bne       Branch_128 ; branch when the values differ or the result is nonzero; target Branch_128
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       Branch_129 ; branch when the values are equal or the result is zero; target Branch_129
                    bra       Branch_130 ; continue execution at Branch_130
Branch_131          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_130          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_131 ; branch when the signed value is greater; target Branch_131
Branch_129          puls      pc,u      ; restore pc,u and return to the caller
Data_008            fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
Branch_117          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Text_025            fcc       "-32768" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $14       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $03       ; store byte data
                    fcc       "M2b" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcc       "0g4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AD       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $4A       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $CA       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $DC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $EB       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $0B       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $BE       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $9B       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $79       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "F2d" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $3B       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "K" ; store literal character data
* Walk the compiler's table of sixteen stream descriptors during process exit.
CloseAllStreams
stk_stream_index    equ       0         ; current descriptor number after PSHS U,D
stk_stream_saved_u  equ       2         ; caller's U after PSHS U,D
stk_stream_return   equ       4         ; caller return address
                    pshs      u,d       ; preserve U and allocate a word-sized slot index
                    leau      >RuntimeInputStream,y ; select the first runtime stream descriptor
                    clra                ; initialize the slot index to zero
                    clrb                ; complete the zero slot index
                    std       ,s        ; retain the index in the local stack word
                    bra       CheckNextStreamSlot ; test the first descriptor
CloseNextStreamSlot
                    tfr       u,d       ; pass the current descriptor address
                    leau      StreamDescriptorSize,u ; advance to the next fixed-size descriptor
                    pshs      d         ; pass the descriptor being closed
                    bsr       CloseStream ; flush and close this occupied stream slot
                    leas      $02,s     ; discard the descriptor argument
CheckNextStreamSlot
                    ldd       ,s        ; recover the next slot index
                    addd      #1        ; prepare the following index
                    std       ,s        ; retain it for the next iteration
                    subd      #1        ; restore the index being tested now
                    cmpd      #16       ; the runtime owns sixteen stream slots
                    blt       CloseNextStreamSlot ; visit every descriptor table entry
                    lbra      StreamOperationDone ; return through the shared stream epilogue
CloseStream
stk_close_result    equ       0         ; flush result after local allocation
stk_close_saved_u   equ       2         ; caller's U after local allocation
stk_streamclose_return equ       4         ; caller return address after local allocation
stk_close_stream    equ       6         ; descriptor argument after local allocation
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; capture the descriptor before allocating the result word
                    leas      -$02,s    ; reserve the flush result returned to the caller
                    cmpu      #0        ; reject a null descriptor
                    beq       RejectCloseRequest ; a null pointer cannot be closed
                    ldd       StreamFlags,u ; inactive slots do not own an open path
                    bne       CloseActiveStream ; nonzero flags identify an occupied slot
RejectCloseRequest  ldd       #-1       ; report an invalid or already-closed stream
                    lbra      StreamOperationDone ; unwind the local result word
CloseActiveStream   ldd       StreamFlags,u ; determine whether buffered output is possible
                    clra                ; inspect only low-byte access flags
                    andb      #StreamWritable ; isolate write permission
                    beq       SkipCloseFlush ; read-only streams have no pending output
                    pshs      u         ; flush pending output before releasing the path
                    bsr       FlushStream ; preserve any flush failure for the caller
                    leas      $02,s     ; discard the descriptor argument
                    bra       CloseUnderlyingPath ; close even when flushing failed
SkipCloseFlush      clra                ; prepare a successful zero result
                    clrb                ; a read-only stream has no write error to report
CloseUnderlyingPath
                    std       ,s        ; preserve the flush result across I$Close
                    ldd       StreamPath,u ; select the underlying path number
                    pshs      d         ; release the underlying OS-9 path
                    lbsr      ClosePath ; release the OS-9 path
                    leas      $02,s     ; discard the path argument
                    clra                ; clear the descriptor flags as a word
                    clrb                ; mark the table entry inactive
                    std       StreamFlags,u ; make the descriptor reusable regardless of close status
                    ldd       ,s        ; return the earlier flush result
                    bra       StreamOperationDone ; return the saved flush result
FlushStream
stk_flush_saved_u   equ       0         ; caller's U after the entry push
stk_flush_return    equ       2         ; caller return address
stk_flush_stream    equ       4         ; descriptor argument
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; select the requested descriptor
                    beq       RejectFlushRequest ; reject a null descriptor
                    ldd       StreamFlags,u ; require write access without a prior I/O error
                    clra                ; ignore high-byte orientation state
                    andb      #StreamWritable+StreamIoError ; retain permission and error bits
                    cmpd      #StreamWritable ; require writable with no error latched
                    beq       PrepareStreamFlush ; proceed only for a healthy output stream
RejectFlushRequest  ldd       #-1       ; report an invalid flush request
                    puls      pc,u      ; reject null, read-only, or failed streams
PrepareStreamFlush  ldd       StreamFlags,u ; initialize buffering on first use
                    anda      #$80      ; isolate StreamInitialized's high byte
                    clrb                ; form a word-sized initialization test
                    std       -$02,s    ; use the compiler spill slot only for the flag test
                    bne       FlushAssignedBuffer ; skip setup after first use
                    pshs      u         ; pass the descriptor to lazy initialization
                    lbsr      InitializeStreamBuffer ; choose policy and storage
                    leas      $02,s     ; discard the descriptor argument
FlushAssignedBuffer
                    pshs      u         ; pass the prepared descriptor to the buffer flusher
                    bsr       FlushBufferedStream ; return through the shared epilogue
StreamOperationDone leas      $02,s     ; release the caller-specific local word
                    puls      pc,u      ; restore U and return the operation status
FlushBufferedStream
stk_bufwrite_result equ       0         ; most recent line-write result
stk_bufwrite_left   equ       2         ; bytes still pending in the buffer
stk_bufwrite_saved_u equ       4         ; caller's U after local allocation
stk_bufwrite_return equ       6         ; caller return address after local allocation
stk_bufwrite_stream equ       8         ; descriptor argument after local allocation
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; capture the descriptor before allocating locals
                    leas      -$04,s    ; reserve transfer result and remaining-byte words
                    ldd       StreamFlags,u ; distinguish buffered input from pending output
                    anda      #$01      ; isolate StreamWriting's high byte
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the test value below the compiler frame
                    bne       ComputePendingOutput ; output mode needs no input-position repair
                    ldd       StreamCursor,u ; input may have unread bytes beyond the logical cursor
                    cmpd      StreamBufferEnd,u ; detect unread cached input
                    beq       ComputePendingOutput ; no unread input requires repositioning
                    clra                ; build a zero position-query argument
                    clrb                ; complete the zero word
                    pshs      d         ; request the runtime's current logical position
                    pshs      u         ; pass the descriptor to the position hook
                    lbsr      NoOpStreamPositionHook ; compiler helper leaves its long-result pointer in X
                    leas      $02,s     ; discard only the descriptor argument
                    ldd       $02,x     ; pass the returned 32-bit low word
                    pshs      d         ; pass the returned low position word
                    ldd       ,x        ; pass the returned 32-bit high word
                    pshs      d         ; pass the returned high position word
                    ldd       StreamPath,u ; select the stream's OS-9 path
                    pshs      d         ; pass the path number
                    lbsr      SeekPath  ; synchronize OS-9 with the logical input position
                    leas      $08,s     ; discard path, offset, and origin arguments
ComputePendingOutput
                    ldd       StreamCursor,u ; start with the current write position
                    subd      StreamBufferStart,u ; measure buffered bytes preceding the cursor
                    std       $02,s     ; retain the number of buffered bytes
                    lbeq      ResetFlushedStream ; nothing has been accumulated
                    ldd       StreamFlags,u ; verify that those bytes are output
                    anda      #$01      ; only output-oriented buffers contain bytes to write
                    clrb                ; form the word-sized orientation test
                    std       -$02,s    ; preserve it in the compiler spill slot
                    lbeq      ResetFlushedStream ; discard cached input rather than writing it
                    ldd       StreamFlags,u ; select line or block transfer semantics
                    clra                ; inspect only low-byte buffering flags
                    andb      #StreamLineBuffered ; isolate line-oriented output
                    beq       WriteBlockBuffer ; ordinary buffers use one bulk write
                    ldd       StreamBufferStart,u ; begin the line-write loop at the buffer start
                    bra       UpdateWriteCursor ; seed the line-write cursor
WriteRemainingLineBytes
                    ldd       $02,s     ; recover the bytes still pending
                    pshs      d         ; pass the remaining byte count
                    ldd       StreamCursor,u ; continue at the first unwritten byte
                    pshs      d         ; pass the first unwritten byte
                    ldd       StreamPath,u ; select the destination path
                    pshs      d         ; pass it to the line-write wrapper
                    lbsr      WriteLineBytes ; stop each transfer at a carriage return
                    leas      $06,s     ; discard the transfer arguments
                    std       ,s        ; retain the number written or -1
                    cmpd      #-1       ; detect an OS-9 write failure
                    bne       AccountForLineWrite ; otherwise consume the completed prefix
                    leax      $04,s     ; preserve the compiler's error-frame restoration
                    bra       RestoreFlushErrorFrame ; join the common failure path
AccountForLineWrite
                    ldd       $02,s     ; recover the previous remaining count
                    subd      ,s        ; remove the completed portion from the remainder
                    std       $02,s     ; retain the reduced count
                    ldd       StreamCursor,u ; recover the previous transfer pointer
                    addd      ,s        ; advance to the next unwritten byte
UpdateWriteCursor   std       StreamCursor,u ; advance beyond the completed line
                    ldd       $02,s     ; test whether bytes remain
                    bne       WriteRemainingLineBytes ; continue through every CR-delimited fragment
                    bra       ResetFlushedStream ; all line fragments reached OS-9
WriteBlockBuffer    ldd       $02,s     ; recover the complete pending length
                    pshs      d         ; write the entire pending block in one call
                    ldd       StreamBufferStart,u ; select the beginning of buffered output
                    pshs      d         ; pass the source address
                    ldd       StreamPath,u ; select the destination path
                    pshs      d         ; pass the path number
                    lbsr      WriteBytes ; perform the bulk transfer
                    leas      $06,s     ; discard the transfer arguments
                    cmpd      $02,s     ; a short write is treated as failure
                    beq       ResetFlushedStream ; accept only a complete block write
                    bra       MarkStreamWriteError ; short writes latch the stream error
RestoreFlushErrorFrame
                    leas      -$04,x    ; reconstruct the compiler's local frame after failure
MarkStreamWriteError
                    ldd       StreamFlags,u ; preserve access and buffering state
                    orb       #StreamIoError ; latch the failed transfer
                    std       StreamFlags,u ; publish the terminal error state
                    ldd       StreamBufferEnd,u ; prevent further buffered writes
                    std       StreamCursor,u ; leave the buffer unavailable after an error
                    ldd       #-1       ; return the conventional failure value
                    bra       ReturnFlushStatus ; release locals and return failure
ResetFlushedStream  ldd       StreamFlags,u ; preserve the descriptor configuration
                    ora       #$01      ; mark the reset buffer as output-oriented
                    std       StreamFlags,u ; publish the new orientation
                    ldd       StreamBufferStart,u ; reset output to the first buffer byte
                    std       StreamCursor,u ; make the buffer empty
                    addd      StreamBufferSize,u ; restore the full writable boundary
                    std       StreamBufferEnd,u ; reopen the complete buffer for output
                    clra                ; prepare a successful zero result
                    clrb                ; report a successful flush
ReturnFlushStatus   leas      $04,s     ; release transfer-result locals
                    puls      pc,u      ; restore U and return the flush status
* this compiler-generated hook preserves all live values; its caller relies on
* X already naming the runtime's shared 32-bit position result.
NoOpStreamPositionHook
                    pshs      u         ; preserve the calling convention's U value
                    puls      pc,u      ; return without disturbing the position pointer
ReadStreamCharacter
stk_getc_saved_u    equ       0         ; caller's U after the entry push
stk_getc_return     equ       2         ; caller return address
stk_getc_stream     equ       4         ; descriptor argument
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; select the requested stream
                    beq       ReturnReadFailure ; reject a null stream
                    ldd       StreamFlags,u ; reject a stream currently oriented for output
                    anda      #$01      ; an output-oriented buffer cannot satisfy getc
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the orientation test below the frame
                    bne       ReturnReadFailure ; getc cannot switch direction implicitly
                    ldd       StreamCursor,u ; inspect the next cached-byte pointer
                    cmpd      StreamBufferEnd,u ; consume cached data while cursor is in range
                    bcc       RefillEmptyStream ; refill when cursor reached the boundary
                    ldd       StreamCursor,u ; retain the byte address being returned
                    addd      #1        ; calculate the following cursor
                    std       StreamCursor,u ; advance past the returned byte
                    subd      #1        ; recover the original byte address
                    tfr       d,x       ; use it as the memory pointer
                    ldb       ,x        ; return the previous cursor byte as an unsigned integer
                    clra                ; widen the byte to a positive compiler integer
                    lbra      ReturnStreamCharacter ; share the normal getc return sequence
RefillEmptyStream   pshs      u         ; ask the refill path to return its first byte
                    lbsr      RefillStreamBuffer ; return its first byte or -1
                    lbra      FinishStreamRefill ; discard the pushed descriptor in the shared tail
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $05       ; store byte data
ReturnReadFailure   ldd       #-1       ; represent EOF, error, or invalid orientation
                    puls      pc,u      ; restore U and return failure
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "d2|4@" ; store literal character data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $93       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $95       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d5" ; store literal character data
                    fcb       $C0       ; store byte data
RefillStreamBuffer
stk_refill_count    equ       0         ; byte count returned by the low-level read
stk_refill_saved_u  equ       2         ; caller's U after local allocation
stk_refill_return   equ       4         ; caller return address after local allocation
stk_refill_stream   equ       6         ; descriptor argument after local allocation
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; capture the descriptor before allocating the count
                    leas      -$02,s    ; reserve the low-level transfer count
                    ldd       StreamFlags,u ; accept initialized readable streams with no terminal status
                    anda      #$80      ; isolate StreamInitialized's high byte
                    andb      #StreamReadable+StreamAtEof+StreamIoError ; retain terminal read state
                    cmpd      #StreamInitialized+StreamReadable ; require ready, readable, and clean
                    beq       StreamReadyForRead ; skip lazy setup on the normal path
                    ldd       StreamFlags,u ; an otherwise clean readable stream needs initialization
                    clra                ; ignore initialization and orientation state
                    andb      #StreamReadable+StreamAtEof+StreamIoError ; retain read eligibility
                    cmpd      #StreamReadable ; only a clean readable stream can be initialized
                    lbne      ReturnRefillFailure ; reject EOF, error, or non-readable streams
                    pshs      u         ; pass the descriptor to lazy buffer setup
                    lbsr      InitializeStreamBuffer ; establish policy and storage
                    leas      $02,s     ; discard the descriptor argument
StreamReadyForRead  leax      >RuntimeInputStream,y ; identify reads from standard input
                    pshs      x         ; compare without sacrificing a working register
                    cmpu      ,s++      ; detect the standard-input descriptor
                    bne       SelectReadStorage ; ordinary streams need no prompt flush
                    ldd       StreamFlags,u ; only terminal-style input needs prompt synchronization
                    clra                ; inspect low-byte buffering state
                    andb      #StreamLineBuffered ; detect terminal-style input
                    beq       SelectReadStorage ; block input does not synchronize stdout
                    leax      >RuntimeOutputStream,y ; select standard output
                    pshs      x         ; flush any prompt before waiting for a line
                    lbsr      FlushStream ; display a pending prompt before blocking for input
                    leas      $02,s     ; discard the output descriptor argument
SelectReadStorage   ldd       StreamFlags,u ; select allocated or one-byte storage
                    clra                ; inspect low-byte buffer flags
                    andb      #StreamHasBuffer ; detect multi-byte storage
                    beq       ReadUnbufferedByte ; fall back to a single-byte transfer
                    ldd       StreamBufferSize,u ; pass the maximum transfer length
                    pshs      d         ; pass the allocated buffer capacity
                    ldd       StreamBufferStart,u ; pass the destination buffer
                    pshs      d         ; preserve the shared argument layout
                    ldd       StreamPath,u ; pass the OS-9 path number
                    pshs      d         ; complete the low-level read arguments
                    ldd       StreamFlags,u ; choose line or unstructured I/O
                    clra                ; inspect low-byte buffering state
                    andb      #StreamLineBuffered ; isolate terminal-style input
                    beq       SelectBlockRead ; files use an ordinary byte read
                    leax      >ReadLineBytes,pc ; terminals use CR-terminated line reads
                    bra       InvokeSelectedRead ; use the common indirect-call path
SelectBlockRead     leax      >ReadBytes,pc ; ordinary files use unstructured reads
InvokeSelectedRead  tfr       x,d       ; preserve the selected entry in compiler form
                    tfr       d,x       ; restore it as an indirect-call pointer
                    jsr       ,x        ; invoke the selected wrapper with the shared arguments
                    bra       HandleRefillResult ; normalize either wrapper's result
ReadUnbufferedByte  ldd       #1        ; request the descriptor-local byte only
                    pshs      d         ; request exactly one byte
                    leax      StreamPushbackByte,u ; select the fallback byte
                    stx       StreamBufferStart,u ; reuse descriptor-local storage
                    pshs      x         ; pass the fallback destination
                    ldd       StreamPath,u ; pass the source path
                    pshs      d         ; complete the one-byte read arguments
                    lbsr      ReadBytes ; use ordinary reads for one-byte mode
HandleRefillResult  leas      $06,s     ; discard path, buffer, and count arguments
                    std       ,s        ; retain the actual count or failure value
                    ldd       ,s        ; classify the transfer result
                    bgt       ReturnFirstRefilledByte ; positive counts provide a character
                    ldd       StreamFlags,u ; preserve existing descriptor state
                    pshs      d         ; preserve existing state while adding EOF or error
                    ldd       $02,s     ; recover the transfer result through the temporary push
                    beq       MarkStreamEof ; zero bytes means clean end-of-file
                    ldd       #StreamIoError ; a negative result means transfer failure
                    bra       MergeReadStatus ; merge failure with existing state
MarkStreamEof       ldd       #StreamAtEof ; latch EOF for later getc calls
MergeReadStatus     ora       ,s+       ; restore the prior high flag byte
                    orb       ,s+       ; merge the new terminal-state bit
                    std       StreamFlags,u ; latch EOF or error for later calls
ReturnRefillFailure ldd       #-1       ; expose both EOF and error as getc failure
                    bra       FinishStreamRefill ; release the count local
ReturnFirstRefilledByte
                    ldd       StreamBufferStart,u ; locate the first returned byte
                    addd      #1        ; advance the cursor past it
                    std       StreamCursor,u ; consume the first byte immediately
                    ldd       StreamBufferStart,u ; calculate the valid-data boundary
                    addd      ,s        ; add the actual transfer count
                    std       StreamBufferEnd,u ; limit cached input to the actual read count
                    ldb       [<StreamBufferStart,u] ; return the first byte of the refill
                    clra                ; widen the byte to a positive compiler integer
FinishStreamRefill  leas      $02,s     ; release the saved transfer count
ReturnStreamCharacter
                    puls      pc,u      ; restore U and return the character or -1
InitializeStreamBuffer
stk_bufinit_saved_u equ       0         ; caller's U after the entry push
stk_bufinit_return  equ       2         ; caller return address
stk_bufinit_stream  equ       4         ; descriptor argument
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; select the descriptor being initialized
                    ldd       StreamFlags,u ; honor an explicitly selected buffering policy
                    clra                ; inspect only low-byte buffering policy
                    andb      #StreamLineBuffered+StreamFullyBuffered ; retain policy bits
                    bne       BufferingModeSelected ; retain caller-selected policy
* no policy was supplied, so inspect the OS-9 option table in a 32-byte local.
                    leas      -$20,s    ; reserve an OS-9 option table
                    leax      ,s        ; point X at its first byte
                    pshs      x         ; pass the option-table destination
                    ldd       StreamPath,u ; pass the path being classified
                    pshs      d         ; preserve the status-call argument order
                    clra                ; request base option status code zero
                    clrb                ; complete selector zero
                    pshs      d         ; request the path's base option status
                    lbsr      GetPathStatus ; obtain the device-type byte
                    leas      $06,s     ; discard status arguments
                    ldd       StreamFlags,u ; preserve existing stream state
                    pshs      d         ; preserve existing state during policy selection
                    ldb       $02,s     ; device type zero identifies an SCF-style terminal
                    bne       SelectFullBuffering ; non-SCF paths use block buffering
                    ldd       #StreamLineBuffered ; terminal paths flush at carriage returns
                    bra       SaveBufferingMode ; merge the chosen terminal policy
SelectFullBuffering ldd       #StreamFullyBuffered ; files favor sector-sized transfers
SaveBufferingMode   ora       ,s+       ; restore the existing high flag byte
                    orb       ,s+       ; merge the selected buffering policy
                    std       StreamFlags,u ; publish the chosen policy
                    leas      <$0020,s  ; release the temporary option table
BufferingModeSelected
                    ldd       StreamFlags,u ; mark policy and storage setup complete
                    ora       #$80      ; set StreamInitialized in the high byte
                    std       StreamFlags,u ; prevent repeated device classification
                    clra                ; inspect the already-configured storage flags
                    andb      #StreamUnbuffered+StreamHasBuffer ; retain storage state
                    beq       ChooseBufferSize ; allocate only when no storage exists
                    puls      pc,u      ; an existing buffer configuration is ready
ChooseBufferSize    ldd       StreamBufferSize,u ; use a caller-selected size when present
                    bne       EnsureBufferStorage ; retain a caller-selected capacity
                    ldd       StreamFlags,u ; otherwise size according to buffering policy
                    clra                ; inspect the low-byte line flag
                    andb      #StreamLineBuffered ; distinguish terminal and file defaults
                    beq       ChooseBlockBufferSize ; select the sector-sized file buffer
                    ldd       #128      ; terminals default to a smaller line buffer
                    bra       SaveDefaultBufferSize ; retain the terminal-sized default
ChooseBlockBufferSize
                    ldd       #256      ; ordinary files default to one sector
SaveDefaultBufferSize
                    std       StreamBufferSize,u ; publish the selected capacity
EnsureBufferStorage
                    ldd       StreamBufferStart,u ; accept caller-provided storage when nonzero
                    bne       MarkBufferAvailable ; accept caller-provided storage
                    ldd       StreamBufferSize,u ; otherwise request storage from the heap
                    pshs      d         ; pass the allocation size
                    lbsr      AllocateHeapBytes ; allocate the selected capacity from the runtime heap
                    leas      $02,s     ; discard the allocation-size argument
                    std       StreamBufferStart,u ; retain the returned buffer pointer
                    cmpd      #-1       ; detect heap exhaustion
                    beq       UseFallbackByteBuffer ; remain usable without heap space
MarkBufferAvailable
                    ldd       StreamFlags,u ; record that multi-byte storage is available
                    orb       #StreamHasBuffer ; select the normal refill path
                    std       StreamFlags,u ; publish available storage
                    bra       ResetBufferWindow ; initialize its empty bounds
UseFallbackByteBuffer
                    ldd       StreamFlags,u ; degrade gracefully when allocation fails
                    orb       #StreamUnbuffered ; select single-byte transfers
                    std       StreamFlags,u ; publish fallback mode
                    leax      StreamPushbackByte,u ; use the descriptor's spare byte
                    stx       StreamBufferStart,u ; fall back to descriptor-local storage
                    ldd       #1        ; limit transfers to the fallback byte
                    std       StreamBufferSize,u ; record its single-byte capacity
ResetBufferWindow   ldd       StreamBufferStart,u ; compute the empty-buffer boundary
                    addd      StreamBufferSize,u ; advance past the assigned storage
                    std       StreamBufferEnd,u ; publish the buffer boundary
                    std       StreamCursor,u ; an empty input buffer starts at its end
                    puls      pc,u      ; restore U with buffering ready
Routine_030         pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_175 ; continue execution at Branch_175
Branch_176          ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >Data_010,pc ; form the address >Data_010,pc in x
                    bra       Branch_177 ; continue execution at Branch_177
Branch_178          ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$000C,y  ; store b at >$000C,y
                    leax      >$000B,y  ; form the address >$000B,y in x
Branch_177          tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_175          cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    bra       Branch_178 ; continue execution at Branch_178
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Data_010            fcb       $00       ; store byte data
Routine_028         pshs      u         ; save u on the stack
                    leax      >Data_011,pc ; form the address >Data_011,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Data_011            fcb       $00       ; store byte data
Routine_033         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
Branch_179          ldb       ,u+       ; load b from ,u+
                    bne       Branch_179 ; branch when the values differ or the result is nonzero; target Branch_179
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_032         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_180          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_180 ; branch when the values differ or the result is nonzero; target Branch_180
                    bra       Branch_181 ; continue execution at Branch_181
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2~" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F4       ; store byte data
Branch_181          ldd       $06,s     ; load d from the current stack frame at $06,s
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_5" ; store literal character data
                    fcb       $C0       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $41       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Routine_023         tsta                ; set condition codes from a without changing it
                    bne       Branch_182 ; branch when the values differ or the result is nonzero; target Branch_182
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       Branch_182 ; branch when the values differ or the result is nonzero; target Branch_182
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       ,s        ; load x from the current stack frame at ,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
Branch_182          pshs      d         ; save d on the stack
                    ldd       #0        ; set d to the constant 0
                    pshs      d         ; save d on the stack
                    pshs      d         ; save d on the stack
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_183 ; branch when carry is clear; target Branch_183
                    inc       ,s        ; increment the value at ,s
Branch_183          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_184 ; branch when carry is clear; target Branch_184
                    inc       ,s        ; increment the value at ,s
Branch_184          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      ,s        ; add to d using ,s
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leas      $08,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcc       "gbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "dbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d9]'" ; store literal character data
                    fcb       $F0       ; store byte data
                    fcc       "hcibZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $E7       ; store byte data
GetPathStatus       lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_185 ; branch when the values are equal or the result is zero; target Branch_185
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_187 ; branch when the values are equal or the result is zero; target Branch_187
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       Branch_187 ; branch when the values are equal or the result is zero; target Branch_187
                    ldb       #208      ; set b to the constant 208
                    lbra      StoreRuntimeError ; continue execution at StoreRuntimeError
Branch_187          pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_189 ; branch when carry is clear; target Branch_189
                    puls      u         ; restore u from the stack
                    lbra      StoreRuntimeError ; continue execution at StoreRuntimeError
Branch_189          stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_185          ldx       $06,s     ; load x from the current stack frame at $06,s
Branch_186          os9       I$GetStt  ; query status code B for path A
                    lbra      ReturnZeroOnSuccess ; continue execution at ReturnZeroOnSuccess
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $D0       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $CA       ; store byte data
OpenPath
stk_open_return     equ       0         ; caller return address
stk_open_name       equ       2         ; pathname pointer
stk_open_mode       equ       4         ; word-sized access mode; low byte is at +1
                    ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; use the low byte of the requested mode
                    os9       I$Open    ; ask OS-9 for a path number
                    lbcs      StoreRuntimeError ; translate an OS-9 error to -1
                    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts
ClosePath
stk_close_return    equ       0         ; caller return address
stk_close_path      equ       2         ; word-sized path number; low byte is at +1
                    lda       $03,s     ; select the path argument
                    os9       I$Close   ; flush and release the OS-9 path
                    lbra      ReturnZeroOnSuccess ; return zero or record the OS-9 error
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A9       ; store byte data
CreateOrTruncatePath
stk_create_return   equ       0         ; caller return address
stk_create_name     equ       2         ; pathname pointer
stk_create_mode     equ       4         ; compiler mode bits; low byte is at +1
                    ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; recover the compiler open/create mode
                    tfr       a,b       ; derive OS-9 file attributes from that mode
                    andb      #36       ; retain requested write/public attribute bits
                    orb       #11       ; always grant owner read/write and public read
                    os9       I$Create  ; create a new file and return its path
                    bcs       HandleExistingFile ; optionally reopen an existing file
ReturnPathNumber    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts
HandleExistingFile  cmpb      #E$CEF    ; only "creating existing file" is recoverable
                    lbne      StoreRuntimeError
                    lda       $05,s     ; recover the original compiler mode
                    bita      #OpenModeDirectory ; test the directory-access flag
                    lbne      StoreRuntimeError ; an existing directory is not a truncatable file
                    anda      #7        ; reduce it to OS-9 access-mode bits
                    ldx       $02,s     ; reopen the existing pathname
                    os9       I$Open
                    lbcs      StoreRuntimeError
                    pshs      u,a       ; preserve workspace and returned path
                    ldx       #0        ; request a new file size of zero
                    leau      ,x        ; supply the low size word
                    ldb       #SS.Size  ; truncate through the size status call
                    os9       I$SetStt
                    puls      u,a       ; recover workspace and path number
                    bcc       ReturnPathNumber ; return the truncated stream
                    pshs      b         ; preserve the truncation error
                    os9       I$Close   ; do not leak the reopened path
                    puls      b         ; restore the error for translation
                    lbra      StoreRuntimeError
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $87       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5B       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O9" ; store literal character data
ReadBytes
stk_read_saved_y    equ       0         ; caller's Y after the entry push
stk_read_return     equ       2         ; caller return address
stk_read_path       equ       4         ; word-sized path; low byte is at +1
stk_read_buffer     equ       6         ; destination pointer
stk_read_count      equ       8         ; requested byte count
                    pshs      y         ; preserve the caller's Y
                    ldx       $06,s     ; select the destination buffer
                    lda       $05,s     ; select the OS-9 path number
                    ldy       $08,s     ; supply the requested transfer length
                    pshs      y         ; preserve that length across I$Read
                    os9       I$Read    ; perform an unstructured byte read
                    bcc       ReadBytesSucceeded
                    cmpb      #E$EOF    ; expose EOF as a zero-byte read
                    bne       ReadBytesFailed
                    clra
                    clrb                ; return zero rather than -1 for EOF
                    puls      pc,y,x
ReadBytesFailed     puls      y,x       ; discard saved length and restore Y
                    lbra      StoreRuntimeError ; save B and return -1
ReadBytesSucceeded  tfr       y,d       ; return the actual byte count
                    puls      pc,y,x
* encoded companion to ReadBytes using I$ReadLn.  It preserves Y, loads the
* path/buffer/count arguments, saves the count, and joins ReadBytes' result path.
ReadLineBytes
                    fcb       $34,$20   ; push Y
                    fcb       $A6,$65   ; load the path number into A
                    fcb       $AE,$66   ; load the destination buffer into X
                    fcb       $10,$AE,$68 ; load the maximum line length into Y
                    fcb       $34,$20   ; preserve the requested length
                    fcb       $10,$3F,$8B ; invoke I$ReadLn
                    fcb       $20,$DD   ; join the shared read-result handler

WriteBytes
stk_write_saved_y   equ       0         ; caller's Y after the entry push
stk_write_return    equ       2         ; caller return address
stk_write_path      equ       4         ; word-sized path; low byte is at +1
stk_write_buffer    equ       6         ; source pointer
stk_write_count     equ       8         ; requested byte count
                    pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the transfer length
                    beq       ReturnTransferLength ; a zero-length write succeeds immediately
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the source buffer
                    os9       I$Write   ; perform an unstructured byte write
FinishWrite         bcc       ReturnTransferLength ; return the completed byte count
                    puls      y         ; restore Y before the shared error path
                    lbra      StoreRuntimeError ; save B and return -1
ReturnTransferLength
                    tfr       y,d       ; return the actual transfer count
                    puls      pc,y
WriteLineBytes
                    pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the maximum line length
                    beq       ReturnTransferLength ; a zero-length line write succeeds
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the CR-terminated source line
                    os9       I$WritLn  ; write through the first carriage return
                    bra       FinishWrite ; reuse normal/error result conversion
SeekPath
stk_seek_saved_u    equ       0         ; caller's U after the entry push
stk_seek_return     equ       2         ; caller return address
stk_seek_path       equ       4         ; word-sized path; low byte is at +1
stk_seek_high       equ       6         ; signed offset high word
stk_seek_low        equ       8         ; offset low word
stk_seek_origin     equ       10        ; zero=start, one=current, two=end
                    pshs      u         ; preserve U for the 32-bit OS-9 offset
                    ldd       $0A,s     ; select the requested origin
                    bne       SeekFromCurrentOrEnd
                    ldu       #0        ; absolute seeks start from zero
                    ldx       #0
                    bra       ApplySeekOffset
SeekFromCurrentOrEnd
                    cmpd      #1        ; one requests the current position
                    beq       SeekFromCurrent
                    cmpd      #2        ; two requests end-of-file
                    beq       SeekFromEnd
                    ldb       #E$Seek   ; original runtime reports an unsupported origin as seek error
SeekFailed          clra                ; widen the OS-9 error to a compiler word
                    std       >RuntimeErrorCode,y ; publish the failure status
                    ldd       #-1       ; represent failure in both result words
                    leax      >RuntimeSeekHigh,y ; select the shared 32-bit result
                    std       ,x
                    std       $02,x
                    puls      pc,u
SeekFromEnd         lda       $05,s     ; select the path number
                    ldb       #SS.Size  ; obtain its 32-bit file length in X:U
                    os9       I$GetStt
                    bcs       SeekFailed
                    bra       ApplySeekOffset
SeekFromCurrent     lda       $05,s     ; select the path number
                    ldb       #SS.Pos   ; obtain its current 32-bit position
                    os9       I$GetStt
                    bcs       SeekFailed
ApplySeekOffset     tfr       u,d       ; begin with the base position's low word
                    addd      $08,s     ; add the requested low offset
                    std       >RuntimeSeekLow,y ; retain the resulting low word
                    tfr       d,u       ; supply it to I$Seek
                    tfr       x,d       ; continue with the base high word
                    adcb      $07,s     ; propagate carry through the requested high word
                    adca      $06,s
                    bmi       SeekFailed ; reject a negative final file position
                    tfr       d,x       ; supply the high word to I$Seek
                    std       >RuntimeSeekHigh,y ; publish the complete result
                    lda       $05,s     ; select the path number
                    os9       I$Seek    ; commit the calculated X:U position
                    bcs       SeekFailed
                    leax      >RuntimeSeekHigh,y ; return a pointer to the 32-bit result
                    puls      pc,u
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       " 5 $" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "2b9" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $AC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $86       ; store byte data
AllocateHeapBytes   ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >RuntimeHeapEnd,y ; add to d using >RuntimeHeapEnd,y
                    bcs       Branch_202 ; branch when carry reports an error or unsigned underflow; target Branch_202
                    cmpd      >RuntimeStackLowWater,y ; compare d with >RuntimeStackLowWater,y and set the condition codes
                    bcc       Branch_202 ; branch when carry is clear; target Branch_202
                    pshs      d         ; save d on the stack
                    ldx       >RuntimeHeapEnd,y ; load x from >RuntimeHeapEnd,y
                    clra                ; clear a to zero and set the condition codes
Branch_203          cmpx      ,s        ; compare x with ,s and set the condition codes
                    bcc       Branch_204 ; branch when carry is clear; target Branch_204
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_203 ; continue execution at Branch_203
Branch_204          ldd       >RuntimeHeapEnd,y ; load d from >RuntimeHeapEnd,y
                    puls      x         ; restore x from the stack
                    stx       >RuntimeHeapEnd,y ; store x at >RuntimeHeapEnd,y
                    rts                 ; return to the caller
Branch_202          ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
StoreRuntimeError   clra                ; widen OS-9's error byte in B
                    std       >RuntimeErrorCode,y ; expose it through the compiler runtime
                    ldd       #-1       ; return the conventional failure value
                    rts
ReturnZeroOnSuccess
                    bcs       StoreRuntimeError ; translate a failed OS-9 service
                    clra
                    clrb                ; return zero for a successful void-style wrapper
                    rts
ExitProcess         lbsr      RunExitHook ; allow a linked application cleanup hook
                    lbsr      CloseAllStreams ; flush every compiler-managed stream
ExitWithStackStatus
stk_exit_return     equ       0         ; caller return address
stk_exit_status     equ       2         ; word-sized compiler exit argument
                    ldd       $02,s     ; recover the compiler's word-sized exit status
                    os9       F$Exit    ; terminate with its low byte in B
RunExitHook         rts                 ; default application cleanup hook does nothing

* packed initialized-data image, relocation metadata, ctype tables, and runtime
* literals expanded by the startup code above.  Its internal regions are decoded
* in the later data-table pass.
RuntimeInitializerImage
                    fcb       $00       ; first initialized-data block length high byte
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5E       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $78       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "0               HHHHHHHHHH       BBBBBB" ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcc       "      DDDDDD" ; store literal character data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "    " ; store literal character data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcc       "New_user" ; store literal character data
                    fcb       $00       ; store byte data

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
