**********************************************************************
* pause - OS-9 Level 2 BBS command
*
* syntax: pause ["message"]
* purpose: display a message and wait for one keypress.
* interactive scripts must redirect standard input from the caller terminal.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       pause
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

KeyBuffer           rmb       1         ; receives the single key that dismisses the prompt
MessageLength       rmb       1         ; length of a caller-supplied message before CR/quote
MessagePointer      rmb       2         ; beginning of the caller-supplied message
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /pause/   ; os-9 module name
TrailingNewline     fcb       C$LF,C$CR ; move below the prompt after the keypress

* only a quoted parameter is displayed; other command-line text is ignored until CR.
start               lda       ,x+       ; scan for an opening quote or the parameter terminator
                    cmpa      #'"'      ; a quote begins a custom prompt
                    beq       MeasureCustomMessage ; nonempty parameters replace the default prompt
                    cmpa      #C$CR     ; the end of unquoted input selects the default
                    bne       start     ; ignore unsupported unquoted text
                    leax      >DefaultPrompt,pc ; no message was supplied, so use the documented default
                    ldy       #28       ; write the visible text without its trailing CR
                    bra       DisplayPrompt ; default text already has a known length
MeasureCustomMessage clr       MessageLength,u ; count only the visible caller-supplied text
                    stx       MessagePointer,u ; retain its beginning while X scans for the end
ScanMessageEnd      lda       ,x+       ; inspect the next parameter character
                    cmpa      #'"'      ; a closing quote ends the custom prompt
                    beq       CustomLengthReady ; omit the quote itself
                    cmpa      #C$CR     ; also tolerate a missing closing quote
                    beq       CustomLengthReady ; omit the parameter terminator
                    inc       MessageLength,u ; include this visible character
                    bra       ScanMessageEnd ; continue until CR or the closing quote
CustomLengthReady   ldb       MessageLength,u ; convert the byte count to I$Write's Y length
                    clra                ; zero-extend the byte count
                    tfr       d,y       ; supply the resulting word to I$Write
                    ldx       MessagePointer,u ; restore the start of the custom message
DisplayPrompt       lda       #1        ; display the selected prompt on standard output
                    os9       I$Write   ; write Y bytes from X to path A
                    bcs       ExitWithStatus ; do not wait for input after an output failure
                    clra                ; select standard input
                    ldy       #1        ; consume exactly one keypress
                    leax      KeyBuffer,u ; discard one key into the one-byte input buffer
                    os9       I$Read    ; block until the caller dismisses the prompt
                    bcs       ExitWithStatus ; propagate an input-path failure
                    lda       #1        ; target standard output
                    leax      >TrailingNewline,pc ; leave the terminal at the next line
                    ldy       #2        ; emit LF followed by CR
                    os9       I$WritLn  ; restore a clean terminal line for the caller
                    clrb                ; report success after the keypress
ExitWithStatus      os9       F$Exit    ; return the I/O status in B
DefaultPrompt       fcc       "Press any key to continue..." ; default when no message argument is present
                    fcb       C$CR      ; retain the original terminator after the unwritten text

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
