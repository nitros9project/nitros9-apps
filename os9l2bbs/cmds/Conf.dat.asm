**********************************************************************
* Conf.dat - OS-9 Level 2 BBS command
*
* Syntax: linked data module
* Purpose: Hold conference participant registrations and character-exchange slots.
* Linked by BBS.conf and BBS.conf.who; not executed directly.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Conf.dat
                    ttl       data module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Data+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkBuffer_001      rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Conf.dat/ ; store an OS-9 high-bit-terminated string
start               fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
