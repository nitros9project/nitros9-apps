**********************************************************************
* Makdir - OS-9 Level 2 BBS command
*
* syntax: Makdir <path>
* purpose: create an OS-9 directory for installer compatibility.
* thin command wrapper around the directory-creation service.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       Makdir
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

name                fcs       /Makdir/  ; os-9 module name
* x is the shell-supplied pathname; $3F grants the original public permissions.
start               ldb       #$3F      ; allow owner and public read/write/execute access
                    os9       I$MakDir  ; create the requested directory
                    bcs       ExitWithStatus ; return the directory-creation error unchanged
                    clrb                ; report success
ExitWithStatus      os9       F$Exit    ; return zero or the I$MakDir error in B

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
