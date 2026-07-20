**********************************************************************
* ViewBBS - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /ViewBBS/ ; store an OS-9 high-bit-terminated string
L0014               fcc       "/wb" ; store literal character data
                    fcb       $0D       ; store byte data
L0018               fcb       $1B       ; store byte data
                    fcb       $21       ; store byte data
start               leax      >L0014,pc ; form the address >L0014,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L004E     ; branch when carry reports an error or unsigned underflow; target L004E
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0018,pc ; form the address >L0018,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    clrb                ; clear b to zero and set the condition codes
L004E               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
