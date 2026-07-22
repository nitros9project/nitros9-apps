**********************************************************************
* suser - OS-9 Level 2 BBS command
*
* Syntax: suser <number> [command]
* Purpose: Adopt an OS-9 user number and run a command or shell.
* Restricted sysop utility for reproducing another caller access context.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Suser
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
RuntimeDescriptorTableRemainder rmb       338       ; remaining storage for the sixteen stream descriptors
StartupArgv0Pointer rmb       2         ; program-name pointer installed as argv[0]
StartupArgvVectorTail rmb       58        ; remaining argument-vector pointer slots
StartupArgcHigh     rmb       1         ; high byte adjoining compiler argument state
StartupArgumentState rmb       3         ; argc low byte and scanner bookkeeping
StartupParameterLength rmb       2         ; original OS-9 parameter length
RuntimeWorkspaceTail rmb       938       ; compiler globals and suser application frame
StreamDescriptorSize equ       RuntimeDescriptorTableRemainder ; thirteen-byte descriptor stride
size                equ       .

name                fcs       /Suser/
                    fcb       $01
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
                    leax      >$01CB,x  ; select $01 cb
                    pshs      x         ; retain the workspace-clear boundary
                    leay      >RuntimeInitializerImage,pc ; select data 001
                    ldx       ,y++      ; read the next initialized block length
                    beq       InitializeSecondDataBlock ; select branch 002 when the requested case matches
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    ldu       $02,s     ; recover $02
InitializeSecondDataBlock leau      >StreamCursor+1,u ; select work byte 002
                    ldx       ,y++      ; read the next initialized block length
                    beq       ClearRemainingWorkspace ; select branch 003 when the requested case matches
                    bsr       CopyInitializerBytes ; expand the described initialized bytes
                    clra                ; prepare a zero byte and a 256-byte loop count
ClearRemainingWorkspace cmpu      ,s        ; stop clearing when the workspace end is reached
CheckWorkspaceClearEnd beq       ApplyCodeRelocations ; begin relocation after all remaining BSS is zeroed
                    sta       ,u+       ; install it in the process workspace
                    bra       ClearRemainingWorkspace ; continue with branch 003
ApplyCodeRelocations ldu       $02,s     ; recover $02
                    ldd       ,y++      ; recover
                    beq       ApplyDataRelocations ; skip an empty code-reference relocation table
                    leax      >0,pc     ; use the module base as the relocation delta
                    lbsr      ApplyRelocationTable ; invoke routine 002
ApplyDataRelocations ldd       ,y++      ; recover
                    beq       ParseCommandLine ; begin argument parsing when no data relocations remain
                    leax      StreamCursor,u ; select work byte 001
                    lbsr      ApplyRelocationTable ; invoke routine 002
ParseCommandLine    leas      $04,s     ; release $04,s bytes of stack state
                    puls      x         ; recover the OS-9 parameter length
                    stx       >StartupParameterLength,u ; retain work word 006
                    sty       >StartupArgv0Pointer,u ; retain work word 005
                    ldd       #1        ; initialize work byte 006 to 1
                    std       >StartupArgcHigh,u ; retain work byte 006
                    leay      >StartupArgvVectorTail,u ; select work buffer 002
                    leax      ,s        ; point at OS-9's CR-terminated parameter text
                    lda       ,x+       ; prime the argument scanner with its first byte
ParseNextArgument   ldb       >StartupArgumentState,u ; recover work buffer 003
                    cmpb      #29       ; reserve the thirtieth argv slot for termination
                    beq       InvokeSuser ; stop parsing at the argument-vector capacity or CR
SkipArgumentDelimiters cmpa      #13       ; recognize the carriage-return terminator
                    beq       InvokeSuser ; stop parsing at the argument-vector capacity or CR
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
                    beq       InvokeSuser ; stop parsing at the argument-vector capacity or CR
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
InvokeSuser         leax      >StartupArgv0Pointer,u ; select work word 005
                    pshs      x         ; pass argv through the compiler calling convention
                    ldd       >StartupArgcHigh,u ; recover work byte 006
                    pshs      d         ; pass argc beside argv
                    leay      StreamCursor,u ; select work byte 001
                    bsr       InitializeRuntimeBounds ; invoke routine 003
                    lbsr      SuserMain ; invoke routine 004
                    clr       ,-s       ; push a zero process exit status
                    clr       ,-s       ; push a zero process exit status
                    lbsr      ExitProcess ; flush runtime state and terminate successfully
InitializeRuntimeBounds leax      >$01CB,y  ; select $01 cb
                    stx       >$01A9,y  ; retain $01 a9
                    sts       >$019D,y  ; record the initial C stack boundary
                    sts       >$01AB,y  ; record the current C stack low-water mark
                    ldd       #-126     ; supply failure or frame value -126 to the following operation
CheckStackSpace     leax      d,s       ; project the requested stack growth below the current S
                    cmpx      >$01AB,y  ; test against $01 ab
                    bcc       StackSpaceAvailable ; select branch 017 when carry remains clear
                    cmpx      >$01A9,y  ; test against $01 a9
                    bcs       AbortStackOverflow ; select branch 018 when carry reports an error or underflow
                    stx       >$01AB,y  ; retain $01 ab
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
                    lbsr      ExitWithStackStatus ; invoke routine 007
                    ldd       >$019D,y  ; recover $019 d
                    subd      >$01AB,y  ; subtract from d using >$01AB,y
                    rts                 ; return to the diagnostic caller
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $AB
                    fcb       $A3
                    fcb       $A9
                    fcb       $01
                    fcb       $A9
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
SuserMain           pshs      u         ; preserve the caller frame while the registration program runs
                    ldd       #-284     ; supply failure or frame value -284 to the following operation
                    lbsr      CheckStackSpace ; invoke routine 006
                    leas      >$FF34,s  ; release >$FF34,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       >$00D0,s  ; recover $00 d0
                    cmpd      #1        ; test against #1
                    bne       ValidateUserArgument ; select branch 020 when the requested case does not match
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >UsageMessage,pc ; select text 002
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      AbortCannotOpen ; print the diagnostic and terminate with the saved error
                    leas      $04,s     ; release $04,s bytes of stack state
