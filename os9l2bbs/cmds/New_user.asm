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
*          2026/07/21  Codex
* Decoded character/word I/O, pushback, path status, and heap allocation.
**********************************************************************

                    nam       New_user
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

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

StreamCursor        rmb       2         ; current byte pointer within the assigned buffer
StreamBufferStart   rmb       2         ; first byte of the assigned stream buffer
StreamBufferEnd     rmb       2         ; byte just beyond valid or writable buffered data
StreamFlags         rmb       2         ; access, buffering, EOF, error, and orientation bits
StreamPath          rmb       2         ; underlying OS-9 path number
StreamPushbackByte  rmb       1         ; descriptor-local ungetc or fallback byte
StreamBufferSize    rmb       2         ; configured buffer capacity
RuntimeDescriptorTableRemainder rmb       338       ; remaining storage for the sixteen stream descriptors
StartupArgv0Pointer rmb       2         ; program-name pointer installed as argv[0]
StartupArgvVectorTail rmb       58        ; remaining argument-vector pointer slots
StartupArgcHigh     rmb       1         ; high byte adjoining compiler argument state
StartupArgumentState rmb       3         ; argc low byte and scanner bookkeeping
StartupParameterLength rmb       2         ; original OS-9 parameter length
RuntimeWorkspaceTail rmb       1418      ; compiler globals, scratch buffers, and application fields
size                equ       .

* compiler stream descriptor layout; each entry occupies thirteen bytes

StreamReadable      equ       $0001     ; reads are permitted
StreamWritable      equ       $0002     ; writes are permitted
StreamUnbuffered    equ       $0004     ; use the descriptor's one-byte fallback
StreamHasBuffer     equ       $0008     ; descriptor has multi-byte buffer storage
StreamAtEof         equ       $0010     ; the last refill reached end-of-file
StreamIoError       equ       $0020     ; the last transfer failed
StreamLineBuffered  equ       $0040     ; transfer carriage-return-terminated lines
StreamDescriptorSize equ       RuntimeDescriptorTableRemainder ; thirteen-byte stream descriptor stride
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
InitializeSecondDataBlock leau      >StreamCursor+1,u ; advance to the second initialized-data destination
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
                    leax      StreamCursor,u ; use the process data base as the relocation delta
                    lbsr      ApplyRelocationTable ; adjust every address named by this table
ParseCommandLine    leas      $04,s     ; discard saved startup registers and initializer boundary
                    puls      x         ; recover the OS-9 parameter length
                    stx       >StartupParameterLength,u ; retain the original parameter length
                    sty       >StartupArgv0Pointer,u ; seed argv with the program-name pointer
                    ldd       #1        ; begin argc with the implicit program name
                    std       >StartupArgcHigh,u ; seed argc with the implicit program-name argument
                    leay      >StartupArgvVectorTail,u ; select storage for the argv pointer vector
                    leax      ,s        ; point at OS-9's CR-terminated parameter text
                    lda       ,x+       ; prime the argument scanner with its first byte
ParseNextArgument   ldb       >StartupArgumentState,u ; recover the current argument count
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
                    inc       >StartupArgumentState,u ; count the newly discovered argument
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
                    inc       >StartupArgumentState,u ; count the newly discovered argument
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
InvokeRegistration  leax      >StartupArgv0Pointer,u ; pass the completed argv vector to the application
                    pshs      x         ; pass argv through the compiler calling convention
                    ldd       >StartupArgcHigh,u ; pass the completed argc value
                    pshs      d         ; pass argc beside argv
                    leay      StreamCursor,u ; establish the compiler global-data base
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
                    andb      #3        ; preserve the flags or register state required by the following operation
                    lbeq      ReturnFreeStreamSlot ; reuse an inactive descriptor
                    leau      StreamDescriptorSize,u ; advance by one descriptor structure
                    pshs      u         ; compare the candidate with the table end
                    leax      >$00DE,y  ; point just beyond the final descriptor
                    cmpx      ,s++      ; preserve the flags or register state required by the following operation
                    bhi       ScanStreamSlots ; inspect another in-range slot
                    ldd       #E$PthFul ; report exhaustion of runtime stream slots
                    std       >RuntimeErrorCode,y ; preserve the flags or register state required by the following operation
                    lbra      StreamSetupFailed ; continue at stream setup failed
                    fcb       $35
                    fcb       $C0
InitializeStreamDescriptor
stk_init_saved_u    equ       0         ; caller's U after the entry push
stk_init_return     equ       2         ; caller return address
stk_init_path       equ       4         ; path number supplied by OS-9
stk_init_mode       equ       6         ; mode-string pointer
stk_init_stream     equ       8         ; supplied descriptor or null
                    pshs      u         ; preserve the caller's descriptor register
                    ldu       $08,s     ; reuse a caller-supplied stream when present
                    bne       HaveStreamDescriptor ; select have stream descriptor when the requested case does not match
                    bsr       AllocateStreamSlot ; otherwise claim an inactive table entry
                    tfr       d,u       ; use the allocator's descriptor pointer
HaveStreamDescriptor
                    stu       -$02,s    ; mirror the pointer in the compiler spill slot and set Z
                    beq       StreamSetupFailed ; propagate table exhaustion as null
                    ldd       $04,s     ; attach the already-open OS-9 path
                    std       StreamPath,u ; preserve the flags or register state required by the following operation
                    ldx       $06,s     ; inspect the textual access mode
                    ldb       $01,x     ; a plus in either modifier position means update access
                    cmpb      #'+'      ; establish the scan stream slots loop or field bound ('+')
                    beq       MarkStreamForUpdate ; select mark stream for update when the requested case matches
                    ldx       $06,s     ; preserve the flags or register state required by the following operation
                    ldb       $02,x     ; preserve the flags or register state required by the following operation
                    cmpb      #'+'      ; establish the scan stream slots loop or field bound ('+')
                    bne       MarkSingleDirection ; select mark single direction when the requested case does not match
MarkStreamForUpdate
                    ldd       StreamFlags,u ; retain buffering state already assigned to the slot
                    orb       #OpenModeUpdate ; allow both buffered reads and writes
                    bra       FinishStreamDescriptor ; continue at finish stream descriptor
MarkSingleDirection
                    ldd       StreamFlags,u ; preserve all unrelated stream state bits
                    pshs      d         ; hold those bits while deriving the access direction
                    ldb       [<$08,s]  ; recover the mode string after the temporary push
                    cmpb      #'r'      ; establish the scan stream slots loop or field bound ('r')
                    beq       SelectReadDirection ; select select read direction when the requested case matches
                    ldb       [<$08,s]  ; preserve the flags or register state required by the following operation
                    cmpb      #'d'      ; directory streams are read-only
                    bne       SelectWriteDirection ; select select write direction when the requested case does not match
SelectReadDirection
                    ldd       #OpenModeRead ; establish the scan stream slots loop or field bound (OpenModeRead)
                    bra       MergeStreamDirection ; continue at merge stream direction
SelectWriteDirection
                    ldd       #OpenModeWrite ; append and write modes produce output streams
MergeStreamDirection
                    ora       ,s+       ; restore the existing high flag byte
                    orb       ,s+       ; merge the access bits into its low byte
FinishStreamDescriptor
                    std       StreamFlags,u ; preserve the flags or register state required by the following operation
                    ldd       StreamBufferStart,u ; calculate the boundary of any assigned buffer
                    addd      StreamBufferSize,u ; preserve the flags or register state required by the following operation
                    std       StreamBufferEnd,u ; preserve the flags or register state required by the following operation
                    std       StreamCursor,u ; an empty stream begins at that boundary
ReturnFreeStreamSlot
                    tfr       u,d       ; return the available descriptor pointer
                    puls      pc,u      ; preserve the flags or register state required by the following operation
