**********************************************************************
* Makdir - OS-9 Level 2 BBS command
*
* Syntax: Makdir <path>
* Purpose: Create an OS-9 directory for installer compatibility.
* Thin command wrapper around the directory-creation service.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Makdir
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

name                fcs       /Makdir/ ; store an OS-9 high-bit-terminated string
start               ldb       #63       ; set b to the constant 63
                    os9       I$MakDir  ; create the directory named at X
                    bcs       ExitWithStatus ; return the directory-creation error unchanged
                    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      os9       F$Exit    ; return zero on success or the F$MakDir error in B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
