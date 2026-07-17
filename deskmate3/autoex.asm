********************************************************************
* TURNKEY - DeskMate 3 automatic startup command
*
* This source was reconstructed from the original Tandy binary stored
* as "autoex". It starts DeskMate and falls back to the OS-9 shell.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/16  Codex
* Disassembled and annotated from the original executable.
*

                    nam       TURNKEY
                    ttl       DeskMate 3 automatic startup command

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt
edition             set       $44

                    mod       eom,name,tylg,atrv,start,$0100

name                fcs       /TURNKEY/ ; OS-9 module name

* The edition byte doubles as the initial "D" in the primary command name.
DeskName            fcb       edition   ; edition $44 is ASCII "D"
                    fcc       /ESK/     ; remainder of the DeskMate command name
                    fcb       C$CR      ; terminate the OS-9 command name
ShellName           fcc       /SHELL/   ; fallback command name
                    fcb       C$CR      ; terminate the OS-9 command name

start               leas      $0100,u   ; place the stack above the 256-byte data area
                    lda       #$FA      ; select DeskMate's turnkey startup behavior
                    sta       ,u        ; build the one-byte parameter block
                    lda       #tylg     ; request a program-module 6809 object
                    ldb       #$04      ; request four additional 256-byte pages
                    leax      >DeskName,pcr ; point to the DeskMate command name
                    ldy       #$0001    ; pass the single startup-control byte
                    os9       F$Chain   ; replace TURNKEY with DeskMate

* F$Chain returns only if DESK could not be started. Try a plain shell
* while retaining A = Prgrm+Objct from the first request.
                    ldb       #$01      ; request one additional memory page
                    leax      >ShellName,pcr ; point to the fallback shell name
                    ldy       #$0000    ; the fallback receives no parameters
                    leau      $05,x     ; supply a harmless pointer just past "SHELL"
                    os9       F$Chain   ; replace TURNKEY with the OS-9 shell
                    os9       F$Exit    ; return the second chain error if it also failed

                    emod
eom                 equ       *
                    end
