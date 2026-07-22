**********************************************************************
* AnsiEd - OS-9 Level 2 BBS command
*
* Syntax: AnsiEd [input] [output]
* Purpose: Edit the final screen image while separately recording the ordered ANSI output stream.
* Reads: optional input screen or animation data and interactive editor keys.
* Writes: optional screen/animation output selected by the operator.
* Cooperates: OS-9 window path controls and the compiler runtime stream layer.
* Failure: reports file and path errors in a temporary window before restoring
* the editor canvas.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded editor state, ANSI parsing, buffer handling, and runtime flow.
**********************************************************************

                    nam       AnsiEd
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,StartupEntry,size ; emit the OS-9 module header

StreamCursorHigh    rmb       1         ; high byte of the primary stream cursor
dpsiz               rmb       1         ; low cursor byte and direct-page boundary
StreamBufferStartHigh rmb       1         ; high byte of the stream buffer base
StreamBufferStartLow rmb       1         ; low byte of the stream buffer base
StreamBufferEndHigh rmb       1         ; high byte of the stream buffer limit
StreamBufferEndLow  rmb       1         ; low byte of the stream buffer limit
StreamFlagsHigh     rmb       1         ; high byte of stream state flags
EditModeFlag        rmb       1         ; nonzero edits; zero records ANSI output
StreamPathHigh      rmb       1         ; high byte of the underlying OS-9 path
CurrentAttributes   rmb       1         ; packed rendition and color state
StreamPushbackByte  rmb       1         ; ungetc or unbuffered byte storage
StreamBufferSize    rmb       2         ; configured buffer capacity
OutputLength        rmb       2         ; bytes committed to OutputBuffer
AnsiColorCodeTable  rmb       16        ; menu-color to ANSI-value lookup words
RuntimeDescriptorTail rmb       16
StartupArgumentState rmb       8
StartupParameterLength rmb       2
RuntimeErrorCode    rmb       1
RuntimeHeapLimit    rmb       2
RuntimeIoScratch    rmb       13
TerminalOutputStream rmb       196
LineInputBuffer     rmb       128
StartupArgv0Pointer rmb       2
StartupArgvVectorTail rmb       58
StartupArgcHigh     rmb       1
StartupArgumentCount rmb       1
_sttop              rmb       2
memend              rmb       2
RuntimeHeapCursor   rmb       2
RuntimeAllocatorState rmb       6
_mtop               rmb       2
_stbot              rmb       2
LastIoError         rmb       2
AnsiParameterCount  rmb       1
AnsiParameters      rmb       9
FilenameBuffer      rmb       50
CursorColumn        rmb       2
CursorRow           rmb       2
SavedCursorColumn   rmb       2
SavedCursorRow      rmb       2
ForegroundColor     rmb       2
BackgroundColor     rmb       2
OutputBuffer        rmb       8192      ; ordered ANSI stream and animation
ScreenCharacters    rmb       1840      ; editable 80-by-23 character plane
ScreenAttributes    rmb       3680      ; word-sized style for every cell
AnsiParserValue     rmb       2
DecimalConversionBuffer rmb       10
NumericConversionBuffer rmb       10
RuntimeFormatFlags  rmb       2
RuntimeFormatLength rmb       2
RuntimeFormatPadByte rmb       1
RuntimeStreamIndex  rmb       2
RuntimeStatusWord   rmb       2
EncodedServiceAddress rmb       2
EncodedServiceScratch rmb       14
end                 rmb       1
RuntimeWorkspaceTail rmb       895
size                equ       .

name                fcs       /AnsiEd/
                    fcb       $01

* ===== cstart.a =====

*
* move bytes (Y=From addr, U=To addr, X=Count)
*
CopyInitializerBytes lda       ,y+       ; copy one byte from the packed initializer image
                    sta       ,u+       ; install it in the process workspace
                    leax      -$01,x    ; count down the current initialized block
                    bne       CopyInitializerBytes ; and round again
                    rts                 ; return to the startup dispatcher

StartupEntry        pshs      y         ; preserve OS-9's parameter length
                    pshs      u         ; preserve the process workspace base

                    clra                ; prepare a zero byte and a 256-byte loop count
                    clrb                ; prepare a zero byte and a 256-byte loop count
ClearDirectPage     sta       ,u+       ; clear the first workspace page
                    decb                ; advance the modulo-256 clear count
                    bne       ClearDirectPage ; nonzero result: clear direct page

InitializeWorkspace ldx       ,s        ; recover the original workspace base
                    leau      ,x        ; (tfr x,u)
                    leax      >$37E4,x  ; get the end of bss address
                    pshs      x         ; retain the workspace-clear boundary
                    leay      >etext,pc ; point to dp-data count word

                    ldx       ,y++      ; read the next initialized block length
                    beq       InitializeSecondDataBlock ; bra if none
                    bsr       CopyInitializerBytes ; move dp data into position
                    ldu       $02,s     ; get beginning address again
InitializeSecondDataBlock leau      >dpsiz,u  ; point to where non-dp should start
                    ldx       ,y++      ; read the next initialized block length
                    beq       ClearRemainingWorkspace ; zero result: clear remaining workspace
                    bsr       CopyInitializerBytes ; move non-dp data into position

* Clear the bss area - starts where
* the transferred data finished
                    clra                ; prepare a zero byte and a 256-byte loop count
ClearRemainingWorkspace cmpu      ,s        ; reached the end?
                    beq       ApplyCodeRelocations ; bra if so
                    sta       ,u+       ; install it in the process workspace
                    bra       ClearRemainingWorkspace ; resume ClearRemainingWorkspace

* now relocate the data-text references
ApplyCodeRelocations ldu       $02,s     ; restore to data bottom
                    ldd       ,y++      ; get data-text ref. count
                    beq       ApplyDataRelocations ; zero result: apply data relocations
                    leax      >0,pc     ; use the module base as the relocation delta
                    lbsr      ApplyRelocationTable ; applyRelocationTable them

* and the data-data refs.
ApplyDataRelocations ldd       ,y++      ; get the count of data refs.
                    beq       ParseCommandLine ; bra if none
                    leax      StreamCursorHigh,u ; u was already pointing there
                    lbsr      ApplyRelocationTable ; relocate the compiler-generated pointer table

ParseCommandLine    leas      $04,s     ; reset stack
                    puls      x         ; recover the OS-9 parameter length
                    stx       >memend,u ; retain memend

* process the params
* the stack pointer is back where it started so is
* pointing at the params
*
* the objective is to insert null chars at the end of each argument
* and fill in the StartupArgv0Pointer vector with pointers to them

* first store the program name address
* (an extra name inserted here for just this purpose
* - undocumented as yet)
                    sty       >StartupArgv0Pointer,u ; retain StartupArgv0Pointer

                    ldd       #1        ; at least one arg
                    std       >StartupArgcHigh,u ; retain StartupArgcHigh
                    leay      >StartupArgvVectorTail,u ; point y at second slot
                    leax      ,s        ; point at OS-9's CR-terminated parameter text
                    lda       ,x+       ; prime the argument scanner with its first byte

ParseNextArgument   ldb       >StartupArgumentCount,u ; recover StartupArgcHigh 1
                    cmpb      #29       ; reserve the thirtieth StartupArgv0Pointer slot for termination
                    beq       InvokeAnsiEditor ; a full argv table stops further argument collection
SkipArgumentDelimiters cmpa      #13       ; is it EOL?
                    beq       InvokeAnsiEditor ; carriage return ends the OS-9 parameter line

                    cmpa      #32       ; treat spaces as argument separators
                    beq       AdvancePastDelimiter ; yes - try another
                    cmpa      #44       ; also accept commas as argument separators
                    bne       ClassifyArgument ; no - a word has started
AdvancePastDelimiter lda       ,x+       ; yes - bump
                    bra       SkipArgumentDelimiters ; and round again

ClassifyArgument    cmpa      #34       ; recognize a double-quoted argument
                    beq       ScanQuotedArgument ; yes
                    cmpa      #39       ; also recognize a single-quoted argument
                    bne       RecordPlainArgument ; no - ordinary

ScanQuotedArgument  stx       ,y++      ; record the first byte inside the quotes as StartupArgv0Pointer
                    inc       >StartupArgumentCount,u ; bump the arg count
                    pshs      a         ; retain the opening quote as the required closer

FindClosingQuote    lda       ,x+       ; consume the next quoted byte
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       TerminateQuotedArgument ; zero result: terminate quoted argument
                    cmpa      ,s        ; test for the matching quote character
                    bne       FindClosingQuote ; nonzero result: find closing quote

TerminateQuotedArgument puls      b         ; clean stack
                    clr       -$01,x    ; replace the closing delimiter with a C-string NUL
                    cmpa      #13       ; allow CR to terminate an unterminated quote
                    beq       InvokeAnsiEditor ; an unterminated quote at CR still yields the last argument
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ParseNextArgument ; resume ParseNextArgument

RecordPlainArgument leax      -$01,x    ; rewind to include the first unquoted byte
                    stx       ,y++      ; append the argument pointer to StartupArgv0Pointer
                    leax      $01,x     ; resume scanning after its first byte
                    inc       >StartupArgumentCount,u ; bump the arg count

* at least one non-space char has been seen
ScanPlainArgument   cmpa      #13       ; test the current unquoted byte for termination
                    beq       TerminatePlainArgument ; we
                    cmpa      #32       ; treat spaces as argument separators
                    beq       TerminatePlainArgument ; the end?
                    cmpa      #44       ; also accept commas as argument separators
                    beq       TerminatePlainArgument ; zero result: terminate plain argument
                    lda       ,x+       ; prime the argument scanner with its first byte
                    bra       ScanPlainArgument ; resume ScanPlainArgument

TerminatePlainArgument clr       -$01,x    ; yes - put in the null byte
                    bra       ParseNextArgument ; and look for the next word

* now put the pointers on the stack
InvokeAnsiEditor    leax      >StartupArgv0Pointer,u ; get the address of the arg vector
                    pshs      x         ; pass StartupArgv0Pointer through the compiler calling convention
                    ldd       >StartupArgcHigh,u ; get the arg count
                    pshs      d         ; pass StartupArgcHigh beside StartupArgv0Pointer
                    leay      StreamCursorHigh,u ; c progs. assume data & bss offset from y

                    bsr       _fixtop   ; set various variables

                    lbsr      AnsiEditorMain ; call the program

                    clr       ,-s       ; push a zero process exit status
                    clr       ,-s       ; push a zero process exit status
                    lbsr      exit      ; and a dummy 'return address'

* no return here
_fixtop             leax      >end,y    ; get the initial memory end address
                    stx       >_mtop,y  ; it's the current memory top
                    sts       >_sttop,y ; this is really two bytes short!
                    sts       >_stbot,y ; remember the bottom of the C runtime stack
                    ldd       #-126     ; give ourselves some breating space

* on entry here, d holds the negative of a stack reservation request
_stkcheck           leax      d,s       ; project the requested stack growth below the current S
                    cmpx      >_stbot,y ; is it lower than already reserved?
                    bcc       stk10     ; no - return
                    cmpx      >_mtop,y  ; yes - is it lower than possible?
                    bcs       fsterr    ; yes - can't cope
                    stx       >_stbot,y ; no - reserve it
stk10               rts                 ; return with the requested stack range validated

fixserr             fcc       "**** STACK OVERFLOW ****"
                    fcb       $0D

fsterr              leax      <fixserr,pc ; address of error string
                    ldb       #E$MemFul ; original runtime reports the collision as memory full

erexit              pshs      b         ; pass that status to the nonreturning exit wrapper
                    lda       #2        ; write the diagnostic on standard error
                    ldy       #100      ; bound output beyond the fixed message length
                    os9       I$WritLn  ; display the fatal diagnostic through its carriage return
                    clr       ,-s       ; widen the one-byte status to a compiler word
                    lbsr      _exit     ; and out
* no return here

* stacksize()
* returns the extent of stack requested
* can be used by programmer for guidance
* in sizing memory at compile time
stacksiz            ldd       >_sttop,y ; top of stack on entry
                    subd      >_stbot,y ; subtract current reserved limit
                    rts                 ; return to the caller

* freemem()
* returns the current size of the free memory area
freemem             ldd       >_stbot,y ; recover  stbot
                    subd      >_mtop,y  ; subtract from d using >_mtop,y
                    rts                 ; return to the diagnostic caller

* ApplyRelocationTable - adjust initialized data which refer to memory locations
* entry:
*       y -> list of offsets in the data area to be patched
*       u -> base of data
*       x -> base of either text or data area as appropriate
*       d =  count of offsets in the list
*
* exit:
*       u - unchanged
*       y - past the last entry in the list
*       x and d mangled

ApplyRelocationTable pshs      x         ; preserve the selected relocation delta
                    leax      d,y       ; locate the end of the packed word-offset table
                    leax      d,x       ; account for the table's own displacement encoding
                    pshs      x         ; retain the computed table end

* we do not come to this routine with
* a zero count (check!) so a test at the loop top
* is unnecessary
RelocateNextReference ldd       ,y++      ; get the offset
                    leax      d,u       ; locate the word requiring relocation
                    ldd       ,x        ; get the relative reference
                    addd      $02,s     ; add the selected module or data base
                    std       ,x        ; install the runtime absolute address
                    cmpy      ,s        ; test for the end of the relocation table
                    bne       RelocateNextReference ; no - round again

                    leas      $04,s     ; reset the stack
                    rts                 ; return to the startup dispatcher

AnsiEditorMain      pshs      u         ; preserve the compiler caller frame throughout the editor session
                    ldd       #-118     ; prepare constant -118 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      <-$22,s   ; allocate <$22,s bytes of stack state
                    lbsr      InitializeEditorDisplay ; initialize editor display
                    lbsr      ResetEditorBuffers ; reset editor buffers
                    ldd       <$0026,s  ; read the relevant word from the active stack frame
                    cmpd      #1        ; test against #1
                    ble       StartEditorAfterOptionalLoad ; continue at StartEditorAfterOptionalLoad when the signed bound test succeeds
                    ldx       <$0028,s  ; read the relevant word from the active stack frame
                    ldd       $02,x     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      LoadAnsiFile ; load ansi file
                    leas      $02,s     ; release $02,s bytes of stack state
StartEditorAfterOptionalLoad lbsr      RunEditorSession ; run editor session
                    ldd       <$0026,s  ; read the relevant word from the active stack frame
                    cmpd      #2        ; test against #2
                    ble       PromptForDefaultOutputName ; continue at PromptForDefaultOutputName when the signed bound test succeeds
                    ldx       <$0028,s  ; read the relevant word from the active stack frame
                    ldd       $04,x     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      SaveAnsiFile ; save ansi file
                    lbra      FinishEditorMain ; resume finish editor main
PromptForDefaultOutputName ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #21       ; prepare constant 21 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >savprmpt,pc ; select savprmpt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #32       ; recognize the first printable ASCII value
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $04,s     ; select $04
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      readln    ; collect one operator response line
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #1        ; test against #1
                    bgt       UseEnteredOutputName ; continue at UseEnteredOutputName when the signed bound test succeeds
                    ldx       <$0028,s  ; read the relevant word from the active stack frame
                    ldd       $02,x     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $04,s     ; select $04
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      CopyCString ; copy cstring
                    leas      $04,s     ; release $04,s bytes of stack state
UseEnteredOutputName leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      SaveAnsiFile ; save ansi file
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
FinishEditorMain    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      InitializeTerminalDisplay ; initialize terminal display
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Title,pc ; select title
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Copyright,pc ; select copyright
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >License,pc ; select license
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Rights,pc ; select rights
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      PauseForBanner ; pause for banner
                    leas      $02,s     ; release $02,s bytes of stack state
                    leas      <$0022,s  ; release <$0022,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Establish the editor windows and initial terminal state.  The status area
* occupies the bottom rows while the 80-by-23 canvas remains editable.
InitializeEditorDisplay pshs      u         ; preserve the caller data base
                    ldd       #-84      ; prepare constant -84 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Clear both screen planes, reset cursor and graphics state, and enter edit
* mode.  Characters and attributes remain separate for every canvas cell.
ResetEditorBuffers  pshs      u         ; preserve the caller data base
                    ldd       #-75      ; prepare constant -75 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$05,s    ; allocate $05,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      AdvanceScreenColumn ; resume advance screen column
StartScreenRow      clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       AdvanceScreenRow ; resume advance screen row
ClearNextScreenCell ldd       $01,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       >CurrentAttributes,y ; recover current attributes
                    std       ,x        ; retain
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceScreenRow    std       $01,s     ; retain the stream pointer in the local frame
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    cmpd      #23       ; test against #23
                    blt       ClearNextScreenCell ; signed comparison remains below its limit: clear next screen cell
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceScreenColumn std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    cmpd      #80       ; test against #80
                    lblt      StartScreenRow ; signed comparison remains below its limit: start screen row
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; initialize edit mode flag to 1
                    std       >EditModeFlag,y ; retain edit mode flag
                    lbsr      RenderStatusLine ; render status line
                    leas      $05,s     ; release $05,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Save the ordered output stream, optionally merging pending screen edits so
* recorded animation is followed by the final static canvas.
SaveAnsiFile        pshs      u         ; preserve the caller data base
                    ldd       #-99      ; prepare constant -99 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$0F,s    ; allocate $0F,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CurrentAttributes,y ; retain current attributes
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       <$0015,s  ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      creat     ; create the selected output file
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       $0D,s     ; store d in the current stack frame at $0D,s
                    cmpd      #-1       ; test against #-1
                    bne       OutputFileOpened ; nonzero result: output file opened
                    ldd       >LastIoError,y ; recover last io error
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >CantOpen1,pc ; select cant open1
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReportEditorError ; report editor error
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #-1       ; prepare constant -1 for the surrounding operation
                    lbra      ReturnSaveStatus ; resume return save status
OutputFileOpened    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #30       ; prepare constant 30 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #28       ; prepare constant 28 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #11       ; prepare constant 11 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >PutScrn,pc ; select put scrn
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      FlushStream ; flush pending terminal output before reading one byte
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; form standard-input path zero for the raw read
                    clrb                ; form standard-input path zero for the raw read
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover the confirmation character
                    clra                ; form standard-input path zero for the raw read
                    andb      #223      ; mask b using #223
                    cmpd      #78       ; test against #78
                    beq       SkipPreSaveMerge ; zero result: skip pre save merge
                    lbsr      MergeScreenIntoOutput ; merge screen into output
SkipPreSaveMerge    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >ClrScrn,pc ; select clr scrn
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; test against #89
                    bne       SkipClearScreenRecord ; nonzero result: skip clear screen record
                    ldd       #27       ; initialize $01 to 27
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    ldd       #91       ; initialize $02 to 91
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    ldd       #50       ; initialize $03 to 50
                    stb       $03,s     ; store b in the current stack frame at $03,s
                    ldd       #74       ; initialize $04 to 74
                    stb       $04,s     ; store b in the current stack frame at $04,s
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       <$0011,s  ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
SkipClearScreenRecord ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >OutputLength,y ; recover output length
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >OutputBuffer,y ; select output buffer
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       <$0011,s  ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $0D,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      close     ; close the selected runtime stream
                    leas      $02,s     ; release $02,s bytes of stack state
