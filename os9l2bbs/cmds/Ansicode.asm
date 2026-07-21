**********************************************************************
* Ansicode - OS-9 Level 2 BBS command
*
* syntax: Ansicode <codes>
* purpose: emit ANSI escape sequences selected by compact command-line codes.
* output: terminal control bytes on standard output.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       Ansicode
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ReservedWorkspace   rmb       400       ; retain the module's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /Ansicode/ ; os-9 module name
AnsiPrefix          fcb       $1B,'['   ; control-sequence introducer shared by ANSI terminals
* prepend ESC '[' to the shell-supplied selector text at X. The parameter CR becomes
* the terminal sequence's final line terminator because the second write uses I$WritLn.
start               pshs      x         ; protect the parameter-string pointer
                    leax      >AnsiPrefix,pc ; select the two-byte ANSI introducer
                    ldy       #2        ; write ESC and '[' only
                    lda       #1        ; target standard output
                    os9       I$Write   ; begin the terminal control sequence
                    puls      x         ; recover the caller's selector text
                    ldy       #200      ; let I$WritLn stop at the parameter CR
                    os9       I$WritLn  ; append the selector and terminate the sequence
                    clrb                ; preserve the original unconditional success status
                    os9       F$Exit    ; return to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
