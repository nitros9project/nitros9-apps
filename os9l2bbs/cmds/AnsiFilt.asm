**********************************************************************
* AnsiFilt - OS-9 Level 2 BBS command
*
* Syntax: AnsiFilt <input> or <producer> | AnsiFilt
* Purpose: Translate ANSI terminal sequences into CoCo OS-9 display operations.
* State: parser state, numeric parameters, cursor controls, and translated output.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       AnsiFilt
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt+rev
rev                 set       $01

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ReadBuf             rmb       1
ColCount            rmb       1
RowCount            rmb       1
SavedColumn         rmb       1
SavedRow            rmb       1
InEscSeq            rmb       1
XSave               rmb       2
WriteBuf            rmb       1
EscapeBufferTail    rmb       499
size                equ       .

name                fcs       /AnsiFilt/
                    fcb       $0A

start               lbsr      Setup     ; initialize parser and cursor state
ReadLoop            clra                ; select standard input
                    leax      ReadBuf,u ; select read buf
                    ldy       #1        ; read one stream byte at a time
                    os9       I$Read    ; read the requested fixed-size field
                    bcs       Error     ; select error when carry reports an error or underflow
                    lda       ReadBuf,u ; recover read buf
                    lbsr      ProcessInputByte ; invoke process input byte
                    bra       ReadLoop  ; continue with read loop

Error               cmpb      #E$EOF    ; distinguish normal end of input from a real failure
                    lbne      ErrExit   ; select err exit when the requested case does not match
                    bra       Exit      ; continue with exit
Exit                clrb                ; report successful translation at end of input
ErrExit             os9       F$Exit    ; terminate the process with status B

Setup               clr       InEscSeq,u ; initialize in esc seq
                    leax      WriteBuf,u ; select write buf
                    stx       XSave,u   ; retain xsave
                    lda       #1        ; initialize col count to 1
                    sta       ColCount,u ; retain col count
                    sta       RowCount,u ; retain row count
                    sta       SavedColumn,u ; retain saved column
                    sta       SavedRow,u ; retain saved row
                    rts                 ; return to the caller

ProcessInputByte    cmpa      #32       ; is it a space?
                    bcs       HandleControlCharacter ; no, go check others
                    tst       <InEscSeq ; in an ESC sequence?
                    lbne      AccumulateEscapeSequence ; yes, go handle it

* Write the character to the output path
stk_printable_char  equ       0
                    pshs      a         ; expose the printable byte as a one-byte output buffer
                    leax      stk_printable_char,s ; point I$Write at the saved character
                    ldy       #1        ; emit exactly that character
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field

                    inc       ColCount,u ; increment the number of chars written
                    lda       ColCount,u ; recover col count
                    cmpa      #128      ; wrap the filter's logical display width
                    bls       ReturnAfterPrintable ; no, so return

                    lda       #1        ; reset the column count
                    sta       ColCount,u ; retain col count
                    inc       RowCount,u ; increment the row count
                    lda       RowCount,u ; recover row count
                    cmpa      #23       ; have we written 24 rows?
                    bls       ReturnAfterPrintable ; no, so return

                    lda       #23       ; reset the row count
                    sta       RowCount,u ; retain row count
ReturnAfterPrintable puls      pc,a      ; clean the stack and return

HandleControlCharacter cmpa      #27       ; is it an ESC?
                    beq       HandleESC ; yes, go handle it
                    cmpa      #7        ; is it a BEL character?
                    beq       HandleBEL ; yes, go handle it
                    cmpa      #8        ; is it a BS character?
                    beq       HandleBS  ; yes, go handle it
                    cmpa      #10       ; is it an LF character?
                    beq       HandleLF  ; yes, go handle it
                    cmpa      #13       ; is it a CR character?
                    beq       HandleCR  ; yes, go handle it
                    rts                 ; something else, so return

