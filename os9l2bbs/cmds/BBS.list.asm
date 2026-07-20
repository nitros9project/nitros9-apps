**********************************************************************
* BBS.list - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.list
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

InPath              rmb       1         ; reserve 1 byte(s) in the module workspace
Buffer              rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.list/ ; store an OS-9 high-bit-terminated string

start               lda       #1        ; set a to the constant 1
                    os9       I$Open    ; Open the specified file for reading
                    lbcs      ErrExit   ; Exit on error
                    sta       InPath,u  ; Store the input path number

* Copy the data in the file to the terminal or console
CopyLoop            lda       InPath,u  ; Get the input path number
                    leax      Buffer,u  ; form the address Buffer,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; Read 200 bytes from the input file
                    bcs       Exit      ; Exit on error
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; Write the buffer to the output path

* Has the user pressed a key on the terminal?
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; Is data waiting on the terminal?
                    bcs       CopyLoop  ; No, continue listing to the output path

* If the user presses SPACE, abort the list
                    ldy       #1        ; set y to the constant 1
                    leax      Buffer,u  ; form the address Buffer,u in x
                    os9       I$Read    ; Read a character from the terminal
                    lda       0,x       ; load a from 0,x
                    cmpa      #32       ; Did the user press SPACE?
                    bne       CopyLoop  ; No, continue the listing

Exit                clrb                ; Clear the error flag
ErrExit             os9       F$Exit    ; and exit

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
