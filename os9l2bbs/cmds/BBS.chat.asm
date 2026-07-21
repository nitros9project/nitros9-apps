**********************************************************************
* BBS.chat - OS-9 Level 2 BBS command
*
* Syntax: BBS.chat
* Purpose: Publish a user chat request and exchange characters with the sysop-side Answer command.
* Coordination: process signals and a shared one-character mailbox.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.chat
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

DefCntr             rmb       1         ; reserve 1 byte(s) in the module workspace
BeepCntr            rmb       1         ; reserve 1 byte(s) in the module workspace
Flag                rmb       3         ; reserve 3 byte(s) in the module workspace
DotCntr             rmb       1         ; reserve 1 byte(s) in the module workspace
WPath               rmb       1         ; reserve 1 byte(s) in the module workspace
XSave               rmb       2         ; reserve 2 byte(s) in the module workspace
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.chat/ ; store an OS-9 high-bit-terminated string

Paging              fcc       "Paging Sysop...Please wait" ; store literal character data
                    fcb       $0D       ; store byte data

NotHome             fcc       "Sorry, but the sysop does not seem to be home!" ; store literal character data
                    fcb       $0D       ; store byte data

lf                  fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data

w                   fcc       "/w" ; store literal character data
                    fcb       $0D       ; store byte data

dot                 fcc       "." ; store literal character data
                    fcb       $0D       ; store byte data

bell                fcb       $07       ; store byte data

start               bra       start_a   ; continue execution at start_a

DataRdy             fcb       $00       ; store byte data
ChatBuf             fcb       $00       ; store byte data

start_a             stx       XSave,u   ; store x at XSave,u
                    lda       #10       ; set a to the constant 10
                    sta       DefCntr,u ; initialize the default counter

* Set up the signal intercept handler
                    leax      >Icpt,pc  ; form the address >Icpt,pc in x
                    os9       F$Icpt    ; install the signal-intercept routine at X

                    lda       #255      ; set a to the constant 255
                    sta       Flag,u    ; set the flag
                    lda       #10       ; set a to the constant 10
                    sta       DotCntr,u ; initialize the counter

* Open /w for read/write
                    leax      >w,pc     ; form the address >w,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      ErrExit   ; exit on error
                    sta       WPath,u   ; store the path

* Inform the user we are paging the sysop
                    leax      >Paging,pc ; form the address >Paging,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A

**************************************************
* Page the sysop to join the chat
PageLoop            lda       DefCntr,u ; get the default counter
                    sta       BeepCntr,u ; initialize the beep counter

* Ding the sysop
BeepBeep            leax      >bell,pc  ; form the address >bell,pc in x
                    lda       WPath,u   ; load a from WPath,u
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ErrExit   ; exit on error
                    ldx       #4        ; set x to the constant 4
                    os9       F$Sleep   ; sleep 4 ticks
                    dec       BeepCntr,u ; decrement the counter
                    bne       BeepBeep  ; beep again if the counter is not zero

                    ldx       #90       ; set x to the constant 90
                    os9       F$Sleep   ; sleep 90 ticks
                    tst       Flag,u    ; is the sysop home?
                    beq       SysopAnswered ; signal 129 means Answer attached to this request

* Write a dot on /w
                    leax      >dot,pc   ; form the address >dot,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    dec       DotCntr,u ; decrement the counter
                    bne       PageLoop  ; try again if the counter is not zero

* Nobody's home so inform the user and exit
                    leax      >NotHome,pc ; form the address >NotHome,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Exit      ; continue execution at Exit

SysopAnswered       clr       >DataRdy,pc ; initialize the shared mailbox as empty

* Wait for the user or the sysop to press a key
DataLoop            clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; ss.Ready
                    os9       I$GetStt  ; has the user pressed a key?
                    bcc       TestFlag  ; yes, so go read it
                    tst       >DataRdy,pc ; has the sysop pressed a key?
                    beq       DataLoop  ; no, so continue polling

* Echo the sysop's char to the user
Echo                leax      >ChatBuf,pc ; form the address >ChatBuf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

                    lda       >ChatBuf,pc ; get the char the sysop typed
                    cmpa      #13       ; is it a CR?
                    bne       ClrFlag   ; no, clear the flag and poll for more

* Append LF to CR on the output path
                    leax      >lf,pc    ; form the address >lf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

ClrFlag             clr       >DataRdy,pc ; we are ready for more data
                    bra       DataLoop  ; check for more data

TestFlag            tst       >DataRdy,pc ; is data available yet?
                    bne       Echo      ; yes, go read it

* Read one character from the user
                    leax      >ChatBuf,pc ; form the address >ChatBuf,pc in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X

                    lda       ,x        ; get the character read
                    cmpa      #13       ; is it a CR?
                    bne       SetFlag   ; no, so don't write an LF

* Append an LF to the CR
                    leax      >lf,pc    ; form the address >lf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

SetFlag             pshs      cc        ; save the condition codes
                    orcc      #80       ; disable interrupts
                    tst       >DataRdy,pc ; is data available yet?
                    bne       SleepRet  ; yes, echo it to the user
                    lda       #1        ; set a to the constant 1
                    sta       >DataRdy,pc ; set the data available flag
                    puls      cc        ; restore cc from the stack

* Sleep until the flag is cleared
Sleep               lda       >DataRdy,pc ; get the data available flag
                    lbeq      DataLoop  ; flag reset, so continue the loop
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; sleep the remainder of the time slice
                    bra       Sleep     ; ... until the flag is cleared

SleepRet            puls      cc        ; restore interrupts
                    lbra      Echo      ; echo the character to the user

Exit                clrb                ; clear the error flag...
ErrExit             os9       F$Exit    ; ... and exit

* Interrupt service handler
Icpt                cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Exit2     ; exit if signal 2
                    cmpb      #3        ; compare b with #3 and set the condition codes
                    beq       Return    ; return if signal 3
                    clr       Flag,u    ; clear the flag...
Return              rti                 ; ... and exit the interrupt handler

Exit2               clrb                ; clear the error flag...
                    os9       F$Exit    ; ... and exit

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