HandleESC           lda       #1        ; parsing an ESC seq, so set the flag
                    sta       InEscSeq,u ; retain in esc seq
                    leax      WriteBuf,u ; select write buf
                    lda       #27       ; save the ESC code in the buffer
                    sta       ,x+       ; increment the buffer pointer
                    stx       XSave,u   ; save a copy of the pointer
                    rts                 ; ... and return

* Write the BEL to the output path
stk_bell_char       equ       0
HandleBEL           pshs      a         ; expose BEL as a one-byte output buffer
                    leax      stk_bell_char,s ; point I$Write at the saved BEL
                    ldy       #1        ; emit exactly one control byte
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      pc,a      ; restore pc,a and return to the caller

HandleBS            pshs      a         ; preserve a across the operation
                    dec       ColCount,u ; decrement the column count
                    bne       bs1       ; branch if col count not zero
                    lda       #1        ; reset the column count
                    sta       ColCount,u ; retain col count
                    bra       bsret     ; ... and return

* Write the BS to the output path
stk_backspace_char  equ       0
bs1                 leax      stk_backspace_char,s ; point I$Write at the saved backspace
                    ldy       #1        ; emit exactly one control byte
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
bsret               puls      pc,a      ; clean the stack and return

* Write the LF to the output path
stk_linefeed_char   equ       0
HandleLF            pshs      a         ; expose LF as a one-byte output buffer
                    leax      stk_linefeed_char,s ; point I$Write at the saved LF
                    ldy       #1        ; emit exactly one control byte
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field

                    inc       RowCount,u ; increment the row count
                    lda       RowCount,u ; recover row count
                    cmpa      #23       ; recognize 23 as a meaningful value in this parser state
                    bls       lfret     ; return if less than 24 rows
                    lda       #23       ; reset the row count
                    sta       RowCount,u ; retain row count
lfret               puls      pc,a      ; clean the stack and return

* Write the CR to the output path
stk_return_char     equ       0
HandleCR            pshs      a         ; expose CR as a one-byte output buffer
                    leax      stk_return_char,s ; point I$Write at the saved CR
                    ldy       #1        ; emit exactly one control byte
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field

                    lda       #1        ; reset the col count
                    sta       ColCount,u ; retain col count
                    puls      pc,a      ; clean the stack and return

AccumulateEscapeSequence cmpa      #65       ; is it less than 'A'?
                    bcs       AppendEscapeByte ; yes, append it to the save sequence
                    cmpa      #91       ; it is a '['?
                    beq       AppendEscapeByte ; yes, append it to the save sequence
                    cmpa      #122      ; is it greater than 'z'?
                    bhi       AppendEscapeByte ; yes, append it to the save sequence
                    lbra      DispatchEscapeFinal ; continue with dispatch escape final

* Append the char to the ESC sequence buffer
AppendEscapeByte    ldx       XSave,u   ; recover the next free escape-buffer position
                    sta       ,x+       ; append this intermediate escape byte
                    stx       XSave,u   ; retain xsave
                    rts                 ; return to the caller

DispatchEscapeFinal clr       InEscSeq,u ; reset the ESC sequence flag
                    ldx       XSave,u   ; get the buffer pointer
                    sta       ,x+       ; save the current character
                    stx       XSave,u   ; ... and save the new pointer
                    cmpa      #72       ; is it an 'H'?
                    lbeq      Esc_Hf    ; yes, handle it
                    cmpa      #65       ; is it an 'A'?
                    lbeq      Esc_A     ; yes, handle it
                    cmpa      #66       ; is it a 'B'?
                    lbeq      Esc_B     ; yes, handle it
                    cmpa      #67       ; is it a 'C'?
                    lbeq      Esc_C     ; select esc c when the requested case matches
                    cmpa      #68       ; recognize 68 as a meaningful value in this parser state
                    lbeq      Esc_D     ; select esc d when the requested case matches
                    cmpa      #102      ; recognize 102 as a meaningful value in this parser state
                    lbeq      Esc_Hf    ; select esc hf when the requested case matches
                    cmpa      #115      ; recognize 115 as a meaningful value in this parser state
                    lbeq      Esc_s     ; select esc s when the requested case matches
                    cmpa      #117      ; recognize 117 as a meaningful value in this parser state
                    lbeq      Esc_u     ; select esc u when the requested case matches
                    cmpa      #74       ; recognize 74 as a meaningful value in this parser state
                    lbeq      Esc_J     ; select esc j when the requested case matches
                    cmpa      #107      ; recognize 107 as a meaningful value in this parser state
                    lbeq      Esc_k     ; select esc k when the requested case matches
                    cmpa      #109      ; recognize 109 as a meaningful value in this parser state
                    lbeq      Esc_m     ; select esc m when the requested case matches