ReturnSaveStatus    leas      $0F,s     ; release $0F,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Load ANSI data either as immutable recorded output or by replaying it
* through the parser into the editable character and attribute planes.
LoadAnsiFile        pshs      u         ; preserve the caller data base
                    ldd       #-88      ; prepare constant -88 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$04,s    ; allocate $04,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $0A,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      open      ; open the selected input file
                    leas      $04,s     ; release $04,s bytes of stack state
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; test against #-1
                    bne       ReturnLoadedCharacter ; nonzero result: return loaded character
                    ldd       >LastIoError,y ; recover last io error
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >CantOpen2,pc ; select cant open2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      ReportEditorError ; report editor error
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #-1       ; initialize cursor column to -1
                    lbra      FinishFileLoad ; resume finish file load
ReturnLoadedCharacter clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorColumn,y ; retain cursor column
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorRow,y ; retain cursor row
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >ForegroundColor,y ; retain foreground color
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >BackgroundColor,y ; retain background color
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >SavedCursorColumn,y ; retain saved cursor column
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >SavedCursorRow,y ; retain saved cursor row
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    leax      >ReadFile,pc ; select read file
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       NormalizeLoadChoice ; resume normalize load choice
AcceptScreenLoadChoice ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
NormalizeLoadChoice stb       $01,s     ; store b in the current stack frame at $01,s
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #79       ; prepare constant 79 for the surrounding operation
                    beq       ProcessLoadedByte ; zero result: process loaded byte
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #83       ; prepare constant 83 for the surrounding operation
                    bne       AcceptScreenLoadChoice ; nonzero result: accept screen load choice
ProcessLoadedByte   ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #83       ; prepare constant 83 for the surrounding operation
                    bne       SetRecordLoadMode ; nonzero result: set record load mode
                    ldd       #1        ; initialize edit mode flag to 1
                    bra       StoreLoadMode ; resume store load mode
SetRecordLoadMode   clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
StoreLoadMode       std       >EditModeFlag,y ; retain edit mode flag
                    leax      >AddLf,pc ; select add lf
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       NormalizeLoadConfirmation ; resume normalize load confirmation
RepeatLoadConfirmation ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover the confirmation character
                    clra                ; form standard-input path zero for the raw read
                    andb      #223      ; mask b using #223
NormalizeLoadConfirmation stb       ,s        ; store b in the current stack frame at ,s
                    ldb       ,s        ; recover the confirmation character
                    cmpb      #89       ; accept only an explicit Y
                    beq       AcceptLoadConfirmation ; zero result: accept load confirmation
                    ldb       ,s        ; recover
                    cmpb      #78       ; prepare constant 78 for the surrounding operation
                    bne       RepeatLoadConfirmation ; nonzero result: repeat load confirmation
AcceptLoadConfirmation ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    lbra      ContinueFileRead ; resume continue file read
HandleLoadedByte    ldd       >EditModeFlag,y ; recover edit mode flag
                    bne       CheckLoadedEscape ; nonzero result: check loaded escape
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    cmpd      #8192     ; test against #8192
                    blt       CheckLoadedEscape ; signed comparison remains below its limit: check loaded escape
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    std       >OutputLength,y ; retain output length
CheckLoadedEscape   ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #27       ; prepare constant 27 for the surrounding operation
                    lbne      ReplayLoadedByte ; nonzero result: replay loaded byte
                    ldd       >StreamBufferEndLow,y ; recover stream buffer end low
                    lbne      ReplayLoadedByte ; nonzero result: replay loaded byte
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    bne       CheckLoadedCsi ; nonzero result: check loaded csi
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    cmpd      #8192     ; test against #8192
                    blt       CheckLoadedCsi ; signed comparison remains below its limit: check loaded csi
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    std       >OutputLength,y ; retain output length
CheckLoadedCsi      ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #91       ; prepare constant 91 for the surrounding operation
                    bne       ReplayLoadedByte ; nonzero result: replay loaded byte
                    ldd       #1        ; initialize stream buffer end low to 1
                    std       >StreamBufferEndLow,y ; retain stream buffer end low
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    bne       ReplayLoadedByte ; nonzero result: replay loaded byte
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    cmpd      #8192     ; test against #8192
                    blt       ReplayLoadedByte ; signed comparison remains below its limit: replay loaded byte
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    std       >OutputLength,y ; retain output length
ReplayLoadedByte    ldb       ,s        ; recover
                    cmpb      #89       ; prepare constant 89 for the surrounding operation
                    bne       EmitLoadedByte ; nonzero result: emit loaded byte
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #13       ; recognize the carriage-return terminator
                    bne       EmitLoadedByte ; nonzero result: emit loaded byte
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #10       ; select the line-feed control byte
                    bra       SubmitLoadedByte ; resume submit loaded byte
EmitLoadedByte      ldb       $01,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
SubmitLoadedByte    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
ContinueFileRead    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      HandleLoadedByte ; nonzero result: handle loaded byte
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      close     ; close the selected runtime stream
                    leas      $02,s     ; release $02,s bytes of stack state
FinishFileLoad      leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore the caller frame and return

* Configure raw input, draw the editor chrome, and own the command loop and
* terminal restoration for the editing session.
RunEditorSession    pshs      u         ; preserve the caller frame for fatal error reporting
                    ldd       #-120     ; prepare constant -120 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      <-$24,s   ; allocate <$24,s bytes of stack state
                    clra                ; return a null descriptor pointer
                    clrb                ; complete the null return value
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; clear the access-mode high byte
                    clrb                ; begin with no access bits
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      RefreshEditorDisplay ; resume refresh editor display
EditorCommandLoop   clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >Status,pc ; select status
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    beq       ShowRecordingMode ; zero result: show recording mode
                    leax      >Editing,pc ; select editing
                    bra       PrintModeStatus ; resume print mode status
ShowRecordingMode   leax      >Recording,pc ; select recording
PrintModeStatus     pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorColumn,y ; recover cursor column
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    beq       ShowBlankScreenCell ; zero result: show blank screen cell
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorColumn,y ; recover cursor column
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >CharDump,pc ; select char dump
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $04,s     ; release $04,s bytes of stack state
                    bra       PrintAttributeStatus ; resume print attribute status
ShowBlankScreenCell leax      >Char,pc  ; select char
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
PrintAttributeStatus leax      >Attrs,pc ; select attrs
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    anda      #1        ; mask a using #1
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       ShowUnderlineOff ; zero result: show underline off
                    leax      >UnderlineStatusOn,pc ; select underline status on
                    bra       PrintUnderlineStatus ; resume print underline status
ShowUnderlineOff    leax      >UnderlineStatusOff,pc ; select underline status off
PrintUnderlineStatus pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    anda      #2        ; mask a using #2
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       ShowBlinkOff ; zero result: show blink off
                    leax      >BlinkStatusOn,pc ; select blink status on
                    bra       PrintBlinkStatus ; resume print blink status
ShowBlinkOff        leax      >BlinkStatusOff,pc ; select blink status off
PrintBlinkStatus    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    anda      #4        ; mask a using #4
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       ShowReverseOff ; zero result: show reverse off
                    leax      >ReverseStatusOn,pc ; select reverse status on
                    bra       PrintReverseStatus ; resume print reverse status
ShowReverseOff      leax      >ReverseStatusOff,pc ; select reverse status off
PrintReverseStatus  pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    anda      #8        ; mask a using #8
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       ShowInvisibleOff ; zero result: show invisible off
                    leax      >InvisibleStatusOn,pc ; select invisible status on
                    bra       PrintInvisibleStatus ; resume print invisible status
ShowInvisibleOff    leax      >InvisibleStatusOff,pc ; select invisible status off
PrintInvisibleStatus pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    anda      #16       ; mask a using #16
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       ShowBoldOff ; zero result: show bold off
                    leax      >BoldStatusOn,pc ; select bold status on
                    bra       PrintBoldStatus ; resume print bold status
ShowBoldOff         leax      >BoldStatusOff,pc ; select bold status off
PrintBoldStatus     pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #256      ; prepare constant 256 for the surrounding operation
                    lbsr      UnsignedRemainder ; unsigned remainder
                    beq       ShowDefaultColors ; zero result: show default colors
                    ldd       >CurrentAttributes,y ; recover current attributes
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #16       ; prepare constant 16 for the surrounding operation
                    lbsr      UnsignedRemainder ; unsigned remainder
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >RuntimeDescriptorTail,y ; select runtime descriptor tail
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CurrentAttributes,y ; recover current attributes
                    clra                ; select standard input
                    andb      #240      ; mask b using #240
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #16       ; prepare constant 16 for the surrounding operation
                    lbsr      UnsignedQuotient ; unsigned quotient
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >RuntimeDescriptorTail,y ; select runtime descriptor tail
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >ColorsOn,pc ; select colors on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $06,s     ; release $06,s bytes of stack state
                    bra       EnterCommandReadLoop ; resume enter command read loop
ShowDefaultColors   leax      >ColorsBW,pc ; select colors bw
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
EnterCommandReadLoop leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0025,s  ; select $0025
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; initialize stream buffer end low to 1
                    std       >StreamBufferEndLow,y ; retain stream buffer end low
                    ldb       <$0023,s  ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; preserve the flags or register state required by the following operation
                    lbra      DispatchEditorKey ; resume dispatch editor key
RedrawAfterCommand  ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #19       ; prepare constant 19 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; append adds a zero 32-bit offset
                    ldd       #17       ; prepare constant 17 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #21       ; prepare constant 21 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    clra                ; select standard input
                    clrb                ; preserve the original runtime's anomalous zero result
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Help,pc  ; select help
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Line,pc  ; select line
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltG,pc  ; select alt g
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltR,pc  ; select alt r
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltE,pc  ; select alt e
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltC,pc  ; select alt c
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltN,pc  ; select alt n
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltS,pc  ; select alt s
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltA,pc  ; select alt a
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltP,pc  ; select alt p
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltL,pc  ; select alt l
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltK,pc  ; select alt k
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltZ,pc  ; select alt z
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltX,pc  ; select alt x
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >AltQ,pc  ; select alt q
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReadAltKey ; read alt key
                    leas      $02,s     ; release $02,s bytes of stack state
HandleAltCommand    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReadPortCharacter ; read port character
                    leas      $02,s     ; release $02,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    beq       HandleAltCommand ; zero result: handle alt command
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReadEditorKey ; read editor key
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    lbra      FinishCommandAction ; resume finish command action
HandlePlainCharacter ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #18       ; prepare constant 18 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Sure,pc  ; select sure
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0025,s  ; select $0025
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       <$0023,s  ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; test against #89
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      InitializeTerminalDisplay ; initialize terminal display
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Title2,pc ; select title2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >CpyRite2,pc ; select cpy rite2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >License2,pc ; select license2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Rights2,pc ; select rights2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      PauseForBanner ; pause for banner
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      exit      ; exit
                    lbra      FinishCommandAction ; resume finish command action
PromptForLoadFilename ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #21       ; prepare constant 21 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >LoadPrompt,pc ; select load prompt
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #32       ; recognize the first printable ASCII value
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $04,s     ; select $04
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      readln    ; collect one operator response line
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       ,s        ; recover
                    cmpd      #1        ; test against #1
                    bgt       UseEnteredLoadFilename ; continue at UseEnteredLoadFilename when the signed bound test succeeds
                    lbra      RefreshEditorDisplay ; resume refresh editor display
UseEnteredLoadFilename leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      LoadAnsiFile ; load ansi file
                    lbra      FinishCommandAction ; resume finish command action
PromptForSaveFilename ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #21       ; prepare constant 21 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >SavePrompt,pc ; select save prompt
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #32       ; recognize the first printable ASCII value
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $04,s     ; select $04
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      readln    ; collect one operator response line
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       ,s        ; recover
                    cmpd      #1        ; test against #1
                    bgt       UseEnteredSaveFilename ; continue at UseEnteredSaveFilename when the signed bound test succeeds
                    lbra      RefreshEditorDisplay ; resume refresh editor display
UseEnteredSaveFilename leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      SaveAnsiFile ; save ansi file
                    lbra      FinishCommandAction ; resume finish command action
HandleCursorUpKey   ldd       #65       ; prepare constant 65 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #65       ; prepare constant 65 for the surrounding operation
                    lbra      RecordCursorMotion ; resume record cursor motion
HandleCursorDownKey ldd       #66       ; prepare constant 66 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #66       ; prepare constant 66 for the surrounding operation
                    lbra      RecordCursorMotion ; resume record cursor motion
HandleCursorLeftKey ldd       #68       ; prepare constant 68 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #68       ; prepare constant 68 for the surrounding operation
                    lbra      RecordCursorMotion ; resume record cursor motion
HandleCursorRightKey ldd       #67       ; prepare constant 67 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #67       ; prepare constant 67 for the surrounding operation
                    lbra      RecordCursorMotion ; resume record cursor motion
SaveCursorPosition  ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #18       ; prepare constant 18 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #11       ; prepare constant 11 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >PosSaved,pc ; select pos saved
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      PauseEditorMessage ; pause editor message
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #115      ; prepare constant 115 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #115      ; prepare constant 115 for the surrounding operation
                    lbra      RecordCursorMotion ; resume record cursor motion
RestoreCursorPosition ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #18       ; prepare constant 18 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #11       ; prepare constant 11 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >PosRestrd,pc ; select pos restrd
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      PauseEditorMessage ; pause editor message
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #117      ; prepare constant 117 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #117      ; prepare constant 117 for the surrounding operation
                    bra       RecordCursorMotion ; resume record cursor motion
ClearToEndOfLine    ldd       #74       ; prepare constant 74 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #74       ; prepare constant 74 for the surrounding operation
                    bra       RecordCursorMotion ; resume record cursor motion
HandleSaveShortcut  ldd       #107      ; prepare constant 107 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       #107      ; prepare constant 107 for the surrounding operation
RecordCursorMotion  pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      RecordCursorCommand ; record cursor command
                    lbra      FinishCommandAction ; resume finish command action
OpenGraphicsMenu    lbsr      GraphicsMenu ; graphics menu
                    lbra      RefreshEditorDisplay ; resume refresh editor display
CheckSavedCursorColumn ldd       >CursorColumn,y ; recover cursor column
                    cmpd      >SavedCursorColumn,y ; test against saved cursor column
                    bne       RecordSavedCursorPosition ; nonzero result: record saved cursor position
                    ldd       >CursorRow,y ; recover cursor row
                    cmpd      >SavedCursorRow,y ; test against saved cursor row
                    lbeq      CursorAlreadyAtSavedPosition ; zero result: cursor already at saved position
RecordSavedCursorPosition ldd       >OutputLength,y ; recover output length
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; test against #8192
                    lbge      OutputFullDuringCursorSave ; signed comparison reached its upper case: output full during cursor save
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #27       ; initialize  to 27
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #91       ; initialize  to 91
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedQuotient ; unsigned quotient
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedRemainder ; unsigned remainder
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #59       ; initialize  to 59
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedQuotient ; unsigned quotient
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedRemainder ; unsigned remainder
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #72       ; initialize  to 72
                    stb       ,x        ; retain
                    bra       CursorAlreadyAtSavedPosition ; resume cursor already at saved position
OutputFullDuringCursorSave ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
CursorAlreadyAtSavedPosition clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >EditModeFlag,y ; retain edit mode flag
                    ldd       >CursorColumn,y ; recover cursor column
                    std       >SavedCursorColumn,y ; retain saved cursor column
                    ldd       >CursorRow,y ; recover cursor row
                    std       >SavedCursorRow,y ; retain saved cursor row
                    lbra      RefreshEditorDisplay ; resume refresh editor display
RecordCursorRowDigits ldd       #1        ; initialize edit mode flag to 1
                    std       >EditModeFlag,y ; retain edit mode flag
                    lbra      RefreshEditorDisplay ; resume refresh editor display
RecordCursorColumnDigits ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #30       ; prepare constant 30 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #28       ; prepare constant 28 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #11       ; prepare constant 11 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >MovBuff,pc ; select mov buff
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbsr      MergeScreenIntoOutput ; merge screen into output
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    lbra      FinishCommandAction ; resume finish command action
SwitchToRecordMode  ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetTerminalRawMode ; set terminal raw mode
                    leas      $02,s     ; release $02,s bytes of stack state
                    leas      <$0024,s  ; release <$0024,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
SwitchToEditMode    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #30       ; prepare constant 30 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #8        ; prepare constant 8 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #28       ; prepare constant 28 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Zap,pc   ; select zap
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >RecBuff,pc ; select rec buff
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BothBuffs,pc ; select both buffs
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >ScrnChar,pc ; select scrn char
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >RecChar,pc ; select rec char
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Choose,pc ; select choose
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0024,s  ; select $0024
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    stb       <$0022,s  ; store b in the current stack frame at <$0022,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       <$0023,s  ; store b in the current stack frame at <$0023,s
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    cmpb      #83       ; prepare constant 83 for the surrounding operation
                    beq       ConfirmExitWithoutSave ; zero result: confirm exit without save
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    cmpb      #82       ; prepare constant 82 for the surrounding operation
                    beq       ConfirmExitWithoutSave ; zero result: confirm exit without save
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    cmpb      #66       ; prepare constant 66 for the surrounding operation
                    beq       ConfirmExitWithoutSave ; zero result: confirm exit without save
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    cmpb      #68       ; prepare constant 68 for the surrounding operation
                    beq       ConfirmExitWithoutSave ; zero result: confirm exit without save
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    cmpb      #84       ; prepare constant 84 for the surrounding operation
                    bne       ReadExitConfirmation ; repeat read exit confirmation until the terminating condition is met
ConfirmExitWithoutSave leax      >Sure2,pc ; select sure2
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0025,s  ; select $0025
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
ReadExitConfirmation ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       <$0023,s  ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; test against #89
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldb       <$0022,s  ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    tfr       d,x       ; transfer d,x
                    lbra      DispatchAltLetter ; resume dispatch alt letter
HandleZapCommand    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CurrentAttributes,y ; retain current attributes
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitBackgroundColor ; emit background color
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbsr      ResetEditorBuffers ; reset editor buffers
                    ldd       #74       ; prepare constant 74 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    lbra      FinishZapMenu ; resume finish zap menu
ZapScreenBuffer     clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitBackgroundColor ; emit background color
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbsr      ResetEditorBuffers ; reset editor buffers
                    ldd       #74       ; prepare constant 74 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
ZapOutputBuffer     clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CurrentAttributes,y ; retain current attributes
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >OutputLength,y ; retain output length
                    lbra      RefreshEditorDisplay ; resume refresh editor display
