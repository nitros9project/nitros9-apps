**********************************************************************
* Quikterm - OS-9 Level 2 BBS command
*
* Syntax: Quikterm [port]
* Purpose: Run a simple terminal emulator with XMODEM transfer support.
* Reads: local keyboard input, the selected communications port, and files
* chosen for transmission.
* Writes: terminal output, the communications port, and received files.
* Cooperates: Alt-T opens its transfer menu; xmode configures the port while
* the embedded XMODEM-family engines perform file transfer.
* Failure: reports port and file errors, removes incomplete receive files,
* restores path options, and returns the saved OS-9 status.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded terminal relay, transfer state machines, and compiler runtime.
**********************************************************************

                    nam       Quikterm
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

StreamCursor        rmb       2         ; current byte pointer within the assigned buffer
StreamBufferStart   rmb       2         ; first byte of the assigned stream buffer
StreamBufferEnd     rmb       2         ; byte just beyond valid or writable buffered data
StreamFlags         rmb       2         ; access, buffering, EOF, error, and orientation bits
StreamPath          rmb       2         ; underlying OS-9 path number
StreamPushbackByte  rmb       1         ; descriptor-local ungetc or fallback byte
StreamBufferSize    rmb       2         ; configured buffer capacity
RuntimeDescriptorTableAndGlobals rmb       343       ; remaining descriptors and runtime global words
StartupArgv0Pointer rmb       2         ; program-name pointer installed as argv[0]
StartupArgvVectorTail rmb       58        ; remaining argument-vector pointer slots
StartupArgcHigh     rmb       1         ; high byte adjoining compiler argument state
StartupArgumentState rmb       3         ; argc low byte and scanner bookkeeping
StartupParameterLength rmb       2         ; original OS-9 parameter length
RuntimeWorkspaceTail rmb       1250      ; compiler globals and terminal/XMODEM application state
StreamDescriptorSize equ       RuntimeDescriptorTableAndGlobals ; thirteen-byte descriptor stride
size                equ       .

name                fcs       /Quikterm/
                    fcb       $01
* Expand the compiler's packed globals, clear BSS, relocate pointers, and turn
* the OS-9 parameter line into the argc/argv representation expected by C.
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
                    leau      ,x        ; select
                    leax      >$0308,x  ; select $0308
                    pshs      x         ; retain the workspace-clear boundary
                    leay      >RuntimeInitializerImage,pc ; address runtime initializer image
                    ldx       ,y++      ; read the next initialized block length
                    beq       InitializeSecondDataBlock ; zero result: initialize second data block
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    ldu       $02,s     ; recover $02
InitializeSecondDataBlock leau      >StreamCursor+1,u ; select stream cursor+1
                    ldx       ,y++      ; read the next initialized block length
                    beq       ClearRemainingWorkspace ; zero result: clear remaining workspace
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    clra                ; prepare a zero byte and a 256-byte loop count
ClearRemainingWorkspace cmpu      ,s        ; stop clearing when the workspace end is reached
                    beq       ApplyCodeRelocations ; begin relocation after all remaining BSS is zeroed
                    sta       ,u+       ; install it in the process workspace
                    bra       ClearRemainingWorkspace ; resume clear remaining workspace
ApplyCodeRelocations ldu       $02,s     ; recover $02
                    ldd       ,y++      ; recover
                    beq       ApplyDataRelocations ; skip an empty code-reference relocation table
                    leax      >0,pc     ; use the module base as the relocation delta
                    lbsr      ApplyRelocationTable ; relocate the compiler-generated pointer table
ApplyDataRelocations ldd       ,y++      ; recover
                    beq       ParseCommandLine ; begin argument parsing when no data relocations remain
                    leax      StreamCursor,u ; address stream cursor
                    lbsr      ApplyRelocationTable ; relocate the compiler-generated pointer table
ParseCommandLine    leas      $04,s     ; release $04,s bytes of stack state
                    puls      x         ; recover the OS-9 parameter length
                    stx       >StartupParameterLength,u ; preserve startup parameter length
                    sty       >StartupArgv0Pointer,u ; retain startup argv0 pointer
                    ldd       #1        ; initialize startup argc high to 1
                    std       >StartupArgcHigh,u ; preserve startup argc high
                    leay      >StartupArgvVectorTail,u ; address startup argv vector tail
                    leax      ,s        ; point at OS-9's CR-terminated parameter text
                    lda       ,x+       ; prime the argument scanner with its first byte
ParseNextArgument   ldb       >StartupArgumentState,u ; recover startup argument state
                    cmpb      #29       ; reserve the thirtieth argv slot for termination
                    beq       InvokeQuikterm ; zero result: invoke quikterm
SkipArgumentDelimiters cmpa      #13       ; recognize the carriage-return terminator
                    beq       InvokeQuikterm ; zero result: invoke quikterm
                    cmpa      #32       ; treat spaces as argument separators
                    beq       ConsumeArgumentDelimiter ; skip a separating space
                    cmpa      #44       ; also accept commas as argument separators
                    bne       CheckQuotedArgument ; classify the first nonseparator byte
ConsumeArgumentDelimiter lda       ,x+       ; consume the next byte while consume argument delimiter
                    bra       SkipArgumentDelimiters ; discard consecutive spaces and commas
CheckQuotedArgument cmpa      #34       ; recognize a double-quoted argument
                    beq       RecordQuotedArgument ; begin a double-quoted argument
                    cmpa      #39       ; also recognize a single-quoted argument
                    bne       RecordBareArgument ; use ordinary delimiter rules otherwise
RecordQuotedArgument stx       ,y++      ; record the first byte inside the quotes as argv
                    inc       >StartupArgumentState,u ; increment the value at >StartupArgumentState,u
                    pshs      a         ; retain the opening quote as the required closer
ScanQuotedArgument  lda       ,x+       ; consume the next quoted byte
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       TerminateQuotedArgument ; terminate an unmatched quote at end-of-line
                    cmpa      ,s        ; test for the matching quote character
                    bne       ScanQuotedArgument ; keep delimiters literal while inside quotes
TerminateQuotedArgument puls      b         ; restore b
                    clr       -$01,x    ; replace the closing delimiter with a C-string NUL
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       InvokeQuikterm ; zero result: invoke quikterm
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ParseNextArgument ; look for another argument
RecordBareArgument  leax      -$01,x    ; rewind to include the first unquoted byte
                    stx       ,y++      ; append the argument pointer to argv
                    leax      $01,x     ; resume scanning after its first byte
                    inc       >StartupArgumentState,u ; increment the value at >StartupArgumentState,u
ScanBareArgument    cmpa      #13       ; test the current unquoted byte for termination
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    cmpa      #32       ; treat spaces as argument separators
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    cmpa      #44       ; also accept commas as argument separators
                    beq       TerminateBareArgument ; finish on CR, space, or comma
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ScanBareArgument ; consume another ordinary argument byte
TerminateBareArgument clr       -$01,x    ; initialize -$01
                    bra       ParseNextArgument ; look for another argument
InvokeQuikterm      leax      >StartupArgv0Pointer,u ; address startup argv0 pointer
                    pshs      x         ; pass argv through the compiler calling convention
                    ldd       >StartupArgcHigh,u ; recover startup argc high
                    pshs      d         ; pass argc beside argv
                    leay      StreamCursor,u ; address stream cursor
                    bsr       InitializeRuntimeBounds ; establish the compiler heap and stack limits
                    lbsr      QuiktermMain ; quikterm main
                    clr       ,-s       ; push a zero process exit status
                    clr       ,-s       ; push a zero process exit status
                    lbsr      ExitProcess ; flush runtime state and terminate successfully
InitializeRuntimeBounds leax      >$0308,y  ; select $0308
                    stx       >$01AE,y  ; retain $01 ae
                    sts       >$01A2,y  ; record the initial C stack boundary
                    sts       >$01B0,y  ; record the current C stack low-water mark
                    ldd       #-126     ; supply failure or frame value -126 to the following operation
CheckStackSpace     leax      d,s       ; project the requested stack growth below the current S
                    cmpx      >$01B0,y  ; test against $01 b0
                    bcc       StackSpaceAvailable ; select stack space available when carry remains clear
                    cmpx      >$01AE,y  ; test against $01 ae
                    bcs       AbortStackOverflow ; carry reports failure: abort stack overflow
                    stx       >$01B0,y  ; retain $01 b0
StackSpaceAvailable rts                 ; return with the requested stack range validated
StackOverflowMessage fcc       "**** STACK OVERFLOW ****"
                    fcb       $0D
AbortStackOverflow  leax      <StackOverflowMessage,pc ; select text 001
                    ldb       #207      ; supply 207 as the control, count, or argument value required here
                    pshs      b         ; pass that status to the nonreturning exit wrapper
                    lda       #2        ; write the diagnostic on standard error
                    ldy       #100      ; bound output beyond the fixed message length
                    os9       I$WritLn  ; display the fatal diagnostic through its carriage return
                    clr       ,-s       ; widen the one-byte status to a compiler word
                    lbsr      ExitWithStackStatus ; return the saved status through the runtime exit path
                    ldd       >$01A2,y  ; recover $01 a2
                    subd      >$01B0,y  ; subtract from d using >$01B0,y
                    rts                 ; return to the diagnostic caller
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B0
                    fcb       $A3
                    fcb       $A9
                    fcb       $01
                    fcb       $AE
                    fcb       $39
ApplyRelocationTable pshs      x         ; preserve the selected relocation delta
                    leax      d,y       ; locate the end of the packed word-offset table
                    leax      d,x       ; account for the table's own displacement encoding
                    pshs      x         ; retain the computed table end
RelocateNextWord    ldd       ,y++      ; recover
                    leax      d,u       ; locate the word requiring relocation
                    ldd       ,x        ; recover
                    addd      $02,s     ; add the selected module or data base
                    std       ,x        ; install the runtime absolute address
                    cmpy      ,s        ; test for the end of the relocation table
                    bne       RelocateNextWord ; relocate every listed word
                    leas      $04,s     ; release $04,s bytes of stack state
                    rts                 ; return to the startup dispatcher
* Encoded helper retained byte-for-byte: configure the selected terminal paths
* and install the event callback before entering the decoded application body.
EncodedTerminalSetupEntry fcb       $34
                    fcb       $40
                    fcb       $CC
                    fcb       $FF
                    fcb       $B0
                    fcb       $17
                    fcb       $FF
                    fcb       $8B
                    fcb       $32
                    fcb       $7A
                    fcb       $AE
                    fcb       $6A
                    fcb       $16
                    fcb       $00
                    fcb       $94
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B6
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $1F
                    fcb       $9D
                    fcb       $32
                    fcb       $62
                    fcb       $ED
                    fcb       $64
                    fcb       $34
                    fcb       $06
                    fcb       $30
                    fcb       $A9
                    fcb       $01
                    fcb       $DA
                    fcb       $34
                    fcb       $10
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B6
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $1D
                    fcb       $D5
                    fcb       $32
                    fcb       $66
                    fcb       $EC
                    fcb       $64
                    fcb       $34
                    fcb       $06
                    fcb       $30
                    fcb       $A9
                    fcb       $01
                    fcb       $DA
                    fcb       $34
                    fcb       $10
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B4
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $1D
                    fcb       $F1
                    fcb       $32
                    fcb       $66
                    fcb       $16
                    fcb       $00
                    fcb       $66
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B6
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $1D
                    fcc       "E2b0"
                    fcb       $A9
                    fcb       $01
                    fcb       $B8
                    fcb       $34
                    fcb       $10
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B4
                    fcb       $34
                    fcb       $06
                    fcc       "O_4"
                    fcb       $06
                    fcb       $17
                    fcb       $1C
                    fcb       $B2
                    fcb       $32
                    fcb       $66
                    fcb       $CC
                    fcb       $00
                    fcb       $01
                    fcb       $E7
                    fcb       $A9
                    fcb       $01
                    fcb       $BC
                    fcb       $CC
                    fcb       $00
                    fcb       $03
                    fcb       $E7
                    fcb       $A9
                    fcb       $01
                    fcb       $C8
                    fcb       $CC
                    fcb       $00
                    fcb       $05
                    fcb       $E7
                    fcb       $A9
                    fcb       $01
                    fcb       $C9
                    fcb       $CC
                    fcb       $00
                    fcb       $0D
                    fcb       $E7
                    fcb       $A9
                    fcb       $01
                    fcb       $C3
                    fcb       $30
                    fcb       $A9
                    fcb       $01
                    fcb       $B8
                    fcb       $34
                    fcb       $10
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $B4
                    fcb       $34
                    fcb       $06
                    fcc       "O_4"
                    fcb       $06
                    fcb       $17
                    fcb       $1C
                    fcb       $BC
                    fcb       $32
                    fcb       $66
                    fcb       $EC
                    fcb       $6A
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $1F
                    fcb       $0A
                    fcc       "2b "
                    fcb       $0A
                    fcb       $8C
                    fcb       $00
                    fcb       $0A
                    fcb       $10
                    fcb       $27
                    fcb       $FF
                    fcb       $65
                    fcb       $16
                    fcb       $FF
                    fcb       $9A
                    fcc       "2f5"
                    fcb       $C0