* Write the buffer to the output path
FlushEscapeLiteral  leax      WriteBuf,u ; recover the escape sequence's starting address
stk_escape_start    equ       0
                    pshs      x         ; retain it while computing the buffered length
                    ldd       XSave,u   ; recover xsave
                    subd      stk_escape_start,s ; convert end pointer minus start into length
                    leas      $02,s     ; discard the temporary start pointer
                    tfr       d,y       ; transfer d,y
                    leax      WriteBuf,u ; select write buf
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    clr       InEscSeq,u ; initialize in esc seq
                    rts                 ; return to the caller

* Clear the screen
ClearScreenCode     fcb       $0C
Esc_J               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lda       ,x+       ; consume the next byte while esc j
                    cmpa      #50       ; recognize 50 as a meaningful value in this parser state
                    bne       FlushEscapeLiteral ; select flush escape literal when the requested case does not match
                    leax      >ClearScreenCode,pc ; select clear screen code
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    lda       #1        ; initialize col count to 1
                    sta       ColCount,u ; retain col count
                    sta       RowCount,u ; retain row count
                    rts                 ; return to the caller

ClearToEolCode      fcb       $04
Esc_k               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    leax      >ClearToEolCode,pc ; select clear to eol code
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    rts                 ; return to the caller

SetCursorCode       fcb       $02
Esc_Hf              lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    sta       RowCount,u ; retain row count
                    adda      #31       ; add to a using #31
                    pshs      a         ; preserve a across the operation
                    lda       ,x+       ; consume the next byte while esc hf
                    cmpa      #59       ; recognize 59 as a meaningful value in this parser state
                    beq       ParseCursorColumn ; enter parse cursor column when the terminating condition is met
                    puls      a         ; restore a
                    lbra      FlushEscapeLiteral ; continue with flush escape literal
ParseCursorColumn   lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    sta       ColCount,u ; retain col count
                    adda      #31       ; add to a using #31
                    pshs      a         ; preserve a across the operation
                    leax      >SetCursorCode,pc ; select set cursor code
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      ,s        ; select
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leas      $02,s     ; release $02,s bytes of stack state
                    rts                 ; return to the caller

CursorUpCode        fcb       $09
Esc_A               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    pshs      a         ; preserve a across the operation
                    lda       RowCount,u ; recover row count
                    suba      ,s        ; subtract from a using ,s
                    bgt       CursorUpClamped ; continue at CursorUpClamped when the signed value is above the limit
                    lda       #1        ; initialize row count to 1
CursorUpClamped     sta       RowCount,u ; retain row count
                    leax      >CursorUpCode,pc ; select cursor up code
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
EmitRepeatedCursorMove tst       ,s        ; set condition codes from ,s without changing it
                    beq       CursorMoveDone ; select cursor move done when the requested case matches
                    os9       I$Write   ; write the requested fixed-size field
                    dec       ,s        ; consume one
                    bne       EmitRepeatedCursorMove ; select emit repeated cursor move when the requested case does not match
CursorMoveDone      leas      $01,s     ; release $01,s bytes of stack state
                    rts                 ; return to the caller

