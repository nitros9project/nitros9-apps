**********************************************************************
* ViewBBS - OS-9 Level 2 BBS command
*
* Syntax: ViewBBS
* Purpose: Select the double-driver viewing window for the local operator.
* Allows observation of the serial BBS session through the mirrored window.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       ViewBBS
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ViewPath            rmb       1         ; path number returned when the mirrored /wb window opens
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; define the assembly-time value for size

name                fcs       /ViewBBS/ ; store an OS-9 high-bit-terminated string
ViewDevice          fcc       "/wb" ; double-driver window used to observe the online caller
                    fcb       $0D       ; store byte data
SelectWindowCode    fcb       $1B       ; CoCo display sequence that selects the opened window
                    fcb       $21       ; store byte data
start               leax      >ViewDevice,pc ; open the double driver's observation window
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ExitWithStatus ; report an unavailable /wb device to the caller
                    sta       ViewPath,u ; preserve the opened path across display operations
                    leax      >SelectWindowCode,pc ; select /wb as the operator's visible window
                    ldy       #2        ; set y to the constant 2
                    lda       ViewPath,u ; direct the selection sequence to /wb
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    lda       ViewPath,u ; close the observation path after selecting it
                    os9       I$Dup     ; duplicate path A into the next free path number
                    os9       I$Dup     ; duplicate path A into the next free path number
                    os9       I$Dup     ; duplicate path A into the next free path number
                    clrb                ; clear b to zero and set the condition codes
ExitWithStatus      os9       F$Exit    ; return success or the original path error

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
