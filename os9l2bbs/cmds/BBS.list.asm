**********************************************************************
* bbs.list - OS-9 Level 2 BBS command
*
* syntax: BBS.list <file>
* purpose: display a text file using BBS-friendly terminal output.
* the file is read sequentially and written to the caller path.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.list
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

InputPath           rmb       1         ; open path number for the listed file
LineBuffer          rmb       200       ; one terminal-sized CR-delimited input line
ReservedWorkspace   rmb       400       ; retain the command's original 600-byte data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.list/ ; os-9 module name

* x already points at the command-line pathname supplied by OS-9.
start               lda       #READ.    ; list without modifying the selected file
                    os9       I$Open    ; open the pathname passed to the module
                    lbcs      ErrorExit ; return an open failure unchanged
                    sta       InputPath,u ; retain the sequential input path

* copy one CR-delimited line at a time, polling for an abort key after every write.
CopyNextLine        lda       InputPath,u ; select the listed file
                    leax      LineBuffer,u ; receive the next display line
                    ldy       #200      ; bound the read by the actual buffer size
                    os9       I$ReadLn  ; preserve the file's authored line boundaries
                    bcs       ListingComplete ; eof and read errors both end the original pager
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; display the line just read

                    clra                ; poll standard input
                    ldb       #SS.Ready ; ask whether the caller has typed ahead
                    os9       I$GetStt  ; avoid blocking when no abort key is available
                    bcs       CopyNextLine ; continue immediately while input is idle

* consume a pending key so it cannot leak into the next command; space stops listing.
                    ldy       #1        ; consume exactly the pending byte
                    leax      LineBuffer,u ; safely reuse the beginning of the line buffer
                    os9       I$Read    ; remove the key from standard input
                    lda       ,x        ; inspect the consumed byte
                    cmpa      #C$SPAC   ; space is the pager's abort convention
                    bne       CopyNextLine ; discard other keys and continue listing

ListingComplete     clrb                ; preserve the original successful eof/abort status
ErrorExit           os9       F$Exit    ; return status B to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