CursorDownCode      fcb       $0A
Esc_B               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    pshs      a         ; preserve a across the operation
                    lda       RowCount,u ; recover row count
                    adda      ,s        ; add to a using ,s
                    cmpa      #23       ; recognize 23 as a meaningful value in this parser state
                    bls       CursorDownClamped ; select cursor down clamped at or below the unsigned boundary
                    suba      #23       ; subtract from a using #23
                    pshs      a         ; preserve a across the operation
                    lda       $01,s     ; recover $01
                    suba      ,s        ; subtract from a using ,s
                    leas      $01,s     ; release $01,s bytes of stack state
                    sta       ,s        ; store a in the current stack frame at ,s
                    lda       #23       ; initialize row count to 23
CursorDownClamped   sta       RowCount,u ; retain row count
                    leax      >CursorDownCode,pc ; select cursor down code
                    ldy       #1        ; supply 1 as the control, count, or argument value required here
                    lda       #1        ; supply 1 as the control, count, or argument value required here
                    bra       EmitRepeatedCursorMove ; continue with emit repeated cursor move

CursorRightCode     fcb       $06
Esc_C               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    pshs      a         ; preserve a across the operation
                    lda       ColCount,u ; recover col count
                    adda      ,s        ; add to a using ,s
                    cmpa      #80       ; recognize 80 as a meaningful value in this parser state
                    bls       CursorRightClamped ; select cursor right clamped at or below the unsigned boundary
                    suba      #80       ; subtract from a using #80
                    pshs      a         ; preserve a across the operation
                    lda       $01,s     ; recover $01
                    suba      ,s        ; subtract from a using ,s
                    sta       $01,s     ; store a in the current stack frame at $01,s
                    leas      $01,s     ; release $01,s bytes of stack state
                    lda       #80       ; initialize col count to 80
CursorRightClamped  sta       ColCount,u ; retain col count
                    leax      >CursorRightCode,pc ; select cursor right code
                    ldy       #1        ; supply 1 as the control, count, or argument value required here
                    lda       #1        ; supply 1 as the control, count, or argument value required here
                    lbra      EmitRepeatedCursorMove ; continue with emit repeated cursor move

CursorLeftCode      fcb       $08
Esc_D               lbsr      LocateCsiParameters ; invoke locate csi parameters
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    pshs      a         ; preserve a across the operation
                    lda       ColCount,u ; recover col count
                    suba      ,s        ; subtract from a using ,s
                    bgt       CursorLeftClamped ; continue at CursorLeftClamped when the signed value is above the limit
                    deca                ; decrement a
                    adda      ,s        ; add to a using ,s
                    sta       ,s        ; store a in the current stack frame at ,s
                    lda       #1        ; initialize col count to 1
CursorLeftClamped   sta       ColCount,u ; retain col count
                    leax      >CursorLeftCode,pc ; select cursor left code
                    ldy       #1        ; supply 1 as the control, count, or argument value required here
                    lda       #1        ; initialize saved column to 1
                    lbra      EmitRepeatedCursorMove ; continue with emit repeated cursor move

Esc_s               lda       ColCount,u ; recover col count
                    sta       SavedColumn,u ; retain saved column
                    lda       RowCount,u ; recover row count
                    sta       SavedRow,u ; retain saved row
                    rts                 ; return to the caller

Esc_u               lda       SavedRow,u ; recover saved row
                    sta       RowCount,u ; retain row count
                    adda      #31       ; add to a using #31
                    pshs      a         ; preserve a across the operation
                    lda       SavedColumn,u ; recover saved column
                    sta       ColCount,u ; retain col count
                    adda      #31       ; add to a using #31
                    pshs      a         ; preserve a across the operation
                    leax      >SetCursorCode,pc ; select set cursor code
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      ,s        ; select
                    ldy       #2        ; cap this output request at 2 bytes
                    os9       I$Write   ; write the requested fixed-size field
                    leas      $02,s     ; release $02,s bytes of stack state
                    rts                 ; return to the caller