ZapBothBuffers      ldd       >CursorColumn,y ; recover cursor column
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorRow,y ; recover cursor row
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >CursorColumn,y ; recover cursor column
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorRow,y ; recover cursor row
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,x        ; retain
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >BlankForegroundChoice,pc ; select blank foreground choice
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      RefreshEditorDisplay ; resume refresh editor display
ZapScreenCharacter  ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    std       >OutputLength,y ; retain output length
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorDown ; emit ansi cursor down
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >BlankBackgroundChoice,pc ; select blank background choice
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorDown ; emit ansi cursor down
FinishZapMenu       leas      $02,s     ; release $02,s bytes of stack state
                    lbra      RefreshEditorDisplay ; resume refresh editor display
DispatchAltLetter   cmpx      #83       ; test against #83
                    lbeq      HandleZapCommand ; zero result: handle zap command
                    cmpx      #82       ; test against #82
                    lbeq      ZapOutputBuffer ; zero result: zap output buffer
                    cmpx      #66       ; test against #66
                    lbeq      ZapScreenBuffer ; zero result: zap screen buffer
                    cmpx      #68       ; test against #68
                    lbeq      ZapBothBuffers ; zero result: zap both buffers
                    cmpx      #84       ; test against #84
                    beq       ZapScreenCharacter ; zero result: zap screen character
                    lbra      RefreshEditorDisplay ; resume refresh editor display
ZapOutputCharacter  clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >StreamBufferEndLow,y ; retain stream buffer end low
                    ldb       <$0023,s  ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      RefreshEditorDisplay ; nonzero result: refresh editor display
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    cmpd      #8192     ; test against #8192
                    bge       RejectUnknownAltCommand ; signed comparison reached its upper case: reject unknown alt command
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldb       <$0023,s  ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    lbra      RefreshEditorDisplay ; resume refresh editor display
RejectUnknownAltCommand ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
FinishCommandAction leas      $02,s     ; release $02,s bytes of stack state
                    lbra      RefreshEditorDisplay ; resume refresh editor display
DispatchEditorKey   cmpx      #-81      ; test against #-81
                    lbeq      RedrawAfterCommand ; zero result: redraw after command
                    cmpx      #-15      ; test against #-15
                    lbeq      HandlePlainCharacter ; zero result: handle plain character
                    cmpx      #-20      ; test against #-20
                    lbeq      PromptForLoadFilename ; ask again at prompt for load filename
                    cmpx      #-21      ; test against #-21
                    lbeq      PromptForSaveFilename ; ask again at prompt for save filename
                    cmpx      #12       ; test against #12
                    lbeq      HandleCursorUpKey ; zero result: handle cursor up key
                    cmpx      #10       ; test against #10
                    lbeq      HandleCursorDownKey ; zero result: handle cursor down key
                    cmpx      #8        ; test against #8
                    lbeq      HandleCursorLeftKey ; zero result: handle cursor left key
                    cmpx      #9        ; test against #9
                    lbeq      HandleCursorRightKey ; zero result: handle cursor right key
                    cmpx      #-13      ; test against #-13
                    lbeq      SaveCursorPosition ; zero result: save cursor position
                    cmpx      #-31      ; test against #-31
                    lbeq      RestoreCursorPosition ; zero result: restore cursor position
                    cmpx      #-29      ; test against #-29
                    lbeq      ClearToEndOfLine ; zero result: clear to end of line
                    cmpx      #-18      ; test against #-18
                    lbeq      HandleSaveShortcut ; zero result: handle save shortcut
                    cmpx      #-25      ; test against #-25
                    lbeq      OpenGraphicsMenu ; zero result: open graphics menu
                    cmpx      #-14      ; test against #-14
                    lbeq      CheckSavedCursorColumn ; zero result: check saved cursor column
                    cmpx      #-27      ; test against #-27
                    lbeq      RecordCursorRowDigits ; zero result: record cursor row digits
                    cmpx      #-16      ; test against #-16
                    lbeq      RecordCursorColumnDigits ; zero result: record cursor column digits
                    cmpx      #-8       ; test against #-8
                    lbeq      SwitchToRecordMode ; zero result: switch to record mode
                    cmpx      #-6       ; test against #-6
                    lbeq      SwitchToEditMode ; zero result: switch to edit mode
                    lbra      ZapOutputCharacter ; resume zap output character
RefreshEditorDisplay lbra      EditorCommandLoop ; resume editor command loop
                    leas      <$0024,s  ; release <$0024,s bytes of stack state
                    puls      pc,u      ; preserve the flags or register state required by the following operation

* Process graphics selections.  Record mode appends SGR commands; edit mode
* changes only the active style used for subsequent canvas cells.
GraphicsMenu        pshs      u         ; preserve U while it carries the opened path
                    ldd       #-86      ; prepare constant -86 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    bne       GraphicsMenuLoop ; nonzero result: graphics menu loop
                    ldd       >OutputLength,y ; recover output length
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; test against #8192
                    bge       GraphicsMenuReady ; signed comparison reached its upper case: graphics menu ready
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #27       ; initialize  to 27
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #91       ; initialize  to 91
                    stb       ,x        ; retain
                    bra       GraphicsMenuLoop ; resume graphics menu loop
GraphicsMenuReady   ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
GraphicsMenuLoop    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    lbra      DispatchGraphicsChoice ; resume dispatch graphics choice
ShowGraphicsMenu    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    ldd       #17       ; prepare constant 17 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; fopen-style failure returns a null stream
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #15       ; prepare constant 15 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #21       ; prepare constant 21 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; request allocation of a new descriptor
                    pshs      d         ; pass the supplied or null descriptor
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; preserve the flags or register state required by the following operation
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >SetGraphs,pc ; select set graphs
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Line2,pc ; select line2
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >RestGraph,pc ; select rest graph
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BoldOn,pc ; select bold on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >UndrOn,pc ; select undr on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >BlnkOn,pc ; select blnk on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >RevVidOn,pc ; select rev vid on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >InvisOn,pc ; select invis on
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >SetForClr,pc ; select set for clr
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >SetBckClr,pc ; select set bck clr
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >Done,pc  ; select done
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >SelChoice,pc ; select sel choice
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $03,s     ; select $03
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #223      ; mask b using #223
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       $01,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      ReturnFromGraphicsMenu ; resume return from graphics menu
ResetGraphicsAttributes ldd       #48       ; recognize or generate ASCII zero
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
EnableBoldChoice    ldd       #49       ; prepare constant 49 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
EnableUnderlineChoice ldd       #52       ; prepare constant 52 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
EnableBlinkChoice   ldd       #53       ; prepare constant 53 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
EnableReverseChoice ldd       #55       ; prepare constant 55 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
EnableInvisibleChoice ldd       #56       ; prepare constant 56 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldd       #8        ; initialize  to 8
                    lbra      ApplyGraphicsChoice ; resume apply graphics choice
ChooseForegroundColor lbsr      ChooseAnsiColor ; choose ansi color
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #51       ; prepare constant 51 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    addd      #30       ; add to d using #30
                    bra       ApplyGraphicsChoice ; resume apply graphics choice
ChooseBackgroundColor lbsr      ChooseAnsiColor ; choose ansi color
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #52       ; prepare constant 52 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #59       ; prepare constant 59 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    bne       DispatchGraphicsChoice ; nonzero result: dispatch graphics choice
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    addd      #40       ; add to d using #40
ApplyGraphicsChoice pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
                    bra       DispatchGraphicsChoice ; resume dispatch graphics choice
ReturnFromGraphicsMenu cmpx      #82       ; test against #82
                    lbeq      ResetGraphicsAttributes ; zero result: reset graphics attributes
                    cmpx      #79       ; test against #79
                    lbeq      EnableBoldChoice ; zero result: enable bold choice
                    cmpx      #85       ; test against #85
                    lbeq      EnableUnderlineChoice ; zero result: enable underline choice
                    cmpx      #76       ; test against #76
                    lbeq      EnableBlinkChoice ; zero result: enable blink choice
                    cmpx      #86       ; test against #86
                    lbeq      EnableReverseChoice ; zero result: enable reverse choice
                    cmpx      #73       ; test against #73
                    lbeq      EnableInvisibleChoice ; zero result: enable invisible choice
                    cmpx      #70       ; test against #70
                    lbeq      ChooseForegroundColor ; zero result: choose foreground color
                    cmpx      #66       ; test against #66
                    lbeq      ChooseBackgroundColor ; zero result: choose background color
DispatchGraphicsChoice ldb       $01,s     ; read the relevant word from the active stack frame
                    cmpb      #68       ; prepare constant 68 for the surrounding operation
                    lbne      ShowGraphicsMenu ; nonzero result: show graphics menu
                    ldd       #109      ; prepare constant 109 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ApplyEditorCharacter ; apply editor character
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >EditModeFlag,y ; recover edit mode flag
                    lbne      FinishCharacterApplication ; nonzero result: finish character application
                    ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #109      ; initialize  to 109
                    stb       ,x        ; retain
                    lbra      FinishCharacterApplication ; resume finish character application

* Translate a foreground or background menu choice through the ANSI color
* table, then update or record the selected color.
ChooseAnsiColor     pshs      u         ; preserve the caller data base
                    ldd       #-87      ; prepare constant -87 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$03,s    ; allocate $03,s bytes of stack state
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #12       ; prepare constant 12 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #20       ; prepare constant 20 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #18       ; prepare constant 18 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #41       ; prepare constant 41 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      AdvanceAnsiInput ; resume advance ansi input
HandlePrintableCharacter ldd       $01,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DecodeAnsiParameter ; decode ansi parameter
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    beq       HandleControlCharacter ; zero result: handle control character
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >AnsiColorCodeTable,y ; select ansi color code table
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
HandleControlCharacter ldd       $01,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >RuntimeDescriptorTail,y ; select runtime descriptor tail
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >NumString,pc ; select num string
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceAnsiInput    std       $01,s     ; store d in the current stack frame at $01,s
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    cmpd      #8        ; test against #8
                    lblt      HandlePrintableCharacter ; signed comparison remains below its limit: handle printable character
                    leax      >ClrNum,pc ; select clr num
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      printf    ; render the prepared formatted text
                    leas      $02,s     ; release $02,s bytes of stack state
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      FlushStream ; commit pending stream output before continuing
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    subd      #48       ; subtract from d using #48
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    leas      $03,s     ; release $03,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Record a cursor command only when the complete escape sequence fits in the
* output stream.
RecordCursorCommand pshs      u         ; preserve the caller data base
                    ldd       #-70      ; prepare constant -70 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    ldd       >OutputLength,y ; recover output length
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; test against #8192
                    lbge      OutputBufferHasRoom ; signed comparison reached its upper case: output buffer has room
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #27       ; initialize  to 27
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #91       ; initialize  to 91
                    stb       ,x        ; retain
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    cmpb      #74       ; prepare constant 74 for the surrounding operation
                    bne       AppendRecordedByte ; nonzero result: append recorded byte
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #50       ; initialize  to 50
                    stb       ,x        ; retain
AppendRecordedByte  ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    lbra      ReturnCharacterResult ; resume return character result
OutputBufferHasRoom ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    lbra      FinishCharacterApplication ; resume finish character application

* Apply one byte to editor state.  Printable data updates a cell; controls and
* CSI data drive cursor/parser state; record mode also appends the operation.
ApplyEditorCharacter pshs      u         ; preserve the caller data base
                    ldd       #-76      ; prepare constant -76 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    ldd       >StreamBufferEndLow,y ; recover stream buffer end low
                    lbeq      UpdateCursorAfterCharacter ; zero result: update cursor after character
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    beq       HandleCarriageReturn ; zero result: handle carriage return
                    ldd       >dpsiz,y  ; recover dpsiz
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >FilenameBuffer,y ; select filename buffer
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    addd      #1        ; add to d using #1
                    std       >StreamBufferStartLow,y ; retain stream buffer start low
                    subd      #1        ; subtract from d using #1
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
HandleCarriageReturn ldb       $07,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #6        ; mask b using #6
                    lbeq      HandleLineFeed ; zero result: handle line feed
                    ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    ble       HandleBackspace ; continue at HandleBackspace when the signed bound test succeeds
                    ldd       >dpsiz,y  ; recover dpsiz
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >FilenameBuffer,y ; select filename buffer
                    leax      d,x       ; select d
                    ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >dpsiz,y  ; recover dpsiz
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >dpsiz,y  ; recover dpsiz
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >FilenameBuffer,y ; select filename buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      ScreenCellOffset ; screen cell offset
                    leas      $02,s     ; release $02,s bytes of stack state
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       RecordCarriageReturn ; resume record carriage return
HandleBackspace     ldd       >dpsiz,y  ; recover dpsiz
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldd       #1        ; initialize  to 1
                    stb       ,x        ; retain
RecordCarriageReturn ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    bgt       RecordLineFeed ; continue at RecordLineFeed when the signed bound test succeeds
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    cmpb      #109      ; prepare constant 109 for the surrounding operation
                    beq       RecordBackspace ; zero result: record backspace
RecordLineFeed      ldd       >dpsiz,y  ; recover dpsiz
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; retain dpsiz
RecordBackspace     clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >StreamBufferStartLow,y ; retain stream buffer start low
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ParseAnsiSequence ; parse ansi sequence
                    leas      $02,s     ; release $02,s bytes of stack state
HandleLineFeed      ldb       $07,s     ; read the relevant word from the active stack frame
                    cmpb      #59       ; prepare constant 59 for the surrounding operation
                    lbne      FinishCharacterApplication ; nonzero result: finish character application
                    ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    ble       ApplyLineFeed ; continue at ApplyLineFeed when the signed bound test succeeds
                    ldd       >dpsiz,y  ; recover dpsiz
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >FilenameBuffer,y ; select filename buffer
                    leax      d,x       ; select d
                    ldd       >StreamBufferStartLow,y ; recover stream buffer start low
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >dpsiz,y  ; recover dpsiz
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       >dpsiz,y  ; recover dpsiz
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >FilenameBuffer,y ; select filename buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      ScreenCellOffset ; screen cell offset
                    leas      $02,s     ; release $02,s bytes of stack state
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       ClampCursorAtLastRow ; resume clamp cursor at last row
ApplyLineFeed       ldd       >dpsiz,y  ; recover dpsiz
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldd       #1        ; initialize  to 1
                    stb       ,x        ; retain
ClampCursorAtLastRow ldd       >dpsiz,y  ; recover dpsiz
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; retain dpsiz
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >StreamBufferStartLow,y ; retain stream buffer start low
                    lbra      FinishCharacterApplication ; resume finish character application
UpdateCursorAfterCharacter ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $09,s     ; select $09
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      DispatchCursorEffect ; resume dispatch cursor effect
HandleCursorDown    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    std       >CursorRow,y ; retain cursor row
                    cmpd      #23       ; test against #23
                    lble      FinishCharacterApplication ; continue at FinishCharacterApplication when the signed bound test succeeds
                    ldd       #23       ; prepare constant 23 for the surrounding operation
                    lbra      FinishCursorEffect ; resume finish cursor effect
ClampCursorDown     clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      StoreCursorColumn ; resume store cursor column
StoreCursorRow      clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       ClampCursorColumn ; resume clamp cursor column
HandleCursorUp      ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorColumn,y ; recover cursor column
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       >CurrentAttributes,y ; recover current attributes
                    std       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
ClampCursorColumn   std       >CursorRow,y ; retain cursor row
                    ldd       >CursorRow,y ; recover cursor row
                    cmpd      #23       ; test against #23
                    blt       HandleCursorUp ; signed comparison remains below its limit: handle cursor up
                    ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
StoreCursorColumn   std       >CursorColumn,y ; retain cursor column
                    ldd       >CursorColumn,y ; recover cursor column
                    cmpd      #80       ; test against #80
                    lblt      StoreCursorRow ; signed comparison remains below its limit: store cursor row
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorColumn,y ; retain cursor column
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      FinishCursorEffect ; resume finish cursor effect
ClampCursorUp       clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorColumn,y ; retain cursor column
                    lbra      FinishCharacterApplication ; resume finish character application
HandleCursorRight   ldb       $07,s     ; read the relevant word from the active stack frame
                    cmpb      #32       ; recognize the first printable ASCII value
                    bge       RecordRightMotion ; signed comparison reached its upper case: record right motion
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    lbge      FinishCharacterApplication ; signed comparison reached its upper case: finish character application
RecordRightMotion   ldd       >EditModeFlag,y ; recover edit mode flag
                    beq       AdvanceCursorRight ; zero result: advance cursor right
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorColumn,y ; recover cursor column
                    leax      d,x       ; select d
                    ldb       $07,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       >CurrentAttributes,y ; recover current attributes
                    std       ,x        ; retain
AdvanceCursorRight  ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
                    std       >CursorColumn,y ; retain cursor column
                    cmpd      #80       ; test against #80
                    blt       FinishCharacterApplication ; signed comparison remains below its limit: finish character application
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorColumn,y ; retain cursor column
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    std       >CursorRow,y ; retain cursor row
                    cmpd      #23       ; test against #23
                    blt       FinishCharacterApplication ; signed comparison remains below its limit: finish character application
                    ldd       #22       ; initialize cursor row to 22
FinishCursorEffect  std       >CursorRow,y ; retain cursor row
                    bra       FinishCharacterApplication ; resume finish character application
DispatchCursorEffect cmpx      #10       ; test against #10
                    lbeq      HandleCursorDown ; zero result: handle cursor down
                    cmpx      #12       ; test against #12
                    lbeq      ClampCursorDown ; zero result: clamp cursor down
                    cmpx      #13       ; test against #13
                    lbeq      ClampCursorUp ; zero result: clamp cursor up
                    lbra      HandleCursorRight ; resume handle cursor right
FinishCharacterApplication leas      $02,s     ; release $02,s bytes of stack state
ReturnCharacterResult puls      pc,u      ; restore pc,u and return to the caller

* Interpret a completed CSI sequence and mirror cursor movement, erasure,
* saved position, and SGR changes into the live editor model.
ParseAnsiSequence   pshs      u         ; preserve the caller data base
                    ldd       #-79      ; prepare constant -79 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$05,s    ; allocate $05,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >StreamBufferEndLow,y ; retain stream buffer end low
                    ldb       $0A,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      DispatchAnsiFinalByte ; resume dispatch ansi final byte
HandleCursorPosition ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       >AnsiParameters,y ; recover ansi parameters
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DecodeAnsiParameter ; decode ansi parameter
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       >AnsiParameters,y ; recover ansi parameters
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >CursorColumn,y ; retain cursor column
                    ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >CursorRow,y ; retain cursor row
                    lbra      FinishAnsiCommand ; resume finish ansi command
HandleCursorUpSequence clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       UseDefaultUpDistance ; resume use default up distance
MoveCursorUp        ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorRight ; emit ansi cursor right
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #-1       ; add to d using #-1
                    std       >CursorRow,y ; retain cursor row
                    bge       ClampUpDistance ; signed comparison reached its upper case: clamp up distance
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorRow,y ; retain cursor row
ClampUpDistance     ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
UseDefaultUpDistance std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; test against $03
                    bgt       MoveCursorUp ; continue at MoveCursorUp when the signed bound test succeeds
                    lbra      FinishAnsiCommand ; resume finish ansi command