* Open the requested communications path (default /t2), save both SCF option
* packets, put the console and port into raw relay mode, show the banner, and
* shuttle bytes until Alt-X exits or Alt-T invokes the transfer menu.
QuiktermMain        pshs      u         ; preserve the caller frame while Quikterm runs
                    ldd       #-75      ; supply failure or frame value -75 to the following operation
                    lbsr      CheckStackSpace ; verify that the application frame fits below the heap
                    leas      -$01,s    ; release -$01,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >$01B4,y  ; retain $01 b4
                    ldd       $05,s     ; recover $05
                    cmpd      #1        ; test against #1
                    bne       UseSuppliedPort ; nonzero result: use supplied port
                    ldd       #3        ; supply 3 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >DefaultPortPath,pc ; select text 002
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      OpenPortPath ; open the selected communications device
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       >$01B6,y  ; retain $01 b6
                    cmpd      #-1       ; test against #-1
                    bne       ConfigureTerminalPaths ; nonzero result: configure terminal paths
                    ldd       >$01B2,y  ; recover $01 b2
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >DefaultPortOpenError,pc ; select text 003
                    pshs      x         ; preserve x across the operation
                    lbsr      ExitWithFormattedError ; format the diagnostic and terminate the session
                    leas      $04,s     ; release $04,s bytes of stack state
                    bra       ConfigureTerminalPaths ; resume configure terminal paths
UseSuppliedPort     ldd       #3        ; supply 3 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    ldx       $09,s     ; recover $09
                    ldd       $02,x     ; recover $02
                    pshs      d         ; preserve d across the operation
                    lbsr      OpenPortPath ; open the selected communications device
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       >$01B6,y  ; retain $01 b6
                    cmpd      #-1       ; test against #-1
                    bne       ConfigureTerminalPaths ; nonzero result: configure terminal paths
                    ldx       $07,s     ; recover $07
                    ldd       $02,x     ; recover $02
                    pshs      d         ; preserve d across the operation
                    leax      >PortOpenErrorFormat,pc ; select text 004
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >$01B2,y  ; recover $01 b2
                    pshs      d         ; preserve d across the operation
                    lbsr      ExitProcess ; leave through the compiler runtime cleanup path
                    leas      $02,s     ; release $02,s bytes of stack state
ConfigureTerminalPaths leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BC,y  ; retain $01 bc
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C9,y  ; retain $01 c9
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C8,y  ; retain $01 c8
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01B9,y  ; retain $01 b9
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BA,y  ; retain $01 ba
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BB,y  ; retain $01 bb
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BC,y  ; retain $01 bc
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BD,y  ; retain $01 bd
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BE,y  ; retain $01 be
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BF,y  ; retain $01 bf
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C0,y  ; retain $01 c0
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C1,y  ; retain $01 c1
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C2,y  ; retain $01 c2
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C3,y  ; retain $01 c3
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C4,y  ; retain $01 c4
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C5,y  ; retain $01 c5
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C6,y  ; retain $01 c6
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C7,y  ; retain $01 c7
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C8,y  ; retain $01 c8
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C9,y  ; retain $01 c9
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01CA,y  ; retain $01 ca
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01CB,y  ; retain $01 cb
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01CC,y  ; retain $01 cc
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >EncodedTerminalSetupEntry,pc ; select encoded terminal setup entry
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      InstallTerminalSignalHandler ; install the terminal cleanup signal handler
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      ClearTerminalScreen ; restore a clean terminal canvas
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      InitializeTerminalDisplay ; apply the terminal emulator display settings
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BannerTitle,pc ; select text 005
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BannerAuthor,pc ; select text 006
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BannerRelease,pc ; select text 007
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      PauseForBanner ; leave the startup banner visible briefly
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BannerSpacing,pc ; address banner spacing
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalHelpLine,pc ; select text 008
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BannerRule,pc ; select text 009
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    lbra      TerminalRelayLoop ; resume terminal relay loop
RelayRemoteInput    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; preserve d across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPortReadTimeout ; bound the next communications-path read
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortCharacter ; poll one character from the communications path
                    leas      $02,s     ; release $02,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    beq       TerminalExitRequested ; zero result: terminal exit requested
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; address the local confirmation byte
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    bsr       HandleTerminalKey ; dispatch the local terminal command key
                    std       ,s++      ; store d in the current stack frame at ,s++
                    beq       ContinueTerminalRelay ; zero result: continue terminal relay
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $02,s     ; select $02
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
ContinueTerminalRelay bra       RelayRemoteInput ; resume relay remote input
TerminalExitRequested ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    lbsr      PauseOneTick ; yield briefly before polling the port again
TerminalRelayLoop   leas      $02,s     ; release $02,s bytes of stack state
                    lbra      RelayRemoteInput ; resume relay remote input
HandleTerminalKey   pshs      u         ; preserve u across the operation
                    ldd       #-74      ; supply failure or frame value -74 to the following operation
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    ldb       $05,s     ; recover $05
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      ClassifyTerminalKey ; resume classify terminal key
ExitTerminal        ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bc to 1
                    stb       >$01BC,y  ; retain $01 bc
                    ldd       #3        ; initialize $01 c8 to 3
                    stb       >$01C8,y  ; retain $01 c8
                    ldd       #5        ; initialize $01 c9 to 5
                    stb       >$01C9,y  ; retain $01 c9
                    ldd       #13       ; recognize the carriage-return terminator
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      ClearTerminalScreen ; restore a clean terminal canvas
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalExitMessage,pc ; select text 010
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >ExitMessageSpacing,pc ; address exit message spacing
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AddressSpacing,pc ; address address spacing
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AddressLineOne,pc ; select text 011
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AddressLineTwo,pc ; select text 012
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TransferSpacing,pc ; address transfer spacing
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      ExitProcess ; leave through the compiler runtime cleanup path
                    leas      $02,s     ; release $02,s bytes of stack state
                    bra       ReturnTerminalKeyStatus ; resume return terminal key status
OpenTransferMenu    bsr       TransferMenu ; open the interactive transfer menu
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    puls      pc,u      ; restore pc,u and return to the caller
ReturnUnhandledKey  ldd       #1        ; supply 1 as the control, count, or argument value required here
                    puls      pc,u      ; restore pc,u and return to the caller
ClassifyTerminalKey cmpx      #-8       ; test against #-8
                    lbeq      ExitTerminal ; zero result: exit terminal
                    cmpx      #-12      ; test against #-12
                    beq       OpenTransferMenu ; zero result: open transfer menu
                    bra       ReturnUnhandledKey ; resume return unhandled key
ReturnTerminalKeyStatus puls      pc,u      ; restore pc,u and return to the caller
* Temporarily restore terminal settings, ask for receive/send direction, run
* the chosen XMODEM engine, then reinstall raw relay settings on the port.
TransferMenu        pshs      u         ; preserve the terminal application's frame
                    ldd       #-75      ; supply failure or frame value -75 to the following operation
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      -$01,s    ; release -$01,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      ClearTerminalScreen ; restore a clean terminal canvas
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TransferDirectionPrompt,pc ; select text 013
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$0020,y  ; select $0020
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      FlushStream ; flush pending terminal output before reading one byte
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; select $02
                    pshs      x         ; preserve x across the operation
                    clra                ; form standard-input path zero for the raw read
                    clrb                ; form standard-input path zero for the raw read
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >TransferPromptReturn,pc ; address transfer prompt return
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       ,s        ; recover the confirmation character
                    clra                ; form standard-input path zero for the raw read
                    andb      #223      ; mask b using #223
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #82       ; recognize 82 as a meaningful value in this parser state
                    bne       RestorePortAfterReceive ; nonzero result: restore port after receive
                    lbsr      ReceiveFile ; run the upload receive state machine
RestorePortAfterReceive leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #4371     ; initialize $01 d0 to 4371
                    std       >$01D0,y  ; retain $01 d0
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover
                    cmpb      #83       ; recognize 83 as a meaningful value in this parser state
                    bne       TransferMenuDone ; nonzero result: transfer menu done
                    bsr       SendFile  ; run the download transmit state machine
TransferMenuDone    leas      $01,s     ; release $01,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
* Send a file with 128-byte checksum XMODEM blocks.  Each block is retried until
* ACK, cancelled on Alt-Q/CAN, and followed by EOT after the final short block.
SendFile            pshs      u         ; preserve the transfer-menu frame
                    ldd       #-283     ; initialize  to -283
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      >$FF31,s  ; release >$FF31,s bytes of stack state
                    ldd       #1        ; initialize  to 1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      PrepareTransferPort ; switch the communications path into transfer mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bc to 1
                    stb       >$01BC,y  ; retain $01 bc
                    ldd       #13       ; recognize the carriage-return terminator
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >SendFilenamePrompt,pc ; select text 014
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$0013,y  ; select $0013
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       #200      ; supply 200 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $0B,s     ; select $0 b
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      OpenTransferFile ; open the selected transfer source
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BC,y  ; retain $01 bc
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $09,s     ; select $09
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      OpenPortPath ; open the selected communications device
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       $04,s     ; store d in the current stack frame at $04,s
                    cmpd      #-1       ; test against #-1
                    bne       SendFileOpened ; nonzero result: send file opened
                    ldd       >$01B2,y  ; recover $01 b2
                    pshs      d         ; preserve d across the operation
                    leax      >SendOpenErrorFormat,pc ; select text 015
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnTransferStatus ; resume return transfer status
SendFileOpened      leax      >SendingStatus,pc ; select text 016
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TransferRule,pc ; select text 017
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 d8 to 1
                    stb       >$01D8,y  ; retain $01 d8
                    ldd       #1        ; initialize $01 d9 to 1
                    stb       >$01D9,y  ; retain $01 d9
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    stb       >$01DA,y  ; retain $01 da
                    ldd       #128      ; supply 128 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$01DB,y  ; select $01 db
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $08,s     ; recover $08
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01DB,y  ; select $01 db
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ComputeBlockChecksum ; calculate the transfer block checksum
                    leas      $02,s     ; release $02,s bytes of stack state
                    stb       >$025B,y  ; retain $025 b
                    ldd       ,s        ; recover
                    pshs      d         ; preserve d across the operation
                    leax      >SendStatusReturn,pc ; address send status return
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    leax      >$0020,y  ; select $0020
                    pshs      x         ; preserve x across the operation
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      SendNextBlock ; resume send next block
RetrySendHandshake  clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      PollAbortKey ; allow the operator to cancel the active transfer
                    leas      $02,s     ; release $02,s bytes of stack state
                    cmpd      #-15      ; test against #-15
                    bne       SendNextBlock ; nonzero result: send next block
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bd to 1
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >SendAbortMessage,pc ; select text 018
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0005,y  ; select $0005
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      ReturnTransferStatus ; resume return transfer status
SendNextBlock       leax      $06,s     ; select $06
                    pshs      x         ; preserve x across the operation
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadBlockWithTimeout ; collect one transfer block within its timeout
                    leas      $08,s     ; release $08,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    lbeq      RetrySendHandshake ; zero result: retry send handshake
                    ldb       $06,s     ; recover $06
                    cmpb      #21       ; recognize 21 as a meaningful value in this parser state
                    bne       WaitForBlockResponse ; nonzero result: wait for block response
                    ldd       #132      ; supply 132 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$01D8,y  ; select $01 d8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
WaitForBlockResponse ldb       $06,s     ; recover $06
                    cmpb      #24       ; recognize 24 as a meaningful value in this parser state
                    bne       RetryCurrentBlock ; nonzero result: retry current block
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bd to 1
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >ReceiveAbortMessage,pc ; select text 019
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $04,s     ; recover $04
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    lbra      FinishTransferOperation ; resume finish transfer operation
RetryCurrentBlock   ldb       $06,s     ; recover $06
                    cmpb      #6        ; recognize 6 as a meaningful value in this parser state
                    lbne      SendNextBlock ; nonzero result: send next block
                    ldb       >$01D9,y  ; recover $01 d9
                    addd      #1        ; add to d using #1
                    stb       >$01D9,y  ; retain $01 d9
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    stb       >$01DA,y  ; retain $01 da
                    ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       SendBlockBytes ; resume send block bytes
SendNextBlockByte   ldd       $02,s     ; recover $02
                    leax      >$01DB,y  ; select $01 db
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       $02,s     ; recover $02
                    addd      #1        ; add to d using #1