ValidateUserArgument ldx       >$00D2,s  ; recover $00 d2
                    ldd       $02,x     ; recover $02
                    pshs      d         ; preserve d across the operation
                    lbsr      ParseUserNumber ; invoke routine 009
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       >$00CA,s  ; store d in the current stack frame at >$00CA,s
                    pshs      d         ; preserve d across the operation
                    lbsr      SetProcessUser ; invoke routine 010
                    leas      $02,s     ; release $02,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    bne       BuildCommandLine ; select branch 021 when the requested case does not match
                    ldd       >$01AD,y  ; recover $01 ad
                    pshs      d         ; preserve d across the operation
                    leax      >UserChangeDeniedMessage,pc ; select text 003
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      AbortCannotOpen ; invoke abort cannot open
                    leas      $04,s     ; release $04,s bytes of stack state
BuildCommandLine    ldd       #2        ; supply 2 as the control, count, or argument value required here
                    bra       AdvanceCommandArgument ; continue with branch 022
AppendCommandArgument ldd       >$00C8,s  ; recover $00 c8
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    ldx       >$00D2,s  ; recover $00 d2
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; address the local confirmation byte
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      AppendCString ; invoke routine 011
                    leas      $04,s     ; release $04,s bytes of stack state
                    leax      >SpaceString,pc ; select data 002
                    pshs      x         ; preserve x across the operation
                    leax      $02,s     ; select $02
                    pshs      x         ; preserve x across the operation
                    lbsr      AppendCString ; invoke routine 011
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >$00C8,s  ; recover $00 c8
                    addd      #1        ; add to d using #1
AdvanceCommandArgument std       >$00C8,s  ; store d in the current stack frame at >$00C8,s
                    ldd       >$00C8,s  ; recover $00 c8
                    cmpd      >$00D0,s  ; test against $00 d0
                    blt       AppendCommandArgument ; continue with branch 023 below the signed limit
                    leax      >CarriageReturnString,pc ; select data 003
                    pshs      x         ; preserve x across the operation
                    leax      $02,s     ; select $02
                    pshs      x         ; preserve x across the operation
                    lbsr      AppendCString ; invoke routine 011
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #3        ; supply 3 as the control, count, or argument value required here
                    pshs      d         ; pass the current value as a word-sized argument
                    ldd       #1        ; supply 1 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    ldd       #16       ; supply 16 as the control, count, or argument value required here
                    pshs      d         ; preserve d across the operation
                    leax      $06,s     ; select $06
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      $08,s     ; select $08
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      MeasureCString ; invoke measure cstring
                    std       ,s        ; store d in the current stack frame at ,s
                    leax      >DefaultShellName,pc ; select text 004
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ForkSelectedProgram ; invoke routine 013
                    leas      $0C,s     ; release $0C,s bytes of stack state
                    leas      >$00CC,s  ; release >$00CC,s bytes of stack state
                    puls      pc,u      ; restore the caller frame and return
AbortCannotOpen     pshs      u         ; preserve the caller frame for fatal error reporting
                    ldd       #-72      ; supply failure or frame value -72 to the following operation
                    lbsr      CheckStackSpace ; invoke routine 006
                    ldd       $04,s     ; recover $04
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >StringLineFormat,pc ; select data 004
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; invoke routine 014
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       $06,s     ; recover $06
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ExitProcess ; terminate with the open failure status
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore the caller frame and return
UsageMessage        fcc       "Usage is: Suser <number> [progname]"
                    fcb       $00
UserChangeDeniedMessage fcc       "Sorry, you cannot change the user number"
                    fcb       $00
SpaceString         fcb       $20
                    fcb       $00
CarriageReturnString fcb       $0D
                    fcb       $00
DefaultShellName    fcc       "Shell"
                    fcb       $0D
                    fcb       $00
StringLineFormat    fcb       $25
                    fcb       $73
                    fcb       $0D
                    fcb       $00
PrintFormatted      pshs      u         ; preserve the caller's descriptor pointer
                    leax      >$001B,y  ; select $001 b
                    stx       >$01AF,y  ; retain $01 af
                    leax      $06,s     ; select $06
                    pshs      x         ; preserve x across the operation
                    ldd       $06,s     ; recover $06
                    bra       InvokeFormatEngine ; continue with invoke format engine
                    fcb       $34
                    fcb       $40
                    fcb       $EC
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $01
                    fcb       $AF
                    fcc       "0h4"
                    fcb       $10
                    fcb       $EC
                    fcb       $68