Esc_m               lbsr      LocateCsiParameters ; invoke locate csi parameters
ParseSgrParameter   lda       ,x        ; recover
                    cmpa      #109      ; recognize 109 as a meaningful value in this parser state
                    beq       ReturnFromSgr ; select return from sgr when the requested case matches
                    lbsr      ParseAnsiParameter ; invoke parse ansi parameter
                    bsr       ApplySgrAttribute ; invoke apply sgr attribute
                    lda       ,x+       ; consume the next byte while parse sgr parameter
                    cmpa      #59       ; recognize 59 as a meaningful value in this parser state
                    beq       ParseSgrParameter ; enter parse sgr parameter when the terminating condition is met
ReturnFromSgr       rts                 ; return to the caller

ApplySgrAttribute   pshs      x         ; preserve x across the operation
                    cmpa      #0        ; recognize 0 as a meaningful value in this parser state
                    beq       ResetAttributes ; select reset attributes when the requested case matches
                    cmpa      #4        ; recognize 4 as a meaningful value in this parser state
                    beq       SetUnderline ; select set underline when the requested case matches
                    cmpa      #5        ; recognize 5 as a meaningful value in this parser state
                    beq       SetBlink  ; select set blink when the requested case matches
                    cmpa      #7        ; recognize 7 as a meaningful value in this parser state
                    beq       SetReverseVideo ; select set reverse video when the requested case matches
                    cmpa      #8        ; recognize 8 as a meaningful value in this parser state
                    beq       SetConceal ; select set conceal when the requested case matches
                    cmpa      #40       ; recognize 40 as a meaningful value in this parser state
                    lbge      MapBackgroundColor ; continue with map background color at or above the signed limit
                    cmpa      #30       ; recognize 30 as a meaningful value in this parser state
                    bge       MapForegroundColor ; continue with map foreground color at or above the signed limit
                    puls      pc,x      ; restore pc,x and return to the caller

ResetAttributeCodes fcb       $1B
                    fcb       $32
                    fcb       $00
                    fcb       $1B
                    fcb       $33
                    fcb       $02
                    fcb       $1F
                    fcb       $21
                    fcb       $1F
                    fcb       $23
                    fcb       $1F
                    fcb       $25

ResetAttributes     leax      >ResetAttributeCodes,pc ; select reset attribute codes
                    ldy       #12       ; cap this output request at 12 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      pc,x      ; restore pc,x and return to the caller

UnderlineCode       fcb       $1F
                    fcb       $22

SetUnderline        leax      >UnderlineCode,pc ; select underline code
EmitTwoByteAttribute ldy       #2        ; cap this output request at 2 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      pc,x      ; restore pc,x and return to the caller

BlinkCode           fcb       $1F
                    fcb       $24

SetBlink            leax      >BlinkCode,pc ; select blink code
                    bra       EmitTwoByteAttribute ; continue with emit two byte attribute

ReverseVideoCode    fcb       $1F
                    fcb       $20

SetReverseVideo     leax      >ReverseVideoCode,pc ; select reverse video code
                    bra       EmitTwoByteAttribute ; continue with emit two byte attribute

ConcealCodes        fcb       $1B
                    fcb       $32
                    fcb       $02
                    fcb       $1B
                    fcb       $33
                    fcb       $02

SetConceal          leax      >ConcealCodes,pc ; select conceal codes
                    ldy       #6        ; cap this output request at 6 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      pc,x      ; restore pc,x and return to the caller

ForegroundPrefix    fcb       $1B
                    fcb       $32

MapForegroundColor  cmpa      #37       ; recognize 37 as a meaningful value in this parser state
                    ble       EmitForegroundColor ; continue at EmitForegroundColor when the signed value is at or below the limit
                    puls      pc,x      ; restore pc,x and return to the caller