SendBlockBytes      std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $02,s     ; recover $02
                    cmpd      #127      ; test against #127
                    ble       SendNextBlockByte ; continue at SendNextBlockByte when the signed value is at or below the limit
                    ldd       #128      ; supply 128 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$01DB,y  ; select $01 db
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      SendEndOfFile ; nonzero result: send end of file
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0003,y  ; select $0003
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bd to 1
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >TransferCompleteMessage,pc ; select text 020
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $04,s     ; recover $04
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      CompleteReceive ; resume complete receive
SendEndOfFile       leax      >$01DB,y  ; select $01 db
                    pshs      x         ; preserve x across the operation
                    lbsr      ComputeBlockChecksum ; calculate the transfer block checksum
                    leas      $02,s     ; release $02,s bytes of stack state
                    stb       >$025B,y  ; retain $025 b
                    ldd       ,s        ; recover
                    pshs      d         ; preserve d across the operation
                    leax      >TransferCompleteReturn,pc ; address transfer complete return
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    leax      >$0020,y  ; select $0020
                    pshs      x         ; preserve x across the operation
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #132      ; supply 132 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$01D8,y  ; select $01 d8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      SendNextBlock ; resume send next block
* Receive checksum XMODEM into a newly created file.  Validate the block number,
* one's-complement block byte, payload checksum, retry budget, and cancellation.
ReceiveFile         pshs      u         ; preserve the transfer-menu frame
                    ldd       #-283     ; initialize $06 to -283
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      >$FF31,s  ; release >$FF31,s bytes of stack state
                    ldd       #1        ; initialize $06 to 1
                    stb       $06,s     ; store b in the current stack frame at $06,s
                    ldd       #1        ; initialize $04 to 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      PrepareTransferPort ; switch the communications path into transfer mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >$01D0,y  ; retain $01 d0
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bc to 1
                    stb       >$01BC,y  ; retain $01 bc
                    ldd       #13       ; recognize the carriage-return terminator
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >ReceiveFilenamePrompt,pc ; select text 021
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$0013,y  ; select $0013
                    pshs      x         ; preserve x across the operation
                    ldd       #200      ; supply 200 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $0B,s     ; select $0 b
                    pshs      x         ; preserve x across the operation
                    lbsr      OpenTransferFile ; open the selected transfer source
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BC,y  ; retain $01 bc
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $09,s     ; select $09
                    pshs      x         ; preserve x across the operation
                    lbsr      CheckPathExists ; distinguish an existing pathname from a new destination
                    leas      $04,s     ; release $04,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    beq       ReceiveFileMayExist ; zero result: receive file may exist
                    leax      >FileExistsMessage,pc ; select text 022
                    lbra      PrintReceiveError ; resume print receive error
ReceiveFileMayExist ldd       #2        ; supply 2 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $09,s     ; select $09
                    pshs      x         ; preserve x across the operation
                    lbsr      CreateReceiveFile ; create the upload destination before receiving data
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; test against #-1
                    bne       ReceiveFileReady ; nonzero result: receive file ready
                    ldd       >$01B2,y  ; recover $01 b2
                    pshs      d         ; preserve d across the operation
                    leax      >ReceiveOpenErrorFormat,pc ; select text 023
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnTransferStatus ; resume return transfer status
ReceiveFileReady    leax      >ReceivingStatus,pc ; select text 024
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >ReceiveRule,pc ; select text 025
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0004,y  ; select $0004
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      ContinueReceiveLoop ; resume continue receive loop
ReceiveBlockLoop    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      PollAbortKey ; allow the operator to cancel the active transfer
                    leas      $02,s     ; release $02,s bytes of stack state
                    cmpd      #-15      ; test against #-15
                    bne       AwaitSenderStart ; nonzero result: await sender start
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0005,y  ; select $0005
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bd to 1
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >ReceiveStatusReturn,pc ; address receive status return
PrintReceiveError   pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    lbra      FinishTransferOperation ; resume finish transfer operation
AwaitSenderStart    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01D8,y  ; retain $01 d8
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; recover $04
                    pshs      d         ; preserve d across the operation
                    leax      >ReceivePromptReturn,pc ; address receive prompt return
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    leax      >$0020,y  ; select $0020
                    pshs      x         ; preserve x across the operation
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      ValidateIncomingBlock ; resume validate incoming block
ReadNextIncomingBlock leax      >$01D8,y  ; select $01 d8
                    pshs      x         ; preserve x across the operation
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; preserve d across the operation
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadBlockWithTimeout ; collect one transfer block within its timeout
                    leas      $08,s     ; release $08,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    bne       CheckIncomingSequence ; nonzero result: check incoming sequence
                    leax      >ReceiveTimeoutMessage,pc ; select text 026
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0004,y  ; select $0004
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
CheckIncomingSequence ldb       >$01D8,y  ; recover $01 d8
                    cmpb      #4        ; recognize 4 as a meaningful value in this parser state
                    lbne      AcceptIncomingBlock ; nonzero result: accept incoming block
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0002,y  ; select $0002
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bd to 1
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >ReceiveSuccessMessage,pc ; select text 027
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
CompleteReceive     clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      ReturnReceiveStatus ; resume return receive status
AcceptIncomingBlock ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #10       ; test against #10
                    lble      ReceiveErrorLimitReached ; continue at ReceiveErrorLimitReached when the signed value is at or below the limit
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leax      >ReceiveErrorLimitMessage,pc ; select text 028
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0005,y  ; select $0005
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      $07,s     ; select $07
                    pshs      x         ; preserve x across the operation
                    lbsr      DeletePath ; remove the incomplete transfer destination
FinishTransferOperation leas      $02,s     ; release $02,s bytes of stack state
                    lbra      ReturnTransferStatus ; resume return transfer status
ReceiveErrorLimitReached ldb       >$01D8,y  ; recover $01 d8
                    cmpb      #24       ; recognize 24 as a meaningful value in this parser state
                    bne       ValidateIncomingBlock ; nonzero result: validate incoming block
                    leax      >ReceiveAbortStatus,pc ; select text 029
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      $07,s     ; select $07
                    pshs      x         ; preserve x across the operation
                    lbsr      DeletePath ; remove the incomplete transfer destination
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       >$01BD,y  ; retain $01 bd
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
ReturnTransferStatus ldd       #-1       ; supply failure or frame value -1 to the following operation
                    lbra      ReturnReceiveStatus ; resume return receive status
ValidateIncomingBlock ldb       >$01D8,y  ; recover $01 d8
                    cmpb      #1        ; recognize 1 as a meaningful value in this parser state
                    lbne      ReadNextIncomingBlock ; nonzero result: read next incoming block
                    leax      >$01D9,y  ; select $01 d9
                    pshs      x         ; preserve x across the operation
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    ldd       #131      ; supply 131 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadBlockWithTimeout ; collect one transfer block within its timeout
                    leas      $08,s     ; release $08,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    bne       CheckBlockComplement ; nonzero result: check block complement
                    ldd       >$01B2,y  ; recover $01 b2
                    pshs      d         ; preserve d across the operation
                    leax      >ReceiveReadErrorFormat,pc ; select text 030
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
ReportReceiveReadError ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0004,y  ; select $0004
                    lbra      FinalizeReceiveFile ; resume finalize receive file
CheckBlockComplement ldb       >$01D9,y  ; recover $01 d9
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    ldb       >$01DA,y  ; recover $01 da
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    cmpd      ,s++      ; test against
                    beq       CheckExpectedBlock ; zero result: check expected block
                    leax      >BlockComplementError,pc ; select text 031
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    bra       ReportReceiveReadError ; resume report receive read error
CheckExpectedBlock  ldb       >$01D9,y  ; recover $01 d9
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; test against
                    beq       VerifyIncomingChecksum ; zero result: verify incoming checksum
                    leax      >UnexpectedBlockMessage,pc ; select text 032
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      ReportReceiveReadError ; resume report receive read error
VerifyIncomingChecksum leax      >$01DB,y  ; select $01 db
                    pshs      x         ; preserve x across the operation
                    lbsr      ComputeBlockChecksum ; calculate the transfer block checksum
                    leas      $02,s     ; release $02,s bytes of stack state
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    ldb       >$025B,y  ; recover $025 b
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; test against
                    beq       WriteIncomingBlock ; zero result: write incoming block
                    ldb       >$025B,y  ; recover $025 b
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    leax      >$01DB,y  ; select $01 db
                    pshs      x         ; preserve x across the operation
                    lbsr      ComputeBlockChecksum ; calculate the transfer block checksum
                    leas      $02,s     ; release $02,s bytes of stack state
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    leax      >ChecksumErrorFormat,pc ; select text 033
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      ReportReceiveReadError ; resume report receive read error
WriteIncomingBlock  ldd       #128      ; supply 128 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$01DB,y  ; select $01 db
                    pshs      x         ; preserve x across the operation
                    ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       $06,s     ; recover $06
                    addd      #1        ; add to d using #1
                    stb       $06,s     ; store b in the current stack frame at $06,s
                    ldd       $04,s     ; recover $04
                    addd      #1        ; add to d using #1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      >$0002,y  ; select $0002
FinalizeReceiveFile pshs      x         ; preserve x across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      WriteBytes ; commit the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
ContinueReceiveLoop lbra      ReceiveBlockLoop ; receive the next protocol block after committing this one
ReturnReceiveStatus leas      >$00CF,s  ; release >$00CF,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ReadBlockWithTimeout pshs      u         ; preserve u across the operation
                    ldd       #-78      ; supply failure or frame value -78 to the following operation
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      -$04,s    ; release -$04,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       ReadTimedCharacter ; resume read timed character
ReadTimedCharacter  ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortCharacter ; poll one character from the communications path
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; test against #-1
                    bne       TimedReadResult ; nonzero result: timed read result
                    ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #60       ; test against #60
                    ble       DelayBeforeRetry ; continue at DelayBeforeRetry when the signed value is at or below the limit
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; recover $0 c
                    addd      #-1       ; add to d using #-1
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       RetryTimedRead ; continue at RetryTimedRead when the signed value is above the limit
                    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    bra       ReturnTimedRead ; resume return timed read
                    fcb       $20
                    fcb       $0A
DelayBeforeRetry    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    lbsr      PauseOneTick ; yield briefly before polling the port again
                    leas      $02,s     ; release $02,s bytes of stack state
RetryTimedRead      bra       ReadTimedCharacter ; resume read timed character
TimedReadResult     ldd       $02,s     ; recover $02
                    cmpd      $0A,s     ; test against $0 a
                    bge       ReadRequestedBytes ; signed comparison reached its upper case: read requested bytes
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    ldd       <$0010,s  ; recover $0010
                    pshs      d         ; preserve d across the operation
                    ldd       $0C,s     ; recover $0 c
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $0E,s     ; recover $0 e
                    addd      $02,s     ; add to d using $02,s
                    std       $0E,s     ; store d in the current stack frame at $0E,s
                    ldd       $0A,s     ; recover $0 a
                    subd      $02,s     ; subtract from d using $02,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    lbra      ReadTimedCharacter ; resume read timed character
ReadRequestedBytes  ldd       $0A,s     ; recover $0 a
                    pshs      d         ; preserve d across the operation
                    ldd       <$0010,s  ; recover $0010
                    pshs      d         ; preserve d across the operation
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; preserve d across the operation
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
ReturnTimedRead     leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ComputeBlockChecksum pshs      u         ; preserve u across the operation
                    ldd       #-69      ; supply failure or frame value -69 to the following operation
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      -$03,s    ; release -$03,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       ChecksumLoop ; resume checksum loop
AddChecksumByte     ldb       $02,s     ; recover $02
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    ldx       $09,s     ; recover $09
                    ldd       $02,s     ; recover $02
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
ChecksumLoop        std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; recover
                    cmpd      #127      ; test against #127
                    ble       AddChecksumByte ; continue at AddChecksumByte when the signed value is at or below the limit
                    ldb       $02,s     ; recover $02
                    leas      $03,s     ; release $03,s bytes of stack state
                    puls      pc,u      ; restore the caller frame and return
ExitWithFormattedError pshs      u         ; preserve the caller frame for fatal error reporting
                    ldd       #-74      ; supply failure or frame value -74 to the following operation
                    lbsr      CheckStackSpace ; verify that the application frame fits below the heap
                    ldd       >$01B6,y  ; recover $01 b6
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve the flags or register state required by the following operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; append adds a zero 32-bit offset
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize $01 bc to 1
                    stb       >$01BC,y  ; retain $01 bc
                    ldd       #3        ; initialize $01 c8 to 3
                    stb       >$01C8,y  ; retain $01 c8
                    ldd       #5        ; initialize $01 c9 to 5
                    stb       >$01C9,y  ; retain $01 c9
                    ldd       #13       ; recognize the carriage-return terminator
                    stb       >$01C3,y  ; retain $01 c3
                    leax      >$01B8,y  ; select $01 b8
                    pshs      x         ; preserve x across the operation
                    ldd       >$01B4,y  ; recover $01 b4
                    pshs      d         ; preserve d across the operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; preserve d across the operation
                    lbsr      ClearTerminalScreen ; restore a clean terminal canvas
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $04,s     ; recover $04
                    pshs      d         ; preserve d across the operation
                    leax      >StringLineFormat,pc ; address string line format
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $04,s     ; release $04,s bytes of stack state
                    leax      >TerminalFailureMessage,pc ; select text 034
                    pshs      x         ; preserve x across the operation
                    lbsr      PrintTerminalLine ; display the selected terminal prompt or status line
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $06,s     ; recover $06
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ExitProcess ; terminate with the open failure status
                    bra       ReturnAbortKey ; resume return abort key
PollAbortKey        pshs      u         ; preserve u across the operation
                    ldd       #-76      ; supply failure or frame value -76 to the following operation
                    lbsr      CheckStackSpace ; verify that the requested frame fits below the heap
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    ldd       $06,s     ; recover $06
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #1        ; initialize $01 to 1
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $04,s     ; release $04,s bytes of stack state
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    bne       NoAbortKey ; nonzero result: no abort key
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve the flags or register state required by the following operation
                    leax      $02,s     ; select $02
                    pshs      x         ; preserve x across the operation
                    ldd       $0A,s     ; recover $0 a
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
                    leas      $06,s     ; release $06,s bytes of stack state
                    bra       ReturnPolledKey ; resume return polled key
NoAbortKey          clra                ; select standard input
                    clrb                ; preserve the original runtime's anomalous zero result
                    stb       ,s        ; store b in the current stack frame at ,s
