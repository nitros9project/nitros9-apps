**********************************************************************
* ViewBBS - OS-9 Level 2 BBS command
*
* syntax: ViewBBS
* purpose: select the double-driver viewing window for the local operator.
* allows observation of the serial BBS session through the mirrored window.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       ViewBBS
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ViewPath            rmb       1         ; path number returned when the mirrored /wb window opens
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /ViewBBS/ ; os-9 module name
ViewDevice          fcc       "/wb" ; double-driver window used to observe the online caller
                    fcb       C$CR      ; terminate the OS-9 device pathname
SelectWindowCode    fcb       $1B,$21   ; coco display sequence that selects the opened window
* open /wb, select it in the display driver, then replace paths 0, 1, and 2 with
* duplicates of that window so the caller inherits /wb as stdin, stdout, and stderr.
start               leax      >ViewDevice,pc ; open the double driver's observation window
                    lda       #UPDAT.   ; the replacement standard paths need input and output
                    os9       I$Open    ; acquire the mirrored window
                    lbcs      ExitWithStatus ; report an unavailable /wb device to the caller
                    sta       ViewPath,u ; preserve the opened path across display operations
                    leax      >SelectWindowCode,pc ; select /wb as the operator's visible window
                    ldy       #2        ; send the complete two-byte selection code
                    lda       ViewPath,u ; direct the selection sequence to /wb
                    os9       I$Write   ; make /wb the operator's visible window
                    clra                ; begin with standard input path zero
                    os9       I$Close   ; vacate path 0 for the first duplicate
                    inca                ; select standard output path one
                    os9       I$Close   ; vacate path 1 for the second duplicate
                    inca                ; select standard error path two
                    os9       I$Close   ; vacate path 2 for the third duplicate
                    lda       ViewPath,u ; close the observation path after selecting it
                    os9       I$Dup     ; fill newly free path 0 from /wb
                    os9       I$Dup     ; fill newly free path 1 from /wb
                    os9       I$Dup     ; fill newly free path 2 from /wb
                    clrb                ; report success after redirecting all standard paths
ExitWithStatus      os9       F$Exit    ; return success or the original path error

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