HandleCursorDownSequence clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       UseDefaultDownDistance ; resume use default down distance
MoveCursorDown      ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
                    std       >CursorRow,y ; retain cursor row
                    cmpd      #23       ; test against #23
                    blt       ClampDownDistance ; signed comparison remains below its limit: clamp down distance
                    ldd       #22       ; initialize cursor row to 22
                    std       >CursorRow,y ; retain cursor row
                    bra       StoreDownDistance ; resume store down distance
ClampDownDistance   ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorLeft ; emit ansi cursor left
                    leas      $02,s     ; release $02,s bytes of stack state
StoreDownDistance   ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
UseDefaultDownDistance std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; test against $03
                    bgt       MoveCursorDown ; continue at MoveCursorDown when the signed bound test succeeds
                    lbra      FinishAnsiCommand ; resume finish ansi command
HandleCursorRightSequence clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       UseDefaultRightDistance ; resume use default right distance
MoveCursorRight     ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
                    std       >CursorColumn,y ; retain cursor column
                    cmpd      #79       ; test against #79
                    ble       ClampRightDistance ; continue at ClampRightDistance when the signed bound test succeeds
                    ldd       #79       ; initialize cursor column to 79
                    std       >CursorColumn,y ; retain cursor column
                    bra       StoreRightDistance ; resume store right distance
ClampRightDistance  ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorUp ; emit ansi cursor up
                    leas      $02,s     ; release $02,s bytes of stack state
StoreRightDistance  ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
UseDefaultRightDistance std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; test against $03
                    bgt       MoveCursorRight ; continue at MoveCursorRight when the signed bound test succeeds
                    lbra      FinishAnsiCommand ; resume finish ansi command
HandleCursorLeftSequence clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       UseDefaultLeftDistance ; resume use default left distance
MoveCursorLeft      ldd       >CursorColumn,y ; recover cursor column
                    addd      #-1       ; add to d using #-1
                    std       >CursorColumn,y ; retain cursor column
                    bge       ClampLeftDistance ; signed comparison reached its upper case: clamp left distance
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorColumn,y ; retain cursor column
                    bra       StoreLeftDistance ; resume store left distance
ClampLeftDistance   ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorDown ; emit ansi cursor down
                    leas      $02,s     ; release $02,s bytes of stack state
StoreLeftDistance   ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
UseDefaultLeftDistance std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >AnsiParameterCount,y ; recover ansi parameter count
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; test against $03
                    bgt       MoveCursorLeft ; continue at MoveCursorLeft when the signed bound test succeeds
                    lbra      FinishAnsiCommand ; resume finish ansi command
SaveAnsiCursor      ldd       >CursorColumn,y ; recover cursor column
                    std       >ForegroundColor,y ; retain foreground color
                    ldd       >CursorRow,y ; recover cursor row
                    std       >BackgroundColor,y ; retain background color
                    lbra      FinishAnsiCommand ; resume finish ansi command
RestoreAnsiCursor   ldd       >ForegroundColor,y ; recover foreground color
                    std       >CursorColumn,y ; retain cursor column
                    ldd       >BackgroundColor,y ; recover background color
                    std       >CursorRow,y ; retain cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DecodeAnsiParameter ; decode ansi parameter
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      FinishAnsiCommand ; resume finish ansi command
EraseDisplaySequence ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      AdvanceClearColumn ; resume advance clear column
StartClearRow       clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       AdvanceClearRow ; resume advance clear row
ClearScreenCell     ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       >CursorColumn,y ; recover cursor column
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       >CursorColumn,y ; recover cursor column
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       >CurrentAttributes,y ; recover current attributes
                    std       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    addd      #1        ; add to d using #1
AdvanceClearRow     std       >CursorRow,y ; retain cursor row
                    ldd       >CursorRow,y ; recover cursor row
                    cmpd      #23       ; test against #23
                    blt       ClearScreenCell ; signed comparison remains below its limit: clear screen cell
                    ldd       >CursorColumn,y ; recover cursor column
                    addd      #1        ; add to d using #1
AdvanceClearColumn  std       >CursorColumn,y ; retain cursor column
                    ldd       >CursorColumn,y ; recover cursor column
                    cmpd      #80       ; test against #80
                    lblt      StartClearRow ; signed comparison remains below its limit: start clear row
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >CursorRow,y ; retain cursor row
                    std       >CursorColumn,y ; retain cursor column
                    lbra      FinishAnsiCommand ; resume finish ansi command
EraseLineSequence   ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitAnsiCursorHome ; emit ansi cursor home
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CursorColumn,y ; recover cursor column
                    bra       AdvanceEraseColumn ; resume advance erase column
ClearLineCell       ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       >CursorRow,y ; recover cursor row
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,x        ; retain
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceEraseColumn  std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    cmpd      #80       ; test against #80
                    blt       ClearLineCell ; signed comparison remains below its limit: clear line cell
                    lbra      FinishAnsiCommand ; resume finish ansi command
ResetGraphicsSequence clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      AdvanceSgrParameter ; resume advance sgr parameter
ReadNextSgrParameter ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      DispatchSgrParameter ; resume dispatch sgr parameter
ResetAllGraphics    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitBackgroundColor ; emit background color
                    leas      $04,s     ; release $04,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EnableUnderlineAttribute ; enable underline attribute
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EnableReverseAttribute ; enable reverse attribute
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      PauseForBanner ; pause for banner
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
SetBoldBit          ldd       >CurrentAttributes,y ; recover current attributes
                    ora       #16       ; set selected bits in a using #16
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
SetUnderlineBit     ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EnableBoldAttribute ; enable bold attribute
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    ora       #1        ; set selected bits in a using #1
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
SetBlinkBit         ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EnableBlinkAttribute ; enable blink attribute
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    ora       #2        ; set selected bits in a using #2
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
SetReverseBit       ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      InitializeTerminalDisplay ; initialize terminal display
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    ora       #4        ; set selected bits in a using #4
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
SetInvisibleBit     ldd       >CurrentAttributes,y ; recover current attributes
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >AnsiColorCodeTable,y ; select ansi color code table
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    ora       #8        ; set selected bits in a using #8
                    lbra      StoreUpdatedAttributes ; resume store updated attributes
CheckForegroundCode ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    cmpb      #30       ; prepare constant 30 for the surrounding operation
                    lblt      CheckBackgroundCode ; signed comparison remains below its limit: check background code
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    cmpb      #38       ; prepare constant 38 for the surrounding operation
                    bge       CheckBackgroundCode ; signed comparison reached its upper case: check background code
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    addd      #-30      ; add to d using #-30
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >AnsiColorCodeTable,y ; select ansi color code table
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitForegroundColor ; emit foreground color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    andb      #15       ; mask b using #15
                    std       >CurrentAttributes,y ; retain current attributes
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    addd      #-30      ; add to d using #-30
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    lbra      MergeColorBits ; resume merge color bits
CheckBackgroundCode ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    cmpb      #40       ; prepare constant 40 for the surrounding operation
                    lblt      NextSgrParameter ; signed comparison remains below its limit: next sgr parameter
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    cmpb      #48       ; recognize or generate ASCII zero
                    lbge      NextSgrParameter ; signed comparison reached its upper case: next sgr parameter
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >AnsiColorCodeTable,y ; select ansi color code table
                    leax      d,x       ; select d
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EmitBackgroundColor ; emit background color
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       >CurrentAttributes,y ; recover current attributes
                    andb      #240      ; mask b using #240
                    std       >CurrentAttributes,y ; retain current attributes
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
MergeColorBits      ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
StoreUpdatedAttributes std       >CurrentAttributes,y ; retain current attributes
                    bra       NextSgrParameter ; resume next sgr parameter
DispatchSgrParameter stx       -$02,s    ; store x in the current stack frame at -$02,s
                    lbeq      ResetAllGraphics ; zero result: reset all graphics
                    cmpx      #1        ; test against #1
                    lbeq      SetBoldBit ; zero result: set bold bit
                    cmpx      #4        ; test against #4
                    lbeq      SetUnderlineBit ; zero result: set underline bit
                    cmpx      #5        ; test against #5
                    lbeq      SetBlinkBit ; zero result: set blink bit
                    cmpx      #7        ; test against #7
                    lbeq      SetReverseBit ; zero result: set reverse bit
                    cmpx      #8        ; test against #8
                    lbeq      SetInvisibleBit ; zero result: set invisible bit
                    lbra      CheckForegroundCode ; resume check foreground code
NextSgrParameter    ldd       $03,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceSgrParameter std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    cmpd      >dpsiz,y  ; test against dpsiz
                    lblt      ReadNextSgrParameter ; signed comparison remains below its limit: read next sgr parameter
                    bra       FinishAnsiCommand ; resume finish ansi command
DispatchAnsiFinalByte cmpx      #72       ; test against #72
                    lbeq      HandleCursorPosition ; zero result: handle cursor position
                    cmpx      #102      ; test against #102
                    lbeq      HandleCursorPosition ; zero result: handle cursor position
                    cmpx      #65       ; test against #65
                    lbeq      HandleCursorUpSequence ; zero result: handle cursor up sequence
                    cmpx      #66       ; test against #66
                    lbeq      HandleCursorDownSequence ; zero result: handle cursor down sequence
                    cmpx      #67       ; test against #67
                    lbeq      HandleCursorRightSequence ; zero result: handle cursor right sequence
                    cmpx      #68       ; test against #68
                    lbeq      HandleCursorLeftSequence ; zero result: handle cursor left sequence
                    cmpx      #115      ; test against #115
                    lbeq      SaveAnsiCursor ; zero result: save ansi cursor
                    cmpx      #117      ; test against #117
                    lbeq      RestoreAnsiCursor ; zero result: restore ansi cursor
                    cmpx      #74       ; test against #74
                    lbeq      EraseDisplaySequence ; zero result: erase display sequence
                    cmpx      #107      ; test against #107
                    lbeq      EraseLineSequence ; zero result: erase line sequence
                    cmpx      #109      ; test against #109
                    lbeq      ResetGraphicsSequence ; zero result: reset graphics sequence
FinishAnsiCommand   bsr       RenderStatusLine ; render status line
                    leas      $05,s     ; release $05,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Repaint mode, cursor, cell, attribute, and color status without changing the
* editable canvas.
RenderStatusLine    pshs      u         ; preserve the caller data base
                    ldd       #-66      ; prepare constant -66 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    bra       StartStatusColumnScan ; resume start status column scan
RenderNextStatusColumn ldd       ,s        ; recover
                    leax      >AnsiParameterCount,y ; select ansi parameter count
                    leax      d,x       ; select d
                    ldd       #1        ; initialize  to 1
                    stb       ,x        ; retain
                    ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
StartStatusColumnScan std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; recover
                    cmpd      #10       ; test against #10
                    blt       RenderNextStatusColumn ; signed comparison remains below its limit: render next status column
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >dpsiz,y  ; retain dpsiz
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >StreamBufferStartLow,y ; retain stream buffer start low
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Scan the canvas and append meaningful cells, using cursor commands to bridge
* empty gaps instead of dumping all 1,840 positions.
MergeScreenIntoOutput pshs      u         ; preserve the caller data base
                    ldd       #-80      ; prepare constant -80 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$08,s    ; allocate $08,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      StartScreenRenderRow ; resume start screen render row
StartScreenRenderColumn clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    lbra      AdvanceRenderColumn ; resume advance render column
RenderOccupiedCell  ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    lbeq      RenderCellState ; zero result: render cell state
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    cmpd      $06,s     ; test against $06
                    bne       SkipEmptyScreenCell ; nonzero result: skip empty screen cell
                    ldd       ,s        ; recover
                    cmpd      $04,s     ; test against $04
                    lbeq      EmitCursorMoveForCell ; zero result: emit cursor move for cell
SkipEmptyScreenCell ldd       >OutputLength,y ; recover output length
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; test against #8192
                    lbge      AppendCursorColumnDigits ; signed comparison reached its upper case: append cursor column digits
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #27       ; initialize  to 27
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #91       ; initialize  to 91
                    stb       ,x        ; retain
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; test against #10
                    blt       AppendCursorRowDigits ; signed comparison remains below its limit: append cursor row digits
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedQuotient ; unsigned quotient
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
AppendCursorRowDigits ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedRemainder ; unsigned remainder
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #59       ; initialize  to 59
                    stb       ,x        ; retain
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; test against #10
                    blt       AppendCellCharacter ; signed comparison remains below its limit: append cell character
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedQuotient ; unsigned quotient
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
AppendCellCharacter ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedRemainder ; unsigned remainder
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #72       ; initialize  to 72
                    stb       ,x        ; retain
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       EmitCursorMoveForCell ; resume emit cursor move for cell
AppendCursorColumnDigits ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
EmitCursorMoveForCell ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       ,x        ; recover
                    cmpd      >CurrentAttributes,y ; test against current attributes
                    beq       AfterRenderedCharacter ; zero result: after rendered character
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    ldd       ,x        ; recover
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendSgrSequence ; append sgr sequence
                    leas      $02,s     ; release $02,s bytes of stack state
AfterRenderedCharacter ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #79       ; test against #79
                    ble       RenderCellState ; continue at RenderCellState when the signed bound test succeeds
                    ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #22       ; test against #22
                    ble       ClampNextRenderRow ; continue at ClampNextRenderRow when the signed bound test succeeds
                    ldd       #22       ; initialize  to 22
                    std       ,s        ; store d in the current stack frame at ,s
ClampNextRenderRow  clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
RenderCellState     ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #80       ; prepare constant 80 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenCharacters,y ; select screen characters
                    leax      d,x       ; select d
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    leax      d,x       ; select d
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       ,x        ; retain
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #160      ; prepare constant 160 for the surrounding operation
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    leax      >ScreenAttributes,y ; select screen attributes
                    leax      d,x       ; select d
                    tfr       x,d       ; transfer x,d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; transfer d,x
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,x        ; retain
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
AdvanceRenderColumn std       $06,s     ; store d in the current stack frame at $06,s
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    cmpd      #80       ; test against #80
                    lblt      RenderOccupiedCell ; signed comparison remains below its limit: render occupied cell
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
StartScreenRenderRow std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    cmpd      #23       ; test against #23
                    lblt      StartScreenRenderColumn ; signed comparison remains below its limit: start screen render column
                    leas      $08,s     ; release $08,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Append an SGR sequence reproducing the packed attribute/color word and make
* it the current recorded style.
AppendSgrSequence   pshs      u         ; preserve the caller data base
                    ldd       #-70      ; prepare constant -70 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    ldd       >OutputLength,y ; recover output length
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; test against #8192
                    bge       OutputFullBeforeSgr ; signed comparison reached its upper case: output full before sgr
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #27       ; initialize  to 27
                    stb       ,x        ; retain
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #91       ; initialize  to 91
                    stb       ,x        ; retain
                    bra       BeginSgrParameters ; resume begin sgr parameters
OutputFullBeforeSgr ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
BeginSgrParameters  clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    anda      #16       ; mask a using #16
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       SkipBoldParameter ; zero result: skip bold parameter
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipBoldParameter   ldd       $04,s     ; read the relevant word from the active stack frame
                    anda      #1        ; mask a using #1
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       SkipUnderlineParameter ; zero result: skip underline parameter
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipUnderlineParameter ldd       $04,s     ; read the relevant word from the active stack frame
                    anda      #2        ; mask a using #2
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       SkipBlinkParameter ; zero result: skip blink parameter
                    ldd       #5        ; prepare constant 5 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipBlinkParameter  ldd       $04,s     ; read the relevant word from the active stack frame
                    anda      #4        ; mask a using #4
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       SkipReverseParameter ; zero result: skip reverse parameter
                    ldd       #7        ; prepare constant 7 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipReverseParameter ldd       $04,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #240      ; mask b using #240
                    beq       SkipForegroundParameter ; zero result: skip foreground parameter
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #240      ; mask b using #240
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    addd      #30       ; add to d using #30
                    pshs      d         ; pass or retain this word through the compiler ABI
                    bsr       AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipForegroundParameter ldd       $04,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    beq       SkipBackgroundParameter ; zero result: skip background parameter
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    addd      #40       ; add to d using #40
                    pshs      d         ; pass or retain this word through the compiler ABI
                    bsr       AppendDecimalParameter ; append decimal parameter
                    leas      $02,s     ; release $02,s bytes of stack state
SkipBackgroundParameter ldd       $04,s     ; read the relevant word from the active stack frame
                    std       >CurrentAttributes,y ; retain current attributes
                    ldd       >OutputLength,y ; recover output length
                    addd      #-1       ; add to d using #-1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #109      ; initialize  to 109
                    stb       ,x        ; retain
                    puls      pc,u      ; restore pc,u and return to the caller

* Append a decimal cursor or SGR parameter, including a tens digit only when
* the value requires one.
AppendDecimalParameter pshs      u         ; preserve the caller data base
                    ldd       #-72      ; prepare constant -72 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    ldd       >OutputLength,y ; recover output length
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; test against #8192
                    lbge      OutputFullBeforeNumber ; signed comparison reached its upper case: output full before number
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    cmpd      #10       ; test against #10
                    blt       AppendOnesDigit ; signed comparison remains below its limit: append ones digit
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedQuotient ; unsigned quotient
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
AppendOnesDigit     ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      UnsignedRemainder ; unsigned remainder
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >OutputLength,y ; recover output length
                    addd      #1        ; add to d using #1
                    std       >OutputLength,y ; retain output length
                    subd      #1        ; subtract from d using #1
                    leax      >OutputBuffer,y ; select output buffer
                    leax      d,x       ; select d
                    ldd       #59       ; initialize  to 59
                    stb       ,x        ; retain
                    bra       ReturnFromDecimalAppend ; resume return from decimal append
OutputFullBeforeNumber ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SignalOutputOverflow ; signal output overflow
                    leas      $02,s     ; release $02,s bytes of stack state
ReturnFromDecimalAppend puls      pc,u      ; restore pc,u and return to the caller

* Put the terminal path into the raw mode needed for ALT and escape handling.
SetTerminalRawMode  pshs      u         ; preserve the caller data base
                    ldd       #-106     ; prepare constant -106 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$20,s    ; allocate $20,s bytes of stack state
                    leax      ,s        ; select
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      GetPathStatus ; obtain the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldb       <$0025,s  ; read the relevant word from the active stack frame
                    stb       $04,s     ; store b in the current stack frame at $04,s
                    leax      ,s        ; select
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SetPathStatus ; apply the prepared OS-9 path-status request
                    leas      $06,s     ; release $06,s bytes of stack state
                    leas      <$0020,s  ; release <$0020,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller

* Show an I/O error in a temporary window, wait for acknowledgement, and then
* restore the canvas and status display.
ReportEditorError   pshs      u         ; preserve the transfer-menu frame
                    ldd       #-85      ; prepare constant -85 for the surrounding operation
                    lbsr      _stkcheck ; ensure the C stack has room for this frame
                    leas      -$01,s    ; allocate $01,s bytes of stack state
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #6        ; prepare constant 6 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #40       ; prepare constant 40 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #3        ; prepare constant 3 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #38       ; prepare constant 38 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #4        ; prepare constant 4 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #11       ; prepare constant 11 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      DefineEditorWindow ; define editor window
                    leas      <$0010,s  ; release <$0010,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ClearEditorScreen ; clear editor screen
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      MeasureCString ; measure cstring
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #2        ; prepare constant 2 for the surrounding operation
                    lbsr      UnsignedQuotient ; unsigned quotient
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #19       ; prepare constant 19 for the surrounding operation
                    subd      ,s++      ; subtract from d using ,s++
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >Spaces,pc ; select spaces
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       $05,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >String,pc ; select string
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       $07,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >ErrNum,pc ; select err num
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      printf    ; render the prepared formatted text
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; select $02
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      read      ; collect the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      EndEditorWindow ; end editor window
                    leas      $02,s     ; release $02,s bytes of stack state
                    leas      $01,s     ; release $01,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcc       "Black"
                    fcb       $00
                    fcc       "Red"
                    fcb       $00
                    fcc       "Green"
                    fcb       $00
                    fcc       "Yellow"
                    fcb       $00
                    fcc       "Blue"
                    fcb       $00
                    fcc       "Magenta"
                    fcb       $00
                    fcc       "Cyan"
                    fcb       $00
                    fcc       "White"
                    fcb       $00
savprmpt            fcb       $0D
                    fcc       " Filename to save:"
                    fcb       $00
Title               fcc       "Ansi Graphic"
                    fcb       $7F
                    fcc       " Editor, Version 1.0      "
                    fcb       $0D
                    fcb       $00
Copyright           fcc       "Copyright (c) 1989, By Keith Alphonso  "
                    fcb       $0D
                    fcb       $00
License             fcc       "Licensed to Alpha Software Technologies"
                    fcb       $0D
                    fcb       $00
Rights              fcc       "All rights reserved                    "
                    fcb       $0D
                    fcb       $00
CantOpen1           fcc       "Cannot open output file"
                    fcb       $00
PutScrn             fcb       $0D
                    fcc       "Put Screen into Buffer?"
                    fcb       $00
ClrScrn             fcb       $0D
                    fcc       "Start with clear screen?"
                    fcb       $00
CantOpen2           fcc       "Cannot open file"
                    fcb       $00
ReadFile            fcb       $0D
                    fcc       "Read file to [O]utput buffer or [S]creen buffer"
                    fcb       $00
AddLf               fcb       $0D
                    fcc       "Add line feeds to carriage returns?"
                    fcb       $00
Status              fcc       "X=%2d Y=%2d   Status:"
                    fcb       $00
Editing             fcc       "EDITING  "
                    fcb       $00
Recording           fcc       "RECORDING"
                    fcb       $00
CharDump            fcc       "  Char:%1c"
                    fcb       $00
Char                fcc       "  Char: "
                    fcb       $00
Attrs               fcc       "  Attrs:"
                    fcb       $00
UnderlineStatusOn   fcc       "U"
                    fcb       $00
UnderlineStatusOff  fcc       " "
                    fcb       $00
BlinkStatusOn       fcc       "L"
                    fcb       $00
BlinkStatusOff      fcc       " "
                    fcb       $00
ReverseStatusOn     fcc       "V"
                    fcb       $00
ReverseStatusOff    fcc       " "
                    fcb       $00
InvisibleStatusOn   fcc       "I"
                    fcb       $00
InvisibleStatusOff  fcc       " "
                    fcb       $00
BoldStatusOn        fcc       "O"
                    fcb       $00
BoldStatusOff       fcc       " "
                    fcb       $00
ColorsOn            fcc       " Colors:%7s on %7s"
                    fcb       $00
ColorsBW            fcc       " Colors:White   on Black  "
                    fcb       $00
Help                fcc       "           Ansi-Editor  Help"
                    fcb       $0D
                    fcb       $00
Line                fcc       "--------------------------------------"
                    fcb       $0D
                    fcb       $00
AltG                fcc       " [ALT][G] - Set graphics"
                    fcb       $0D
                    fcb       $00
AltR                fcc       " [ALT][R] - Record mode"
                    fcb       $0D
                    fcb       $00
AltE                fcc       " [ALT][E] - Edit mode"
                    fcb       $0D
                    fcb       $00
AltC                fcc       " [ALT][C] - Clear screen"
                    fcb       $0D
                    fcb       $00
AltN                fcc       " [ALT][N] - Clear to end of line"
                    fcb       $0D
                    fcb       $00
AltS                fcc       " [ALT][S] - Save cursor position"
                    fcb       $0D
                    fcb       $00
AltA                fcc       " [ALT][A] - Restore cursor position"
                    fcb       $0D
                    fcb       $00
AltP                fcc       " [ALT][P] - Put screen into buffer"
                    fcb       $0D
                    fcb       $00
AltL                fcc       " [ALT][L] - Load from file"
                    fcb       $0D
                    fcb       $00
AltK                fcc       " [ALT][K] - Save to file"
                    fcb       $0D
                    fcb       $00
AltZ                fcc       " [ALT][Z] - Zap buffers"
                    fcb       $0D
                    fcb       $00
AltX                fcc       " [ALT][X] - Save & Exit"
                    fcb       $0D
                    fcb       $00
AltQ                fcc       " [ALT][Q] - Quit without save"
                    fcb       $0D
                    fcb       $00
Sure                fcb       $0D
                    fcc       "  Are you sure?"
                    fcb       $00
Title2              fcc       "ANSI Graphics Editor, Version 1.0      "
                    fcb       $0D
                    fcb       $00
CpyRite2            fcc       "Copyright (c) 1989, By Keith Alphonso  "
                    fcb       $0D
                    fcb       $00
License2            fcc       "Licensed to Alpha Software Technologies"
                    fcb       $0D
                    fcb       $00
Rights2             fcc       "All rights reserved                    "
                    fcb       $0D
                    fcb       $00
LoadPrompt          fcb       $0D
                    fcc       " Filename to load:"
                    fcb       $00
SavePrompt          fcb       $0D
                    fcc       " Filename to save:"
                    fcb       $00
PosSaved            fcb       $0D
                    fcc       "Position Saved!!"
                    fcb       $0D
                    fcb       $00
PosRestrd           fcb       $0D
                    fcc       "Position Restored"
                    fcb       $0D
                    fcb       $00
MovBuff             fcb       $0D
                    fcc       " Moving screen buffer..."
                    fcb       $0D
                    fcb       $00
Zap                 fcb       $0D
                    fcc       "Zap:   S> Screen Buffer"
                    fcb       $0D
                    fcb       $00
RecBuff             fcc       "       R> Record Buffer"
                    fcb       $0D
                    fcb       $00
BothBuffs           fcc       "       B> Both   buffers"
                    fcb       $0D
                    fcb       $00
ScrnChar            fcc       "       D> Screen Character"
                    fcb       $0D
                    fcb       $00
RecChar             fcc       "       T> Record Character"
                    fcb       $0D
                    fcb       $00
Choose              fcc       "Your Choice:"
                    fcb       $00
Sure2               fcb       $0C
                    fcb       $0D
                    fcb       $0D
                    fcc       "     Are you sure?"
                    fcb       $00
BlankForegroundChoice fcc       " "
                    fcb       $00
BlankBackgroundChoice fcc       " "
                    fcb       $00
SetGraphs           fcc       "             Set  Graphics"
                    fcb       $0D
                    fcb       $00
Line2               fcc       "           -----------------"
                    fcb       $0D
                    fcb       $0D
                    fcb       $00
RestGraph           fcc       "[R] - Reset Graphics (white on black)"
                    fcb       $0D
                    fcb       $00
BoldOn              fcc       "[O] - Bold on"
                    fcb       $0D
                    fcb       $00
UndrOn              fcc       "[U] - Underscore on"
                    fcb       $0D
                    fcb       $00
BlnkOn              fcc       "[L] - Blink on"
                    fcb       $0D
                    fcb       $00
RevVidOn            fcc       "[V] - Reverse Video on"
                    fcb       $0D
                    fcb       $00
InvisOn             fcc       "[I] - Invisible on"
                    fcb       $0D
                    fcb       $00
SetForClr           fcc       "[F] - Set foreground color"
                    fcb       $0D
                    fcb       $00
SetBckClr           fcc       "[B] - Set background color"
                    fcb       $0D
                    fcb       $00
Done                fcc       "[D] - Done"
                    fcb       $0D
                    fcb       $00
SelChoice           fcb       $0D
                    fcc       "Select your choice:"
                    fcb       $00
NumString           fcc       "%1d: %s"
                    fcb       $0D
                    fcb       $00
ClrNum              fcb       $0D
                    fcc       "Color #:"
                    fcb       $00
Spaces              fcc       "                    "
                    fcb       $00
String              fcc       "%s"
                    fcb       $0D
                    fcb       $00
ErrNum              fcb       $0D
                    fcc       "               ERROR %03d"
                    fcb       $0D
                    fcb       $00