ReturnPolledKey     ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
ReturnAbortKey      leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore the caller frame and return
DefaultPortPath     fcc       "/t2"
                    fcb       $00
DefaultPortOpenError fcc       "Cannot open /t2"
                    fcb       $00
PortOpenErrorFormat fcc       "Cannot open %s"
                    fcb       $0D
                    fcb       $00
BannerTitle         fcc       "Quik terminal Version 1.00    "
                    fcb       $0D
                    fcb       $00
BannerAuthor        fcc       "By Alpha Software Technologies"
                    fcb       $0D
                    fcb       $00
BannerRelease       fcc       "Released for shareware, 1988  "
                    fcb       $0D
                    fcb       $00
BannerSpacing       fcb       $0D
                    fcb       $00
TerminalHelpLine    fcc       "Press <ALT><X> to exit          <ALT><T> to transfer files"
                    fcb       $0D
                    fcb       $00
BannerRule          fcc       "----------------------------------------------------------------"
                    fcb       $0D
                    fcb       $00
TerminalExitMessage fcc       "Quik terminal...exited"
                    fcb       $0D
                    fcb       $00
ExitMessageSpacing  fcb       $0D
                    fcc       "For a free catalog please write to:"
                    fcb       $0D
                    fcb       $00
AddressSpacing      fcb       $0D
                    fcc       "Alpha Software Technologies"
                    fcb       $0D
                    fcb       $00
AddressLineOne      fcc       "2810 Buffon St."
                    fcb       $0D
                    fcb       $00
AddressLineTwo      fcc       "Chalmette, La. 70043"
                    fcb       $0D
                    fcb       $00
TransferSpacing     fcb       $0D
                    fcc       "or leave mail for 'ALPHASOFT' on DELPHI"
                    fcb       $0D
                    fcb       $00
TransferDirectionPrompt fcc       "[R]ecieve or [S]end a file:"
                    fcb       $00
TransferPromptReturn fcb       $0D
                    fcb       $00
SendFilenamePrompt  fcc       "Enter filename to send:"
                    fcb       $00
SendOpenErrorFormat fcc       "Cannot open file, error %d"
                    fcb       $0D
                    fcb       $00
SendingStatus       fcc       "Sending file                    press <ALT><Q> to abort"
                    fcb       $0D
                    fcb       $00
TransferRule        fcc       "----------------------------------------------------------------"
                    fcb       $0D
                    fcb       $00
SendStatusReturn    fcb       $0D
                    fcc       "Sending block #%05u "
                    fcb       $00
SendAbortMessage    fcc       "File transfer aborted!"
                    fcb       $0D
                    fcb       $00
ReceiveAbortMessage fcc       "File transfer aborted!"
                    fcb       $0D
                    fcb       $00
TransferCompleteMessage fcc       "File transfer complete."
                    fcb       $0D
                    fcb       $00
TransferCompleteReturn fcb       $0D
                    fcc       "Sending block #%05u "
                    fcb       $00
ReceiveFilenamePrompt fcc       "Enter filename to recieve:"
                    fcb       $00
FileExistsMessage   fcc       "File exists!"
                    fcb       $0D
                    fcb       $00
ReceiveOpenErrorFormat fcc       "Cannot open file, error %d"
                    fcb       $0D
                    fcb       $00
ReceivingStatus     fcc       "Recieving file                  press <ALT><Q> to abort"
                    fcb       $0D
                    fcb       $00
ReceiveRule         fcc       "----------------------------------------------------------------"
                    fcb       $0D
                    fcb       $00
ReceiveStatusReturn fcb       $0D
                    fcc       "File transfer aborted!"
                    fcb       $0D
                    fcb       $00
ReceivePromptReturn fcb       $0D
                    fcc       "Recieving block #%05u "
                    fcb       $00
ReceiveTimeoutMessage fcc       "Timeout/read error"
                    fcb       $0D
                    fcb       $00
ReceiveSuccessMessage fcc       "File receive successful."
                    fcb       $0D
                    fcb       $00
ReceiveErrorLimitMessage fcc       "Too many errors...I give up!"
                    fcb       $0D
                    fcb       $00
ReceiveAbortStatus  fcc       "File transfer aborted!"
                    fcb       $0D
                    fcb       $00
ReceiveReadErrorFormat fcc       "Timeout/read error %d!!"
                    fcb       $0D
                    fcb       $00
BlockComplementError fcc       "Block # scrambled!"
                    fcb       $0D
                    fcb       $00
UnexpectedBlockMessage fcc       "Bad block #!"
                    fcb       $0D
                    fcb       $00
ChecksumErrorFormat fcc       "Bad checksum! %d / %d"
                    fcb       $0D
                    fcb       $00
StringLineFormat    fcb       $25
                    fcb       $73
                    fcb       $0D
                    fcb       $00
TerminalFailureMessage fcc       "Stupid terminal...exited"
                    fcb       $0D
                    fcb       $00
                    fcb       $34
                    fcb       $46
                    fcb       $EE
                    fcb       $66
                    fcb       $20
                    fcb       $04
                    fcb       $EC
                    fcb       $E4
                    fcb       $E7
                    fcb       $C0
                    fcb       $30
                    fcb       $A9
                    fcb       $00
                    fcb       $13
                    fcb       $34
                    fcb       $10
                    fcb       $17
                    fcb       $07
                    fcb       $90
                    fcb       $32
                    fcb       $62
                    fcb       $ED
                    fcb       $E4
                    fcb       $10
                    fcb       $83
                    fcb       $00
                    fcb       $0D
                    fcb       $27
                    fcb       $08
                    fcb       $EC
                    fcb       $E4
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $E1
                    fcb       $EC
                    fcb       $E4
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $04
                    fcc       "O_ "
                    fcb       $06
                    fcb       $4F
                    fcb       $5F
                    fcb       $E7
                    fcb       $C4
                    fcb       $EC
                    fcc       "f2b5"
                    fcb       $C0
OpenTransferFile    pshs      u         ; preserve the caller's descriptor pointer
                    ldu       $06,s     ; recover $06
                    leas      -$04,s    ; release -$04,s bytes of stack state
                    ldd       $08,s     ; recover $08
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       ScanOpenMode ; resume scan open mode
AccumulateOpenMode  ldd       $02,s     ; recover $02
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
                    cmpb      #13       ; recognize the carriage-return terminator
                    beq       OpenModeReady ; zero result: open mode ready
ScanOpenMode        tfr       u,d       ; transfer u,d
                    leau      -$01,u    ; select -$01
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    ble       OpenModeReady ; continue at OpenModeReady when the signed value is at or below the limit
                    ldd       $0C,s     ; recover $0 c
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      InitializeStreamBuffer ; attach storage appropriate for the stream mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; test against #-1
                    bne       AccumulateOpenMode ; nonzero result: accumulate open mode
OpenModeReady       clra                ; select standard input
                    clrb                ; fopen-style failure returns a null stream
                    stb       [,s]      ; store b in the current stack frame at [,s]
                    ldd       $02,s     ; recover $02
                    cmpd      #-1       ; test against #-1
                    bne       ReturnOpenFailure ; nonzero result: return open failure
                    clra                ; select standard input
                    clrb                ; request allocation of a new descriptor
                    bra       ReturnOpenedPath ; resume return opened path
ReturnOpenFailure   ldd       $08,s     ; recover $08
ReturnOpenedPath    leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
PrintTerminalLine   pshs      u         ; preserve u across the operation
                    leax      >$0020,y  ; select $0020
                    stx       >$02DA,y  ; retain $02 da
                    leax      $06,s     ; select $06
                    pshs      x         ; preserve x across the operation
                    ldd       $06,s     ; recover $06
                    bra       InvokeFormatEngine ; resume invoke format engine
                    fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $02
                    fcb       $DA
                    fcc       "0h4"
                    fcb       $10
                    fcb       $EC
                    fcb       $68
InvokeFormatEngine  pshs      d         ; preserve d across the operation
                    leax      >EncodedFormatWrapper,pc ; address encoded format wrapper
                    pshs      x         ; preserve x across the operation
                    bsr       FormatOutputCore ; format the next conversion into the output stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $02
                    fcb       $DA
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
                    fcb       $02
                    fcb       $DA
                    fcb       $EC
                    fcb       $64
                    fcb       $35
                    fcb       $C0
* Compiler printf engine used by the status and error messages below.  It parses
* flags, width and precision, converts integer fields, and emits through a callback.
FormatOutputCore    pshs      u         ; preserve the caller while formatting
                    ldu       $06,s     ; recover $06
                    leas      -$0B,s    ; release -$0B,s bytes of stack state
                    bra       ScanFormatString ; resume scan format string
EmitLiteralFormatByte ldb       $08,s     ; recover $08
                    lbeq      FinishFormattedOutput ; zero result: finish formatted output
                    ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$11,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
ScanFormatString    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; recognize 37 as a meaningful value in this parser state
                    bne       EmitLiteralFormatByte ; nonzero result: emit literal format byte
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; recover $08
                    cmpb      #45       ; recognize 45 as a meaningful value in this parser state
                    bne       FormatSetupReady ; nonzero result: format setup ready
                    ldd       #1        ; initialize $02 f0 to 1
                    std       >$02F0,y  ; retain $02 f0
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       SelectFormatPadding ; resume select format padding
FormatSetupReady    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >$02F0,y  ; retain $02 f0
SelectFormatPadding ldb       $08,s     ; recover $08
                    cmpb      #48       ; recognize or generate ASCII zero
                    bne       UseSpacePadding ; nonzero result: use space padding
                    ldd       #48       ; recognize or generate ASCII zero
                    bra       SaveFormatCallback ; resume save format callback
UseSpacePadding     ldd       #32       ; recognize the first printable ASCII value
SaveFormatCallback  std       >$02F2,y  ; retain $02 f2
                    bra       ParseFieldWidth ; resume parse field width
AccumulateFieldWidth ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
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
                    leax      >$00E4,y  ; select $00 e4
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulateFieldWidth ; repeat accumulate field width until the terminating condition is met
                    ldb       $08,s     ; recover $08
                    cmpb      #46       ; recognize 46 as a meaningful value in this parser state
                    bne       NoPrecisionSpecified ; nonzero result: no precision specified
                    ldd       #1        ; initialize $04 to 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       ParsePrecisionDigits ; resume parse precision digits
AccumulatePrecision ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
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
                    leax      >$00E4,y  ; select $00 e4
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulatePrecision ; repeat accumulate precision until the terminating condition is met
                    bra       DispatchConversion ; resume dispatch conversion
NoPrecisionSpecified clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $04,s     ; store d in the current stack frame at $04,s
DispatchConversion  ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      MatchConversionType ; resume match conversion type
FormatSignedDecimal ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    lbsr      ConvertSignedDecimal ; convert signed decimal
                    bra       StoreConvertedPointer ; resume store converted pointer
FormatOctal         ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    lbsr      ConvertOctal ; convert octal
StoreConvertedPointer std       ,s        ; store d in the current stack frame at ,s
                    lbra      WriteConvertedField ; resume write converted field
FormatHexadecimal   ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldb       $0A,s     ; recover $0 a
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; select $00 e4
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
                    lbsr      ConvertHexadecimal ; convert the numeric value to hexadecimal text
                    lbra      RestoreFormatStack ; resume restore format stack
FormatUnsignedDecimal ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    leax      >$02DC,y  ; select $02 dc
                    pshs      x         ; preserve x across the operation
                    lbsr      ConvertUnsignedDecimal ; convert unsigned decimal
                    lbra      RestoreFormatStack ; resume restore format stack