InvokeFormatEngine  pshs      d         ; preserve d across the operation
                    leax      >EncodedFormatWrapper,pc ; select data 005
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
                    fcb       $01
                    fcb       $AF
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
                    fcb       $01
                    fcb       $AF
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
                    jsr       [<$11,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
ScanFormatString    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; recognize 37 as a meaningful value in this parser state
                    bne       EmitLiteralFormatByte ; select emit literal format byte when the requested case does not match
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; recover $08
                    cmpb      #45       ; recognize 45 as a meaningful value in this parser state
                    bne       NoLeftJustifyFlag ; select branch 028 when the requested case does not match
                    ldd       #1        ; initialize $01 c5 to 1
                    std       >$01C5,y  ; retain $01 c5
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       SelectFormatPadding ; continue with select format padding
NoLeftJustifyFlag   clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >$01C5,y  ; retain $01 c5
SelectFormatPadding ldb       $08,s     ; recover $08
                    cmpb      #48       ; recognize or generate ASCII zero
                    bne       UseSpacePadding ; select use space padding when the requested case does not match
                    ldd       #48       ; recognize or generate ASCII zero
                    bra       SaveFormatPadding ; continue with branch 031
UseSpacePadding     ldd       #32       ; recognize the first printable ASCII value
SaveFormatPadding   std       >$01C7,y  ; retain $01 c7
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
                    cmpb      #46       ; recognize 46 as a meaningful value in this parser state
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
                    lbsr      ConvertHexadecimal ; invoke routine 019
                    lbra      RestoreFormatStack ; continue with restore format stack
FormatUnsignedDecimal ldd       $06,s     ; recover $06
                    pshs      d         ; preserve d across the operation
                    ldx       <$0015,s  ; recover $0015
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; preserve d across the operation
                    leax      >$01B1,y  ; select $01 b1
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
                    jsr       [<$11,s]  ; emit the next field byte through the caller-selected callback
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
                    leax      >$01B1,y  ; select $01 b1
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; recover $06
                    bge       ConvertSignedMagnitude ; continue with convert signed magnitude at or above the signed limit
                    ldd       $06,s     ; recover $06
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       PrefixMinusSign ; continue with prefix minus sign at or above the signed limit
                    leax      >MinimumSignedText,pc ; select text 005
                    pshs      x         ; preserve x across the operation
                    leax      >$01B1,y  ; select $01 b1
                    pshs      x         ; preserve x across the operation
                    lbsr      CopyCString ; invoke copy cstring
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReturnConversionBuffer ; continue with branch 062
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
                    lbra      ReturnNumericBuffer ; continue with branch 063
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
                    stb       StreamCursor,u ; retain work byte 001
                    ldd       $0A,s     ; recover $0 a
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertOctal        pshs      u,d       ; save u,d on the stack
                    leax      >$01B1,y  ; select $01 b1
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$01BB,y  ; select $01 bb
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
CopyOctalDigit      ldb       StreamCursor,u ; recover work byte 001
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseOctalDigits  leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$01BB,y  ; select $01 bb
                    cmpx      ,s++      ; test against
                    bls       CopyOctalDigit ; continue copy octal digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [,s]      ; store b in the current stack frame at [,s]
ReturnNumericBuffer leax      >$01B1,y  ; select $01 b1
                    tfr       x,d       ; transfer x,d
ReturnConversionBuffer leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertHexadecimal  pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$01B1,y  ; select $01 b1
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$01BB,y  ; select $01 bb
ExtractHexDigit     ldd       $08,s     ; recover $08
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; preserve d across the operation
                    ldd       $02,s     ; recover $02
                    cmpd      #9        ; test against #9
                    ble       UseNumericHexDigit ; continue at UseNumericHexDigit when the signed value is at or below the limit
                    ldd       $0C,s     ; recover $0 c
                    beq       UseLowercaseHexBase ; select use lowercase hex base when the requested case matches
                    ldd       #65       ; supply 65 as the control, count, or argument value required here
                    bra       AdjustHexAlphabeticDigit ; continue with adjust hex alphabetic digit
UseLowercaseHexBase ldd       #97       ; supply 97 as the control, count, or argument value required here
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
CopyHexDigit        ldb       StreamCursor,u ; recover work byte 001
                    ldx       $02,s     ; recover $02
                    leax      $01,x     ; select $01
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseHexDigits    leau      -$01,u    ; select -$01
                    pshs      u         ; preserve u across the operation
                    leax      >$01BB,y  ; select $01 bb
                    cmpx      ,s++      ; test against
                    bls       CopyHexDigit ; continue copy hex digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$01B1,y  ; select $01 b1
                    tfr       x,d       ; transfer x,d
                    lbra      ReturnFormattedBuffer ; continue with return formatted buffer
WritePaddedField    pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    ldd       $0A,s     ; recover $0 a
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$01C5,y  ; recover $01 c5
                    bne       EmitFieldBytes ; select emit field bytes when the requested case does not match
                    bra       EmitLeadingPadding ; continue with emit leading padding
EmitLeadingPadByte  ldd       >$01C7,y  ; recover $01 c7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitLeadingPadding  ldd       $0A,s     ; recover $0 a
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitLeadingPadByte ; continue at EmitLeadingPadByte when the signed value is above the limit
                    bra       EmitFieldBytes ; continue with emit field bytes
EmitNextFieldByte   ldb       ,u+       ; consume the next byte while emit next field byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitFieldBytes      ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       EmitNextFieldByte ; select emit next field byte when the requested case does not match
                    ldd       >$01C5,y  ; recover $01 c5
                    beq       ReturnPaddedField ; select return padded field when the requested case matches
                    bra       EmitTrailingPadding ; continue with emit trailing padding
EmitTrailingPadByte ldd       >$01C7,y  ; recover $01 c7
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
                    lbsr      MeasureCString ; invoke measure cstring
                    leas      $02,s     ; release $02,s bytes of stack state
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$01C5,y  ; recover $01 c5
                    bne       EmitStringBytes ; select emit string bytes when the requested case does not match
                    bra       EmitStringLeadingPadding ; continue with emit string leading padding
EmitStringLeadingPadByte ldd       >$01C7,y  ; recover $01 c7
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringLeadingPadding ldd       $08,s     ; recover $08
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       EmitStringLeadingPadByte ; continue at EmitStringLeadingPadByte when the signed value is above the limit
                    bra       EmitStringBytes ; continue with emit string bytes
EmitNextStringByte  ldb       ,u+       ; consume the next byte while emit next string byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; preserve d across the operation
                    jsr       [<$06,s]  ; emit the next field byte through the caller-selected callback
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringBytes     ldb       StreamCursor,u ; recover work byte 001
                    bne       EmitNextStringByte ; select emit next string byte when the requested case does not match
                    ldd       >$01C5,y  ; recover $01 c5
                    beq       ReturnPaddedString ; select return padded string when the requested case matches
                    bra       EmitStringTrailingPadding ; continue with emit string trailing padding
EmitStringTrailingPadByte ldd       >$01C7,y  ; recover $01 c7
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
                    fcb       $01
                    fcb       $AF
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
                    fcb       $01
                    fcb       $AF
                    fcb       $30
                    fcb       $01
                    fcb       $AF
                    fcb       $A9
                    fcb       $01
                    fcb       $AF
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
                    fcb       $01
                    fcb       $F9
                    fcb       $32
                    fcb       $62
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
                    fcb       $05
                    fcb       $62
                    fcb       $20
                    fcb       $04
                    fcb       $30
                    fcb       $8D
                    fcb       $05
                    fcb       $43
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
                    fcb       $03
                    fcb       $98
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
CloseAllStreams     pshs      u,d       ; preserve U and allocate a word-sized slot index
                    leau      >$000E,y  ; select $000 e
                    clra                ; initialize the slot index to zero
                    clrb                ; complete the zero slot index
                    std       ,s        ; retain the index in the local stack word
                    bra       CheckNextStreamSlot ; continue with branch 096
CloseNextStreamSlot tfr       u,d       ; pass the current descriptor address
                    leau      RuntimeDescriptorTableRemainder,u ; select work buffer 001
                    pshs      d         ; pass the descriptor being closed
                    bsr       CloseStream ; invoke routine 027
                    leas      $02,s     ; release $02,s bytes of stack state
CheckNextStreamSlot ldd       ,s        ; recover
                    addd      #1        ; prepare the following index
                    std       ,s        ; retain it for the next iteration
                    subd      #1        ; restore the index being tested now
                    cmpd      #16       ; test against #16
                    blt       CloseNextStreamSlot ; continue with branch 097 below the signed limit
                    lbra      StreamOperationDone ; return through the shared stream epilogue
CloseStream         pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    cmpu      #0        ; detect a null runtime allocation result
                    beq       RejectCloseRequest ; a null pointer cannot be closed
                    ldd       StreamFlags,u ; recover work word 003
                    bne       CloseActiveStream ; nonzero flags identify an occupied slot
RejectCloseRequest  ldd       #-1       ; supply failure or frame value -1 to the following operation
                    lbra      StreamOperationDone ; unwind the local result word
CloseActiveStream   ldd       StreamFlags,u ; recover work word 003
                    clra                ; inspect only low-byte access flags
                    andb      #2        ; mask b using #2
                    beq       SkipCloseFlush ; read-only streams have no pending output
                    pshs      u         ; flush pending output before releasing the path
                    bsr       FlushStream ; invoke routine 028
                    leas      $02,s     ; release $02,s bytes of stack state
                    bra       CloseUnderlyingPath ; continue with branch 102
SkipCloseFlush      clra                ; prepare a successful zero result
                    clrb                ; a read-only stream has no write error to report
CloseUnderlyingPath std       ,s        ; preserve the flush result across I$Close
                    ldd       StreamPath,u ; recover work byte 003
                    pshs      d         ; release the underlying OS-9 path
                    lbsr      ClosePath ; invoke routine 029
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; clear the descriptor flags as a word
                    clrb                ; mark the table entry inactive
                    std       StreamFlags,u ; retain work word 003
                    ldd       ,s        ; recover
                    bra       StreamOperationDone ; return the saved flush result
FlushStream         pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    beq       RejectFlushRequest ; select branch 103 when the requested case matches
                    ldd       StreamFlags,u ; recover work word 003
                    clra                ; ignore high-byte orientation state
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; test against #2
                    beq       PrepareStreamFlush ; select branch 104 when the requested case matches
RejectFlushRequest  ldd       #-1       ; supply failure or frame value -1 to the following operation
                    puls      pc,u      ; reject null, read-only, or failed streams
PrepareStreamFlush  ldd       StreamFlags,u ; recover work word 003
                    anda      #128      ; mask a using #128
                    clrb                ; form a word-sized initialization test
                    std       -$02,s    ; use the compiler spill slot only for the flag test
                    bne       FlushAssignedBuffer ; select branch 105 when the requested case does not match
                    pshs      u         ; pass the descriptor to lazy initialization
                    lbsr      InitializeStreamBuffer ; invoke routine 030
                    leas      $02,s     ; release $02,s bytes of stack state
FlushAssignedBuffer pshs      u         ; pass the prepared descriptor to the buffer flusher
                    bsr       FlushBufferedStream ; invoke routine 031
StreamOperationDone leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore U and return the operation status
FlushBufferedStream pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    leas      -$04,s    ; release -$04,s bytes of stack state
                    ldd       StreamFlags,u ; recover work word 003
                    anda      #1        ; mask a using #1
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the test value below the compiler frame
                    bne       ComputePendingOutput ; select branch 106 when the requested case does not match
                    ldd       StreamCursor,u ; recover work byte 001
                    cmpd      StreamBufferEnd,u ; test against work word 002
                    beq       ComputePendingOutput ; select branch 106 when the requested case matches
                    clra                ; build a zero position-query argument
                    clrb                ; complete the zero word
                    pshs      d         ; request the runtime's current logical position
                    pshs      u         ; pass the descriptor to the position hook
                    lbsr      NoOpStreamPositionHook ; invoke routine 032
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $02,x     ; recover $02
                    pshs      d         ; pass the returned low position word
                    ldd       ,x        ; recover
                    pshs      d         ; pass the returned high position word
                    ldd       StreamPath,u ; recover work byte 003
                    pshs      d         ; pass the path number
                    lbsr      SeekPath  ; invoke routine 033
                    leas      $08,s     ; release $08,s bytes of stack state
ComputePendingOutput ldd       StreamCursor,u ; recover work byte 001
                    subd      StreamBufferStart,u ; subtract from d using StreamBufferStart,u
                    std       $02,s     ; retain the number of buffered bytes
                    lbeq      ResetFlushedStream ; nothing has been accumulated
                    ldd       StreamFlags,u ; recover work word 003
                    anda      #1        ; mask a using #1
                    clrb                ; form the word-sized orientation test
                    std       -$02,s    ; preserve it in the compiler spill slot
                    lbeq      ResetFlushedStream ; discard cached input rather than writing it
                    ldd       StreamFlags,u ; recover work word 003
                    clra                ; inspect only low-byte buffering flags
                    andb      #64       ; mask b using #64
                    beq       WriteBlockBuffer ; ordinary buffers use one bulk write
                    ldd       StreamBufferStart,u ; recover work word 001
                    bra       UpdateWriteCursor ; seed the line-write cursor
WriteNextLineFragment ldd       $02,s     ; recover $02
                    pshs      d         ; pass the remaining byte count
                    ldd       StreamCursor,u ; recover work byte 001
                    pshs      d         ; pass the first unwritten byte
                    ldd       StreamPath,u ; recover work byte 003
                    pshs      d         ; pass it to the line-write wrapper
                    lbsr      WriteLineBytes ; invoke routine 034
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; retain the number written or -1
                    cmpd      #-1       ; test against #-1
                    bne       AdvanceAfterLineWrite ; select branch 111 when the requested case does not match
                    leax      $04,s     ; preserve the compiler's error-frame restoration
                    bra       RestoreFailedWriteFrame ; continue with branch 112
AdvanceAfterLineWrite ldd       $02,s     ; recover $02
                    subd      ,s        ; remove the completed portion from the remainder
                    std       $02,s     ; retain the reduced count
                    ldd       StreamCursor,u ; recover work byte 001
                    addd      ,s        ; advance to the next unwritten byte
UpdateWriteCursor   std       StreamCursor,u ; retain work byte 001
                    ldd       $02,s     ; recover $02
                    bne       WriteNextLineFragment ; select branch 110 when the requested case does not match
                    bra       ResetFlushedStream ; all line fragments reached OS-9
WriteBlockBuffer    ldd       $02,s     ; recover $02
                    pshs      d         ; write the entire pending block in one call
                    ldd       StreamBufferStart,u ; recover work word 001
                    pshs      d         ; pass the source address
                    ldd       StreamPath,u ; recover work byte 003
                    pshs      d         ; pass the path number
                    lbsr      WriteBytes ; invoke routine 035
                    leas      $06,s     ; release $06,s bytes of stack state
                    cmpd      $02,s     ; test against $02
                    beq       ResetFlushedStream ; accept only a complete block write
                    bra       MarkStreamWriteError ; continue with branch 113
RestoreFailedWriteFrame leas      -$04,x    ; release -$04,x bytes of stack state
MarkStreamWriteError ldd       StreamFlags,u ; recover work word 003
                    orb       #32       ; set selected bits in b using #32
                    std       StreamFlags,u ; retain work word 003
                    ldd       StreamBufferEnd,u ; recover work word 002
                    std       StreamCursor,u ; retain work byte 001
                    ldd       #-1       ; initialize work word 003 to -1
                    bra       ReturnFlushStatus ; release locals and return failure
ResetFlushedStream  ldd       StreamFlags,u ; recover work word 003
                    ora       #1        ; set selected bits in a using #1
                    std       StreamFlags,u ; retain work word 003
                    ldd       StreamBufferStart,u ; recover work word 001
                    std       StreamCursor,u ; retain work byte 001
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEnd,u ; retain work word 002
                    clra                ; prepare a successful zero result
                    clrb                ; report a successful flush
ReturnFlushStatus   leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore U and return the flush status
NoOpStreamPositionHook pshs      u         ; preserve the calling convention's U value
                    puls      pc,u      ; return without disturbing the position pointer
InitializeStreamBuffer pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; recover $04
                    ldd       StreamFlags,u ; recover work word 003
                    clra                ; widen the byte to a positive compiler integer
                    andb      #192      ; mask b using #192
                    bne       BufferingModeSelected ; select branch 115 when the requested case does not match
                    leas      -$20,s    ; release -$20,s bytes of stack state
                    leax      ,s        ; point X at its first byte
                    pshs      x         ; pass the option-table destination
                    ldd       StreamPath,u ; recover work byte 003
                    pshs      d         ; preserve the status-call argument order
                    clra                ; request base option status code zero
                    clrb                ; complete selector zero
                    pshs      d         ; request the path's base option status
                    lbsr      GetPathStatus ; invoke routine 036
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       StreamFlags,u ; recover work word 003
                    pshs      d         ; preserve existing state during policy selection
                    ldb       $02,s     ; device type zero identifies an SCF-style terminal
                    bne       SelectFullBuffering ; select branch 116 when the requested case does not match
                    ldd       #64       ; supply 64 as the control, count, or argument value required here
                    bra       SaveBufferingMode ; continue with branch 117
SelectFullBuffering ldd       #128      ; initialize work word 003 to 128
SaveBufferingMode   ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       StreamFlags,u ; retain work word 003
                    leas      <$0020,s  ; release <$0020,s bytes of stack state
BufferingModeSelected ldd       StreamFlags,u ; recover work word 003
                    ora       #128      ; set selected bits in a using #128
                    std       StreamFlags,u ; retain work word 003
                    clra                ; inspect the already-configured storage flags
                    andb      #12       ; mask b using #12
                    beq       ChooseBufferSize ; allocate only when no storage exists
                    puls      pc,u      ; an existing buffer configuration is ready
ChooseBufferSize    ldd       StreamBufferSize,u ; recover work word 004
                    bne       EnsureBufferStorage ; select branch 119 when the requested case does not match
                    ldd       StreamFlags,u ; recover work word 003
                    clra                ; inspect the low-byte line flag
                    andb      #64       ; mask b using #64
                    beq       ChooseBlockBufferSize ; select branch 120 when the requested case matches
                    ldd       #128      ; initialize work word 004 to 128
                    bra       SaveDefaultBufferSize ; continue with branch 121
ChooseBlockBufferSize ldd       #256      ; initialize work word 004 to 256
SaveDefaultBufferSize std       StreamBufferSize,u ; retain work word 004
EnsureBufferStorage ldd       StreamBufferStart,u ; recover work word 001
                    bne       MarkBufferAvailable ; select branch 122 when the requested case does not match
                    ldd       StreamBufferSize,u ; recover work word 004
                    pshs      d         ; pass the allocation size
                    lbsr      AllocateHeapBytes ; invoke routine 037
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       StreamBufferStart,u ; retain work word 001
                    cmpd      #-1       ; test against #-1
                    beq       UseFallbackByteBuffer ; select branch 123 when the requested case matches
MarkBufferAvailable ldd       StreamFlags,u ; recover work word 003
                    orb       #8        ; set selected bits in b using #8
                    std       StreamFlags,u ; retain work word 003
                    bra       ResetBufferWindow ; initialize its empty bounds
UseFallbackByteBuffer ldd       StreamFlags,u ; recover work word 003
                    orb       #4        ; set selected bits in b using #4
                    std       StreamFlags,u ; retain work word 003
                    leax      StreamPushbackByte,u ; select work byte 005
                    stx       StreamBufferStart,u ; retain work word 001
                    ldd       #1        ; initialize work word 004 to 1
                    std       StreamBufferSize,u ; retain work word 004
ResetBufferWindow   ldd       StreamBufferStart,u ; recover work word 001
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEnd,u ; retain work word 002
                    std       StreamCursor,u ; retain work byte 001
                    puls      pc,u      ; restore U with buffering ready
SelectIntegerArgument pshs      u         ; preserve u across the operation
                    ldb       $05,s     ; recover $05
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    bra       ClassifyIntegerConversion ; continue with classify integer conversion
FetchLongIntegerArgument ldd       [<$06,s]  ; recover [<$06
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >EmptyIntegerText,pc ; select data 006
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
                    leax      >EmptyString,pc ; select data 007
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
                    bra       ReturnCopiedString ; continue with branch 131
AppendCString       pshs      u         ; preserve u across the operation
                    ldu       $06,s     ; recover $06
                    leas      -$02,s    ; release -$02,s bytes of stack state
                    ldd       $06,s     ; recover $06
                    std       ,s        ; store d in the current stack frame at ,s
FindAppendEnd       ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldb       -$01,x    ; recover -$01
                    bne       FindAppendEnd ; select branch 132 when the requested case does not match
                    ldd       ,s        ; recover
                    addd      #-1       ; add to d using #-1
                    std       ,s        ; store d in the current stack frame at ,s
AppendCStringByte   ldb       ,u+       ; consume the next byte while branch 133
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
                    bne       AppendCStringByte ; select branch 133 when the requested case does not match
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
ParseUserNumber     pshs      u         ; preserve u across the operation
                    ldu       $04,s     ; recover $04
                    leas      -$05,s    ; release -$05,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $01,s     ; store d in the current stack frame at $01,s
SkipLeadingWhitespace ldb       ,u+       ; consume the next byte while branch 134
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #32       ; recognize the first printable ASCII value
                    beq       SkipLeadingWhitespace ; select branch 134 when the requested case matches
                    ldb       ,s        ; recover
                    cmpb      #9        ; recognize 9 as a meaningful value in this parser state
                    lbeq      SkipLeadingWhitespace ; select branch 134 when the requested case matches
                    ldb       ,s        ; recover
                    cmpb      #45       ; recognize 45 as a meaningful value in this parser state
                    bne       PositiveNumber ; select branch 135 when the requested case does not match
                    ldd       #1        ; initialize $03 to 1
                    bra       SaveNumericSign ; continue with branch 136
PositiveNumber      clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
SaveNumericSign     std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       ,s        ; recover
                    cmpb      #45       ; recognize 45 as a meaningful value in this parser state
                    beq       ConsumeNumericByte ; select branch 137 when the requested case matches
                    ldb       ,s        ; recover
                    cmpb      #43       ; recognize 43 as a meaningful value in this parser state
                    bne       TestNumericByte ; select branch 138 when the requested case does not match
                    bra       ConsumeNumericByte ; continue with branch 137
AccumulateDecimalDigit ldd       $01,s     ; recover $01
                    pshs      d         ; preserve d across the operation
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; invoke multiply unsigned words
                    pshs      d         ; preserve d across the operation
                    ldb       $02,s     ; recover $02
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
ConsumeNumericByte  ldb       ,u+       ; consume the next byte while branch 137
                    stb       ,s        ; store b in the current stack frame at ,s
TestNumericByte     ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; select $00 df
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulateDecimalDigit ; select branch 139 when the requested case does not match
                    ldd       $03,s     ; recover $03
                    beq       ReturnPositiveNumber ; select branch 140 when the requested case matches
                    ldd       $01,s     ; recover $01
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       ReturnParsedNumber ; continue with branch 141
ReturnPositiveNumber ldd       $01,s     ; recover $01
ReturnParsedNumber  leas      $05,s     ; release $05,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
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
                    beq       GetRegisterPathStatus ; select branch 146 when the requested case matches
                    cmpb      #6        ; selector six also needs no result-buffer translation
                    beq       GetRegisterPathStatus ; select branch 146 when the requested case matches
                    cmpb      #2        ; recognize 2 as a meaningful value in this parser state
                    beq       GetLongPathStatus ; select get long path status when the requested case matches
                    cmpb      #5        ; recognize 5 as a meaningful value in this parser state
                    beq       GetLongPathStatus ; select get long path status when the requested case matches
                    ldb       #208      ; select status operation 208
                    lbra      ReturnOsError ; continue with branch 148
GetLongPathStatus   pshs      u         ; preserve the compiler workspace register
                    os9       I$GetStt  ; obtain the requested 32-bit value in X:U
                    bcc       StoreLongStatusResult ; select branch 149 when carry remains clear
                    puls      u         ; restore U before translating the OS-9 error
                    lbra      ReturnOsError ; continue with branch 148
StoreLongStatusResult stx       [<$08,s]  ; store the high word through the shifted result pointer
                    ldx       $08,s     ; recover that result pointer
                    stu       $02,x     ; retain $02
                    puls      u         ; restore the compiler workspace register
                    clra                ; return zero after a successful status query
                    clrb                ; clear the byte accumulator for counting
                    rts                 ; return the completed result to the caller
GetStatusIntoBuffer ldx       $06,s     ; supply the caller's option-table buffer
GetRegisterPathStatus os9       I$GetStt  ; perform the selector-specific status request
                    lbra      ReturnOsResult ; continue with branch 150
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
                    fcb       $02
                    fcb       $8E
                    fcb       $AE
                    fcb       $66
                    fcb       $10
                    fcb       $3F
                    fcb       $8E
                    fcb       $16
                    fcb       $02
                    fcb       $8F
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
                    fcb       $02
                    fcb       $81
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
                    fcb       $02
                    fcb       $72
                    fcb       $AE
                    fcb       $62
                    fcb       $A6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $84
                    fcb       $10
                    fcb       $25
                    fcb       $02
                    fcb       $5E
                    fcb       $1F
                    fcb       $89
                    fcb       $4F
                    fcb       $39
ClosePath           lda       $03,s     ; select the path argument
                    os9       I$Close   ; flush and release the OS-9 path
                    lbra      ReturnOsResult ; continue with branch 150
                    fcb       $AE
                    fcb       $62
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $85
                    fcb       $16
                    fcb       $02
                    fcb       $51
                    fcb       $AE
                    fcb       $62
                    fcb       $A6
                    fcb       $65
                    fcb       $1F
                    fcb       $89
                    fcb       $C4
                    fcb       $24
                    fcb       $CA
                    fcb       $0B
                    fcb       $10
                    fcb       $3F
                    fcb       $83
                    fcb       $25
                    fcb       $04
                    fcb       $1F
                    fcb       $89
                    fcb       $4F
                    fcb       $39
                    fcb       $C1
                    fcb       $DA
                    fcb       $10
                    fcb       $26
                    fcb       $02
                    fcb       $2F
                    fcb       $A6
                    fcb       $65
                    fcb       $85
                    fcb       $80
                    fcb       $10
                    fcb       $26
                    fcb       $02
                    fcb       $27
                    fcb       $84
                    fcb       $07
                    fcb       $AE
                    fcb       $62
                    fcb       $10
                    fcb       $3F
                    fcb       $84
                    fcb       $10
                    fcb       $25
                    fcb       $02
                    fcb       $1C
                    fcb       $34
                    fcb       $42
                    fcb       $8E
                    fcb       $00
                    fcb       $00
                    fcb       $33
                    fcb       $84
                    fcb       $C6
                    fcb       $02
                    fcb       $10
                    fcb       $3F
                    fcb       $8E
                    fcc       "5B$"
                    fcb       $D3
                    fcb       $34
                    fcb       $04
                    fcb       $10
                    fcb       $3F
                    fcb       $8F
                    fcb       $35
                    fcb       $04
                    fcb       $16
                    fcb       $02
                    fcb       $02
                    fcb       $AE
                    fcb       $62
                    fcb       $10
                    fcb       $3F
                    fcb       $87
                    fcb       $16
                    fcb       $02
                    fcb       $03
                    fcb       $A6
                    fcb       $63
                    fcb       $10
                    fcb       $3F
                    fcb       $82
                    fcb       $10
                    fcb       $25
                    fcb       $01
                    fcb       $F1
                    fcb       $1F
                    fcb       $89
                    fcc       "O94 "
                    fcb       $AE
                    fcb       $66
                    fcb       $A6
                    fcb       $65
                    fcb       $10
                    fcb       $AE
                    fcc       "h4 "
                    fcb       $10
                    fcb       $3F
                    fcb       $89
                    fcb       $24
                    fcb       $0D
                    fcb       $C1
                    fcb       $D3
                    fcb       $26
                    fcb       $04
                    fcc       "O_5"
                    fcb       $B0
                    fcb       $35
                    fcb       $30
                    fcb       $16
                    fcb       $01
                    fcb       $D0
                    fcb       $1F
                    fcb       $20
                    fcb       $35
                    fcb       $B0
                    fcb       $34
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
WriteBytes          pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the transfer length
                    beq       ReturnWriteCount ; select branch 151 when the requested case matches
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the source buffer
                    os9       I$Write   ; perform an unstructured byte write
FinishWrite         bcc       ReturnWriteCount ; select branch 151 when carry remains clear
                    puls      y         ; restore Y before the shared error path
                    lbra      ReturnOsError ; continue with branch 148
ReturnWriteCount    tfr       y,d       ; return the actual transfer count
                    puls      pc,y      ; preserve the flags or register state required by the following operation
WriteLineBytes      pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the maximum line length
                    beq       ReturnWriteCount ; select branch 151 when the requested case matches
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the CR-terminated source line
                    os9       I$WritLn  ; write through the first carriage return
                    bra       FinishWrite ; reuse normal/error result conversion
SeekPath            pshs      u         ; preserve U for the 32-bit OS-9 offset
                    ldd       $0A,s     ; recover $0 a
                    bne       SelectSeekOrigin ; select branch 153 when the requested case does not match
                    ldu       #0        ; initialize the pointer or index for this state transition
                    ldx       #0        ; initialize the pointer or index for this state transition
                    bra       ComputeSeekTarget ; continue with branch 154
SelectSeekOrigin    cmpd      #1        ; test against #1
                    beq       SeekRelativeCurrent ; select branch 155 when the requested case matches
                    cmpd      #2        ; test against #2
                    beq       SeekRelativeEnd ; select branch 156 when the requested case matches
                    ldb       #247      ; initialize $01 ad to 247
ReturnSeekError     clra                ; widen the OS-9 error to a compiler word
                    std       >$01AD,y  ; retain $01 ad
                    ldd       #-1       ; initialize  to -1
                    leax      >$01A1,y  ; select $01 a1
                    std       ,x        ; preserve the flags or register state required by the following operation
                    std       $02,x     ; preserve the flags or register state required by the following operation
                    puls      pc,u      ; preserve the flags or register state required by the following operation
SeekRelativeEnd     lda       $05,s     ; select the path number
                    ldb       #2        ; select status operation 2
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       ReturnSeekError ; select branch 157 when carry reports an error or underflow
                    bra       ComputeSeekTarget ; continue with branch 154
SeekRelativeCurrent lda       $05,s     ; select the path number
                    ldb       #5        ; select status operation 5
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       ReturnSeekError ; select branch 157 when carry reports an error or underflow
ComputeSeekTarget   tfr       u,d       ; begin with the base position's low word
                    addd      $08,s     ; add the requested low offset
                    std       >$01A3,y  ; retain $01 a3
                    tfr       d,u       ; supply it to I$Seek
                    tfr       x,d       ; continue with the base high word
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       ReturnSeekError ; select branch 157 from the preceding condition
                    tfr       d,x       ; supply the high word to I$Seek
                    std       >$01A1,y  ; retain $01 a1
                    lda       $05,s     ; select the path number
                    os9       I$Seek    ; commit the calculated X:U position
                    bcs       ReturnSeekError ; select branch 157 when carry reports an error or underflow
                    leax      >$01A1,y  ; select $01 a1
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
                    fcb       $01
                    fcb       $C9
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
                    fcb       $01
                    fcb       $C9
                    fcb       $A3
                    fcb       $E4
                    fcb       $ED
                    fcb       $A9
                    fcb       $01
                    fcb       $C9
                    fcb       $32
                    fcb       $62
                    fcb       $EC
                    fcb       $A9
                    fcb       $01
                    fcb       $C9
                    fcb       $34
                    fcb       $06
                    fcb       $A3
                    fcb       $64
                    fcb       $ED
                    fcb       $A9
                    fcb       $01
                    fcb       $C9
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
AllocateHeapBytes   ldd       $02,s     ; recover $02
                    addd      >$01A9,y  ; add to d using >$01A9,y
                    bcs       AllocationFailed ; select branch 158 when carry reports an error or underflow
                    cmpd      >$01AB,y  ; test against $01 ab
                    bcc       AllocationFailed ; select branch 158 when carry remains clear
                    pshs      d         ; retain the proposed heap boundary
                    ldx       >$01A9,y  ; recover $01 a9
                    clra                ; use zero as the allocator's initialization byte
CheckHeapCollision  cmpx      ,s        ; test against
                    bcc       CommitHeapEnd ; select branch 160 when carry remains clear
                    sta       ,x+       ; clear one newly allocated byte
                    bra       CheckHeapCollision ; continue with branch 159
CommitHeapEnd       ldd       >$01A9,y  ; recover $01 a9
                    puls      x         ; recover the proposed new boundary
                    stx       >$01A9,y  ; retain $01 a9
                    rts                 ; return the completed result to the caller
AllocationFailed    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    rts                 ; return the completed result to the caller
                    fcb       $A6
                    fcb       $63
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $08
                    fcb       $16
                    fcb       $00
                    fcb       $A7
                    fcb       $4F
                    fcb       $5F
                    fcb       $10
                    fcb       $3F
                    fcb       $04
                    fcb       $10
                    fcb       $25
                    fcb       $00
                    fcb       $95
                    fcb       $AE
                    fcb       $62
                    fcb       $27
                    fcb       $04
                    fcb       $E7
                    fcb       $01
                    fcb       $6F
                    fcb       $84
                    fcb       $1F
                    fcb       $89
                    fcb       $4F
                    fcb       $39
                    fcb       $A6
                    fcb       $63
                    fcb       $E6
                    fcb       $65
                    fcb       $10
                    fcb       $3F
                    fcb       $0D
                    fcb       $16
                    fcb       $00
                    fcb       $88
ForkSelectedProgram leau      ,s        ; select
                    leas      >$00FF,y  ; release >$00FF,y bytes of stack state
                    ldx       StreamBufferStart,u ; recover work word 001
                    ldy       StreamBufferEnd,u ; recover work word 002
                    lda       StreamPath+1,u ; recover work byte 004
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    ora       StreamBufferSize,u ; set selected bits in a using StreamBufferSize,u
                    ldb       RuntimeDescriptorTableRemainder,u ; recover work buffer 001
                    ldu       StreamFlags,u ; recover work word 003
                    os9       F$Chain   ; replace this process with the module at X
                    os9       F$Exit    ; terminate the process with status B
                    fcb       $34
                    fcb       $60
                    fcb       $AE
                    fcb       $66
                    fcb       $10
                    fcb       $AE
                    fcb       $68
                    fcb       $EE
                    fcb       $6A
                    fcb       $A6
                    fcb       $6D
                    fcb       $AA
                    fcb       $6F
                    fcb       $E6
                    fcb       $E8
                    fcb       $11
                    fcb       $10
                    fcb       $3F
                    fcb       $03
                    fcb       $35
                    fcb       $60
                    fcb       $10
                    fcb       $25
                    fcb       $00
                    fcb       $49
                    fcb       $1F
                    fcb       $89
                    fcc       "O94 "
                    fcb       $10
                    fcb       $3F
                    fcb       $0C
                    fcc       "5 $"
                    fcb       $04
                    fcb       $10
                    fcb       $25
                    fcb       $00
                    fcb       $38
                    fcb       $1F
                    fcb       $89
                    fcc       "O9"
SetUserSystemCall   pshs      y         ; preserve y across the operation
                    os9       F$ID      ; retrieve the current process and user IDs
                    bcc       SetUserSucceeded ; select branch 161 when carry remains clear
ReturnUserError     puls      y         ; restore y
                    lbra      ReturnOsError ; continue with branch 148
SetUserSucceeded    tfr       y,d       ; transfer y,d
                    puls      pc,y      ; restore pc,y and return to the caller
SetProcessUser      pshs      y         ; preserve y across the operation
                    bsr       SetUserSystemCall ; invoke routine 038
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       TrySetUser ; select branch 163 when the requested case matches
                    ldb       #214      ; supply 214 as the control, count, or argument value required here
                    bra       ReturnUserError ; continue with branch 162
TrySetUser          ldy       $04,s     ; recover $04
                    os9       F$SUser   ; change the process user ID to Y
                    bcc       ReturnUserSuccess ; select branch 164 when carry remains clear
                    cmpb      #208      ; recognize 208 as a meaningful value in this parser state
                    bne       ReturnUserError ; select branch 162 when the requested case does not match
                    tfr       y,d       ; transfer y,d
                    ldy       >CheckWorkspaceClearEnd ; recover code 001
                    std       $09,y     ; retain $09
ReturnUserSuccess   clra                ; widen OS-9's error byte in B
                    clrb                ; clear the byte accumulator for counting
                    puls      pc,y      ; restore pc,y and return to the caller
ReturnOsError       clra                ; select standard input
                    std       >$01AD,y  ; retain $01 ad
                    ldd       #-1       ; supply failure or frame value -1 to the following operation
                    rts                 ; return the completed result to the caller
ReturnOsResult      bcs       ReturnOsError ; select branch 148 when carry reports an error or underflow
                    clra                ; select standard input
                    clrb                ; return zero for a successful void-style wrapper
                    rts                 ; return the completed result to the caller
ExitProcess         lbsr      RunExitHook ; allow a linked application cleanup hook
                    lbsr      CloseAllStreams ; invoke routine 026
ExitWithStackStatus ldd       $02,s     ; recover $02
                    os9       F$Exit    ; terminate with its low byte in B
RunExitHook         rts                 ; default application cleanup hook does nothing
RuntimeInitializerImage fcb       $00
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
                    fcc       "Suser"
                    fcb       $00

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