StreamSetupFailed   clra                ; return a null descriptor pointer
                    clrb                ; complete the null return value
                    puls      pc,u      ; preserve the flags or register state required by the following operation
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
                    ldb       $01,x     ; preserve the flags or register state required by the following operation
                    sex                 ; widen it for the compiler's switch sequence
                    tfr       d,x       ; preserve the flags or register state required by the following operation
                    bra       DecodeModeModifier ; continue at decode mode modifier
DecodeExecuteModifier
                    ldx       $0A,s     ; an x modifier requests OS-9 execute access
                    ldb       $02,x     ; preserve the flags or register state required by the following operation
                    cmpb      #'+'      ; x+ combines execute with read/write access
                    bne       SelectExecuteMode ; select select execute mode when the requested case does not match
                    ldd       #OpenModeRead+OpenModeWrite+OpenModeExecute ; establish the stream setup failed loop or field bound (OpenModeRead+OpenModeWrite+OpenModeExecute)
                    bra       SaveOpenMode ; continue at save open mode
SelectExecuteMode   ldd       #OpenModeExecute ; initialize  to OpenModeExecute
                    bra       SaveOpenMode ; continue at save open mode
DecodeUpdateModifier
                    ldd       #OpenModeUpdate ; initialize  to OpenModeUpdate
SaveOpenMode        std       ,s        ; preserve the flags or register state required by the following operation
                    bra       DecodePrimaryMode ; continue at decode primary mode
RejectModeModifier  leax      $04,s     ; preserve the compiler-generated frame adjustment
                    lbra      RestoreModeParserFrame ; continue at restore mode parser frame
DecodeModeModifier  stx       -$02,s    ; retain the widened switch value in its spill slot
                    beq       DecodePrimaryMode ; an absent modifier leaves the mode at zero
                    cmpx      #'x'      ; preserve the flags or register state required by the following operation
                    beq       DecodeExecuteModifier ; select decode execute modifier when the requested case matches
                    cmpx      #'+'      ; preserve the flags or register state required by the following operation
                    beq       DecodeUpdateModifier ; select decode update modifier when the requested case matches
                    bra       RejectModeModifier ; continue at reject mode modifier
DecodePrimaryMode   ldb       [<$0A,s]  ; dispatch on the leading mode character
                    sex                 ; preserve the flags or register state required by the following operation
                    tfr       d,x       ; preserve the flags or register state required by the following operation
                    lbra      SelectPrimaryMode ; continue at select primary mode
SelectReadMode      ldd       ,s        ; preserve the flags or register state required by the following operation
                    orb       #OpenModeRead ; ensure r includes read access
                    bra       OpenSelectedPath ; continue at open selected path
SelectAppendMode    ldd       ,s        ; preserve the flags or register state required by the following operation
                    orb       #OpenModeWrite ; append requires write access
                    pshs      d         ; preserve the flags or register state required by the following operation
                    pshs      u         ; preserve the flags or register state required by the following operation
                    lbsr      OpenPath  ; preserve existing contents when the file exists
                    leas      $04,s     ; preserve the flags or register state required by the following operation
                    std       $02,s     ; preserve the flags or register state required by the following operation
                    cmpd      #-1       ; preserve the flags or register state required by the following operation
                    beq       CreateAppendPath ; create the file when opening it fails
                    ldd       #2        ; seek relative to end-of-file
                    pshs      d         ; preserve the flags or register state required by the following operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; append adds a zero 32-bit offset
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       $08,s     ; recover the opened path number
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      SeekPath  ; preserve the flags or register state required by the following operation
                    leas      $08,s     ; preserve the flags or register state required by the following operation
                    bra       ReturnModePath ; continue at return mode path
CreateAppendPath    ldd       ,s        ; preserve the flags or register state required by the following operation
                    orb       #OpenModeWrite ; preserve the flags or register state required by the following operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    pshs      u         ; preserve the flags or register state required by the following operation
                    lbsr      CreateOrTruncatePath ; create an initially empty target
                    bra       SaveModePath ; continue at save mode path
SelectDirectoryMode
                    ldd       ,s        ; preserve the flags or register state required by the following operation
                    orb       #OpenModeDirectory+OpenModeRead ; directory records are read-only
OpenSelectedPath    pshs      d         ; preserve the flags or register state required by the following operation
                    pshs      u         ; preserve the flags or register state required by the following operation
                    lbsr      OpenPath  ; preserve the flags or register state required by the following operation
SaveModePath        leas      $04,s     ; preserve the flags or register state required by the following operation
                    std       $02,s     ; retain the path while unwinding locals
                    bra       ReturnModePath ; continue at return mode path
RestoreModeParserFrame
                    leas      -$04,x    ; reconstruct the parser's original local stack
InvalidModeString   ldd       #E$BMode  ; publish the compiler runtime's bad-mode error
                    std       >RuntimeErrorCode,y ; preserve the flags or register state required by the following operation
                    clra                ; select standard input
                    clrb                ; preserve the original runtime's anomalous zero result
                    bra       FinishModeOpen ; continue at finish mode open
SelectPrimaryMode   cmpx      #'r'      ; preserve the flags or register state required by the following operation
                    lbeq      SelectReadMode ; select select read mode when the requested case matches
                    cmpx      #'a'      ; preserve the flags or register state required by the following operation
                    lbeq      SelectAppendMode ; select select append mode when the requested case matches
                    cmpx      #'w'      ; preserve the flags or register state required by the following operation
                    beq       CreateAppendPath ; write mode always truncates or creates
                    cmpx      #'d'      ; preserve the flags or register state required by the following operation
                    beq       SelectDirectoryMode ; select select directory mode when the requested case matches
                    bra       InvalidModeString ; continue at invalid mode string
ReturnModePath      ldd       $02,s     ; preserve the flags or register state required by the following operation
FinishModeOpen      leas      $04,s     ; release access and result locals
                    puls      pc,u      ; preserve the flags or register state required by the following operation
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
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       $06,s     ; pass the pathname after the first push
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      OpenPathFromMode ; translate the mode and obtain an OS-9 path
                    leas      $04,s     ; preserve the flags or register state required by the following operation
                    tfr       d,u       ; retain the path while building its descriptor
                    cmpu      #-1
                    bne       PathOpenSucceeded ; select path open succeeded when the requested case does not match
                    clra                ; select standard input
                    clrb                ; fopen-style failure returns a null stream
                    bra       ReturnOpenStream ; continue at return open stream
PathOpenSucceeded   clra                ; select standard input
                    clrb                ; request allocation of a new descriptor
                    bra       AttachOpenedPath ; continue at attach opened path
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
                    pshs      d         ; preserve the flags or register state required by the following operation
                    pshs      u         ; pass the opened OS-9 path
                    lbsr      InitializeStreamDescriptor ; preserve the flags or register state required by the following operation
                    leas      $06,s     ; preserve the flags or register state required by the following operation
ReturnOpenStream    puls      pc,u      ; preserve the flags or register state required by the following operation
ReadInputLine       pshs      u,d       ; save u,d on the stack
                    ldu       $06,s     ; recover $06
                    bra       ReadInputCharacter ; continue with read input character
StoreInputCharacter ldd       ,s        ; recover
                    stb       ,u+       ; retain
ReadInputCharacter  leax      >RuntimeInputStream,y ; select runtime input stream
                    pshs      x         ; preserve x across the operation
                    lbsr      ReadStreamCharacter ; invoke read stream character
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #13       ; test against #13
                    beq       FinishInputLine ; select finish input line when the requested case matches
                    ldd       ,s        ; recover
                    cmpd      #-1       ; test against #-1
                    bne       StoreInputCharacter ; select store input character when the requested case does not match
FinishInputLine     ldd       ,s        ; recover
                    cmpd      #-1       ; test against #-1
                    bne       TerminateInputLine ; select terminate input line when the requested case does not match
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       ReturnInputLine ; continue with return input line
TerminateInputLine  clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       StreamCursor,u ; retain stream cursor
                    ldd       $06,s     ; recover $06
