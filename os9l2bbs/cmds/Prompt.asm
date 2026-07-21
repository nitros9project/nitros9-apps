**********************************************************************
* Prompt - OS-9 Level 2 BBS command
*
* syntax: Prompt <command-and-arguments> "prompt" [remaining arguments]
* purpose: read one value, splice it into a child parameter line, and run the command.
* provides interactive parameter substitution for menu and script workflows.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       Prompt
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ParameterLength     rmb       1         ; byte count passed to F$Fork
ParameterLengthReserved rmb  1         ; unused second byte of the original word
PromptTextStart     rmb       2         ; first character inside the quoted prompt
SuffixStart         rmb       2         ; first command-line byte after the closing quote
CommandLineStart    rmb       2         ; original module name and argument string
ParameterBuffer     rmb       600       ; prefix, entered value, suffix, and terminating CR
size                equ       .         ; total per-process workspace size

name                fcs       /Prompt/ ; os-9 module name
start               stx       CommandLineStart,u ; retain the original command-line pointer
FindCommandEnd      lda       ,x+       ; scan across the child module name
                    cmpa      #C$SPAC   ; a space separates the module from its arguments
                    beq       StartParameterCopy ; terminate the module name there
                    cmpa      #C$CR     ; a command without arguments ends immediately
                    beq       StartParameterCopy ; launch it with an empty parameter line
                    bra       FindCommandEnd ; continue through the module name
StartParameterCopy  lda       #C$CR     ; form the terminator required by F$Fork
                    sta       -1,x      ; replace the name/argument separator in place
                    leay      ParameterBuffer,u ; begin assembling the child parameter line
                    clr       ParameterLength,u ; initialize its one-byte length

* copy arguments preceding the opening quote. If no quote exists, the copied line
* is launched unchanged and no interactive read is performed.
CopyParameterPrefix lda       ,x+       ; fetch the next argument byte
                    cmpa      #'"'      ; an opening quote introduces the prompt text
                    beq       MeasurePromptText ; remember and display the quoted text
                    sta       ,y+       ; append an ordinary prefix byte
                    inc       ParameterLength,u ; account for the appended byte
                    cmpa      #C$CR     ; stop when the original arguments end
                    bne       CopyParameterPrefix ; continue toward a quote or CR
                    lbra      LaunchCommand ; fork with the unmodified copied arguments

MeasurePromptText   stx       PromptTextStart,u ; retain the first byte inside the quote
                    clrb                ; measure the prompt in B
FindPromptEnd       lda       ,x+       ; scan the quoted display text
                    cmpa      #C$CR     ; tolerate a missing closing quote
                    beq       ReadPromptValue ; use all remaining text as the prompt
                    cmpa      #'"'      ; a closing quote ends the displayed prompt
                    beq       ReadPromptValue ; preserve the following suffix pointer
                    incb                ; account for one visible prompt byte
                    bra       FindPromptEnd ; continue through the quoted text

ReadPromptValue     stx       SuffixStart,u ; retain the arguments following the quote
                    ldx       PromptTextStart,u ; select the prompt's first character
                    clra                ; zero-extend its length from B into D
                    pshs      y         ; preserve the current parameter append cursor
SavedParameterCursor equ      0         ; saved append cursor at the current stack top
                    tfr       d,y       ; supply the visible prompt length to I$Write
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the prompt without adding a newline
                    ldx       SavedParameterCursor,s ; enter input directly at the append cursor
                    ldy       #80       ; accept at most 79 characters plus CR
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the caller's substituted value
                    leay      -1,y      ; exclude the input CR from the child arguments
                    tfr       y,d       ; retain the entered byte count in B
                    puls      y         ; recover the original append cursor
                    leay      d,y       ; advance it past the entered value
                    addb      ParameterLength,u ; include the earlier parameter prefix
                    stb       ParameterLength,u ; retain the combined length
                    ldx       SuffixStart,u ; select the arguments after the prompt quote
CopyParameterSuffix lda       ,x+       ; fetch the next suffix byte
                    sta       ,y+       ; append it after the entered value
                    inc       ParameterLength,u ; include it in the child parameter length
                    cmpa      #C$CR     ; the suffix includes the final terminator
                    bne       CopyParameterSuffix ; copy through the end of the line

LaunchCommand       ldx       CommandLineStart,u ; select the now-terminated child module name
                    ldb       ParameterLength,u ; zero-extend the parameter byte count
                    clra                ; form the 16-bit F$Fork parameter length
                    tfr       d,y       ; supply that length in Y
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    ldb       #3        ; preserve the original three-page memory request
                    pshs      u         ; preserve this command's workspace pointer
                    leau      ParameterBuffer,u ; pass the assembled parameter line
                    os9       F$Fork    ; start the requested child command
                    lbcs      ExitWithStatus ; propagate fork failures
                    os9       F$Wait    ; wait for that child to finish
                    lbcs      ExitWithStatus ; propagate wait failures
                    puls      u         ; recover this command's workspace pointer
                    clrb                ; return success after the child exits
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
