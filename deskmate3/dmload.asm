********************************************************************
* DMLOAD - DeskMate 3 application launcher
*
* This source was reconstructed from the original Tandy binary.
* DeskMate service numbers $4E and $57 remain unidentified.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/16  Codex
* Disassembled and annotated from the original executable.
*

                    nam       DMLOAD
                    ttl       DeskMate 3 application launcher

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00
edition             set       $7E

                    mod       eom,name,tylg,atrv,start,$0100

name                fcs       /DMLOAD/             ; OS-9 module name

* The edition byte doubles as the $7E opcode for "JMP extended". DeskMate
* patches the following address word with its internal service dispatcher.
* Calls use an LBSR followed by an inline one-byte service number.
start
DeskMateService     fcb       edition   ; edition $7E also encodes the JMP opcode
                    fdb       $0000     ; initially unresolved DeskMate entry address

Initialize          leax      >ZeroBuffer,pcr ; locate the embedded zero-filled workspace
                    tfr       x,d       ; copy its absolute address for alignment
                    addd      #$0100    ; advance far enough to reach the next page
                    clrb                ; round the address down to a page boundary
                    tfr       a,dp      ; make that page the direct page
                    tfr       d,u       ; use the same page as the data-area base
                    sts       ,u        ; save the caller's stack pointer at data offset 0
                    leas      $00FF,u   ; move the stack to the top of the 256-byte page
                    lbra      LaunchApplication ; skip the embedded workspace and run the launcher

* This block is physically present in the original non-shareable module.
ZeroBuffer          zmb       $01FF     ; preserved zero-filled module workspace/padding

* Request DeskMate's selected-application launch descriptor and fork it.
LaunchApplication
stk_saved_u         equ       0         ; saved data-area base after PSHS U
                    lbsr      DeskMateService ; ask DeskMate for the launch descriptor
                    fcb       $4E       ; unidentified DeskMate service selector
                    ldx       $16,y     ; load pointer to the child-process descriptor
                    pshs      u         ; preserve DMLOAD's data-area base

* Child descriptor layout addressed by X:
*   +0  A = module language/type, B = requested memory pages
*   +2  pointer to child module name
*   +4  parameter-byte count
*   +6  pointer to parameter string
                    ldd       ,x        ; load child type and requested memory size
                    ldy       $04,x     ; load parameter-string length
                    ldu       $06,x     ; load parameter-string pointer
                    ldx       $02,x     ; load child module-name pointer
                    os9       F$Fork    ; create the selected DeskMate application
                    os9       F$Wait    ; wait for a child process to terminate
                    puls      u         ; restore DMLOAD's data-area base
                    lds       ,u        ; restore the caller's original stack
                    lbsr      DeskMateService ; return control through DeskMate
                    fcb       $57       ; unidentified non-returning DeskMate service

                    emod
eom                 equ       *
                    end