ReturnInputLine     leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcc       "f2|"
                    fcb       $EC
                    fcb       $68
                    fcb       $ED
                    fcb       $E4
                    fcb       $20
                    fcb       $0E
                    fcb       $EC
                    fcb       $62
                    fcb       $AE
                    fcb       $E4
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $E4
                    fcb       $E7
                    fcb       $1F
                    fcb       $C1
                    fcb       $0D
                    fcb       $27
                    fcb       $19
                    fcb       $1F
                    fcc       "03_"
                    fcb       $ED
                    fcb       $7E
                    fcb       $2F
                    fcb       $11
                    fcb       $EC
                    fcb       $6C
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $07
                    fcc       "?2b"
                    fcb       $ED
                    fcb       $62
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $D9
                    fcb       $4F
                    fcb       $5F
                    fcb       $E7
                    fcb       $F4
                    fcb       $EC
                    fcb       $62
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $04
                    fcc       "O_ "
                    fcb       $02
                    fcb       $EC
                    fcc       "h2d5"
                    fcb       $C0
PrintFormatted      pshs      u         ; preserve u across the operation
                    leax      >RuntimeOutputStream,y ; select runtime output stream
                    stx       >$038F,y  ; retain $038 f
                    leax      $06,s     ; select $06
                    pshs      x         ; preserve x across the operation
                    ldd       $06,s     ; recover $06
                    bra       InvokeFormatEngine ; continue with invoke format engine
WriteFormattedStream pshs      u         ; preserve u across the operation
                    ldd       $04,s     ; recover $04
                    std       >$038F,y  ; retain $038 f
                    leax      $08,s     ; select $08
                    pshs      x         ; preserve x across the operation
                    ldd       $08,s     ; recover $08
InvokeFormatEngine  pshs      d         ; preserve d across the operation
                    leax      >EncodedFormatWrapper,pc ; select encoded format wrapper
                    pshs      x         ; preserve x across the operation
                    bsr       FormatOutputCore ; invoke format output core
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $03
                    fcb       $8F
                    fcc       "0h4"
                    fcb       $10
                    fcb       $EC
                    fcb       $68
                    fcb       $34
                    fcb       $06
                    fcb       $30
                    fcb       $8D
                    fcb       $04
                    fcb       $A9
                    fcb       $34
                    fcb       $10
                    fcb       $8D
                    fcb       $0C
                    fcc       "2fO_"
                    fcb       $E7
                    fcb       $B9
                    fcb       $03
                    fcb       $8F
                    fcb       $EC
                    fcb       $64
                    fcb       $35
                    fcb       $C0
FormatOutputCore    pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    leas      -$0B,s    ; release -$0B,s bytes of stack state
                    bra       ScanFormatString ; continue with scan format string
EmitLiteralFormatByte ldb       $08,s     ; recover $08
                    lbeq      FinishFormattedOutput ; select finish formatted output when the requested case matches
                    ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$11,s]
                    leas      $02,s     ; release $02,s bytes of stack state
ScanFormatString    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; establish the scan format string loop or field bound (37)
                    bne       EmitLiteralFormatByte ; select emit literal format byte when the requested case does not match
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; recover $08
                    cmpb      #45       ; establish the scan format string loop or field bound (45)
                    bne       NoLeftJustifyFlag ; select no left justify flag when the requested case does not match
                    ldd       #1        ; initialize $03 a5 to 1
                    std       >$03A5,y  ; retain $03 a5
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       SelectFormatPadding ; continue with select format padding
NoLeftJustifyFlag   clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >$03A5,y  ; retain $03 a5
SelectFormatPadding ldb       $08,s     ; recover $08
                    cmpb      #48       ; recognize or generate ASCII zero
                    bne       UseSpacePadding ; select use space padding when the requested case does not match
                    ldd       #48       ; recognize or generate ASCII zero
                    bra       SaveFormatPadding ; continue with save format padding
UseSpacePadding     ldd       #32       ; recognize the first printable ASCII value
SaveFormatPadding   std       >$03A7,y  ; retain $03 a7
                    bra       ParseFieldWidth ; continue with parse field width
AccumulateFieldWidth ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; invoke multiply unsigned words
                    pshs      d         ; preserve d across the operation
                    ldb       $0A,s     ; recover $0 a
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; consume the next byte while accumulate field width
                    stb       $08,s     ; store b in the current stack frame at $08,s
ParseFieldWidth     ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; select $00 df
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulateFieldWidth ; repeat accumulate field width until the terminating condition is met
                    ldb       $08,s     ; recover $08
                    cmpb      #46       ; establish the parse field width loop or field bound (46)
                    bne       NoPrecisionSpecified ; select no precision specified when the requested case does not match
                    ldd       #1        ; initialize $04 to 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       ParsePrecisionDigits ; continue with parse precision digits
AccumulatePrecision ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; invoke multiply unsigned words
                    pshs      d         ; preserve d across the operation
                    ldb       $0A,s     ; recover $0 a
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
ParsePrecisionDigits ldb       ,u+       ; consume the next byte while parse precision digits
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; select $00 df
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulatePrecision ; repeat accumulate precision until the terminating condition is met
                    bra       DispatchConversion ; continue with dispatch conversion
NoPrecisionSpecified clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $04,s     ; store d in the current stack frame at $04,s
DispatchConversion  ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      MatchConversionType ; continue with match conversion type
FormatSignedDecimal ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    lbsr      ConvertSignedDecimal ; invoke convert signed decimal
                    bra       StoreConvertedPointer ; continue with store converted pointer
FormatOctal         ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    lbsr      ConvertOctal ; invoke convert octal
StoreConvertedPointer std       ,s        ; store d in the current stack frame at ,s
                    lbra      WriteConvertedField ; continue with write converted field
FormatHexadecimal   ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldb       $0A,s     ; recover $0 a
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; select $00 df
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #2        ; mask b using #2
                    pshs      d         ; preserve d across the operation
                    ldx       <$0017,s  ; recover $0017
                    leax      $02,x     ; select $02
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    lbsr      ConvertHexadecimal ; invoke convert hexadecimal
                    lbra      RestoreFormatStack ; continue with restore format stack
FormatUnsignedDecimal ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    leax      >$0391,y  ; select $0391
                    pshs      x         ; preserve x across the operation
                    lbsr      ConvertUnsignedDecimal ; invoke convert unsigned decimal
                    lbra      RestoreFormatStack ; continue with restore format stack
FormatFloatingValue ldd       $04,s     ; recover $04
                    bne       ConvertFloatingValue ; select convert floating value when the requested case does not match
                    ldd       #6        ; initialize $02 to 6
                    std       $02,s     ; store d in the current stack frame at $02,s