FormatFloatingValue ldd       $04,s     ; recover $04
                    bne       ConvertFloatingValue ; nonzero result: convert floating value
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
                    lbsr      ReturnEmptyString ; return empty string
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      PassConvertedField ; resume pass converted field
FormatCharacterValue ldx       <$0013,s  ; recover $0013
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    lbra      EmitScalarValue ; resume emit scalar value
FormatStringValue   ldx       <$0013,s  ; recover $0013
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; recover $04
                    beq       StringWidthReady ; zero result: string width ready
                    ldd       $09,s     ; recover $09
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       MeasureBoundedString ; resume measure bounded string
CountStringByte     ldb       [<$09,s]  ; recover [<$09
                    beq       EmitFormattedField ; zero result: emit formatted field
                    ldd       $09,s     ; recover $09
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
MeasureBoundedString ldd       $02,s     ; recover $02
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       CountStringByte ; nonzero result: count string byte
EmitFormattedField  ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $0B,s     ; recover $0 b
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; preserve d across the operation
                    ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    ldd       <$0015,s  ; recover $0015
                    pshs      d         ; preserve d across the operation
                    lbsr      WritePaddedField ; write padded field
                    leas      $08,s     ; release $08,s bytes of stack state
                    bra       ResumeFormatScan ; resume resume format scan
StringWidthReady    ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $0B,s     ; recover $0 b
                    bra       PassConvertedField ; resume pass converted field
AcceptLongModifier  ldb       ,u+       ; consume the next byte while accept long modifier
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       FormatLongValue ; resume format long value
                    fcb       $32
                    fcb       $15
FormatLongValue     ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    leax      <$0015,s  ; select $0015
                    pshs      x         ; preserve x across the operation
                    ldb       $0C,s     ; recover $0 c
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    lbsr      SelectIntegerArgument ; select integer argument
RestoreFormatStack  leas      $04,s     ; release $04,s bytes of stack state
PassConvertedField  pshs      d         ; preserve d across the operation
WriteConvertedField ldd       <$0013,s  ; recover $0013
                    pshs      d         ; preserve d across the operation
                    lbsr      WritePaddedString ; write padded string
                    leas      $06,s     ; release $06,s bytes of stack state
ResumeFormatScan    lbra      ScanFormatString ; resume scan format string
EmitUnknownSpecifier ldb       $08,s     ; recover $08
                    sex                 ; sign-extend b into d
EmitScalarValue     pshs      d         ; preserve d across the operation
                    jsr       [<$11,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      ScanFormatString ; resume scan format string
MatchConversionType cmpx      #100      ; test against #100
                    lbeq      FormatSignedDecimal ; zero result: format signed decimal
                    cmpx      #111      ; test against #111
                    lbeq      FormatOctal ; zero result: format octal
                    cmpx      #120      ; test against #120
                    lbeq      FormatHexadecimal ; zero result: format hexadecimal
                    cmpx      #88       ; test against #88
                    lbeq      FormatHexadecimal ; zero result: format hexadecimal
                    cmpx      #117      ; test against #117
                    lbeq      FormatUnsignedDecimal ; zero result: format unsigned decimal
                    cmpx      #102      ; test against #102
                    lbeq      FormatFloatingValue ; zero result: format floating value
                    cmpx      #101      ; test against #101
                    lbeq      FormatFloatingValue ; zero result: format floating value
                    cmpx      #103      ; test against #103
                    lbeq      FormatFloatingValue ; zero result: format floating value
                    cmpx      #69       ; test against #69
                    lbeq      FormatFloatingValue ; zero result: format floating value
                    cmpx      #71       ; test against #71
                    lbeq      FormatFloatingValue ; zero result: format floating value
                    cmpx      #99       ; test against #99
                    lbeq      FormatCharacterValue ; zero result: format character value
                    cmpx      #115      ; test against #115
                    lbeq      FormatStringValue ; zero result: format string value
                    cmpx      #108      ; test against #108
                    lbeq      AcceptLongModifier ; zero result: accept long modifier
                    bra       EmitUnknownSpecifier ; resume emit unknown specifier
FinishFormattedOutput leas      $0B,s     ; release $0B,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertSignedDecimal pshs      u,d       ; save u,d on the stack
                    leax      >$02DC,y  ; select $02 dc
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; recover $06
                    bge       ConvertSignedMagnitude ; signed comparison reached its upper case: convert signed magnitude
                    ldd       $06,s     ; recover $06
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       PrefixMinusSign ; signed comparison reached its upper case: prefix minus sign
                    leax      >MinimumSignedText,pc ; select text 035
                    pshs      x         ; preserve x across the operation
                    leax      >$02DC,y  ; select $02 dc
                    pshs      x         ; preserve x across the operation
                    lbsr      CopyCString ; copy cstring
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnConversionBuffer ; resume return conversion buffer
PrefixMinusSign     ldd       #45       ; initialize  to 45
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ConvertSignedMagnitude ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldd       $02,s     ; recover $02
                    pshs      d         ; preserve d across the operation
                    bsr       ConvertUnsignedDecimal ; convert unsigned decimal
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnNumericBuffer ; resume return numeric buffer
ConvertUnsignedDecimal pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; recover $0 a
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       NormalizeDecimalRange ; resume normalize decimal range
IncreaseDecimalDigitCount ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; recover $0 c
                    subd      >$0006,y  ; subtract from d using >$0006,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
NormalizeDecimalRange ldd       $0C,s     ; recover $0 c
                    blt       IncreaseDecimalDigitCount ; signed comparison remains below its limit: increase decimal digit count
                    leax      >$0006,y  ; select $0006
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       EmitDecimalDigits ; resume emit decimal digits
AdvanceDecimalDigit ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
SubtractDecimalPlace ldd       $0C,s     ; recover $0 c
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       AdvanceDecimalDigit ; signed comparison reached its upper case: advance decimal digit
                    ldd       $0C,s     ; recover $0 c
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; recover
                    beq       MarkDecimalStarted ; zero result: mark decimal started
                    ldd       #1        ; initialize $02 to 1
                    std       $02,s     ; store d in the current stack frame at $02,s
MarkDecimalStarted  ldd       $02,s     ; recover $02
                    beq       AdvanceDecimalDivisor ; zero result: advance decimal divisor
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
                    cmpd      >$000E,y  ; test against $000 e
                    bne       SubtractDecimalPlace ; nonzero result: subtract decimal place
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
                    leax      >$02DC,y  ; select $02 dc
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$02E6,y  ; select $02 e6
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
                    bne       ExtractOctalDigit ; nonzero result: extract octal digit
                    bra       ReverseOctalDigits ; resume reverse octal digits
CopyOctalDigit      ldb       StreamCursor,u ; recover stream cursor
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseOctalDigits  leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$02E6,y  ; select $02 e6
                    cmpx      ,s++      ; test against
                    bls       CopyOctalDigit ; continue copy octal digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [,s]      ; store b in the current stack frame at [,s]
ReturnNumericBuffer leax      >$02DC,y  ; select $02 dc
                    tfr       x,d       ; transfer x,d
ReturnConversionBuffer leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertHexadecimal  pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$02DC,y  ; select $02 dc
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$02E6,y  ; select $02 e6
ExtractHexDigit     ldd       $08,s     ; recover $08
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; preserve d across the operation
                    ldd       $02,s     ; recover $02
                    cmpd      #9        ; test against #9
                    ble       UseNumericHexDigit ; continue at UseNumericHexDigit when the signed value is at or below the limit
                    ldd       $0C,s     ; recover $0 c
                    beq       UseLowercaseHexBase ; zero result: use lowercase hex base
                    ldd       #65       ; supply 65 as the control, count, or argument value required here
                    bra       AdjustHexAlphabeticDigit ; resume adjust hex alphabetic digit
UseLowercaseHexBase ldd       #97       ; supply 97 as the control, count, or argument value required here
AdjustHexAlphabeticDigit addd      #-10      ; add to d using #-10
                    bra       StoreHexDigit ; resume store hex digit
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
                    bne       ExtractHexDigit ; nonzero result: extract hex digit
                    bra       ReverseHexDigits ; resume reverse hex digits
CopyHexDigit        ldb       StreamCursor,u ; recover stream cursor
                    ldx       $02,s     ; recover $02
                    leax      $01,x     ; select $01
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseHexDigits    leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$02E6,y  ; select $02 e6
                    cmpx      ,s++      ; test against
                    bls       CopyHexDigit ; continue copy hex digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$02DC,y  ; select $02 dc
                    tfr       x,d       ; transfer x,d
                    lbra      ReturnFormattedBuffer ; resume return formatted buffer
WritePaddedField    pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    ldd       $0A,s     ; recover $0 a
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$02F0,y  ; recover $02 f0
                    bne       EmitFieldBytes ; nonzero result: emit field bytes
                    bra       EmitLeadingPadding ; resume emit leading padding
EmitLeadingPadByte  ldd       >$02F2,y  ; recover $02 f2
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitLeadingPadding  ldd       $0A,s     ; recover $0 a
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitLeadingPadByte ; continue at EmitLeadingPadByte when the signed value is above the limit
                    bra       EmitFieldBytes ; resume emit field bytes
EmitNextFieldByte   ldb       ,u+       ; consume the next byte while emit next field byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitFieldBytes      ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       EmitNextFieldByte ; nonzero result: emit next field byte
                    ldd       >$02F0,y  ; recover $02 f0
                    beq       ReturnPaddedField ; zero result: return padded field
                    bra       EmitTrailingPadding ; resume emit trailing padding
EmitTrailingPadByte ldd       >$02F2,y  ; recover $02 f2
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitTrailingPadding ldd       $0A,s     ; recover $0 a
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitTrailingPadByte ; continue at EmitTrailingPadByte when the signed value is above the limit
ReturnPaddedField   puls      pc,u      ; restore pc,u and return to the caller
WritePaddedString   pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    ldd       $08,s     ; recover $08
                    pshs      d         ; preserve d across the operation
                    pshs      u         ; preserve u across the operation
                    lbsr      MeasureCString ; measure cstring
                    leas      $02,s     ; release $02,s bytes of stack state
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$02F0,y  ; recover $02 f0
                    bne       EmitStringBytes ; nonzero result: emit string bytes
                    bra       EmitStringLeadingPadding ; resume emit string leading padding
EmitStringLeadingPadByte ldd       >$02F2,y  ; recover $02 f2
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringLeadingPadding ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitStringLeadingPadByte ; continue at EmitStringLeadingPadByte when the signed value is above the limit
                    bra       EmitStringBytes ; resume emit string bytes
EmitNextStringByte  ldb       ,u+       ; consume the next byte while emit next string byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringBytes     ldb       StreamCursor,u ; recover stream cursor
                    bne       EmitNextStringByte ; nonzero result: emit next string byte
                    ldd       >$02F0,y  ; recover $02 f0
                    beq       ReturnPaddedString ; zero result: return padded string
                    bra       EmitStringTrailingPadding ; resume emit string trailing padding
EmitStringTrailingPadByte ldd       >$02F2,y  ; recover $02 f2
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringTrailingPadding ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitStringTrailingPadByte ; continue at EmitStringTrailingPadByte when the signed value is above the limit
ReturnPaddedString  puls      pc,u      ; restore pc,u and return to the caller
EncodedFormatWrapper fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $A9
                    fcb       $02
                    fcb       $DA
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
                    fcb       $02
                    fcb       $DA
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $A9
                    fcb       $02
                    fcb       $DA
                    fcb       $E7
                    fcb       $1F
                    fcb       $35
                    fcb       $C0
MinimumSignedText   fcc       "-32768"
                    fcb       $00
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcb       $66
                    fcb       $EC
                    fcb       $46
                    fcb       $84
                    fcb       $80
                    fcb       $C4
                    fcb       $22
                    fcb       $10
                    fcb       $83
                    fcb       $80
                    fcb       $02
                    fcb       $27
                    fcb       $14
                    fcb       $EC
                    fcb       $46
                    fcb       $4F
                    fcb       $C4
                    fcb       $22
                    fcb       $10
                    fcb       $83
                    fcb       $00
                    fcb       $02
                    fcb       $10
                    fcb       $26
                    fcb       $01
                    fcb       $1F
                    fcb       $34
                    fcb       $40
                    fcb       $17
                    fcb       $03
                    fcc       "M2b"
                    fcb       $EC
                    fcb       $46
                    fcb       $4F
                    fcb       $C4
                    fcb       $04
                    fcb       $27
                    fcb       $35
                    fcb       $CC
                    fcb       $00
                    fcb       $01
                    fcb       $34
                    fcb       $06
                    fcc       "0g4"
                    fcb       $10
                    fcb       $EC
                    fcb       $48
                    fcb       $34
                    fcb       $06
                    fcb       $EC
                    fcb       $46
                    fcb       $4F
                    fcb       $C4
                    fcb       $40
                    fcb       $27
                    fcb       $06
                    fcb       $30
                    fcb       $8D
                    fcb       $06
                    fcb       $43
                    fcb       $20
                    fcb       $04
                    fcb       $30
                    fcb       $8D
                    fcb       $06
                    fcb       $24
                    fcb       $1F
                    fcb       $10
                    fcb       $1F
                    fcb       $01
                    fcb       $AD
                    fcb       $84
                    fcb       $32
                    fcb       $66
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $4A
                    fcb       $EC
                    fcb       $46
                    fcb       $CA
                    fcb       $20
                    fcb       $ED
                    fcb       $46
                    fcb       $16
                    fcb       $00
                    fcb       $DC
                    fcb       $EC
                    fcb       $46
                    fcb       $84
                    fcb       $01
                    fcb       $5F
                    fcb       $ED
                    fcb       $7E
                    fcb       $26
                    fcb       $07
                    fcb       $34
                    fcb       $40
                    fcb       $17
                    fcb       $00
                    fcb       $EB
                    fcb       $32
                    fcb       $62
                    fcb       $EC
                    fcb       $C4
                    fcb       $C3
                    fcb       $00
                    fcb       $01
                    fcb       $ED
                    fcb       $C4
                    fcb       $83
                    fcb       $00
                    fcb       $01
                    fcb       $1F
                    fcb       $01
                    fcb       $EC
                    fcb       $64
                    fcb       $E7
                    fcb       $84
                    fcb       $EC
                    fcb       $C4
                    fcb       $10
                    fcb       $A3
                    fcb       $44
                    fcb       $24
                    fcb       $0F
                    fcb       $EC
                    fcb       $46
                    fcb       $4F
                    fcb       $C4
                    fcb       $40
                    fcb       $27
                    fcb       $13
                    fcb       $EC
                    fcb       $64
                    fcb       $10
                    fcb       $83
                    fcb       $00
                    fcb       $0D
                    fcb       $26
                    fcb       $0B
                    fcb       $34
                    fcb       $40
                    fcb       $17
                    fcb       $00
                    fcb       $BE
                    fcb       $ED
                    fcb       $E1
                    fcb       $10
                    fcb       $26
                    fcb       $00
                    fcb       $9B
                    fcb       $EC
                    fcb       $64
                    fcb       $35
                    fcb       $C0
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcb       $64
                    fcb       $EC
                    fcb       $66
                    fcb       $34
                    fcb       $06
                    fcb       $34
                    fcb       $40
                    fcb       $CC
                    fcb       $00
                    fcb       $08
                    fcb       $17
                    fcb       $04
                    fcb       $79
                    fcb       $34
                    fcb       $06
                    fcb       $17
                    fcb       $FF
                    fcc       "F2d"
                    fcb       $EC
                    fcb       $66
                    fcb       $34
                    fcb       $06
                    fcb       $34
                    fcb       $40
                    fcb       $17
                    fcb       $FF
                    fcb       $3B
                    fcb       $16
                    fcb       $01
                    fcc       "K"
* The remaining routines are the compiler's stdio and OS-9 adaptation layer:
* descriptor cleanup, buffered read/write, pathname services, and heap growth.
CloseAllStreams     pshs      u,d       ; preserve U and allocate a word-sized slot index
                    leau      >$0013,y  ; select $0013
                    clra                ; initialize the slot index to zero
                    clrb                ; complete the zero slot index
                    std       ,s        ; retain the index in the local stack word
                    bra       CheckNextStreamSlot ; resume check next stream slot
CloseNextStreamSlot tfr       u,d       ; pass the current descriptor address
                    leau      RuntimeDescriptorTableAndGlobals,u ; select runtime descriptor table and globals
                    pshs      d         ; pass the descriptor being closed
                    bsr       CloseStream ; flush and release the selected stream
                    leas      $02,s     ; release $02,s bytes of stack state
CheckNextStreamSlot ldd       ,s        ; recover
                    addd      #1        ; prepare the following index
                    std       ,s        ; retain it for the next iteration
                    subd      #1        ; restore the index being tested now
                    cmpd      #16       ; test against #16
                    blt       CloseNextStreamSlot ; signed comparison remains below its limit: close next stream slot
                    lbra      StreamOperationDone ; return through the shared stream epilogue
CloseStream         pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    cmpu      #0        ; detect a null runtime allocation result
                    beq       RejectCloseRequest ; a null pointer cannot be closed
                    ldd       StreamFlags,u ; recover stream flags
                    bne       CloseActiveStream ; nonzero flags identify an occupied slot
RejectCloseRequest  ldd       #-1       ; supply failure or frame value -1 to the following operation
                    lbra      StreamOperationDone ; unwind the local result word
CloseActiveStream   ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect only low-byte access flags
                    andb      #2        ; mask b using #2
                    beq       SkipCloseFlush ; read-only streams have no pending output
                    pshs      u         ; flush pending output before releasing the path
                    bsr       FlushStream ; commit any pending stream output
                    leas      $02,s     ; release $02,s bytes of stack state
                    bra       CloseUnderlyingPath ; resume close underlying path
SkipCloseFlush      clra                ; prepare a successful zero result
                    clrb                ; a read-only stream has no write error to report
CloseUnderlyingPath std       ,s        ; preserve the flush result across I$Close
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; release the underlying OS-9 path
                    lbsr      ClosePath ; release the selected OS-9 path
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; clear the descriptor flags as a word
                    clrb                ; mark the table entry inactive
                    std       StreamFlags,u ; preserve stream flags
                    ldd       ,s        ; recover
                    bra       StreamOperationDone ; return the saved flush result
FlushStream         pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    beq       RejectFlushRequest ; zero result: reject flush request
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; ignore high-byte orientation state
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; test against #2
                    beq       PrepareStreamFlush ; zero result: prepare stream flush
RejectFlushRequest  ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,u      ; reject null, read-only, or failed streams
PrepareStreamFlush  ldd       StreamFlags,u ; recover stream flags
                    anda      #128      ; mask a using #128
                    clrb                ; form a word-sized initialization test
                    std       -$02,s    ; use the compiler spill slot only for the flag test
                    bne       FlushAssignedBuffer ; nonzero result: flush assigned buffer
                    pshs      u         ; pass the descriptor to lazy initialization
                    lbsr      ReadStreamCharacter ; obtain the next buffered stream character
                    leas      $02,s     ; release $02,s bytes of stack state
FlushAssignedBuffer pshs      u         ; pass the prepared descriptor to the buffer flusher
                    bsr       FlushBufferedStream ; commit buffered bytes to the underlying path
StreamOperationDone leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore U and return the operation status
FlushBufferedStream pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    leas      -$04,s    ; release -$04,s bytes of stack state
                    ldd       StreamFlags,u ; recover stream flags
                    anda      #1        ; mask a using #1
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the test value below the compiler frame
                    bne       ComputePendingOutput ; nonzero result: compute pending output
                    ldd       StreamCursor,u ; recover stream cursor
                    cmpd      StreamBufferEnd,u ; test against stream buffer end
                    beq       ComputePendingOutput ; zero result: compute pending output
                    clra                ; build a zero position-query argument
                    clrb                ; complete the zero word
                    pshs      d         ; request the runtime's current logical position
                    pshs      u         ; pass the descriptor to the position hook
                    lbsr      NoOpStreamPositionHook ; preserve the runtime stream-position hook contract
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $02,x     ; recover $02
                    pshs      d         ; pass the returned low position word
                    ldd       ,x        ; recover
                    pshs      d         ; pass the returned high position word
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; pass the path number
                    lbsr      SeekPath  ; move the selected path to the computed file position
                    leas      $08,s     ; release $08,s bytes of stack state
ComputePendingOutput ldd       StreamCursor,u ; recover stream cursor
                    subd      StreamBufferStart,u ; subtract from d using StreamBufferStart,u
                    std       $02,s     ; retain the number of buffered bytes
                    lbeq      ResetFlushedStream ; nothing has been accumulated
                    ldd       StreamFlags,u ; recover stream flags
                    anda      #1        ; mask a using #1
                    clrb                ; form the word-sized orientation test
                    std       -$02,s    ; preserve it in the compiler spill slot
                    lbeq      ResetFlushedStream ; discard cached input rather than writing it
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect only low-byte buffering flags
                    andb      #64       ; mask b using #64
                    beq       WriteBlockBuffer ; ordinary buffers use one bulk write
                    ldd       StreamBufferStart,u ; recover stream buffer start
                    bra       UpdateWriteCursor ; seed the line-write cursor
WriteNextLineFragment ldd       $02,s     ; recover $02
                    pshs      d         ; pass the remaining byte count
                    ldd       StreamCursor,u ; recover stream cursor
                    pshs      d         ; pass the first unwritten byte
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; pass it to the line-write wrapper
                    lbsr      WriteLineBytes ; write through the next carriage return
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; retain the number written or -1
                    cmpd      #-1       ; test against #-1
                    bne       AdvanceAfterLineWrite ; nonzero result: advance after line write
                    leax      $04,s     ; preserve the compiler's error-frame restoration
                    bra       RestoreFailedWriteFrame ; resume restore failed write frame
AdvanceAfterLineWrite ldd       $02,s     ; recover $02
                    subd      ,s        ; remove the completed portion from the remainder
                    std       $02,s     ; retain the reduced count
                    ldd       StreamCursor,u ; recover stream cursor
                    addd      ,s        ; advance to the next unwritten byte
UpdateWriteCursor   std       StreamCursor,u ; preserve stream cursor
                    ldd       $02,s     ; recover $02
                    bne       WriteNextLineFragment ; nonzero result: write next line fragment
                    bra       ResetFlushedStream ; all line fragments reached OS-9
WriteBlockBuffer    ldd       $02,s     ; recover $02
                    pshs      d         ; write the entire pending block in one call
                    ldd       StreamBufferStart,u ; recover stream buffer start
                    pshs      d         ; pass the source address
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; pass the path number
                    lbsr      WriteBytes ; write the prepared byte range to its stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    cmpd      $02,s     ; test against $02
                    beq       ResetFlushedStream ; accept only a complete block write
                    bra       MarkStreamWriteError ; resume mark stream write error
RestoreFailedWriteFrame leas      -$04,x    ; release -$04,x bytes of stack state
MarkStreamWriteError ldd       StreamFlags,u ; recover stream flags
                    orb       #32       ; set selected bits in b using #32
                    std       StreamFlags,u ; preserve stream flags
                    ldd       StreamBufferEnd,u ; recover stream buffer end
                    std       StreamCursor,u ; preserve stream cursor
                    ldd       #-1       ; initialize stream flags to -1
                    bra       ReturnFlushStatus ; release locals and return failure
ResetFlushedStream  ldd       StreamFlags,u ; recover stream flags
                    ora       #1        ; set selected bits in a using #1
                    std       StreamFlags,u ; preserve stream flags
                    ldd       StreamBufferStart,u ; recover stream buffer start
                    std       StreamCursor,u ; preserve stream cursor
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEnd,u ; preserve stream buffer end
                    clra                ; prepare a successful zero result
                    clrb                ; report a successful flush
ReturnFlushStatus   leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore U and return the flush status
NoOpStreamPositionHook pshs      u         ; preserve u across the operation
                    puls      pc,u      ; return without disturbing the position pointer
InitializeStreamBuffer pshs      u         ; preserve u across the operation
                    ldu       $04,s     ; recover $04
                    beq       ReturnReadFailure ; reject a null stream
                    ldd       StreamFlags,u ; recover stream flags
                    anda      #1        ; mask a using #1
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the orientation test below the frame
                    bne       ReturnReadFailure ; getc cannot switch direction implicitly
                    ldd       StreamCursor,u ; recover stream cursor
                    cmpd      StreamBufferEnd,u ; test against stream buffer end
                    bcc       RefillEmptyStream ; select refill empty stream when carry remains clear
                    ldd       StreamCursor,u ; recover stream cursor
                    addd      #1        ; calculate the following cursor
                    std       StreamCursor,u ; advance past the returned byte
                    subd      #1        ; recover the original byte address
                    tfr       d,x       ; use it as the memory pointer
                    ldb       ,x        ; return the previous cursor byte as an unsigned integer
                    clra                ; widen the byte to a positive compiler integer
                    lbra      ReturnStreamCharacter ; resume return stream character
RefillEmptyStream   pshs      u         ; ask the refill path to return its first byte
                    lbsr      RefillStreamBuffer ; refill the input buffer from its OS-9 path
                    lbra      FinishStreamRefill ; discard the pushed descriptor in the shared tail
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcb       $66
                    fcb       $27
                    fcb       $16
                    fcb       $EC
                    fcb       $46
                    fcb       $4F
                    fcb       $C4
                    fcb       $01
                    fcb       $27
                    fcb       $0F
                    fcb       $EC
                    fcb       $64
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $27
                    fcb       $07
                    fcb       $EC
                    fcb       $C4
                    fcb       $10
                    fcb       $A3
                    fcb       $42
                    fcb       $22
                    fcb       $05
ReturnReadFailure   ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,u      ; restore U and return failure
                    fcb       $EC
                    fcb       $C4
                    fcb       $C3
                    fcb       $FF
                    fcb       $FF
                    fcb       $ED
                    fcb       $C4
                    fcb       $1F
                    fcb       $01
                    fcb       $EC
                    fcb       $64
                    fcb       $E7
                    fcb       $84
                    fcb       $EC
                    fcb       $64
                    fcb       $35
                    fcb       $C0
                    fcb       $34
                    fcb       $40
                    fcb       $EE
                    fcc       "d2|4@"
                    fcb       $17
                    fcb       $FF
                    fcb       $93
                    fcb       $32
                    fcb       $62
                    fcb       $ED
                    fcb       $62
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $27
                    fcb       $0F
                    fcb       $34
                    fcb       $40
                    fcb       $17
                    fcb       $FF
                    fcb       $84
                    fcb       $32
                    fcb       $62
                    fcb       $ED
                    fcb       $E4
                    fcb       $10
                    fcb       $83
                    fcb       $FF
                    fcb       $FF
                    fcb       $26
                    fcb       $05
                    fcb       $CC
                    fcb       $FF
                    fcb       $FF
                    fcb       $20
                    fcb       $0C
                    fcb       $EC
                    fcb       $62
                    fcb       $34
                    fcb       $06
                    fcb       $CC
                    fcb       $00
                    fcb       $08
                    fcb       $17
                    fcb       $02
                    fcb       $95
                    fcb       $E3
                    fcb       $E4
                    fcc       "2d5"
                    fcb       $C0
RefillStreamBuffer  pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    ldd       StreamFlags,u ; recover stream flags
                    anda      #128      ; mask a using #128
                    andb      #49       ; mask b using #49
                    cmpd      #-32767   ; test against #-32767
                    beq       StreamReadyForRead ; zero result: stream ready for read
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; ignore initialization and orientation state
                    andb      #49       ; mask b using #49
                    cmpd      #1        ; test against #1
                    lbne      ReturnRefillFailure ; reject EOF, error, or non-readable streams
                    pshs      u         ; pass the descriptor to lazy buffer setup
                    lbsr      ReadStreamCharacter ; obtain the next buffered stream character
                    leas      $02,s     ; release $02,s bytes of stack state
StreamReadyForRead  leax      >$0013,y  ; select $0013
                    pshs      x         ; compare without sacrificing a working register
                    cmpu      ,s++      ; compare this descriptor with the saved table limit
                    bne       SelectReadStorage ; nonzero result: select read storage
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect low-byte buffering state
                    andb      #64       ; mask b using #64
                    beq       SelectReadStorage ; zero result: select read storage
                    leax      >$0020,y  ; select $0020
                    pshs      x         ; flush any prompt before waiting for a line
                    lbsr      FlushStream ; display a pending prompt before blocking for input
                    leas      $02,s     ; release $02,s bytes of stack state
SelectReadStorage   ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect low-byte buffer flags
                    andb      #8        ; mask b using #8
                    beq       ReadUnbufferedByte ; fall back to a single-byte transfer
                    ldd       StreamBufferSize,u ; recover stream buffer size
                    pshs      d         ; pass the allocated buffer capacity
                    ldd       StreamBufferStart,u ; recover stream buffer start
                    pshs      d         ; preserve the shared argument layout
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; complete the low-level read arguments
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect low-byte buffering state
                    andb      #64       ; mask b using #64
                    beq       SelectBlockRead ; files use an ordinary byte read
                    leax      >EncodedUnreadCharacterEntry,pc ; address encoded unread character entry
                    bra       InvokeSelectedRead ; use the common indirect-call path
SelectBlockRead     leax      >ReadPortBytes,pc ; select read port bytes
InvokeSelectedRead  tfr       x,d       ; preserve the selected entry in compiler form
                    tfr       d,x       ; restore it as an indirect-call pointer
                    jsr       ,x        ; the helper selected in the index register
                    bra       HandleRefillResult ; normalize either wrapper's result
ReadUnbufferedByte  ldd       #1        ; initialize stream buffer start to 1
                    pshs      d         ; request exactly one byte
                    leax      StreamPushbackByte,u ; select the fallback byte
                    stx       StreamBufferStart,u ; reuse descriptor-local storage
                    pshs      x         ; pass the fallback destination
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; complete the one-byte read arguments
                    lbsr      ReadPortBytes ; collect the requested bytes from the communications path
HandleRefillResult  leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; retain the actual count or failure value
                    ldd       ,s        ; recover
                    bgt       ReturnFirstRefilledByte ; continue at ReturnFirstRefilledByte when the signed value is above the limit
                    ldd       StreamFlags,u ; recover stream flags
                    pshs      d         ; preserve existing state while adding EOF or error
                    ldd       $02,s     ; recover $02
                    beq       MarkStreamEof ; zero result: mark stream eof
                    ldd       #32       ; recognize the first printable ASCII value
                    bra       MergeReadStatus ; merge failure with existing state
MarkStreamEof       ldd       #16       ; initialize stream flags to 16
MergeReadStatus     ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       StreamFlags,u ; latch EOF or error for later calls
ReturnRefillFailure ldd       #-1       ; initialize stream cursor to -1
                    bra       FinishStreamRefill ; release the count local
ReturnFirstRefilledByte ldd       StreamBufferStart,u ; recover stream buffer start
                    addd      #1        ; advance the cursor past it
                    std       StreamCursor,u ; consume the first byte immediately
                    ldd       StreamBufferStart,u ; recover stream buffer start
                    addd      ,s        ; add the actual transfer count
                    std       StreamBufferEnd,u ; limit cached input to the actual read count
                    ldb       [<$02,u]  ; recover [<$02
                    clra                ; widen the byte to a positive compiler integer
FinishStreamRefill  leas      $02,s     ; release $02,s bytes of stack state
ReturnStreamCharacter puls      pc,u      ; restore U and return the character or -1
ReadStreamCharacter pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; widen the byte to a positive compiler integer
                    andb      #192      ; mask b using #192
                    bne       BufferingModeSelected ; nonzero result: buffering mode selected
                    leas      -$20,s    ; release -$20,s bytes of stack state
                    leax      ,s        ; point X at its first byte
                    pshs      x         ; pass the option-table destination
                    ldd       StreamPath,u ; recover stream path
                    pshs      d         ; preserve the status-call argument order
                    clra                ; request base option status code zero
                    clrb                ; complete selector zero
                    pshs      d         ; request the path's base option status
                    lbsr      GetPathStatus ; read the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       StreamFlags,u ; recover stream flags
                    pshs      d         ; preserve existing state during policy selection
                    ldb       $02,s     ; device type zero identifies an SCF-style terminal
                    bne       SelectFullBuffering ; nonzero result: select full buffering
                    ldd       #64       ; supply 64 as the control, count, or argument value required here
                    bra       SaveBufferingMode ; resume save buffering mode
SelectFullBuffering ldd       #128      ; initialize stream flags to 128
SaveBufferingMode   ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       StreamFlags,u ; preserve stream flags
                    leas      <$0020,s  ; release <$0020,s bytes of stack state
BufferingModeSelected ldd       StreamFlags,u ; recover stream flags
                    ora       #128      ; set selected bits in a using #128
                    std       StreamFlags,u ; preserve stream flags
                    clra                ; inspect the already-configured storage flags
                    andb      #12       ; mask b using #12
                    beq       ChooseBufferSize ; allocate only when no storage exists
                    puls      pc,u      ; an existing buffer configuration is ready
ChooseBufferSize    ldd       StreamBufferSize,u ; recover stream buffer size
                    bne       EnsureBufferStorage ; nonzero result: ensure buffer storage
                    ldd       StreamFlags,u ; recover stream flags
                    clra                ; inspect the low-byte line flag
                    andb      #64       ; mask b using #64
                    beq       ChooseBlockBufferSize ; zero result: choose block buffer size
                    ldd       #128      ; initialize stream buffer size to 128
                    bra       SaveDefaultBufferSize ; resume save default buffer size
ChooseBlockBufferSize ldd       #256      ; initialize stream buffer size to 256
SaveDefaultBufferSize std       StreamBufferSize,u ; retain stream buffer size
EnsureBufferStorage ldd       StreamBufferStart,u ; recover stream buffer start
                    bne       MarkBufferAvailable ; nonzero result: mark buffer available
                    ldd       StreamBufferSize,u ; recover stream buffer size
                    pshs      d         ; pass the allocation size
                    lbsr      AllocateHeapBytes ; reserve heap storage for the requested buffer
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       StreamBufferStart,u ; preserve stream buffer start
                    cmpd      #-1       ; test against #-1
                    beq       UseFallbackByteBuffer ; zero result: use fallback byte buffer
MarkBufferAvailable ldd       StreamFlags,u ; recover stream flags
                    orb       #8        ; set selected bits in b using #8
                    std       StreamFlags,u ; preserve stream flags
                    bra       ResetBufferWindow ; initialize its empty bounds
UseFallbackByteBuffer ldd       StreamFlags,u ; recover stream flags
                    orb       #4        ; set selected bits in b using #4
                    std       StreamFlags,u ; preserve stream flags
                    leax      StreamPushbackByte,u ; address stream pushback byte
                    stx       StreamBufferStart,u ; preserve stream buffer start
                    ldd       #1        ; initialize stream buffer size to 1
                    std       StreamBufferSize,u ; preserve stream buffer size
ResetBufferWindow   ldd       StreamBufferStart,u ; recover stream buffer start
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEnd,u ; preserve stream buffer end
                    std       StreamCursor,u ; preserve stream cursor
                    puls      pc,u      ; restore U with buffering ready
SelectIntegerArgument pshs      u         ; preserve u across the operation
                    ldb       $05,s     ; recover $05
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    bra       ClassifyIntegerConversion ; resume classify integer conversion
FetchLongIntegerArgument ldd       [<$06,s]  ; recover [<$06
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >EmptyIntegerText,pc ; address empty integer text
                    bra       ReturnIntegerArgument ; resume return integer argument
UseByteIntegerArgument ldb       $05,s     ; recover $05
                    stb       >$0011,y  ; retain $0011
                    leax      >$0010,y  ; select $0010
ReturnIntegerArgument tfr       x,d       ; transfer x,d
                    puls      pc,u      ; restore pc,u and return to the caller
ClassifyIntegerConversion cmpx      #100      ; test against #100
                    beq       FetchLongIntegerArgument ; zero result: fetch long integer argument
                    cmpx      #111      ; test against #111
                    lbeq      FetchLongIntegerArgument ; zero result: fetch long integer argument
                    cmpx      #120      ; test against #120
                    lbeq      FetchLongIntegerArgument ; zero result: fetch long integer argument
                    bra       UseByteIntegerArgument ; resume use byte integer argument
                    fcb       $35
                    fcb       $C0
EmptyIntegerText    fcb       $00
ReturnEmptyString   pshs      u         ; preserve u across the operation
                    leax      >EmptyString,pc ; address empty string
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
                    bra       ReturnCopiedString ; resume return copied string
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
                    ldd       #0        ; supply 0 as the control, count, or argument value required here
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
GetPathStatus       lda       $05,s     ; select the OS-9 path number
                    ldb       $03,s     ; dispatch on the requested GetStat selector
                    beq       GetStatusIntoBuffer ; selector zero fills an option table at X
                    cmpb      #1        ; selector one returns register-only status
                    beq       GetRegisterPathStatus ; zero result: get register path status
                    cmpb      #6        ; selector six also needs no result-buffer translation
                    beq       GetRegisterPathStatus ; zero result: get register path status
                    cmpb      #2        ; recognize 2 as a meaningful value in this parser state
                    beq       GetLongPathStatus ; zero result: get long path status
                    cmpb      #5        ; recognize 5 as a meaningful value in this parser state
                    beq       GetLongPathStatus ; zero result: get long path status
                    ldb       #208      ; select status operation 208
                    lbra      ReturnOsError ; resume return os error
GetLongPathStatus   pshs      u         ; preserve the compiler workspace register
                    os9       I$GetStt  ; obtain the requested 32-bit value in X:U
                    bcc       StoreLongStatusResult ; select store long status result when carry remains clear
                    puls      u         ; restore U before translating the OS-9 error
                    lbra      ReturnOsError ; resume return os error
StoreLongStatusResult stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; recover that result pointer
                    stu       $02,x     ; retain $02
                    puls      u         ; restore the compiler workspace register
                    clra                ; return zero after a successful status query
                    clrb                ; clear the byte accumulator for counting
                    rts                 ; return the completed result to the caller
GetStatusIntoBuffer ldx       $06,s     ; supply the caller's option-table buffer
GetRegisterPathStatus os9       I$GetStt  ; query the selected path status
                    lbra      ReturnOsResult ; resume return os result
SetPathStatus       lda       $05,s     ; recover $05
                    ldb       $03,s     ; recover $03
                    beq       SetOptionBuffer ; zero result: set option buffer
                    cmpb      #2        ; recognize 2 as a meaningful value in this parser state
                    beq       SetLongPathStatus ; zero result: set long path status
                    ldb       #208      ; select status operation 208
                    lbra      ReturnOsError ; resume return os error
SetOptionBuffer     ldx       $06,s     ; recover $06
                    os9       I$SetStt  ; apply the selected path status operation
                    lbra      ReturnOsResult ; resume return os result
SetLongPathStatus   pshs      u         ; preserve u across the operation
                    ldx       $08,s     ; recover $08
                    ldu       $0A,s     ; recover $0 a
                    os9       I$SetStt  ; apply the selected path status operation
                    puls      u         ; restore u
                    lbra      ReturnOsResult ; resume return os result
CheckPathExists     ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; use the low byte of the requested mode
                    os9       I$Open    ; ask OS-9 for a path number
                    bcs       ReturnExistsResult ; carry reports failure: return exists result
                    os9       I$Close   ; close the selected path
ReturnExistsResult  lbra      ReturnOsResult ; resume return os result
OpenPortPath        ldx       $02,s     ; recover $02
                    lda       $05,s     ; recover $05
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      ReturnOsError ; carry reports failure: return os error
                    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts                 ; return the completed result to the caller
ClosePath           lda       $03,s     ; select the path argument
                    os9       I$Close   ; flush and release the OS-9 path
                    lbra      ReturnOsResult ; resume return os result
                    fcb       $AE
                    fcb       $62
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $85
                    fcb       $16
                    fcb       $01
                    fcb       $FD
CreateReceiveFile   ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; recover the compiler open/create mode
                    tfr       a,b       ; derive OS-9 file attributes from that mode
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; create a new file and return its path
                    bcs       ReopenExistingForTruncate ; carry reports failure: reopen existing for truncate
ReturnPathNumber    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts                 ; return the completed result to the caller
ReopenExistingForTruncate cmpb      #218      ; recognize 218 as a meaningful value in this parser state
                    lbne      ReturnOsError ; nonzero result: return os error
                    lda       $05,s     ; recover the original compiler mode
                    bita      #128      ; test selected bits in a using #128
                    lbne      ReturnOsError ; nonzero result: return os error
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; reopen the existing pathname
                    os9       I$Open    ; preserve the flags or register state required by the following operation
                    lbcs      ReturnOsError ; carry reports failure: return os error
                    pshs      u,a       ; preserve workspace and returned path
                    ldx       #0        ; request a new file size of zero
                    leau      ,x        ; select
                    ldb       #2        ; select status operation 2
                    os9       I$SetStt  ; preserve the flags or register state required by the following operation
                    puls      u,a       ; recover workspace and path number
                    bcc       ReturnPathNumber ; select return path number when carry remains clear
                    pshs      b         ; preserve the truncation error
                    os9       I$Close   ; do not leak the reopened path
                    puls      b         ; restore the error for translation
                    lbra      ReturnOsError ; resume return os error
DeletePath          ldx       $02,s     ; select the pathname to remove
                    os9       I$Delete  ; delete the path named at X
                    lbra      ReturnOsResult ; resume return os result
                    fcb       $A6
                    fcb       $63
                    fcb       $10
                    fcb       $3F
                    fcb       $82
                    fcb       $10
                    fcb       $25
                    fcb       $01
                    fcb       $9D
                    fcb       $1F
                    fcb       $89
                    fcc       "O9"
ReadPortBytes       pshs      y         ; preserve the caller's Y
                    ldx       $06,s     ; select the destination buffer
                    lda       $05,s     ; select the OS-9 path number
                    ldy       $08,s     ; supply the requested transfer length
                    pshs      y         ; preserve that length across I$Read
                    os9       I$Read    ; read one byte without stream buffering
                    bcc       ReadBytesSucceeded ; continue read bytes succeeded while the range test permits it
                    cmpb      #211      ; recognize the OS-9 end-of-file status
                    bne       ReadBytesFailed ; repeat read bytes failed until the terminating condition is met
                    clra                ; select standard input
                    clrb                ; return zero rather than -1 for EOF
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
ReadBytesFailed     puls      y,x       ; discard saved length and restore Y
                    lbra      ReturnOsError ; resume return os error
ReadBytesSucceeded  tfr       y,d       ; return the actual byte count
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
EncodedUnreadCharacterEntry fcb       $34
                    fcb       $20
                    fcb       $A6
                    fcb       $65
                    fcb       $AE
                    fcb       $66
                    fcb       $10
                    fcb       $AE
                    fcc       "h4 "
                    fcb       $10
                    fcb       $3F
                    fcb       $8B
                    fcb       $20
                    fcb       $DD
WriteBytes          pshs      y         ; preserve y across the operation
                    ldy       $08,s     ; recover the transfer length
                    beq       ReturnWriteCount ; zero result: return write count
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the source buffer
                    os9       I$Write   ; write one byte without stream buffering
FinishWrite         bcc       ReturnWriteCount ; select return write count when carry remains clear
                    puls      y         ; restore Y before the shared error path
                    lbra      ReturnOsError ; resume return os error
ReturnWriteCount    tfr       y,d       ; return the actual transfer count
                    puls      pc,y      ; preserve the flags or register state required by the following operation
WriteLineBytes      pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the maximum line length
                    beq       ReturnWriteCount ; zero result: return write count
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the CR-terminated source line
                    os9       I$WritLn  ; write through the first carriage return
                    bra       FinishWrite ; reuse normal/error result conversion
SeekPath            pshs      u         ; preserve u across the operation
                    ldd       $0A,s     ; recover $0 a
                    bne       SelectSeekOrigin ; nonzero result: select seek origin
                    ldu       #0        ; initialize the pointer or index for this state transition
                    ldx       #0        ; initialize the pointer or index for this state transition
                    bra       ComputeSeekTarget ; resume compute seek target
SelectSeekOrigin    cmpd      #1        ; test against #1
                    beq       SeekRelativeCurrent ; zero result: seek relative current
                    cmpd      #2        ; test against #2
                    beq       SeekRelativeEnd ; zero result: seek relative end
                    ldb       #247      ; initialize $01 ad to 247
ReturnSeekError     clra                ; widen the OS-9 error to a compiler word
                    std       >$01B2,y  ; retain $01 b2
                    ldd       #-1       ; initialize  to -1
                    leax      >$01A6,y  ; select $01 a6
                    std       ,x        ; preserve the flags or register state required by the following operation
                    std       $02,x     ; preserve the flags or register state required by the following operation
                    puls      pc,u      ; preserve the flags or register state required by the following operation
SeekRelativeEnd     lda       $05,s     ; select the path number
                    ldb       #2        ; select status operation 2
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       ReturnSeekError ; carry reports failure: return seek error
                    bra       ComputeSeekTarget ; resume compute seek target
SeekRelativeCurrent lda       $05,s     ; select the path number
                    ldb       #5        ; select status operation 5
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       ReturnSeekError ; carry reports failure: return seek error
ComputeSeekTarget   tfr       u,d       ; begin with the base position's low word
                    addd      $08,s     ; add the requested low offset
                    std       >$01A8,y  ; retain $01 a8
                    tfr       d,u       ; supply it to I$Seek
                    tfr       x,d       ; resume the base high word
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       ReturnSeekError ; select return seek error from the preceding condition
                    tfr       d,x       ; supply the high word to I$Seek
                    std       >$01A6,y  ; retain $01 a6
                    lda       $05,s     ; select the path number
                    os9       I$Seek    ; commit the calculated X:U position
                    bcs       ReturnSeekError ; carry reports failure: return seek error
                    leax      >$01A6,y  ; select $01 a6
                    puls      pc,u      ; preserve the flags or register state required by the following operation
                    fcb       $39
                    fcb       $8E
                    fcb       $00
                    fcb       $00
                    fcb       $5F
                    fcb       $10
                    fcb       $3F
                    fcb       $0A
                    fcb       $16
                    fcb       $00
                    fcb       $CD
                    fcc       "94`"
                    fcb       $AE
                    fcb       $66
                    fcb       $10
                    fcb       $AE
                    fcb       $68
                    fcb       $EE
                    fcb       $6A
                    fcb       $10
                    fcb       $3F
                    fcb       $17
                    fcb       $35
                    fcb       $E0
                    fcb       $A6
                    fcb       $63
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $0F
                    fcb       $10
                    fcb       $25
                    fcb       $00
                    fcb       $B3
                    fcb       $39
PauseOneTick        ldx       $02,s     ; recover $02
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbcs      ReturnOsError ; carry reports failure: return os error
                    tfr       x,d       ; transfer x,d
                    rts                 ; return to the caller
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $A4
                    fcb       $34
                    fcb       $06
                    fcb       $EC
                    fcb       $64
                    fcb       $10
                    fcb       $A3
                    fcb       $A9
                    fcb       $02
                    fcb       $F4
                    fcb       $25
                    fcb       $25
                    fcb       $E3
                    fcb       $A9
                    fcb       $01
                    fcb       $A4
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
                    fcb       $A4
                    fcb       $E3
                    fcb       $A9
                    fcb       $02
                    fcb       $F4
                    fcb       $A3
                    fcb       $E4
                    fcb       $ED
                    fcb       $A9
                    fcb       $02
                    fcb       $F4
                    fcb       $32
                    fcb       $62
                    fcb       $EC
                    fcb       $A9
                    fcb       $02
                    fcb       $F4
                    fcb       $34
                    fcb       $06
                    fcb       $A3
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $02
                    fcb       $F4
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $A4
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
                    fcb       $A4
                    fcb       $25
                    fcb       $F8
                    fcb       $35
                    fcb       $86
AllocateHeapBytes   ldd       $02,s     ; recover $02
                    addd      >$01AE,y  ; add to d using >$01AE,y
                    bcs       AllocationFailed ; carry reports failure: allocation failed
                    cmpd      >$01B0,y  ; test against $01 b0
                    bcc       AllocationFailed ; carry clear confirms success: allocation failed
                    pshs      d         ; retain the proposed heap boundary
                    ldx       >$01AE,y  ; recover $01 ae
                    clra                ; use zero as the allocator's initialization byte
CheckHeapCollision  cmpx      ,s        ; test against
                    bcc       CommitHeapEnd ; carry clear confirms success: commit heap end
                    sta       ,x+       ; clear one newly allocated byte
                    bra       CheckHeapCollision ; resume check heap collision
CommitHeapEnd       ldd       >$01AE,y  ; recover $01 ae
                    puls      x         ; recover the proposed new boundary
                    stx       >$01AE,y  ; retain $01 ae
                    rts                 ; return the completed result to the caller
AllocationFailed    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    rts                 ; return the completed result to the caller
InstallTerminalSignalHandler pshs      u         ; preserve u across the operation
                    tfr       y,u       ; transfer y,u
                    ldx       $04,s     ; recover $04
                    stx       >$02F6,y  ; retain $02 f6
                    leax      >EncodedPauseEntry,pc ; address encoded pause entry
                    os9       F$Icpt    ; install the signal-intercept routine at X
                    puls      u         ; restore u
                    lbra      ReturnOsResult ; resume return os result
EncodedPauseEntry   fcb       $1F
                    fcc       "2O4"
                    fcb       $06
                    fcb       $AD
                    fcb       $B9
                    fcb       $02
                    fcb       $F6
                    fcc       "2b;"     ; preserve encoded runtime table bytes
ReturnOsError       clra                ; widen OS-9's error byte in B
                    std       >$01B2,y  ; retain $01 b2
                    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    rts                 ; return the completed result to the caller
ReturnOsResult      bcs       ReturnOsError ; carry reports failure: return os error
                    clra                ; select standard input
                    clrb                ; return zero for a successful void-style wrapper
                    rts                 ; return the completed result to the caller
ExitProcess         lbsr      RunExitHook ; allow a linked application cleanup hook
                    lbsr      CloseAllStreams ; flush and close every active runtime stream
ExitWithStackStatus ldd       $02,s     ; recover $02
                    os9       F$Exit    ; terminate with its low byte in B
RunExitHook         rts                 ; default application cleanup hook does nothing
ReadPortCharacter   lda       $03,s     ; recover $03
                    ldb       #1        ; select status operation 1
                    os9       I$GetStt  ; query the selected path status
                    lbcs      ReturnOsError ; carry reports failure: return os error
                    clra                ; select standard input
                    rts                 ; return to the caller
SetPortReadTimeout  lda       $03,s     ; recover $03
                    ldb       #26       ; select status operation 26
                    ldx       $04,s     ; recover $04
                    os9       I$SetStt  ; apply the selected path status operation
                    lbra      ReturnOsResult ; resume return os result
PrepareTransferPort lda       $03,s     ; recover $03
                    ldb       #27       ; select status operation 27
                    os9       I$SetStt  ; apply the selected path status operation
                    lbra      ReturnOsResult ; resume return os result
                    fcb       $C6
                    fcb       $01
                    fcb       $20
                    fcb       $30
                    fcb       $C6
                    fcb       $03
                    fcb       $20
                    fcb       $2C
                    fcb       $C6
                    fcb       $04
                    fcb       $20
                    fcb       $28
                    fcb       $CC
                    fcb       $05
                    fcc       "  R"
                    fcb       $CC
                    fcb       $05
                    fcc       "! M"
                    fcb       $C6
                    fcb       $06
                    fcb       $20
                    fcb       $1A
                    fcb       $C6
                    fcb       $07
                    fcb       $20
                    fcb       $16
                    fcb       $C6
                    fcb       $08
                    fcb       $20
                    fcb       $12
                    fcb       $C6
                    fcb       $09
                    fcb       $20
                    fcb       $0E
                    fcb       $C6
                    fcb       $0A
                    fcb       $20
                    fcb       $0A
                    fcb       $C6
                    fcb       $0B
                    fcb       $20
                    fcb       $06
ClearTerminalScreen ldb       #12       ; initialize $02 f8 to 12
                    bra       SaveTerminalControlByte ; resume save terminal control byte
                    fcb       $C6
                    fcb       $0D
SaveTerminalControlByte stb       >$02F8,y  ; retain $02 f8
                    ldb       #1        ; supply 1 as the control, count, or argument value required here
                    lbra      EmitTerminalControl ; resume emit terminal control
InitializeTerminalDisplay ldd       #7968     ; supply 7968 as the control, count, or argument value required here
                    bra       SaveTerminalControlWord ; resume save terminal control word
PauseForBanner      ldd       #7969     ; supply 7969 as the control, count, or argument value required here
                    bra       SaveTerminalControlWord ; resume save terminal control word
                    fcb       $CC
                    fcb       $1F
                    fcb       $22
                    fcb       $20
                    fcb       $17
                    fcb       $CC
                    fcb       $1F
                    fcb       $23
                    fcb       $20
                    fcb       $12
                    fcb       $CC
                    fcb       $1F
                    fcb       $24
                    fcb       $20
                    fcb       $0D
                    fcb       $CC
                    fcb       $1F
                    fcb       $25
                    fcb       $20
                    fcb       $08
                    fcb       $CC
                    fcb       $1F
                    fcb       $30
                    fcb       $20
                    fcb       $03
                    fcb       $CC
                    fcb       $1F
                    fcb       $31
SaveTerminalControlWord std       >$02F8,y  ; retain $02 f8
                    ldb       #2        ; supply 2 as the control, count, or argument value required here
                    lbra      EmitTerminalControl ; resume emit terminal control
EmitTerminalControl clra                ; select standard input
                    leax      >$02F8,y  ; select $02 f8
                    pshs      y         ; preserve y across the operation
                    tfr       d,y       ; transfer d,y
                    lda       $05,s     ; recover $05
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y         ; restore y
                    bcs       TerminalControlWriteFailed ; carry reports failure: terminal control write failed
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    rts                 ; return to the caller
TerminalControlWriteFailed clra                ; select standard input
                    std       >$01B2,y  ; retain $01 b2
                    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    rts                 ; return to the caller
RuntimeInitializerImage fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $01
                    fcb       $63
                    fcb       $01
                    fcb       $06
                    fcb       $04
                    fcb       $15
                    fcb       $18
                    fcb       $27
                    fcb       $10
                    fcb       $03
                    fcb       $E8
                    fcb       $00
                    fcb       $64
                    fcb       $00
                    fcb       $0A
                    fcb       $00
                    fcb       $0E
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
                    fcb       $0E
                    fcc       "Terminal"
                    fcb       $00

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
