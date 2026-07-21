**********************************************************************
* Ansicode - OS-9 Level 2 BBS command
*
* Syntax: Ansicode <codes>
* Purpose: Emit ANSI escape sequences selected by compact command-line codes.
* Output: terminal control bytes on standard output.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Ansicode
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ReservedWorkspace   rmb       400       ; retain the module's original minimum data allocation
size                equ       .         ; define the assembly-time value for size

name                fcs       /Ansicode/ ; store an OS-9 high-bit-terminated string
AnsiPrefix          fcb       $1B       ; ESC introduces the generated ANSI control sequence
                    fcb       $5B       ; store byte data
start               pshs      x         ; save x on the stack
                    leax      >AnsiPrefix,pc ; write ESC plus the caller-supplied ANSI selector
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