ConvertFloatingValue ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    leax      <$0015,s  ; select $0015
                    pshs      x         ; preserve x across the operation
                    ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldb       $0E,s     ; recover $0 e
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    lbsr      ReturnEmptyString ; invoke return empty string
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      PassConvertedField ; continue with pass converted field
FormatCharacterValue ldx       <$0013,s  ; recover $0013
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    lbra      EmitScalarValue ; continue with emit scalar value
FormatStringValue   ldx       <$0013,s  ; recover $0013
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; recover $04
                    beq       StringWidthReady ; select string width ready when the requested case matches
                    ldd       $09,s     ; recover $09
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       MeasureBoundedString ; continue with measure bounded string
CountStringByte     ldb       [<$09,s]  ; recover [<$09
                    beq       EmitFormattedField ; select emit formatted field when the requested case matches
                    ldd       $09,s     ; recover $09
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
MeasureBoundedString ldd       $02,s     ; recover $02
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       CountStringByte ; select count string byte when the requested case does not match
EmitFormattedField  ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $0B,s     ; recover $0 b
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; preserve d across the operation
                    ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    ldd       <$0015,s  ; recover $0015
                    pshs      d         ; preserve d across the operation
                    lbsr      WritePaddedField ; invoke write padded field
                    leas      $08,s     ; release $08,s bytes of stack state
                    bra       ResumeFormatScan ; continue with resume format scan
StringWidthReady    ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $0B,s     ; recover $0 b
                    bra       PassConvertedField ; continue with pass converted field
AcceptLongModifier  ldb       ,u+       ; consume the next byte while accept long modifier
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       FormatLongValue ; continue with format long value
                    fcb       $32
                    fcb       $15
FormatLongValue     ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    leax      <$0015,s  ; select $0015
                    pshs      x         ; preserve x across the operation
                    ldb       $0C,s     ; recover $0 c
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    lbsr      SelectIntegerArgument ; invoke select integer argument
RestoreFormatStack  leas      $04,s     ; release $04,s bytes of stack state
PassConvertedField  pshs      d         ; preserve d across the operation
WriteConvertedField ldd       <$0013,s  ; recover $0013
                    pshs      d         ; preserve d across the operation
                    lbsr      WritePaddedString ; invoke write padded string
                    leas      $06,s     ; release $06,s bytes of stack state
ResumeFormatScan    lbra      ScanFormatString ; continue with scan format string
EmitUnknownSpecifier ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
EmitScalarValue     pshs      d         ; preserve d across the operation
                    jsr       [<$11,s]
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      ScanFormatString ; continue with scan format string
MatchConversionType cmpx      #100      ; test against #100
                    lbeq      FormatSignedDecimal ; select format signed decimal when the requested case matches
                    cmpx      #111      ; test against #111
                    lbeq      FormatOctal ; select format octal when the requested case matches
                    cmpx      #120      ; test against #120
                    lbeq      FormatHexadecimal ; select format hexadecimal when the requested case matches
                    cmpx      #88       ; test against #88
                    lbeq      FormatHexadecimal ; select format hexadecimal when the requested case matches
                    cmpx      #117      ; test against #117
                    lbeq      FormatUnsignedDecimal ; select format unsigned decimal when the requested case matches
                    cmpx      #102      ; test against #102
                    lbeq      FormatFloatingValue ; select format floating value when the requested case matches
                    cmpx      #101      ; test against #101
                    lbeq      FormatFloatingValue ; select format floating value when the requested case matches
                    cmpx      #103      ; test against #103
                    lbeq      FormatFloatingValue ; select format floating value when the requested case matches
                    cmpx      #69       ; test against #69
                    lbeq      FormatFloatingValue ; select format floating value when the requested case matches
                    cmpx      #71       ; test against #71
                    lbeq      FormatFloatingValue ; select format floating value when the requested case matches
                    cmpx      #99       ; test against #99
                    lbeq      FormatCharacterValue ; select format character value when the requested case matches
                    cmpx      #115      ; test against #115
                    lbeq      FormatStringValue ; select format string value when the requested case matches
                    cmpx      #108      ; test against #108
                    lbeq      AcceptLongModifier ; select accept long modifier when the requested case matches
                    bra       EmitUnknownSpecifier ; continue with emit unknown specifier
FinishFormattedOutput leas      $0B,s     ; release $0B,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertSignedDecimal pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; select $0391
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; recover $06
                    bge       ConvertSignedMagnitude ; continue with convert signed magnitude at or above the signed limit
                    ldd       $06,s     ; recover $06
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       PrefixMinusSign ; continue with prefix minus sign at or above the signed limit
                    leax      >MinimumSignedText,pc ; select minimum signed text
                    pshs      x         ; preserve x across the operation
                    leax      >$0391,y  ; select $0391
                    pshs      x         ; preserve x across the operation
                    lbsr      CopyCString ; invoke copy cstring
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnConversionBuffer ; continue with return conversion buffer
PrefixMinusSign     ldd       #45       ; initialize  to 45
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ConvertSignedMagnitude ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    bsr       ConvertUnsignedDecimal ; invoke convert unsigned decimal
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnNumericBuffer ; continue with return numeric buffer
ConvertUnsignedDecimal pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; recover $0 a
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       NormalizeDecimalRange ; continue with normalize decimal range
IncreaseDecimalDigitCount ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; recover $0 c
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
NormalizeDecimalRange ldd       $0C,s     ; recover $0 c
                    blt       IncreaseDecimalDigitCount ; continue with increase decimal digit count below the signed limit
                    leax      >$0001,y  ; select $0001
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       EmitDecimalDigits ; continue with emit decimal digits
AdvanceDecimalDigit ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
SubtractDecimalPlace ldd       $0C,s     ; recover $0 c
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       AdvanceDecimalDigit ; continue with advance decimal digit at or above the signed limit
                    ldd       $0C,s     ; recover $0 c
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; recover
                    beq       MarkDecimalStarted ; select mark decimal started when the requested case matches
                    ldd       #1        ; initialize $02 to 1
                    std       $02,s     ; store d in the current stack frame at $02,s
MarkDecimalStarted  ldd       $02,s     ; recover $02
                    beq       AdvanceDecimalDivisor ; select advance decimal divisor when the requested case matches
                    ldd       ,s        ; recover
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
AdvanceDecimalDivisor clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; recover $04
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
EmitDecimalDigits   ldd       $04,s     ; recover $04
                    cmpd      >$0009,y  ; test against $0009
                    bne       SubtractDecimalPlace ; select subtract decimal place when the requested case does not match
                    ldd       $0C,s     ; recover $0 c
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       StreamCursor,u ; retain stream cursor
                    ldd       $0A,s     ; recover $0 a
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertOctal        pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; select $0391
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$039B,y  ; select $039 b
ExtractOctalDigit   ldd       $06,s     ; recover $06
                    clra                ; select standard input
                    andb      #7        ; mask b using #7
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
                    ldd       $06,s     ; recover $06
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bne       ExtractOctalDigit ; select extract octal digit when the requested case does not match
                    bra       ReverseOctalDigits ; continue with reverse octal digits
CopyOctalDigit      ldb       StreamCursor,u ; recover stream cursor
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseOctalDigits  leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$039B,y  ; select $039 b
                    cmpx      ,s++      ; test against
                    bls       CopyOctalDigit ; continue copy octal digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [,s]      ; store b in the current stack frame at [,s]
ReturnNumericBuffer leax      >$0391,y  ; select $0391
                    tfr       x,d       ; transfer x,d
ReturnConversionBuffer leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertHexadecimal  pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$0391,y  ; select $0391
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$039B,y  ; select $039 b
ExtractHexDigit     ldd       $08,s     ; recover $08
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; preserve d across the operation
                    ldd       $02,s     ; recover $02
                    cmpd      #9        ; test against #9
                    ble       UseNumericHexDigit
                    ldd       $0C,s     ; recover $0 c
                    beq       UseLowercaseHexBase ; select use lowercase hex base when the requested case matches
                    ldd       #65       ; establish the extract hex digit loop or field bound (65)
                    bra       AdjustHexAlphabeticDigit ; continue with adjust hex alphabetic digit
UseLowercaseHexBase ldd       #97       ; establish the use lowercase hex base loop or field bound (97)
AdjustHexAlphabeticDigit addd      #-10      ; add to d using #-10
                    bra       StoreHexDigit ; continue with store hex digit
UseNumericHexDigit  ldd       #48       ; recognize or generate ASCII zero
StoreHexDigit       addd      ,s++      ; add to d using ,s++
                    stb       ,u+       ; retain
                    ldd       $08,s     ; recover $08
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
                    bne       ExtractHexDigit ; select extract hex digit when the requested case does not match
                    bra       ReverseHexDigits ; continue with reverse hex digits
CopyHexDigit        ldb       StreamCursor,u ; recover stream cursor
                    ldx       $02,s     ; recover $02
                    leax      $01,x     ; select $01
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseHexDigits    leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$039B,y  ; select $039 b
                    cmpx      ,s++      ; test against
                    bls       CopyHexDigit ; continue copy hex digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$0391,y  ; select $0391
                    tfr       x,d       ; transfer x,d
                    lbra      ReturnFormattedBuffer ; continue with return formatted buffer
WritePaddedField    pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    ldd       $0A,s     ; recover $0 a
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$03A5,y  ; recover $03 a5
                    bne       EmitFieldBytes ; select emit field bytes when the requested case does not match
                    bra       EmitLeadingPadding ; continue with emit leading padding
EmitLeadingPadByte  ldd       >$03A7,y  ; recover $03 a7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitLeadingPadding  ldd       $0A,s     ; recover $0 a
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitLeadingPadByte
                    bra       EmitFieldBytes ; continue with emit field bytes
EmitNextFieldByte   ldb       ,u+       ; consume the next byte while emit next field byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitFieldBytes      ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       EmitNextFieldByte ; select emit next field byte when the requested case does not match
                    ldd       >$03A5,y  ; recover $03 a5
                    beq       ReturnPaddedField ; select return padded field when the requested case matches
                    bra       EmitTrailingPadding ; continue with emit trailing padding
EmitTrailingPadByte ldd       >$03A7,y  ; recover $03 a7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitTrailingPadding ldd       $0A,s     ; recover $0 a
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitTrailingPadByte
ReturnPaddedField   puls      pc,u      ; restore pc,u and return to the caller
WritePaddedString   pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    pshs      u         ; preserve u across the operation
                    lbsr      MeasureCString ; invoke measure cstring
                    leas      $02,s     ; release $02,s bytes of stack state
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$03A5,y  ; recover $03 a5
                    bne       EmitStringBytes ; select emit string bytes when the requested case does not match
                    bra       EmitStringLeadingPadding ; continue with emit string leading padding
EmitStringLeadingPadByte ldd       >$03A7,y  ; recover $03 a7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringLeadingPadding ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitStringLeadingPadByte
                    bra       EmitStringBytes ; continue with emit string bytes
EmitNextStringByte  ldb       ,u+       ; consume the next byte while emit next string byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringBytes     ldb       StreamCursor,u ; recover stream cursor
                    bne       EmitNextStringByte ; select emit next string byte when the requested case does not match
                    ldd       >$03A5,y  ; recover $03 a5
                    beq       ReturnPaddedString ; select return padded string when the requested case matches
                    bra       EmitStringTrailingPadding ; continue with emit string trailing padding
EmitStringTrailingPadByte ldd       >$03A7,y  ; recover $03 a7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringTrailingPadding ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitStringTrailingPadByte
ReturnPaddedString  puls      pc,u      ; restore pc,u and return to the caller
EncodedFormatWrapper fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $A9
                    fcb       $03
                    fcb       $8F
                    fcb       $34
                    fcb       $06
                    fcb       $EC
                    fcb       $66
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $00
                    fcb       $1D
ReturnFormattedBuffer leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $64
                    fcb       $AE
                    fcb       $A9
                    fcb       $03
                    fcb       $8F
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $A9
                    fcb       $03
                    fcb       $8F
                    fcb       $E7
                    fcb       $1F
                    fcb       $35
                    fcb       $C0
MinimumSignedText   fcc       "-32768"
                    fcb       $00
* encoded putc-style entry point; raw bytes preserve the compiler's exact layout.
WriteStreamCharacter
stk_putc_saved_u    equ       0         ; caller's U after the encoded entry push
stk_putc_return     equ       2         ; caller return address
stk_putc_char       equ       4         ; character value
stk_putc_stream     equ       6         ; destination descriptor
                    fcb       $34,$40   ; preserve U
                    fcb       $EE,$66   ; select the destination descriptor
                    fcb       $EC,$46   ; inspect initialization, write, and error state
                    fcb       $84,$80   ; isolate StreamInitialized's high byte
                    fcb       $C4,$22   ; retain StreamWritable and StreamIoError
                    fcb       $10,$83,$80,$02 ; accept an initialized healthy output stream
                    fcb       $27,$14   ; continue at CharacterStreamReady
                    fcb       $EC,$46   ; retry the state test without initialization
                    fcb       $4F       ; ignore high-byte flags
                    fcb       $C4,$22   ; retain write permission and error state
                    fcb       $10,$83,$00,$02 ; accept an uninitialized healthy output stream
                    fcb       $10,$26,$01,$1F ; otherwise return through RejectFlushRequest
                    fcb       $34,$40   ; pass the descriptor to lazy initialization
                    fcb       $17,$03,$4D ; choose buffering policy and storage
                    fcb       $32,$62   ; discard the descriptor argument
CharacterStreamReady
                    fcb       $EC,$46   ; choose buffered or one-byte output
                    fcb       $4F       ; inspect only low-byte flags
                    fcb       $C4,$04   ; isolate StreamUnbuffered
                    fcb       $27,$35   ; use BufferCharacter for normal buffering
WriteUnbufferedCharacter
                    fcb       $CC,$00,$01 ; request a one-byte transfer
                    fcb       $34,$06   ; pass the transfer length
                    fcb       $30,$67   ; point at the low byte of the character argument
                    fcb       $34,$10   ; pass that one-byte source address
                    fcb       $EC,$48   ; select the underlying OS-9 path
                    fcb       $34,$06   ; pass the path number
                    fcb       $EC,$46   ; choose line or ordinary write semantics
                    fcb       $4F       ; inspect low-byte buffering flags
                    fcb       $C4,$40   ; isolate StreamLineBuffered
                    fcb       $27,$06   ; select WriteBytes for ordinary output
                    fcb       $30,$8D,$06,$43 ; select WriteLineBytes for terminal output
                    fcb       $20,$04   ; join InvokeCharacterWrite
                    fcb       $30,$8D,$06,$24 ; select WriteBytes for ordinary output
InvokeCharacterWrite
                    fcb       $1F,$10   ; preserve the selected wrapper in compiler form
                    fcb       $1F,$01   ; restore it as an indirect-call pointer
                    fcb       $AD,$84   ; invoke the selected one-byte write
                    fcb       $32,$66   ; discard path, buffer, and length arguments
                    fcb       $10,$83,$FF,$FF ; detect low-level write failure
                    fcb       $26,$4A   ; return the written character on success
                    fcb       $EC,$46   ; preserve the descriptor state after failure
                    fcb       $CA,$20   ; latch StreamIoError
                    fcb       $ED,$46   ; publish the error state
                    fcb       $16,$00,$DC ; return -1 through RejectFlushRequest
BufferCharacter
                    fcb       $EC,$46   ; inspect the stream's current orientation
                    fcb       $84,$01   ; isolate StreamWriting's high byte
                    fcb       $5F       ; form a word-sized orientation test
                    fcb       $ED,$7E   ; spill it below the compiler frame
                    fcb       $26,$07   ; retain an existing output buffer
                    fcb       $34,$40   ; pass the descriptor to the buffer flusher
                    fcb       $17,$00,$EB ; reset an input-oriented buffer for output
                    fcb       $32,$62   ; discard the descriptor argument
StoreCharacterInBuffer
                    fcb       $EC,$C4   ; recover the current cursor
                    fcb       $C3,$00,$01 ; advance by one byte
                    fcb       $ED,$C4   ; publish the following cursor
                    fcb       $83,$00,$01 ; recover the byte address being filled
                    fcb       $1F,$01   ; use that address as X
                    fcb       $EC,$64   ; recover the character argument
                    fcb       $E7,$84   ; store its low byte in the buffer
                    fcb       $EC,$C4   ; inspect the updated cursor
                    fcb       $10,$A3,$44 ; compare it with StreamBufferEnd
                    fcb       $24,$0F   ; flush when the buffer is full
                    fcb       $EC,$46   ; otherwise inspect line-buffering state
                    fcb       $4F       ; ignore high-byte flags
                    fcb       $C4,$40   ; isolate StreamLineBuffered
                    fcb       $27,$13   ; return immediately for block buffering
                    fcb       $EC,$64   ; recover the character value
                    fcb       $10,$83,$00,$0D ; detect carriage return
                    fcb       $26,$0B   ; retain non-terminating line characters
FlushBufferedCharacter
                    fcb       $34,$40   ; pass the descriptor to the buffer flusher
                    fcb       $17,$00,$BE ; write the full buffer or completed line
                    fcb       $ED,$E1   ; replace the argument slot with the flush result
                    fcb       $10,$26,$00,$9B ; return -1 if flushing failed
ReturnWrittenCharacter
                    fcb       $EC,$64   ; return the original character value
                    fcb       $35,$C0   ; restore U and return
* encoded putw-style entry point; emit the high byte before the low byte.
WriteStreamWord
stk_putw_saved_u    equ       0         ; caller's U after the encoded entry push
stk_putw_return     equ       2         ; caller return address
stk_putw_stream     equ       4         ; destination descriptor
stk_putw_word       equ       6         ; big-endian word value
                    fcb       $34,$40   ; preserve U
                    fcb       $EE,$64   ; retain the destination descriptor
                    fcb       $EC,$66   ; recover the word being written
                    fcb       $34,$06   ; pass it to the shift helper
                    fcb       $34,$40   ; preserve the stream argument
                    fcb       $CC,$00,$08 ; request an eight-bit right shift
                    fcb       $17,$04,$79 ; extract the original high byte
                    fcb       $34,$06   ; pass that byte to WriteStreamCharacter
                    fcb       $17,$FF,$46 ; emit the high byte first
                    fcb       $32,$64   ; discard the first character arguments
                    fcb       $EC,$66   ; recover the original word
                    fcb       $34,$06   ; pass its low byte as the character value
                    fcb       $34,$40   ; pass the destination descriptor
                    fcb       $17,$FF,$3B ; emit the low byte second
                    fcb       $16,$01,$4B ; return through the shared stream epilogue
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
* encoded ungetc-style entry point; push one byte back into cached input.
UnreadStreamCharacter
stk_ungetc_saved_u  equ       0         ; caller's U after the encoded entry push
stk_ungetc_return   equ       2         ; caller return address
stk_ungetc_char     equ       4         ; character to restore
stk_ungetc_stream   equ       6         ; readable descriptor
                    fcb       $34,$40   ; preserve U
                    fcb       $EE,$66   ; select the target descriptor
                    fcb       $27,$16   ; reject a null stream
                    fcb       $EC,$46   ; inspect its access flags
                    fcb       $4F       ; ignore high-byte orientation state
                    fcb       $C4,$01   ; isolate StreamReadable
                    fcb       $27,$0F   ; reject a non-readable stream
                    fcb       $EC,$64   ; recover the requested character
                    fcb       $10,$83,$FF,$FF ; reject the EOF sentinel
                    fcb       $27,$07   ; return failure for EOF
                    fcb       $EC,$C4   ; recover the current input cursor
                    fcb       $10,$A3,$42 ; compare it with StreamBufferStart
                    fcb       $22,$05   ; push back only when space precedes the cursor
ReturnReadFailure   ldd       #-1       ; represent EOF, error, or invalid orientation
                    puls      pc,u      ; restore U and return failure
PushBackCharacter
                    fcb       $EC,$C4   ; recover the current cursor
                    fcb       $C3,$FF,$FF ; move it back by one byte
                    fcb       $ED,$C4   ; publish the restored input position
                    fcb       $1F,$01   ; use the new cursor as X
                    fcb       $EC,$64   ; recover the character argument
                    fcb       $E7,$84   ; place its low byte before unread input
                    fcb       $EC,$64   ; return the restored character
                    fcb       $35,$C0   ; restore U and return
* encoded getw-style entry point; combine two input bytes in big-endian order.
ReadStreamWord
stk_getw_second     equ       0         ; second byte after local allocation
stk_getw_first      equ       2         ; first byte after local allocation
stk_getw_saved_u    equ       4         ; caller's U after local allocation
stk_getw_return     equ       6         ; caller return address after local allocation
stk_getw_stream     equ       8         ; source descriptor after local allocation
                    fcb       $34,$40   ; preserve U
                    fcb       $EE,$64   ; retain the source descriptor
                    fcb       $32,$7C   ; reserve both byte-result words
                    fcb       $34,$40   ; pass the stream to ReadStreamCharacter
                    fcb       $17,$FF,$93 ; obtain the high byte
                    fcb       $32,$62   ; discard the stream argument
                    fcb       $ED,$62   ; retain the first byte
                    fcb       $10,$83,$FF,$FF ; detect EOF or input failure
                    fcb       $27,$0F   ; return -1 without reading a low byte
                    fcb       $34,$40   ; pass the stream for the second read
                    fcb       $17,$FF,$84 ; obtain the low byte
                    fcb       $32,$62   ; discard the stream argument
                    fcb       $ED,$E4   ; retain the second byte
                    fcb       $10,$83,$FF,$FF ; detect EOF or input failure
                    fcb       $26,$05   ; combine two valid bytes
                    fcb       $CC,$FF,$FF ; otherwise return failure
                    fcb       $20,$0C   ; skip the combination path
CombineStreamWord   fcb       $EC,$62   ; recover the first byte
                    fcb       $34,$06   ; pass it to the shift helper
                    fcb       $CC,$00,$08 ; request an eight-bit left shift
                    fcb       $17,$02,$95 ; move the first byte into the high half
                    fcb       $E3,$E4   ; add the retained second byte
                    fcb       $32,$64   ; release both local words
                    fcb       $35,$C0   ; restore U and return the combined word
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
SelectIntegerArgument pshs      u         ; preserve u across the operation
                    ldb       $05,s     ; recover $05
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    bra       ClassifyIntegerConversion ; continue with classify integer conversion
FetchLongIntegerArgument ldd       [<$06,s]  ; recover [<$06
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >EmptyIntegerText,pc ; select empty integer text
                    bra       ReturnIntegerArgument ; continue with return integer argument
UseByteIntegerArgument ldb       $05,s     ; recover $05
                    stb       >$000C,y  ; retain $000 c
                    leax      >$000B,y  ; select $000 b
ReturnIntegerArgument tfr       x,d       ; transfer x,d
                    puls      pc,u      ; restore pc,u and return to the caller
ClassifyIntegerConversion cmpx      #100      ; test against #100
                    beq       FetchLongIntegerArgument ; select fetch long integer argument when the requested case matches
                    cmpx      #111      ; test against #111
                    lbeq      FetchLongIntegerArgument ; select fetch long integer argument when the requested case matches
                    cmpx      #120      ; test against #120
                    lbeq      FetchLongIntegerArgument ; select fetch long integer argument when the requested case matches
                    bra       UseByteIntegerArgument ; continue with use byte integer argument
                    fcb       $35
                    fcb       $C0
EmptyIntegerText    fcb       $00
ReturnEmptyString   pshs      u         ; preserve u across the operation
                    leax      >EmptyString,pc ; select empty string
                    tfr       x,d       ; transfer x,d
                    puls      pc,u      ; restore pc,u and return to the caller
EmptyString         fcb       $00
MeasureCString      pshs      u         ; preserve u across the operation
                    ldu       $04,s     ; recover $04
FindCStringEnd      ldb       ,u+       ; consume the next byte while find cstring end
                    bne       FindCStringEnd ; repeat find cstring end until the terminating condition is met
                    tfr       u,d       ; transfer u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
CopyCString         pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    ldd       $06,s     ; recover $06
                    std       ,s        ; store d in the current stack frame at ,s
CopyCStringByte     ldb       ,u+       ; consume the next byte while copy cstring byte
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
                    bne       CopyCStringByte ; repeat copy cstring byte until the terminating condition is met
                    bra       ReturnCopiedString ; continue with return copied string
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcc       "f2~"
                    fcb       $EC
                    fcb       $66
                    fcb       $ED
                    fcb       $E4
                    fcb       $AE
                    fcb       $E4
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $E4
                    fcb       $E6
                    fcb       $1F
                    fcb       $26
                    fcb       $F6
                    fcb       $EC
                    fcb       $E4
                    fcb       $C3
                    fcb       $FF
                    fcb       $FF
                    fcb       $ED
                    fcb       $E4
                    fcb       $E6
                    fcb       $C0
                    fcb       $AE
                    fcb       $E4
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $E4
                    fcb       $E7
                    fcb       $1F
                    fcb       $26
                    fcb       $F4
ReturnCopiedString  ldd       $06,s     ; recover $06
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcb       $64
                    fcb       $20
                    fcb       $10
                    fcb       $AE
                    fcb       $66
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $66
                    fcb       $E6
                    fcb       $1F
                    fcb       $26
                    fcb       $04
                    fcc       "O_5"
                    fcb       $C0
                    fcb       $33
                    fcb       $41
                    fcb       $E6
                    fcb       $C4
                    fcb       $1D
                    fcb       $34
                    fcb       $06
                    fcb       $E6
                    fcb       $F8
                    fcb       $08
                    fcb       $1D
                    fcb       $10
                    fcb       $A3
                    fcb       $E1
                    fcb       $27
                    fcb       $E2
                    fcb       $E6
                    fcb       $F8
                    fcb       $06
                    fcb       $1D
                    fcb       $34
                    fcb       $06
                    fcb       $E6
                    fcb       $C4
                    fcb       $1D
                    fcb       $A3
                    fcb       $E1
                    fcb       $35
                    fcb       $C0
MultiplyUnsignedWords tsta                ; set condition codes from a without changing it
                    bne       MultiplyFullWidth ; repeat multiply full width until the terminating condition is met
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       MultiplyFullWidth ; repeat multiply full width until the terminating condition is met
                    lda       $03,s     ; recover $03
                    mul                 ; form the byte-product in D
                    ldx       ,s        ; recover
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; initialize  to 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
MultiplyFullWidth   pshs      d         ; preserve d across the operation
                    ldd       #0        ; establish the multiply full width loop or field bound (0)
                    pshs      d         ; preserve d across the operation
                    pshs      d         ; preserve d across the operation
                    lda       $05,s     ; recover $05
                    ldb       $09,s     ; recover $09
                    mul                 ; form the byte-product in D
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lda       $05,s     ; recover $05
                    ldb       $08,s     ; recover $08
                    mul                 ; form the byte-product in D
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       AccumulateMiddleProduct ; continue accumulate middle product while the range test permits it
                    inc       ,s        ; increment the value at ,s
AccumulateMiddleProduct lda       $04,s     ; recover $04
                    ldb       $09,s     ; recover $09
                    mul                 ; form the byte-product in D
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       AccumulateHighProduct ; continue accumulate high product while the range test permits it
                    inc       ,s        ; increment the value at ,s
AccumulateHighProduct lda       $04,s     ; recover $04
                    ldb       $08,s     ; recover $08
                    mul                 ; form the byte-product in D
                    addd      ,s        ; add to d using ,s
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $06,s     ; recover $06
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       ,s        ; recover
                    ldd       $02,s     ; recover $02
                    leas      $08,s     ; release $08,s bytes of stack state
                    rts                 ; return to the caller
                    fcb       $5D
                    fcb       $27
                    fcb       $13
                    fcc       "gbfcZ&"
                    fcb       $F9
                    fcb       $20
                    fcb       $0A
                    fcb       $5D
                    fcb       $27
                    fcb       $07
                    fcc       "dbfcZ&"
                    fcb       $F9
                    fcb       $EC
                    fcb       $62
                    fcb       $34
                    fcb       $06
                    fcb       $EC
                    fcb       $62
                    fcb       $ED
                    fcb       $64
                    fcb       $EC
                    fcb       $E4
                    fcc       "2d9]'"
                    fcb       $F0
                    fcc       "hcibZ&"
                    fcb       $F9
                    fcb       $20
                    fcb       $E7
GetPathStatus
stk_getstt_return   equ       0         ; caller return address
stk_getstt_selector equ       2         ; word-sized GetStat selector
stk_getstt_path     equ       4         ; word-sized path number
stk_getstt_result   equ       6         ; buffer or 32-bit result pointer
                    lda       $05,s     ; select the OS-9 path number
                    ldb       $03,s     ; dispatch on the requested GetStat selector
                    beq       GetStatusIntoBuffer ; selector zero fills an option table at X
                    cmpb      #1        ; selector one returns register-only status
                    beq       InvokeSimpleGetStatus ; select invoke simple get status when the requested case matches
                    cmpb      #6        ; selector six also needs no result-buffer translation
                    beq       InvokeSimpleGetStatus ; select invoke simple get status when the requested case matches
                    cmpb      #SS.Size  ; file size returns a 32-bit X:U value
                    beq       GetLongPathStatus ; select get long path status when the requested case matches
                    cmpb      #SS.Pos   ; current position also returns X:U
                    beq       GetLongPathStatus ; select get long path status when the requested case matches
                    ldb       #E$UnkSvc ; reject selectors unsupported by this compiler wrapper
                    lbra      StoreRuntimeError ; continue at store runtime error
GetLongPathStatus   pshs      u         ; preserve the compiler workspace register
                    os9       I$GetStt  ; obtain the requested 32-bit value in X:U
                    bcc       StoreLongPathStatus ; select store long path status when carry remains clear
                    puls      u         ; restore U before translating the OS-9 error
                    lbra      StoreRuntimeError ; continue at store runtime error
StoreLongPathStatus
                    stx       [<$08,s]  ; store the high word through the shifted result pointer
                    ldx       $08,s     ; recover that result pointer
                    stu       $02,x     ; store the low word after it
                    puls      u         ; restore the compiler workspace register
                    clra                ; return zero after a successful status query
                    clrb                ; clear the byte accumulator for counting
                    rts                 ; return the completed result to the caller
GetStatusIntoBuffer ldx       $06,s     ; supply the caller's option-table buffer
InvokeSimpleGetStatus
                    os9       I$GetStt  ; perform the selector-specific status request
                    lbra      ReturnZeroOnSuccess ; return zero or publish the OS-9 error
                    fcb       $A6
                    fcb       $65
                    fcb       $E6
                    fcb       $63
                    fcb       $27
                    fcb       $09
                    fcb       $C1
                    fcb       $02
                    fcb       $27
                    fcb       $0D
                    fcb       $C6
                    fcb       $D0
                    fcb       $16
                    fcb       $01
                    fcb       $E6
                    fcb       $AE
                    fcb       $66
                    fcb       $10
                    fcb       $3F
                    fcb       $8E
                    fcb       $16
                    fcb       $01
                    fcb       $E7
                    fcb       $34
                    fcb       $40
                    fcb       $AE
                    fcb       $68
                    fcb       $EE
                    fcb       $6A
                    fcb       $10
                    fcb       $3F
                    fcb       $8E
                    fcb       $35
                    fcb       $40
                    fcb       $16
                    fcb       $01
                    fcb       $D9
                    fcb       $AE
                    fcb       $62
                    fcb       $A6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $84
                    fcb       $25
                    fcb       $03
                    fcb       $10
                    fcb       $3F
                    fcb       $8F
                    fcb       $16
                    fcb       $01
                    fcb       $CA
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
                    rts                 ; return the completed result to the caller
ClosePath
stk_close_return    equ       0         ; caller return address
stk_close_path      equ       2         ; word-sized path number; low byte is at +1
                    lda       $03,s     ; select the path argument
                    os9       I$Close   ; flush and release the OS-9 path
                    lbra      ReturnZeroOnSuccess ; return zero or record the OS-9 error
                    fcb       $AE
                    fcb       $62
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $85
                    fcb       $16
                    fcb       $01
                    fcb       $A9
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
                    rts                 ; return the completed result to the caller
HandleExistingFile  cmpb      #E$CEF    ; only "creating existing file" is recoverable
                    lbne      StoreRuntimeError ; select store runtime error when the requested case does not match
                    lda       $05,s     ; recover the original compiler mode
                    bita      #OpenModeDirectory ; test the directory-access flag
                    lbne      StoreRuntimeError ; an existing directory is not a truncatable file
                    anda      #7        ; reduce it to OS-9 access-mode bits
                    ldx       $02,s     ; reopen the existing pathname
                    os9       I$Open    ; preserve the flags or register state required by the following operation
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
                    pshs      u,a       ; preserve workspace and returned path
                    ldx       #0        ; request a new file size of zero
                    leau      ,x        ; supply the low size word
                    ldb       #SS.Size  ; truncate through the size status call
                    os9       I$SetStt  ; preserve the flags or register state required by the following operation
                    puls      u,a       ; recover workspace and path number
                    bcc       ReturnPathNumber ; return the truncated stream
                    pshs      b         ; preserve the truncation error
                    os9       I$Close   ; do not leak the reopened path
                    puls      b         ; restore the error for translation
                    lbra      StoreRuntimeError ; continue at store runtime error
                    fcb       $AE
                    fcb       $62
                    fcb       $10
                    fcb       $3F
                    fcb       $87
                    fcb       $16
                    fcb       $01
                    fcb       $5B
                    fcb       $A6
                    fcb       $63
                    fcb       $10
                    fcb       $3F
                    fcb       $82
                    fcb       $10
                    fcb       $25
                    fcb       $01
                    fcb       $49
                    fcb       $1F
                    fcb       $89
                    fcc       "O9"
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
                    bcc       ReadBytesSucceeded ; continue read bytes succeeded while the range test permits it
                    cmpb      #E$EOF    ; expose EOF as a zero-byte read
                    bne       ReadBytesFailed ; repeat read bytes failed until the terminating condition is met
                    clra                ; select standard input
                    clrb                ; return zero rather than -1 for EOF
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
ReadBytesFailed     puls      y,x       ; discard saved length and restore Y
                    lbra      StoreRuntimeError ; save B and return -1
ReadBytesSucceeded  tfr       y,d       ; return the actual byte count
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
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
                    puls      pc,y      ; preserve the flags or register state required by the following operation
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
                    bne       SeekFromCurrentOrEnd ; select seek from current or end when the requested case does not match
                    ldu       #0        ; absolute seeks start from zero
                    ldx       #0        ; establish the finish write loop or field bound (0)
                    bra       ApplySeekOffset ; continue at apply seek offset
SeekFromCurrentOrEnd
                    cmpd      #1        ; one requests the current position
                    beq       SeekFromCurrent ; select seek from current when the requested case matches
                    cmpd      #2        ; two requests end-of-file
                    beq       SeekFromEnd ; select seek from end when the requested case matches
                    ldb       #E$Seek   ; original runtime reports an unsupported origin as seek error
SeekFailed          clra                ; widen the OS-9 error to a compiler word
                    std       >RuntimeErrorCode,y ; publish the failure status
                    ldd       #-1       ; represent failure in both result words
                    leax      >RuntimeSeekHigh,y ; select the shared 32-bit result
                    std       ,x        ; preserve the flags or register state required by the following operation
                    std       $02,x     ; preserve the flags or register state required by the following operation
                    puls      pc,u      ; preserve the flags or register state required by the following operation
SeekFromEnd         lda       $05,s     ; select the path number
                    ldb       #SS.Size  ; obtain its 32-bit file length in X:U
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
                    bra       ApplySeekOffset ; continue at apply seek offset
SeekFromCurrent     lda       $05,s     ; select the path number
                    ldb       #SS.Pos   ; obtain its current 32-bit position
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
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
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
                    leax      >RuntimeSeekHigh,y ; return a pointer to the 32-bit result
                    puls      pc,u      ; preserve the flags or register state required by the following operation
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $9F
                    fcb       $34
                    fcb       $06
                    fcb       $EC
                    fcb       $64
                    fcb       $10
                    fcb       $A3
                    fcb       $A9
                    fcb       $03
                    fcb       $A9
                    fcb       $25
                    fcb       $25
                    fcb       $E3
                    fcb       $A9
                    fcb       $01
                    fcb       $9F
                    fcb       $34
                    fcb       $20
                    fcb       $A3
                    fcb       $E4
                    fcb       $10
                    fcb       $3F
                    fcb       $07
                    fcb       $1F
                    fcc       " 5 $"
                    fcb       $06
                    fcb       $CC
                    fcb       $FF
                    fcb       $FF
                    fcc       "2b9"
                    fcb       $ED
                    fcb       $A9
                    fcb       $01
                    fcb       $9F
                    fcb       $E3
                    fcb       $A9
                    fcb       $03
                    fcb       $A9
                    fcb       $A3
                    fcb       $E4
                    fcb       $ED
                    fcb       $A9
                    fcb       $03
                    fcb       $A9
                    fcb       $32
                    fcb       $62
                    fcb       $EC
                    fcb       $A9
                    fcb       $03
                    fcb       $A9
                    fcb       $34
                    fcb       $06
                    fcb       $A3
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $03
                    fcb       $A9
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $9F
                    fcb       $A3
                    fcb       $E1
                    fcb       $34
                    fcb       $06
                    fcb       $4F
                    fcb       $AE
                    fcb       $E4
                    fcb       $A7
                    fcb       $80
                    fcb       $AC
                    fcb       $A9
                    fcb       $01
                    fcb       $9F
                    fcb       $25
                    fcb       $F8
                    fcb       $35
                    fcb       $86
AllocateHeapBytes
stk_heap_return     equ       0         ; caller return address
stk_heap_size       equ       2         ; requested zero-filled byte count
                    ldd       $02,s     ; recover the requested allocation size
                    addd      >RuntimeHeapEnd,y ; calculate the proposed new heap boundary
                    bcs       RejectHeapAllocation ; reject 16-bit address wraparound
                    cmpd      >RuntimeStackLowWater,y ; preserve separation from the growing stack
                    bcc       RejectHeapAllocation ; reject collision or overlap
                    pshs      d         ; retain the proposed heap boundary
                    ldx       >RuntimeHeapEnd,y ; begin clearing at the old boundary
                    clra                ; use zero as the allocator's initialization byte
ClearAllocatedBytes cmpx      ,s        ; stop upon reaching the proposed boundary
                    bcc       CommitHeapAllocation ; select commit heap allocation when carry remains clear
                    sta       ,x+       ; clear one newly allocated byte
                    bra       ClearAllocatedBytes ; continue at clear allocated bytes
CommitHeapAllocation
                    ldd       >RuntimeHeapEnd,y ; return the old boundary as the allocation base
                    puls      x         ; recover the proposed new boundary
                    stx       >RuntimeHeapEnd,y ; commit the allocation atomically
                    rts                 ; return the completed result to the caller
RejectHeapAllocation
                    ldd       #-1       ; report overflow or heap/stack collision
                    rts                 ; return the completed result to the caller
StoreRuntimeError   clra                ; widen OS-9's error byte in B
                    std       >RuntimeErrorCode,y ; expose it through the compiler runtime
                    ldd       #-1       ; return the conventional failure value
                    rts                 ; return the completed result to the caller
ReturnZeroOnSuccess
                    bcs       StoreRuntimeError ; translate a failed OS-9 service
                    clra                ; select standard input
                    clrb                ; return zero for a successful void-style wrapper
                    rts                 ; return the completed result to the caller
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
                    fcb       $01
                    fcb       $00
                    fcb       $01
                    fcb       $5E
                    fcb       $27
                    fcb       $10
                    fcb       $03
                    fcb       $E8
                    fcb       $00
                    fcb       $64
                    fcb       $00
                    fcb       $0A
                    fcb       $00
                    fcb       $09
                    fcb       $6C
                    fcb       $78
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $02
                    fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $42
                    fcb       $00
                    fcb       $02
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $11
                    fcb       $11
                    fcb       $01
                    fcb       $11
                    fcb       $11
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcb       $01
                    fcc       "0               HHHHHHHHHH       BBBBBB"
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcb       $02
                    fcc       "      DDDDDD"
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcb       $04
                    fcc       "    "
                    fcb       $01
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $09
                    fcc       "New_user"
                    fcb       $00

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