printf              pshs      u         ; preserve the caller data base
                    leax      >TerminalOutputStream,y ; select terminal output stream
                    stx       >AnsiParserValue,y ; retain ansi parser value
                    leax      $06,s     ; select $06
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    bra       InvokeFormatEngine ; resume invoke format engine
                    pshs      u         ; preserve the caller data base
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    std       >AnsiParserValue,y ; retain ansi parser value
                    leax      $08,s     ; select $08
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
InvokeFormatEngine  pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >FormatSignedValue,pc ; select format signed value
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    bsr       FormatOutputCore ; format the next conversion into the output stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; preserve the caller data base
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    std       >AnsiParserValue,y ; retain ansi parser value
                    leax      $08,s     ; select $08
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >FormatPositiveValue,pc ; select format positive value
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    bsr       FormatOutputCore ; format the next conversion into the output stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [>$37B5,y] ; retain [>$37 b5
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    puls      pc,u      ; restore pc,u and return to the caller
FormatOutputCore    pshs      u         ; preserve the caller while formatting
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    leas      -$0B,s    ; allocate $0B,s bytes of stack state
                    bra       ScanFormatString ; resume scan format string
EmitLiteralFormatByte ldb       $08,s     ; read the relevant word from the active stack frame
                    lbeq      FinishFormattedOutput ; zero result: finish formatted output
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$11,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
ScanFormatString    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; prepare constant 37 for the surrounding operation
                    bne       EmitLiteralFormatByte ; nonzero result: emit literal format byte
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    cmpb      #45       ; prepare constant 45 for the surrounding operation
                    bne       ReturnFormattedCount ; nonzero result: return formatted count
                    ldd       #1        ; initialize runtime format flags to 1
                    std       >RuntimeFormatFlags,y ; retain runtime format flags
                    ldb       ,u+       ; consume the next byte while scan format string
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       SelectFormatPadding ; resume select format padding
ReturnFormattedCount clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       >RuntimeFormatFlags,y ; retain runtime format flags
SelectFormatPadding ldb       $08,s     ; read the relevant word from the active stack frame
                    cmpb      #48       ; recognize or generate ASCII zero
                    bne       UseSpacePadding ; nonzero result: use space padding
                    ldd       #48       ; recognize or generate ASCII zero
                    bra       SaveFormatWidth ; resume save format width
UseSpacePadding     ldd       #32       ; recognize the first printable ASCII value
SaveFormatWidth     std       >RuntimeFormatLength,y ; retain runtime format length
                    bra       ParseFieldWidth ; resume parse field width
AccumulateFieldWidth ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       $0A,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; consume the next byte while accumulate field width
                    stb       $08,s     ; store b in the current stack frame at $08,s
ParseFieldWidth     ldb       $08,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulateFieldWidth ; repeat accumulate field width until the terminating condition is met
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    cmpb      #46       ; prepare constant 46 for the surrounding operation
                    bne       NoPrecisionSpecified ; nonzero result: no precision specified
                    ldd       #1        ; initialize $04 to 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       ParsePrecisionDigits ; resume parse precision digits
AccumulatePrecision ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       $0A,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
ParsePrecisionDigits ldb       ,u+       ; consume the next byte while parse precision digits
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulatePrecision ; repeat accumulate precision until the terminating condition is met
                    bra       DispatchConversion ; resume dispatch conversion
NoPrecisionSpecified clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $04,s     ; store d in the current stack frame at $04,s
DispatchConversion  ldb       $08,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    lbra      MatchConversionType ; resume match conversion type
FormatSignedDecimal ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldx       <$0015,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ConvertSignedDecimal ; convert signed decimal
                    bra       StoreConvertedPointer ; resume store converted pointer
FormatOctal         ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldx       <$0015,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ConvertOctal ; convert octal
StoreConvertedPointer std       ,s        ; store d in the current stack frame at ,s
                    lbra      WriteConvertedField ; resume write converted field
FormatHexadecimal   ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       $0A,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #2        ; mask b using #2
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldx       <$0017,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      FormatSignedMinimum ; format signed minimum
                    lbra      RestoreFormatStack ; resume restore format stack
FormatUnsignedDecimal ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldx       <$0015,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; recover -$02
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      ConvertUnsignedDecimal ; convert unsigned decimal
                    lbra      RestoreFormatStack ; resume restore format stack
FormatFloatingValue ldd       $04,s     ; read the relevant word from the active stack frame
                    bne       ConvertFloatingValue ; nonzero result: convert floating value
                    ldd       #6        ; initialize $02 to 6
                    std       $02,s     ; store d in the current stack frame at $02,s
ConvertFloatingValue ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0015,s  ; select $0015
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       $0E,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReturnEmptyString ; return empty string
                    leas      $06,s     ; release $06,s bytes of stack state
                    lbra      PassConvertedField ; resume pass converted field
FormatCharacterValue ldx       <$0013,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    lbra      EmitScalarValue ; resume emit scalar value
FormatStringValue   ldx       <$0013,s  ; read the relevant word from the active stack frame
                    leax      $02,x     ; select $02
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; recover -$02
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    beq       StringWidthReady ; zero result: string width ready
                    ldd       $09,s     ; read the relevant word from the active stack frame
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       MeasureBoundedString ; resume measure bounded string
CountStringByte     ldb       [<$09,s]  ; recover [<$09
                    beq       EmitFormattedField ; zero result: emit formatted field
                    ldd       $09,s     ; read the relevant word from the active stack frame
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
MeasureBoundedString ldd       $02,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       CountStringByte ; nonzero result: count string byte
EmitFormattedField  ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $0B,s     ; read the relevant word from the active stack frame
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       <$0015,s  ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      WritePaddedField ; write padded field
                    leas      $08,s     ; release $08,s bytes of stack state
                    bra       ResumeFormatScan ; resume resume format scan
StringWidthReady    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $0B,s     ; read the relevant word from the active stack frame
                    bra       PassConvertedField ; resume pass converted field
AcceptLongModifier  ldb       ,u+       ; consume the next byte while accept long modifier
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       FormatLongValue ; resume format long value
                    leas      -$0B,x    ; allocate $0B,x bytes of stack state
FormatLongValue     ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      <$0015,s  ; select $0015
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldb       $0C,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      SelectIntegerArgument ; select integer argument
RestoreFormatStack  leas      $04,s     ; release $04,s bytes of stack state
PassConvertedField  pshs      d         ; pass or retain this word through the compiler ABI
WriteConvertedField ldd       <$0013,s  ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      WritePaddedString ; write padded string
                    leas      $06,s     ; release $06,s bytes of stack state
ResumeFormatScan    lbra      ScanFormatString ; resume scan format string
EmitUnknownSpecifier ldb       $08,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
EmitScalarValue     pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$11,s]  ; the callback selected by the runtime descriptor
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
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    bge       ConvertSignedMagnitude ; signed comparison reached its upper case: convert signed magnitude
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       PrefixMinusSign ; signed comparison reached its upper case: prefix minus sign
                    leax      >SignedMinimumText,pc ; select signed minimum text
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    lbsr      CopyCString ; copy cstring
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      ReleaseFormatFrame ; resume release format frame
PrefixMinusSign     ldd       #45       ; initialize  to 45
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ConvertSignedMagnitude ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    bsr       ConvertUnsignedDecimal ; convert unsigned decimal
                    leas      $04,s     ; release $04,s bytes of stack state
                    lbra      UseSignedConversionBuffer ; resume use signed conversion buffer
ConvertUnsignedDecimal pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       SelectFormatArgument ; resume select format argument
IncreaseDecimalDigitCount ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; read the relevant word from the active stack frame
                    subd      >StartupArgumentState,y ; subtract from d using >StartupArgumentState,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
SelectFormatArgument ldd       $0C,s     ; read the relevant word from the active stack frame
                    blt       IncreaseDecimalDigitCount ; signed comparison remains below its limit: increase decimal digit count
                    leax      >StartupArgumentState,y ; select startup argument state
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       EmitDecimalDigits ; resume emit decimal digits
AdvanceDecimalDigit ldd       ,s        ; recover
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
SubtractDecimalPlace ldd       $0C,s     ; read the relevant word from the active stack frame
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       AdvanceDecimalDigit ; signed comparison reached its upper case: advance decimal digit
                    ldd       $0C,s     ; read the relevant word from the active stack frame
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; recover
                    beq       MarkDecimalStarted ; zero result: mark decimal started
                    ldd       #1        ; initialize $02 to 1
                    std       $02,s     ; store d in the current stack frame at $02,s
MarkDecimalStarted  ldd       $02,s     ; read the relevant word from the active stack frame
                    beq       AdvanceDecimalDivisor ; zero result: advance decimal divisor
                    ldd       ,s        ; recover
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
AdvanceDecimalDivisor clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
EmitDecimalDigits   ldd       $04,s     ; read the relevant word from the active stack frame
                    cmpd      >StartupParameterLength,y ; test against startup parameter length
                    bne       SubtractDecimalPlace ; nonzero result: subtract decimal place
                    ldd       $0C,s     ; read the relevant word from the active stack frame
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       StreamCursorHigh,u ; retain stream cursor high
                    ldd       $0A,s     ; read the relevant word from the active stack frame
                    leas      $06,s     ; release $06,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
ConvertOctal        pshs      u,d       ; save u,d on the stack
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >NumericConversionBuffer,y ; select numeric conversion buffer
ExtractOctalDigit   ldd       $06,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #7        ; mask b using #7
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; retain
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bne       ExtractOctalDigit ; nonzero result: extract octal digit
                    bra       ReverseOctalDigits ; resume reverse octal digits
CopyOctalDigit      ldb       StreamCursorHigh,u ; recover stream cursor high
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseOctalDigits  leau      -$01,u    ; select -$01
                    pshs      u         ; preserve the caller data base
                    leax      >NumericConversionBuffer,y ; select numeric conversion buffer
                    cmpx      ,s++      ; test against
                    bls       CopyOctalDigit ; continue copy octal digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [,s]      ; store b in the current stack frame at [,s]
UseSignedConversionBuffer leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    tfr       x,d       ; transfer x,d
ReleaseFormatFrame  leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
FormatSignedMinimum pshs      u,x,d     ; save u,x,d on the stack
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >NumericConversionBuffer,y ; select numeric conversion buffer
ExtractHexDigit     ldd       $08,s     ; read the relevant word from the active stack frame
                    clra                ; select standard input
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    cmpd      #9        ; test against #9
                    ble       UseNumericHexDigit ; continue at UseNumericHexDigit when the signed bound test succeeds
                    ldd       $0C,s     ; read the relevant word from the active stack frame
                    beq       UseLowercaseHexBase ; zero result: use lowercase hex base
                    ldd       #65       ; prepare constant 65 for the surrounding operation
                    bra       AdjustHexAlphabeticDigit ; resume adjust hex alphabetic digit
UseLowercaseHexBase ldd       #97       ; prepare constant 97 for the surrounding operation
AdjustHexAlphabeticDigit addd      #-10      ; add to d using #-10
                    bra       StoreHexDigit ; resume store hex digit
UseNumericHexDigit  ldd       #48       ; recognize or generate ASCII zero
StoreHexDigit       addd      ,s++      ; add to d using ,s++
                    stb       ,u+       ; retain
                    ldd       $08,s     ; read the relevant word from the active stack frame
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
CopyHexDigit        ldb       StreamCursorHigh,u ; recover stream cursor high
                    ldx       $02,s     ; read the relevant word from the active stack frame
                    leax      $01,x     ; select $01
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; replace the byte just examined in place
ReverseHexDigits    leau      -$01,u    ; select -$01
                    pshs      u         ; preserve the caller data base
                    leax      >NumericConversionBuffer,y ; select numeric conversion buffer
                    cmpx      ,s++      ; test against
                    bls       CopyHexDigit ; continue copy hex digit while the range test permits it
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >DecimalConversionBuffer,y ; select decimal conversion buffer
                    tfr       x,d       ; transfer x,d
                    lbra      FinishFieldWriter ; resume finish field writer
WritePaddedField    pshs      u         ; preserve the caller data base
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    ldd       $0A,s     ; read the relevant word from the active stack frame
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >RuntimeFormatFlags,y ; recover runtime format flags
                    bne       EmitFieldBytes ; nonzero result: emit field bytes
                    bra       EmitLeadingPadding ; resume emit leading padding
ReturnAfterLeadingPad ldd       >RuntimeFormatLength,y ; recover runtime format length
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitLeadingPadding  ldd       $0A,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       ReturnAfterLeadingPad ; continue at ReturnAfterLeadingPad when the signed bound test succeeds
                    bra       EmitFieldBytes ; resume emit field bytes
EmitNextFieldByte   ldb       ,u+       ; consume the next byte while emit next field byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitFieldBytes      ldd       $08,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       EmitNextFieldByte ; nonzero result: emit next field byte
                    ldd       >RuntimeFormatFlags,y ; recover runtime format flags
                    beq       ReturnPaddedField ; zero result: return padded field
                    bra       EmitTrailingPadding ; resume emit trailing padding
ReturnAfterTrailingPad ldd       >RuntimeFormatLength,y ; recover runtime format length
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitTrailingPadding ldd       $0A,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       ReturnAfterTrailingPad ; continue at ReturnAfterTrailingPad when the signed bound test succeeds
ReturnPaddedField   puls      pc,u      ; restore pc,u and return to the caller
WritePaddedString   pshs      u         ; preserve the caller data base
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    ldd       $08,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    pshs      u         ; preserve the caller data base
                    lbsr      MeasureCString ; measure cstring
                    leas      $02,s     ; release $02,s bytes of stack state
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >RuntimeFormatFlags,y ; recover runtime format flags
                    bne       EmitStringBytes ; nonzero result: emit string bytes
                    bra       EmitStringLeadingPadding ; resume emit string leading padding
ReturnAfterStringLeadingPad ldd       >RuntimeFormatLength,y ; recover runtime format length
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringLeadingPadding ldd       $08,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       ReturnAfterStringLeadingPad ; continue at ReturnAfterStringLeadingPad when the signed bound test succeeds
                    bra       EmitStringBytes ; resume emit string bytes
EmitNextStringByte  ldb       ,u+       ; consume the next byte while emit next string byte
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringBytes     ldb       StreamCursorHigh,u ; recover stream cursor high
                    bne       EmitNextStringByte ; nonzero result: emit next string byte
                    ldd       >RuntimeFormatFlags,y ; recover runtime format flags
                    beq       ReturnPaddedString ; zero result: return padded string
                    bra       EmitStringTrailingPadding ; resume emit string trailing padding
ReturnAfterStringTrailingPad ldd       >RuntimeFormatLength,y ; recover runtime format length
                    pshs      d         ; pass or retain this word through the compiler ABI
                    jsr       [<$06,s]  ; the callback selected by the runtime descriptor
                    leas      $02,s     ; release $02,s bytes of stack state
EmitStringTrailingPadding ldd       $08,s     ; read the relevant word from the active stack frame
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       ReturnAfterStringTrailingPad ; continue at ReturnAfterStringTrailingPad when the signed bound test succeeds
ReturnPaddedString  puls      pc,u      ; restore pc,u and return to the caller
FormatSignedValue   pshs      u         ; preserve the caller data base
                    ldd       >AnsiParserValue,y ; recover ansi parser value
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReadStreamCharacter ; read stream character
FinishFieldWriter   leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
FormatPositiveValue pshs      u         ; preserve the caller data base
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    ldx       >AnsiParserValue,y ; recover ansi parser value
                    leax      $01,x     ; select $01
                    stx       >AnsiParserValue,y ; retain ansi parser value
                    stb       -$01,x    ; replace the byte just examined in place
                    puls      pc,u      ; restore pc,u and return to the caller
SignedMinimumText   fcc       "-32768"
                    fcb       $00
ReadStreamCharacter pshs      u         ; preserve the caller data base
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    anda      #128      ; mask a using #128
                    andb      #34       ; mask b using #34
                    cmpd      #-32766   ; test against #-32766
                    beq       UseUnbufferedStreamByte ; zero result: use unbuffered stream byte
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; select standard input
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; test against #2
                    lbne      RejectFlushRequest ; nonzero result: reject flush request
                    pshs      u         ; preserve the caller data base
                    lbsr      InitializeStreamBuffer ; attach storage appropriate for the stream mode
                    leas      $02,s     ; release $02,s bytes of stack state
UseUnbufferedStreamByte ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; select standard input
                    andb      #4        ; mask b using #4
                    beq       UseBufferedStreamByte ; zero result: use buffered stream byte
                    ldd       #1        ; prepare constant 1 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leax      $07,s     ; select $07
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; select standard input
                    andb      #64       ; mask b using #64
                    beq       UseWriteCallback ; zero result: use write callback
                    leax      >writln,pc ; select writln
                    bra       SaveWriteCallback ; resume save write callback
UseWriteCallback    leax      >write,pc ; select write
SaveWriteCallback   tfr       x,d       ; transfer x,d
                    tfr       d,x       ; transfer d,x
                    jsr       ,x        ; the callback selected by the runtime descriptor
                    leas      $06,s     ; release $06,s bytes of stack state
                    cmpd      #-1       ; test against #-1
                    bne       ReturnStreamCharacter ; nonzero result: return stream character
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    orb       #32       ; set selected bits in b using #32
                    std       StreamFlagsHigh,u ; retain stream flags high
                    lbra      RejectFlushRequest ; resume reject flush request
UseBufferedStreamByte ldd       StreamFlagsHigh,u ; recover stream flags high
                    anda      #1        ; mask a using #1
                    clrb                ; clear the byte accumulator for counting
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       UseReadCallback ; nonzero result: use read callback
                    pshs      u         ; preserve the caller data base
                    lbsr      FlushBufferedStream ; flush buffered stream
                    leas      $02,s     ; release $02,s bytes of stack state
UseReadCallback     ldd       StreamCursorHigh,u ; recover stream cursor high
                    addd      #1        ; add to d using #1
                    std       StreamCursorHigh,u ; retain stream cursor high
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; transfer d,x
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    stb       ,x        ; retain
                    ldd       StreamCursorHigh,u ; recover stream cursor high
                    cmpd      StreamBufferEndHigh,u ; test against stream buffer end high
                    bcc       RetryStreamRead ; select retry stream read when carry remains clear
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; select standard input
                    andb      #64       ; mask b using #64
                    beq       ReturnStreamCharacter ; zero result: return stream character
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    cmpd      #13       ; test against #13
                    bne       ReturnStreamCharacter ; nonzero result: return stream character
RetryStreamRead     pshs      u         ; preserve the caller data base
                    lbsr      FlushBufferedStream ; flush buffered stream
                    std       ,s++      ; store d in the current stack frame at ,s++
                    lbne      RejectFlushRequest ; nonzero result: reject flush request
ReturnStreamCharacter ldd       $04,s     ; read the relevant word from the active stack frame
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; preserve the caller data base
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    pshs      u         ; preserve the caller data base
                    ldd       #8        ; prepare constant 8 for the surrounding operation
                    lbsr      ClassifyStreamByte ; classify stream byte
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      ReadStreamCharacter ; read stream character
                    leas      $04,s     ; release $04,s bytes of stack state
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    pshs      u         ; preserve the caller data base
                    lbsr      ReadStreamCharacter ; read stream character
                    lbra      ReturnFlushStatus ; resume return flush status
DispatchStreamOperation pshs      u,d       ; preserve U and allocate a word-sized slot index
                    leau      >RuntimeIoScratch,y ; select runtime io scratch
                    clra                ; initialize the slot index to zero
                    clrb                ; complete the zero slot index
                    std       ,s        ; retain the index in the local stack word
                    bra       CheckNextStreamSlot ; resume check next stream slot
CloseNextStreamSlot tfr       u,d       ; pass the current descriptor address
                    leau      OutputLength,u ; select output length
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
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    cmpu      #0        ; test whether the candidate pointer is null
                    beq       RejectCloseRequest ; a null pointer cannot be closed
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    bne       CloseActiveStream ; nonzero flags identify an occupied slot
RejectCloseRequest  ldd       #-1       ; prepare constant -1 for the surrounding operation
                    lbra      StreamOperationDone ; unwind the local result word
CloseActiveStream   ldd       StreamFlagsHigh,u ; recover stream flags high
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
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; release the underlying OS-9 path
                    lbsr      close     ; close the selected runtime stream
                    leas      $02,s     ; release $02,s bytes of stack state
                    clra                ; clear the descriptor flags as a word
                    clrb                ; mark the table entry inactive
                    std       StreamFlagsHigh,u ; retain stream flags high
                    ldd       ,s        ; recover
                    bra       StreamOperationDone ; return the saved flush result
FlushStream         pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    beq       RejectFlushRequest ; zero result: reject flush request
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; ignore high-byte orientation state
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; test against #2
                    beq       PrepareStreamFlush ; zero result: prepare stream flush
RejectFlushRequest  ldd       #-1       ; prepare constant -1 for the surrounding operation
                    puls      pc,u      ; reject null, read-only, or failed streams
PrepareStreamFlush  ldd       StreamFlagsHigh,u ; recover stream flags high
                    anda      #128      ; mask a using #128
                    clrb                ; form a word-sized initialization test
                    std       -$02,s    ; use the compiler spill slot only for the flag test
                    bne       FlushAssignedBuffer ; nonzero result: flush assigned buffer
                    pshs      u         ; pass the descriptor to lazy initialization
                    lbsr      InitializeStreamBuffer ; attach a buffer suited to the underlying path
                    leas      $02,s     ; release $02,s bytes of stack state
FlushAssignedBuffer pshs      u         ; pass the prepared descriptor to the buffer flusher
                    bsr       FlushBufferedStream ; commit buffered bytes to the underlying path
StreamOperationDone leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore U and return the operation status
FlushBufferedStream pshs      u         ; preserve the caller's descriptor register
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    leas      -$04,s    ; allocate $04,s bytes of stack state
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    anda      #1        ; mask a using #1
                    clrb                ; complete the word-sized orientation test
                    std       -$02,s    ; spill the test value below the compiler frame
                    bne       ComputePendingOutput ; nonzero result: compute pending output
                    ldd       StreamCursorHigh,u ; recover stream cursor high
                    cmpd      StreamBufferEndHigh,u ; test against stream buffer end high
                    beq       ComputePendingOutput ; zero result: compute pending output
                    clra                ; build a zero position-query argument
                    clrb                ; complete the zero word
                    pshs      d         ; request the runtime's current logical position
                    pshs      u         ; pass the descriptor to the position hook
                    lbsr      NoOpStreamPositionHook ; preserve the runtime stream-position hook contract
                    leas      $02,s     ; release $02,s bytes of stack state
                    ldd       $02,x     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the returned low position word
                    ldd       ,x        ; recover
                    pshs      d         ; pass the returned high position word
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; pass the path number
                    lbsr      SeekPath  ; move the selected path to the computed file position
                    leas      $08,s     ; release $08,s bytes of stack state
ComputePendingOutput ldd       StreamCursorHigh,u ; recover stream cursor high
                    subd      StreamBufferStartHigh,u ; subtract from d using StreamBufferStartHigh,u
                    std       $02,s     ; retain the number of buffered bytes
                    lbeq      ResetFlushedStream ; nothing has been accumulated
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    anda      #1        ; mask a using #1
                    clrb                ; form the word-sized orientation test
                    std       -$02,s    ; preserve it in the compiler spill slot
                    lbeq      ResetFlushedStream ; discard cached input rather than writing it
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; inspect only low-byte buffering flags
                    andb      #64       ; mask b using #64
                    beq       WriteBlockBuffer ; ordinary buffers use one bulk write
                    ldd       StreamBufferStartHigh,u ; recover stream buffer start high
                    bra       UpdateWriteCursor ; seed the line-write cursor
WriteNextLineFragment ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass the remaining byte count
                    ldd       StreamCursorHigh,u ; recover stream cursor high
                    pshs      d         ; pass the first unwritten byte
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; pass it to the line-write wrapper
                    lbsr      writln    ; writln
                    leas      $06,s     ; release $06,s bytes of stack state
                    std       ,s        ; retain the number written or -1
                    cmpd      #-1       ; test against #-1
                    bne       AdvanceAfterLineWrite ; nonzero result: advance after line write
                    leax      $04,s     ; preserve the compiler's error-frame restoration
                    bra       RestoreFailedWriteFrame ; resume restore failed write frame
AdvanceAfterLineWrite ldd       $02,s     ; read the relevant word from the active stack frame
                    subd      ,s        ; remove the completed portion from the remainder
                    std       $02,s     ; retain the reduced count
                    ldd       StreamCursorHigh,u ; recover stream cursor high
                    addd      ,s        ; advance to the next unwritten byte
UpdateWriteCursor   std       StreamCursorHigh,u ; retain stream cursor high
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    bne       WriteNextLineFragment ; nonzero result: write next line fragment
                    bra       ResetFlushedStream ; all line fragments reached OS-9
WriteBlockBuffer    ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; write the entire pending block in one call
                    ldd       StreamBufferStartHigh,u ; recover stream buffer start high
                    pshs      d         ; pass the source address
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; pass the path number
                    lbsr      write     ; commit the requested bytes through the runtime stream
                    leas      $06,s     ; release $06,s bytes of stack state
                    cmpd      $02,s     ; test against $02
                    beq       ResetFlushedStream ; accept only a complete block write
                    bra       MarkStreamWriteError ; resume mark stream write error
RestoreFailedWriteFrame leas      -$04,x    ; allocate $04,x bytes of stack state
MarkStreamWriteError ldd       StreamFlagsHigh,u ; recover stream flags high
                    orb       #32       ; set selected bits in b using #32
                    std       StreamFlagsHigh,u ; retain stream flags high
                    ldd       StreamBufferEndHigh,u ; recover stream buffer end high
                    std       StreamCursorHigh,u ; retain stream cursor high
                    ldd       #-1       ; initialize stream flags high to -1
                    bra       ReturnFlushStatus ; release locals and return failure
ResetFlushedStream  ldd       StreamFlagsHigh,u ; recover stream flags high
                    ora       #1        ; set selected bits in a using #1
                    std       StreamFlagsHigh,u ; retain stream flags high
                    ldd       StreamBufferStartHigh,u ; recover stream buffer start high
                    std       StreamCursorHigh,u ; retain stream cursor high
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEndHigh,u ; retain stream buffer end high
                    clra                ; prepare a successful zero result
                    clrb                ; report a successful flush
ReturnFlushStatus   leas      $04,s     ; release $04,s bytes of stack state
                    puls      pc,u      ; restore U and return the flush status
NoOpStreamPositionHook pshs      u         ; preserve the caller data base
                    puls      pc,u      ; return without disturbing the position pointer
InitializeStreamBuffer pshs      u         ; preserve the caller data base
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; widen the byte to a positive compiler integer
                    andb      #192      ; mask b using #192
                    bne       BufferingModeSelected ; nonzero result: buffering mode selected
                    leas      -$20,s    ; allocate $20,s bytes of stack state
                    leax      ,s        ; point X at its first byte
                    pshs      x         ; pass the option-table destination
                    ldd       StreamPathHigh,u ; recover stream path high
                    pshs      d         ; preserve the status-call argument order
                    clra                ; request base option status code zero
                    clrb                ; complete selector zero
                    pshs      d         ; request the path's base option status
                    lbsr      GetPathStatus ; read the requested OS-9 path status
                    leas      $06,s     ; release $06,s bytes of stack state
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    pshs      d         ; preserve existing state during policy selection
                    ldb       $02,s     ; device type zero identifies an SCF-style terminal
                    bne       SelectFullBuffering ; nonzero result: select full buffering
                    ldd       #64       ; prepare constant 64 for the surrounding operation
                    bra       SaveBufferingMode ; resume save buffering mode
SelectFullBuffering ldd       #128      ; initialize stream flags high to 128
SaveBufferingMode   ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       StreamFlagsHigh,u ; retain stream flags high
                    leas      <$0020,s  ; release <$0020,s bytes of stack state
BufferingModeSelected ldd       StreamFlagsHigh,u ; recover stream flags high
                    ora       #128      ; set selected bits in a using #128
                    std       StreamFlagsHigh,u ; retain stream flags high
                    clra                ; inspect the already-configured storage flags
                    andb      #12       ; mask b using #12
                    beq       ChooseBufferSize ; allocate only when no storage exists
                    puls      pc,u      ; an existing buffer configuration is ready
ChooseBufferSize    ldd       StreamBufferSize,u ; recover stream buffer size
                    bne       EnsureBufferStorage ; nonzero result: ensure buffer storage
                    ldd       StreamFlagsHigh,u ; recover stream flags high
                    clra                ; inspect the low-byte line flag
                    andb      #64       ; mask b using #64
                    beq       ChooseBlockBufferSize ; zero result: choose block buffer size
                    ldd       #128      ; initialize stream buffer size to 128
                    bra       SaveDefaultBufferSize ; resume save default buffer size
ChooseBlockBufferSize ldd       #256      ; initialize stream buffer size to 256
SaveDefaultBufferSize std       StreamBufferSize,u ; retain stream buffer size
EnsureBufferStorage ldd       StreamBufferStartHigh,u ; recover stream buffer start high
                    bne       MarkBufferAvailable ; nonzero result: mark buffer available
                    ldd       StreamBufferSize,u ; recover stream buffer size
                    pshs      d         ; pass the allocation size
                    lbsr      ExitRuntime ; exit runtime
                    leas      $02,s     ; release $02,s bytes of stack state
                    std       StreamBufferStartHigh,u ; retain stream buffer start high
                    cmpd      #-1       ; test against #-1
                    beq       UseFallbackByteBuffer ; zero result: use fallback byte buffer
MarkBufferAvailable ldd       StreamFlagsHigh,u ; recover stream flags high
                    orb       #8        ; set selected bits in b using #8
                    std       StreamFlagsHigh,u ; retain stream flags high
                    bra       ResetBufferWindow ; initialize its empty bounds
UseFallbackByteBuffer ldd       StreamFlagsHigh,u ; recover stream flags high
                    orb       #4        ; set selected bits in b using #4
                    std       StreamFlagsHigh,u ; retain stream flags high
                    leax      StreamPushbackByte,u ; select stream pushback byte
                    stx       StreamBufferStartHigh,u ; retain stream buffer start high
                    ldd       #1        ; initialize stream buffer size to 1
                    std       StreamBufferSize,u ; retain stream buffer size
ResetBufferWindow   ldd       StreamBufferStartHigh,u ; recover stream buffer start high
                    addd      StreamBufferSize,u ; add to d using StreamBufferSize,u
                    std       StreamBufferEndHigh,u ; retain stream buffer end high
                    std       StreamCursorHigh,u ; retain stream cursor high
                    puls      pc,u      ; restore U with buffering ready
SelectIntegerArgument pshs      u         ; preserve the caller data base
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; transfer d,x
                    bra       ClassifyIntegerConversion ; resume classify integer conversion
FetchLongIntegerArgument ldd       [<$06,s]  ; recover [<$06
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >DefaultStreamByte,pc ; select default stream byte
                    bra       ReturnIntegerArgument ; resume return integer argument
UseByteIntegerArgument ldb       $05,s     ; read the relevant word from the active stack frame
                    stb       >RuntimeHeapLimit,y ; retain runtime heap limit
                    leax      >RuntimeErrorCode,y ; select runtime error code
ReturnIntegerArgument tfr       x,d       ; transfer x,d
                    puls      pc,u      ; restore pc,u and return to the caller
ClassifyIntegerConversion cmpx      #100      ; test against #100
                    beq       FetchLongIntegerArgument ; zero result: fetch long integer argument
                    cmpx      #111      ; test against #111
                    lbeq      FetchLongIntegerArgument ; zero result: fetch long integer argument
                    cmpx      #120      ; test against #120
                    lbeq      FetchLongIntegerArgument ; zero result: fetch long integer argument
                    bra       UseByteIntegerArgument ; resume use byte integer argument
                    puls      pc,u      ; restore pc,u and return to the caller
DefaultStreamByte   fcb       $00
ReturnEmptyString   pshs      u         ; preserve the caller data base
                    leax      >FallbackStreamByte,pc ; select fallback stream byte
                    tfr       x,d       ; transfer x,d
                    puls      pc,u      ; restore pc,u and return to the caller
FallbackStreamByte  fcb       $00
MeasureCString      pshs      u         ; preserve the caller data base
                    ldu       $04,s     ; read the relevant word from the active stack frame
FindCStringEnd      ldb       ,u+       ; consume the next byte while find cstring end
                    bne       FindCStringEnd ; repeat find cstring end until the terminating condition is met
                    tfr       u,d       ; transfer u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
CopyCString         pshs      u         ; preserve the caller data base
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    std       ,s        ; store d in the current stack frame at ,s
CopyCStringByte     ldb       ,u+       ; consume the next byte while copy cstring byte
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
                    bne       CopyCStringByte ; repeat copy cstring byte until the terminating condition is met
                    bra       ReturnCopiedString ; resume return copied string
                    pshs      u         ; preserve the caller data base
                    ldu       $06,s     ; read the relevant word from the active stack frame
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    std       ,s        ; store d in the current stack frame at ,s
FindAppendEnd       ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldb       -$01,x    ; recover -$01
                    bne       FindAppendEnd ; nonzero result: find append end
                    ldd       ,s        ; recover
                    addd      #-1       ; add to d using #-1
                    std       ,s        ; store d in the current stack frame at ,s
AppendCStringByte   ldb       ,u+       ; consume the next byte in this scan
                    ldx       ,s        ; recover
                    leax      $01,x     ; select $01
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; replace the byte just examined in place
                    bne       AppendCStringByte ; nonzero result: append c string byte
ReturnCopiedString  ldd       $06,s     ; read the relevant word from the active stack frame
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; preserve the caller data base
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    bra       ReadRuntimeFlag ; resume read runtime flag
UseCallerWorkspaceBase ldx       $06,s     ; read the relevant word from the active stack frame
                    leax      $01,x     ; select $01
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldb       -$01,x    ; recover -$01
                    bne       SelectRuntimeDataBase ; nonzero result: select runtime data base
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    puls      pc,u      ; restore pc,u and return to the caller
SelectRuntimeDataBase leau      dpsiz,u   ; select dpsiz
ReadRuntimeFlag     ldb       StreamCursorHigh,u ; recover stream cursor high
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       [<$08,s]  ; recover [<$08
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; test against
                    beq       UseCallerWorkspaceBase ; zero result: use caller workspace base
                    ldb       [<$06,s]  ; recover [<$06
                    sex                 ; sign-extend b into d
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       StreamCursorHigh,u ; recover stream cursor high
                    sex                 ; sign-extend b into d
                    subd      ,s++      ; subtract from d using ,s++
                    puls      pc,u      ; restore pc,u and return to the caller
ScreenCellOffset    pshs      u         ; preserve the caller data base
                    ldu       $04,s     ; read the relevant word from the active stack frame
                    leas      -$05,s    ; allocate $05,s bytes of stack state
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    std       $01,s     ; store d in the current stack frame at $01,s
SkipLeadingWhitespace ldb       ,u+       ; consume the next byte while skip leading whitespace
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #32       ; recognize the first printable ASCII value
                    beq       SkipLeadingWhitespace ; zero result: skip leading whitespace
                    ldb       ,s        ; recover
                    cmpb      #9        ; prepare constant 9 for the surrounding operation
                    lbeq      SkipLeadingWhitespace ; zero result: skip leading whitespace
                    ldb       ,s        ; recover
                    cmpb      #45       ; prepare constant 45 for the surrounding operation
                    bne       PositiveNumber ; nonzero result: positive number
                    ldd       #1        ; initialize $03 to 1
                    bra       SaveNumericSign ; resume save numeric sign
PositiveNumber      clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
SaveNumericSign     std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       ,s        ; recover
                    cmpb      #45       ; prepare constant 45 for the surrounding operation
                    beq       ConsumeNumericByte ; zero result: consume numeric byte
                    ldb       ,s        ; recover
                    cmpb      #43       ; prepare constant 43 for the surrounding operation
                    bne       TestNumericByte ; nonzero result: test numeric byte
                    bra       ConsumeNumericByte ; resume consume numeric byte
AccumulateDecimalDigit ldd       $01,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldb       $02,s     ; read the relevant word from the active stack frame
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
ConsumeNumericByte  ldb       ,u+       ; consume the next byte in this scan
                    stb       ,s        ; store b in the current stack frame at ,s
TestNumericByte     ldb       ,s        ; recover
                    sex                 ; sign-extend b into d
                    leax      >LineInputBuffer,y ; select line input buffer
                    leax      d,x       ; select d
                    ldb       ,x        ; recover
                    clra                ; select standard input
                    andb      #8        ; mask b using #8
                    bne       AccumulateDecimalDigit ; nonzero result: accumulate decimal digit
                    ldd       $03,s     ; read the relevant word from the active stack frame
                    beq       ReturnPositiveNumber ; zero result: return positive number
                    ldd       $01,s     ; read the relevant word from the active stack frame
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       ReturnParsedNumber ; resume return parsed number
ReturnPositiveNumber ldd       $01,s     ; read the relevant word from the active stack frame
ReturnParsedNumber  leas      $05,s     ; release $05,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
PauseEditorMessage  pshs      u         ; preserve the caller data base
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    beq       AllocateSingleByte ; zero result: allocate single byte
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #10       ; select the line-feed control byte
                    lbsr      MultiplyUnsignedWords ; form the full-width unsigned product
                    bra       PassAllocationSize ; resume pass allocation size
AllocateSingleByte  ldd       #1        ; prepare constant 1 for the surrounding operation
PassAllocationSize  pshs      d         ; pass or retain this word through the compiler ABI
                    lbsr      sleep     ; sleep
                    leas      $02,s     ; release $02,s bytes of stack state
                    puls      pc,u      ; restore pc,u and return to the caller
MultiplyUnsignedWords tsta                ; set condition codes from a without changing it
                    bne       MultiplyFullWidth ; repeat multiply full width until the terminating condition is met
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       MultiplyFullWidth ; repeat multiply full width until the terminating condition is met
                    lda       $03,s     ; read the relevant word from the active stack frame
                    mul                 ; form the byte-product in D
                    ldx       ,s        ; recover
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; initialize  to 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
MultiplyFullWidth   pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       #0        ; prepare constant 0 for the surrounding operation
                    pshs      d         ; pass or retain this word through the compiler ABI
                    pshs      d         ; pass or retain this word through the compiler ABI
                    lda       $05,s     ; read the relevant word from the active stack frame
                    ldb       $09,s     ; read the relevant word from the active stack frame
                    mul                 ; form the byte-product in D
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lda       $05,s     ; read the relevant word from the active stack frame
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    mul                 ; form the byte-product in D
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       AccumulateMiddleProduct ; continue accumulate middle product while the range test permits it
                    inc       ,s        ; increment the value at ,s
AccumulateMiddleProduct lda       $04,s     ; read the relevant word from the active stack frame
                    ldb       $09,s     ; read the relevant word from the active stack frame
                    mul                 ; form the byte-product in D
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       AccumulateHighProduct ; continue accumulate high product while the range test permits it
                    inc       ,s        ; increment the value at ,s
AccumulateHighProduct lda       $04,s     ; read the relevant word from the active stack frame
                    ldb       $08,s     ; read the relevant word from the active stack frame
                    mul                 ; form the byte-product in D
                    addd      ,s        ; add to d using ,s
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $06,s     ; read the relevant word from the active stack frame
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       ,s        ; recover
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    leas      $08,s     ; release $08,s bytes of stack state
                    rts                 ; return to the caller
                    clr       >RuntimeFormatPadByte,y ; initialize runtime format pad byte
                    leax      >SignedRemainder,pc ; select signed remainder
                    stx       >RuntimeStreamIndex,y ; retain runtime stream index
                    bra       RemainderMagnitudeReady ; resume remainder magnitude ready
UnsignedRemainder   leax      >UnsignedQuotient,pc ; select unsigned quotient
                    stx       >RuntimeStreamIndex,y ; retain runtime stream index
                    clr       >RuntimeFormatPadByte,y ; initialize runtime format pad byte
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bpl       RemainderMagnitudeReady ; select remainder magnitude ready from the preceding condition
                    inc       >RuntimeFormatPadByte,y ; increment the value at >RuntimeFormatPadByte,y
RemainderMagnitudeReady subd      #0        ; subtract from d using #0
                    bne       DivideNextWord ; nonzero result: divide next word
                    puls      x         ; restore x
                    ldd       ,s++      ; recover
                    jmp       ,x        ; dispatch through the selected arithmetic helper
DivideNextWord      ldx       $02,s     ; read the relevant word from the active stack frame
                    pshs      x         ; pass or retain this pointer through the compiler ABI
                    jsr       [>$37D0,y] ; the callback selected by the runtime descriptor
                    ldd       ,s        ; recover
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tfr       x,d       ; transfer x,d
                    tst       >RuntimeFormatPadByte,y ; set condition codes from >RuntimeFormatPadByte,y without changing it
                    beq       ReturnDivisionResult ; zero result: return division result
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
ReturnDivisionResult std       ,s++      ; store d in the current stack frame at ,s++
                    rts                 ; return to the caller
SignedRemainder     subd      #0        ; subtract from d using #0
                    beq       RestoreDivisionDividend ; zero result: restore division dividend
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    clr       ,s        ; initialize
                    clr       $01,s     ; initialize $01
                    bra       StartDivisionBitScan ; resume start division bit scan
RestoreDivisionDividend puls      d         ; restore d
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #45       ; prepare constant 45 for the surrounding operation
                    lbra      send      ; resume send
UnsignedQuotient    subd      #0        ; subtract from d using #0
                    beq       RestoreDivisionDividend ; zero result: restore division dividend
                    pshs      d         ; pass or retain this word through the compiler ABI
                    leas      -$02,s    ; allocate $02,s bytes of stack state
                    clr       ,s        ; initialize
                    clr       $01,s     ; initialize $01
                    tsta                ; set condition codes from a without changing it
                    bpl       PrepareLongDivision ; select prepare long division from the preceding condition
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    inc       $01,s     ; increment the value at $01,s
                    std       $02,s     ; store d in the current stack frame at $02,s
PrepareLongDivision ldd       $06,s     ; read the relevant word from the active stack frame
                    bpl       StartDivisionBitScan ; select start division bit scan from the preceding condition
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    com       $01,s     ; complement the value at $01,s
                    std       $06,s     ; store d in the current stack frame at $06,s
StartDivisionBitScan lda       #1        ; prepare constant 1 for the surrounding operation
CountDivisionBits   inca                ; preserve the flags or register state required by the following operation
                    asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    bpl       CountDivisionBits ; select count division bits from the preceding condition
                    sta       ,s        ; store a in the current stack frame at ,s
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    clr       $06,s     ; initialize $06
                    clr       $07,s     ; initialize $07
SubtractTrialDivisor subd      $02,s     ; subtract from d using $02,s
                    bcc       SetDivisionQuotientBit ; select set division quotient bit when carry remains clear
                    addd      $02,s     ; add to d using $02,s
                    andcc     #254      ; clear selected condition-code bits using #254
                    bra       RotateDivisionQuotient ; resume rotate division quotient
SetDivisionQuotientBit orcc      #1        ; set selected condition-code bits using #1
RotateDivisionQuotient rol       $07,s     ; rotate left through carry the value at $07,s
                    rol       $06,s     ; rotate left through carry the value at $06,s
                    lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    dec       ,s        ; consume one
                    bne       SubtractTrialDivisor ; nonzero result: subtract trial divisor
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tst       $01,s     ; set condition codes from $01,s without changing it
                    beq       ShiftDivisionDividend ; enter shift division dividend when the terminating condition is met
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
ShiftDivisionDividend ldx       $04,s     ; read the relevant word from the active stack frame
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    std       $04,s     ; store d in the current stack frame at $04,s
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldx       $02,s     ; read the relevant word from the active stack frame
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    leas      $06,s     ; release $06,s bytes of stack state
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       DivisionShiftComplete ; zero result: division shift complete
ShiftDividendRight  asr       $02,s     ; shift right arithmetically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       ShiftDividendRight ; repeat shift dividend right until the terminating condition is met
                    bra       DivisionShiftComplete ; resume division shift complete
ClassifyStreamByte  tstb                ; set condition codes from b without changing it
                    beq       DivisionShiftComplete ; zero result: division shift complete
ShiftUnsignedDividend lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       ShiftUnsignedDividend ; repeat shift unsigned dividend until the terminating condition is met
DivisionShiftComplete ldd       $02,s     ; read the relevant word from the active stack frame
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldd       $02,s     ; read the relevant word from the active stack frame
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       ,s        ; recover
                    leas      $04,s     ; release $04,s bytes of stack state
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       DivisionShiftComplete ; zero result: division shift complete
ShiftDividendLeft   asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    decb                ; decrement b
                    bne       ShiftDividendLeft ; repeat shift dividend left until the terminating condition is met
                    bra       DivisionShiftComplete ; resume division shift complete
send                std       >LastIoError,y ; retain last io error
                    pshs      y,b       ; save y,b on the stack
                    os9       F$ID      ; retrieve the current process and user IDs
                    puls      y,b       ; restore y,b from the stack
                    os9       F$Send    ; send signal B to process A
                    rts                 ; return to the caller
GetPathStatus       lda       $05,s     ; select the OS-9 path number
                    ldb       $03,s     ; dispatch on the requested GetStat selector
                    beq       GetStatusIntoBuffer ; selector zero fills an option table at X
                    cmpb      #1        ; selector one returns register-only status
                    beq       GetRegisterPathStatus ; zero result: get register path status
                    cmpb      #6        ; selector six also needs no result-buffer translation
                    beq       GetRegisterPathStatus ; zero result: get register path status
                    cmpb      #2        ; prepare constant 2 for the surrounding operation
                    beq       GetLongPathStatus ; zero result: get long path status
                    cmpb      #5        ; prepare constant 5 for the surrounding operation
                    beq       GetLongPathStatus ; zero result: get long path status
                    ldb       #208      ; select status operation 208
                    lbra      StoreRuntimeError ; continue at store runtime error
GetLongPathStatus   pshs      u         ; preserve the compiler workspace register
                    os9       I$GetStt  ; obtain the requested 32-bit value in X:U
                    bcc       StoreLongStatusResult ; select store long status result when carry remains clear
                    puls      u         ; restore U before translating the OS-9 error
                    lbra      StoreRuntimeError ; continue at store runtime error
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
SetPathStatus       lda       $05,s     ; read the relevant word from the active stack frame
                    ldb       $03,s     ; read the relevant word from the active stack frame
                    beq       SetOptionBuffer ; zero result: set option buffer
                    cmpb      #2        ; prepare constant 2 for the surrounding operation
                    beq       SetLongPathStatus ; zero result: set long path status
                    ldb       #208      ; select status operation 208
                    lbra      StoreRuntimeError ; resume store runtime error
SetOptionBuffer     ldx       $06,s     ; read the relevant word from the active stack frame
                    os9       I$SetStt  ; apply the selected path status operation
                    lbra      ReturnOsResult ; resume return os result
SetLongPathStatus   pshs      u         ; preserve the caller data base
                    ldx       $08,s     ; read the relevant word from the active stack frame
                    ldu       $0A,s     ; read the relevant word from the active stack frame
                    os9       I$SetStt  ; apply the selected path status operation
                    puls      u         ; restore u
                    lbra      ReturnOsResult ; resume return os result
                    ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; use the low byte of the requested mode
                    os9       I$Open    ; ask OS-9 for a path number
                    bcs       ReturnExistsResult ; carry reports failure: return exists result
                    os9       I$Close   ; close the selected path
ReturnExistsResult  lbra      ReturnOsResult ; resume return os result
open                ldx       $02,s     ; read the relevant word from the active stack frame
                    lda       $05,s     ; read the relevant word from the active stack frame
                    os9       I$Open    ; open the selected OS-9 path
                    lbcs      StoreRuntimeError ; translate an OS-9 error to -1
                    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts                 ; return the completed result to the caller
close               lda       $03,s     ; select the path argument
                    os9       I$Close   ; flush and release the OS-9 path
                    lbra      ReturnOsResult ; resume return os result
                    ldx       $02,s     ; read the relevant word from the active stack frame
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    os9       I$MakDir  ; create the directory named at X
                    lbra      ReturnOsResult ; resume return os result
creat               ldx       $02,s     ; select the pathname argument
                    lda       $05,s     ; recover the compiler open/create mode
                    tfr       a,b       ; derive OS-9 file attributes from that mode
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; create a new file and return its path
                    bcs       ReopenExistingForTruncate ; carry reports failure: reopen existing for truncate
ReturnPathNumber    tfr       a,b       ; place the path number in the low result byte
                    clra                ; return it as a positive compiler integer
                    rts                 ; return the completed result to the caller
ReopenExistingForTruncate cmpb      #218      ; prepare constant 218 for the surrounding operation
                    lbne      StoreRuntimeError ; nonzero result: store runtime error
                    lda       $05,s     ; recover the original compiler mode
                    bita      #128      ; test selected bits in a using #128
                    lbne      StoreRuntimeError ; an existing directory is not a truncatable file
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; reopen the existing pathname
                    os9       I$Open    ; preserve the flags or register state required by the following operation
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
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
                    lbra      StoreRuntimeError ; continue at store runtime error
                    ldx       $02,s     ; select the pathname to remove
                    os9       I$Delete  ; delete the path named at X
                    lbra      ReturnOsResult ; resume return os result
                    lda       $03,s     ; read the relevant word from the active stack frame
                    os9       I$Dup     ; duplicate path A into the next free path number
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
                    tfr       a,b       ; transfer a,b
                    clra                ; select standard input
                    rts                 ; return to the caller
read                pshs      y         ; preserve the caller's Y
                    ldx       $06,s     ; select the destination buffer
                    lda       $05,s     ; select the OS-9 path number
                    ldy       $08,s     ; supply the requested transfer length
                    pshs      y         ; preserve that length across I$Read
                    os9       I$Read    ; read one byte without stream buffering
ReadCompleted       bcc       ReadBytesSucceeded ; continue read bytes succeeded while the range test permits it
                    cmpb      #211      ; recognize the OS-9 end-of-file status
                    bne       ReadBytesFailed ; repeat read bytes failed until the terminating condition is met
                    clra                ; select standard input
                    clrb                ; return zero rather than -1 for EOF
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
ReadBytesFailed     puls      y,x       ; discard saved length and restore Y
                    lbra      StoreRuntimeError ; save B and return -1
ReadBytesSucceeded  tfr       y,d       ; return the actual byte count
                    puls      pc,y,x    ; preserve the flags or register state required by the following operation
readln              pshs      y         ; preserve the caller's Y
                    lda       $05,s     ; read the relevant word from the active stack frame
                    ldx       $06,s     ; read the relevant word from the active stack frame
                    ldy       $08,s     ; recover the transfer length
                    pshs      y         ; preserve y across the operation
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bra       ReadCompleted ; resume read completed
write               pshs      y         ; preserve y across the operation
                    ldy       $08,s     ; recover the transfer length
                    beq       ReturnWriteCount ; zero result: return write count
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the source buffer
                    os9       I$Write   ; write one byte without stream buffering
FinishWrite         bcc       ReturnWriteCount ; select return write count when carry remains clear
                    puls      y         ; restore Y before the shared error path
                    lbra      StoreRuntimeError ; save B and return -1
ReturnWriteCount    tfr       y,d       ; return the actual transfer count
                    puls      pc,y      ; preserve the flags or register state required by the following operation
writln              pshs      y         ; preserve the caller's Y
                    ldy       $08,s     ; recover the maximum line length
                    beq       ReturnWriteCount ; zero result: return write count
                    lda       $05,s     ; select the OS-9 path number
                    ldx       $06,s     ; select the CR-terminated source line
                    os9       I$WritLn  ; write through the first carriage return
                    bra       FinishWrite ; reuse normal/error result conversion
SeekPath            pshs      u         ; preserve the caller data base
                    ldd       $0A,s     ; read the relevant word from the active stack frame
                    bne       SelectSeekOrigin ; nonzero result: select seek origin
                    ldu       #0        ; prepare constant 0 for the surrounding operation
                    ldx       #0        ; prepare constant 0 for the surrounding operation
                    bra       ApplySeekOffset ; continue at apply seek offset
SelectSeekOrigin    cmpd      #1        ; test against #1
                    beq       SeekRelativeCurrent ; zero result: seek relative current
                    cmpd      #2        ; test against #2
                    beq       getstat   ; zero result: getstat
                    ldb       #247      ; initialize $01 ad to 247
SeekFailed          clra                ; widen the OS-9 error to a compiler word
                    std       >LastIoError,y ; retain last io error
                    ldd       #-1       ; initialize  to -1
                    leax      >RuntimeHeapCursor,y ; select runtime heap cursor
                    std       ,x        ; preserve the flags or register state required by the following operation
                    std       $02,x     ; preserve the flags or register state required by the following operation
                    puls      pc,u      ; preserve the flags or register state required by the following operation
getstat             lda       $05,s     ; select the path number
                    ldb       #2        ; select status operation 2
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
                    bra       ApplySeekOffset ; continue at apply seek offset
SeekRelativeCurrent lda       $05,s     ; select the path number
                    ldb       #5        ; select status operation 5
                    os9       I$GetStt  ; preserve the flags or register state required by the following operation
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
ApplySeekOffset     tfr       u,d       ; begin with the base position's low word
                    addd      $08,s     ; add the requested low offset
                    std       >RuntimeAllocatorState,y ; retain runtime allocator state
                    tfr       d,u       ; supply it to I$Seek
                    tfr       x,d       ; resume the base high word
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       SeekFailed ; select seek failed from the preceding condition
                    tfr       d,x       ; supply the high word to I$Seek
                    std       >RuntimeHeapCursor,y ; retain runtime heap cursor
                    lda       $05,s     ; select the path number
                    os9       I$Seek    ; commit the calculated X:U position
                    bcs       SeekFailed ; select seek failed when carry reports an error or underflow
                    leax      >RuntimeHeapCursor,y ; select runtime heap cursor
                    puls      pc,u      ; preserve the flags or register state required by the following operation
                    rts                 ; return to the caller
                    ldx       #0        ; prepare constant 0 for the surrounding operation
                    clrb                ; clear the byte accumulator for counting
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbra      StoreRuntimeError ; resume store runtime error
                    rts                 ; return to the caller
                    pshs      u,y       ; save u,y on the stack
                    ldx       $06,s     ; read the relevant word from the active stack frame
                    ldy       $08,s     ; read the relevant word from the active stack frame
                    ldu       $0A,s     ; read the relevant word from the active stack frame
                    os9       F$CRC     ; update the CRC accumulator over Y bytes at X
                    puls      pc,u,y    ; restore pc,u,y and return to the caller
                    lda       $03,s     ; read the relevant word from the active stack frame
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    os9       F$PErr    ; print the error message for status B
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
                    rts                 ; return to the caller
sleep               ldx       $02,s     ; read the relevant word from the active stack frame
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
                    tfr       x,d       ; transfer x,d
                    rts                 ; return to the caller
                    ldd       >memend,y ; recover memend
                    pshs      d         ; retain the proposed heap boundary
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    cmpd      >RuntimeStatusWord,y ; test against runtime status word
                    bcs       ReturnHeapAdjustment ; select return heap adjustment when carry reports an error or underflow
                    addd      >memend,y ; add to d using >memend,y
                    pshs      y         ; preserve y across the operation
                    subd      ,s        ; subtract from d using ,s
                    os9       F$Mem     ; resize process memory to D pages
                    tfr       y,d       ; transfer y,d
                    puls      y         ; restore y
                    bcc       HeapLimitAccepted ; select heap limit accepted when carry remains clear
                    ldd       #-1       ; initialize memend to -1
                    leas      $02,s     ; release $02,s bytes of stack state
                    rts                 ; return to the caller
HeapLimitAccepted   std       >memend,y ; retain memend
                    addd      >RuntimeStatusWord,y ; add to d using >RuntimeStatusWord,y
                    subd      ,s        ; subtract from d using ,s
                    std       >RuntimeStatusWord,y ; retain runtime status word
ReturnHeapAdjustment leas      $02,s     ; release $02,s bytes of stack state
                    ldd       >RuntimeStatusWord,y ; recover runtime status word
                    pshs      d         ; pass or retain this word through the compiler ABI
                    subd      $04,s     ; subtract from d using $04,s
                    std       >RuntimeStatusWord,y ; retain runtime status word
                    ldd       >memend,y ; recover memend
                    subd      ,s++      ; subtract from d using ,s++
                    pshs      d         ; pass or retain this word through the compiler ABI
                    clra                ; select standard input
                    ldx       ,s        ; recover
ClearHeapByte       sta       ,x+       ; retain
                    cmpx      >memend,y ; test against memend
                    bcs       ClearHeapByte ; select clear heap byte when carry reports an error or underflow
                    puls      pc,d      ; restore pc,d and return to the caller
ExitRuntime         ldd       $02,s     ; read the relevant word from the active stack frame
                    addd      >_mtop,y  ; add to d using >_mtop,y
                    bcs       RejectHeapRequest ; select reject heap request when carry reports an error or underflow
                    cmpd      >_stbot,y ; test against  stbot
                    bcc       RejectHeapRequest ; select reject heap request when carry remains clear
                    pshs      d         ; pass or retain this word through the compiler ABI
                    ldx       >_mtop,y  ; recover  mtop
                    clra                ; use zero as the allocator's initialization byte
ClearAllocatedBytes cmpx      ,s        ; test against
                    bcc       HeapHasCapacity ; select heap has capacity when carry remains clear
                    sta       ,x+       ; clear one newly allocated byte
                    bra       ClearAllocatedBytes ; continue at clear allocated bytes
HeapHasCapacity     ldd       >_mtop,y  ; recover  mtop
                    puls      x         ; recover the proposed new boundary
                    stx       >_mtop,y  ; retain  mtop
                    rts                 ; return the completed result to the caller
RejectHeapRequest   ldd       #-1       ; initialize last io error to -1
                    rts                 ; return the completed result to the caller
StoreRuntimeError   clra                ; widen OS-9's error byte in B
                    std       >LastIoError,y ; retain last io error
                    ldd       #-1       ; prepare constant -1 for the surrounding operation
                    rts                 ; return the completed result to the caller
ReturnOsResult      bcs       StoreRuntimeError ; translate a failed OS-9 service
                    clra                ; select standard input
                    clrb                ; return zero for a successful void-style wrapper
                    rts                 ; return the completed result to the caller
exit                lbsr      RunExitHook ; allow a linked application cleanup hook
                    lbsr      DispatchStreamOperation ; dispatch stream operation
_exit               ldd       $02,s     ; read the relevant word from the active stack frame
                    os9       F$Exit    ; terminate with its low byte in B
RunExitHook         rts                 ; default application cleanup hook does nothing
ReadPortCharacter   lda       $03,s     ; read the relevant word from the active stack frame
                    ldb       #1        ; select status operation 1
                    os9       I$GetStt  ; query the selected path status
                    lbcs      StoreRuntimeError ; select store runtime error when carry reports an error or underflow
                    clra                ; select standard input
                    rts                 ; return to the caller
                    ldd       #6944     ; prepare constant 6944 for the surrounding operation
                    bsr       InvokeEncodedService ; call the decoded OS-9 service through its stored address
                    ldb       #9        ; prepare constant 9 for the surrounding operation
                    tst       $05,s     ; set condition codes from $05,s without changing it
                    ble       ExitThroughRuntime ; continue at ExitThroughRuntime when the signed bound test succeeds
                    ldb       #10       ; select the line-feed control byte
ExitThroughRuntime  lbra      ReturnEncodedServiceResult ; resume return encoded service result
DefineEditorWindow  ldd       #6946     ; prepare constant 6946 for the surrounding operation
                    bsr       InvokeEncodedService ; call the decoded OS-9 service through its stored address
                    ldb       #9        ; initialize  to 9
                    bra       ExitThroughRuntime ; resume exit through runtime
InvokeEncodedService leax      >EncodedServiceAddress,y ; select encoded service address
                    std       ,x++      ; retain
                    lda       $07,s     ; read the relevant word from the active stack frame
                    ldb       $09,s     ; read the relevant word from the active stack frame
                    std       ,x++      ; retain
                    lda       $0B,s     ; read the relevant word from the active stack frame
                    ldb       $0D,s     ; read the relevant word from the active stack frame
                    std       ,x++      ; retain
                    lda       $0F,s     ; read the relevant word from the active stack frame
                    ldb       <$0011,s  ; read the relevant word from the active stack frame
                    std       ,x++      ; retain
                    lda       <$0013,s  ; read the relevant word from the active stack frame
                    ldb       <$0015,s  ; read the relevant word from the active stack frame
                    std       ,x        ; retain
                    rts                 ; return to the caller
                    ldd       #6948     ; prepare constant 6948 for the surrounding operation
                    bra       SaveEncodedServiceAddress ; resume save encoded service address
EndEditorWindow     ldd       #6947     ; initialize encoded service address to 6947
                    bra       SaveEncodedServiceAddress ; resume save encoded service address
                    ldd       #6945     ; initialize encoded service address to 6945
SaveEncodedServiceAddress std       >EncodedServiceAddress,y ; retain encoded service address
                    ldb       #2        ; initialize encoded service address to 2
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
                    ldd       #6960     ; initialize encoded service address to 6960
                    std       >EncodedServiceAddress,y ; retain encoded service address
                    ldb       #2        ; prepare constant 2 for the surrounding operation
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
EmitForegroundColor ldb       #50       ; prepare constant 50 for the surrounding operation
                    bra       InvokeEncodedEscapeService ; resume invoke encoded escape service
EmitBackgroundColor ldb       #51       ; prepare constant 51 for the surrounding operation
                    bra       InvokeEncodedEscapeService ; resume invoke encoded escape service
                    ldb       #52       ; initialize encoded service address to 52
                    bra       InvokeEncodedEscapeService ; resume invoke encoded escape service
                    ldb       #47       ; initialize encoded service address to 47
InvokeEncodedEscapeService lda       #27       ; initialize encoded service address to 27
                    std       >EncodedServiceAddress,y ; retain encoded service address
                    ldb       $05,s     ; read the relevant word from the active stack frame
                    stb       >EncodedServiceScratch,y ; retain encoded service scratch
                    ldb       #3        ; prepare constant 3 for the surrounding operation
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
                    ldb       #1        ; prepare constant 1 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
                    ldb       #3        ; prepare constant 3 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
EmitAnsiCursorHome  ldb       #4        ; prepare constant 4 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
ReadAltKey          ldd       #1312     ; prepare constant 1312 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
ReadEditorKey       ldd       #1313     ; prepare constant 1313 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
EmitAnsiCursorUp    ldb       #6        ; prepare constant 6 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
SignalOutputOverflow ldb       #7        ; prepare constant 7 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
EmitAnsiCursorDown  ldb       #8        ; prepare constant 8 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
EmitAnsiCursorRight ldb       #9        ; prepare constant 9 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
EmitAnsiCursorLeft  ldb       #10       ; select the line-feed control byte
                    bra       SaveEncodedByteService ; resume save encoded byte service
                    ldb       #11       ; prepare constant 11 for the surrounding operation
                    bra       SaveEncodedByteService ; resume save encoded byte service
ClearEditorScreen   ldb       #12       ; initialize $02 f8 to 12
                    bra       SaveEncodedByteService ; resume save encoded byte service
                    ldb       #13       ; recognize the carriage-return terminator
SaveEncodedByteService stb       >EncodedServiceAddress,y ; retain encoded service address
                    ldb       #1        ; prepare constant 1 for the surrounding operation
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
InitializeTerminalDisplay ldd       #7968     ; prepare constant 7968 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
PauseForBanner      ldd       #7969     ; prepare constant 7969 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
EnableBoldAttribute ldd       #7970     ; prepare constant 7970 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
EnableUnderlineAttribute ldd       #7971     ; prepare constant 7971 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
EnableBlinkAttribute ldd       #7972     ; prepare constant 7972 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
EnableReverseAttribute ldd       #7973     ; prepare constant 7973 for the surrounding operation
                    bra       SaveEncodedWordService ; resume save encoded word service
                    ldd       #7984     ; initialize encoded service address to 7984
                    bra       SaveEncodedWordService ; resume save encoded word service
                    ldd       #7985     ; initialize encoded service address to 7985
SaveEncodedWordService std       >EncodedServiceAddress,y ; retain encoded service address
                    ldb       #2        ; initialize  to 2
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
DecodeAnsiParameter leax      >EncodedServiceAddress,y ; select encoded service address
                    ldb       #2        ; initialize  to 2
                    stb       ,x+       ; retain
                    ldd       $04,s     ; read the relevant word from the active stack frame
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; retain
                    ldd       $06,s     ; read the relevant word from the active stack frame
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; retain
                    ldb       #3        ; prepare constant 3 for the surrounding operation
                    lbra      ReturnEncodedServiceResult ; resume return encoded service result
ReturnEncodedServiceResult clra                ; select standard input
                    leax      >EncodedServiceAddress,y ; select encoded service address
                    pshs      y         ; preserve y across the operation
                    tfr       d,y       ; transfer d,y
                    lda       $05,s     ; read the relevant word from the active stack frame
                    os9       I$Write   ; write the requested fixed-size field
                    puls      y         ; restore y
                    bcs       TerminalControlWriteFailed ; carry reports failure: terminal control write failed
                    clra                ; select standard input
                    clrb                ; clear the byte accumulator for counting
                    rts                 ; return to the caller
TerminalControlWriteFailed clra                ; select standard input
                    std       >LastIoError,y ; retain last io error
                    ldd       #-1       ; prepare constant -1 for the surrounding operation
                    rts                 ; return to the caller

* initialization data

etext               fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $01
                    fcb       $8C
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
                    fcb       $00
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
                    fcb       $04
                    fcb       $00
                    fcb       $03
                    fcb       $00
                    fcb       $05
                    fcb       $00
                    fcb       $01
                    fcb       $00
                    fcb       $06
                    fcb       $00
                    fcb       $07
                    fcb       $00
                    fcb       $00
                    fcc       "&?&E&I&O&V&[&c&h'"
                    fcb       $10
                    fcb       $03
                    fcb       $E8
                    fcb       $00
                    fcb       $64
                    fcb       $00
                    fcb       $0A
                    fcb       $00
                    fcc       "7lx"
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
                    fcb       $08
                    fcb       $00
                    fcb       $1F
                    fcb       $00
                    fcb       $2D
                    fcb       $00
                    fcb       $2B
                    fcb       $00
                    fcb       $29
                    fcb       $00
                    fcb       $27
                    fcb       $00
                    fcb       $25
                    fcb       $00
                    fcb       $23
                    fcb       $00
                    fcb       $21
                    fcb       $00
                    fcb       $01
                    fcb       $00
                    fcc       "7AnsiEd"
                    fcb       $00

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