EmitForegroundColor suba      #30       ; subtract from a using #30
                    pshs      a         ; preserve a across the operation
                    leax      >ForegroundPrefix,pc ; select foreground prefix
                    ldy       #2        ; cap this output request at 2 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      a         ; restore a
                    leax      >ColorTranslationTable,pc ; select color translation table
                    leax      a,x       ; select a
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    puls      pc,x      ; restore pc,x and return to the caller

BackgroundPrefix    fcb       $1B
                    fcb       $33

MapBackgroundColor  cmpa      #47       ; recognize 47 as a meaningful value in this parser state
                    ble       EmitBackgroundColor ; continue at EmitBackgroundColor when the signed value is at or below the limit
                    puls      pc,x      ; restore pc,x and return to the caller

EmitBackgroundColor suba      #40       ; subtract from a using #40
                    pshs      a         ; preserve a across the operation
                    leax      >BackgroundPrefix,pc ; select background prefix
                    ldy       #2        ; cap this output request at 2 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field
                    leax      >ColorTranslationTable,pc ; select color translation table
                    puls      a         ; restore a
                    leax      a,x       ; select a
                    ldy       #1        ; cap this output request at 1 bytes
                    lda       #1        ; select standard output
                    os9       I$Write   ; write the requested fixed-size field

                    puls      pc,x      ; restore pc,x and return to the caller

ColorTranslationTable fcb       $02
                    fcb       $04
                    fcb       $03
                    fcb       $05
                    fcb       $01
                    fcb       $06
                    fcb       $07
                    fcb       $00

LocateCsiParameters leax      WriteBuf,u ; select write buf
                    leax      $01,x     ; select $01
                    lda       ,x+       ; consume the next byte while locate csi parameters
                    cmpa      #91       ; recognize 91 as a meaningful value in this parser state
                    beq       CsiParametersReady ; select csi parameters ready when the requested case matches
                    leas      $02,s     ; release $02,s bytes of stack state
                    lbra      FlushEscapeLiteral ; continue with flush escape literal
CsiParametersReady  rts                 ; return to the caller

ParseAnsiParameter  lda       ,x        ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    blt       DefaultParameter ; continue with default parameter below the signed limit
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bgt       DefaultParameter ; continue at DefaultParameter when the signed value is above the limit
FindParameterEnd    lda       ,x+       ; consume the next byte while find parameter end
                    cmpa      #48       ; recognize or generate ASCII zero
                    blt       ConvertParameterDigits ; continue with convert parameter digits below the signed limit
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bgt       ConvertParameterDigits ; continue at ConvertParameterDigits when the signed value is above the limit
                    bra       FindParameterEnd ; continue with find parameter end
ConvertParameterDigits leax      -$01,x    ; select -$01
                    tfr       x,y       ; transfer x,y
                    pshs      x         ; preserve x across the operation
                    ldb       #1        ; supply 1 as the control, count, or argument value required here
                    ldx       #0        ; initialize the pointer or index for this state transition
AccumulateParameterDigit pshs      b         ; preserve b across the operation
                    lda       ,-y       ; recover
                    cmpa      #48       ; recognize or generate ASCII zero
                    blt       ReturnParsedParameter ; continue with return parsed parameter below the signed limit
                    cmpa      #57       ; recognize ASCII nine as the upper digit bound
                    bgt       ReturnParsedParameter ; continue at ReturnParsedParameter when the signed value is above the limit
                    suba      #48       ; subtract from a using #48
                    mul                 ; form the byte-product in D
                    abx                 ; advance x by the unsigned offset in b
                    puls      b         ; restore b
                    lda       #10       ; select the line-feed control byte
                    mul                 ; form the byte-product in D
                    bra       AccumulateParameterDigit ; continue with accumulate parameter digit

ReturnParsedParameter puls      b         ; restore b
                    tfr       x,d       ; transfer x,d
                    tfr       b,a       ; transfer b,a
                    puls      pc,x      ; restore pc,x and return to the caller

DefaultParameter    lda       #1        ; supply 1 as the control, count, or argument value required here
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end       ;         end the assembly source
