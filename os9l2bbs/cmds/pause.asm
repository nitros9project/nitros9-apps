**********************************************************************
* pause - OS-9 Level 2 BBS command
*
* Syntax: pause ["message"]
* Purpose: Display a message and wait for one keypress.
* Interactive scripts must redirect standard input from the caller terminal.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       pause
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

KeyBuffer           rmb       1         ; receives the single key that dismisses the prompt
MessageLength       rmb       1         ; length of a caller-supplied message before CR/quote
MessagePointer      rmb       2         ; beginning of the caller-supplied message
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; define the assembly-time value for size

name                fcs       /pause/ ; store an OS-9 high-bit-terminated string
TrailingNewline     fcb       $0A       ; LF/CR written after the keypress
                    fcb       $0D       ; store byte data
start               lda       ,x+       ; load a from ,x+
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       MeasureCustomMessage ; nonempty parameters replace the default prompt
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       start     ; branch when the values differ or the result is nonzero; target start
                    leax      >DefaultPrompt,pc ; no message was supplied, so use the documented default
                    ldy       #28       ; set y to the constant 28
                    bra       DisplayPrompt ; default text already has a known length
MeasureCustomMessage clr       MessageLength,u ; count only the visible caller-supplied text
                    stx       MessagePointer,u ; retain its beginning while X scans for the end
ScanMessageEnd      lda       ,x+       ; inspect the next parameter character
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       CustomLengthReady ; cr terminates an unquoted parameter
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       CustomLengthReady ; closing quote is not part of the displayed message
                    inc       MessageLength,u ; include this visible character
                    bra       ScanMessageEnd ; continue until CR or the closing quote
CustomLengthReady   ldb       MessageLength,u ; convert the byte count to I$Write's Y length
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    ldx       MessagePointer,u ; restore the start of the custom message
DisplayPrompt       lda       #1        ; display the selected prompt on standard output
                    os9       I$Write   ; write Y bytes from X to path A
                    bcs       ExitWithStatus ; do not wait for input after an output failure
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    leax      KeyBuffer,u ; discard one key into the one-byte input buffer
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       ExitWithStatus ; propagate an input-path failure
                    lda       #1        ; set a to the constant 1
                    leax      >TrailingNewline,pc ; leave the terminal at the next line
                    ldy       #2        ; set y to the constant 2
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      os9       F$Exit    ; return the I/O status in B
DefaultPrompt       fcc       "Press any key to continue..." ; default when no message argument is present
                    fcb       $0D       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
