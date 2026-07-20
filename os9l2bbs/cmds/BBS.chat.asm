**********************************************************************
* BBS.chat - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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
U0009               rmb       400       ; reserve 400 byte(s) in the module workspace
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
                    sta       DefCntr,u ; Initialize the default counter

* Set up the signal intercept handler
                    leax      >Icpt,pc  ; form the address >Icpt,pc in x
                    os9       F$Icpt    ; invoke the OS-9 F$Icpt service

                    lda       #255      ; set a to the constant 255
                    sta       Flag,u    ; Set the flag
                    lda       #10       ; set a to the constant 10
                    sta       DotCntr,u ; Initialize the counter

* Open /w for read/write
                    leax      >w,pc     ; form the address >w,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      ErrExit   ; Exit on error
                    sta       WPath,u   ; Store the path

* Inform the user we are paging the sysop
                    leax      >Paging,pc ; form the address >Paging,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service

**************************************************
* Page the sysop to join the chat
PageLoop            lda       DefCntr,u ; Get the default counter
                    sta       BeepCntr,u ; Initialize the beep counter

* Ding the sysop
BeepBeep            leax      >bell,pc  ; form the address >bell,pc in x
                    lda       WPath,u   ; load a from WPath,u
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      ErrExit   ; Exit on error
                    ldx       #4        ; set x to the constant 4
                    os9       F$Sleep   ; Sleep 4 ticks
                    dec       BeepCntr,u ; Decrement the counter
                    bne       BeepBeep  ; Beep again if the counter is not zero

                    ldx       #90       ; set x to the constant 90
                    os9       F$Sleep   ; Sleep 90 ticks
                    tst       Flag,u    ; Is the sysop home?
                    beq       L00E6     ; Yes, and he answered the chat

* Write a dot on /w
                    leax      >dot,pc   ; form the address >dot,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    dec       DotCntr,u ; Decrement the counter
                    bne       PageLoop  ; Try again if the counter is not zero

* Nobody's home so inform the user and exit
                    leax      >NotHome,pc ; form the address >NotHome,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      Exit      ; continue execution at Exit

L00E6               clr       >DataRdy,pc ; No data is available yet

* Wait for the user or the sysop to press a key
DataLoop            clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; SS.Ready
                    os9       I$GetStt  ; Has the user pressed a key?
                    bcc       TestFlag  ; Yes, so go read it
                    tst       >DataRdy,pc ; Has the sysop pressed a key?
                    beq       DataLoop  ; No, so continue polling

* Echo the sysop's char to the user
Echo                leax      >ChatBuf,pc ; form the address >ChatBuf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

                    lda       >ChatBuf,pc ; Get the char the sysop typed
                    cmpa      #13       ; Is it a CR?
                    bne       ClrFlag   ; No, clear the flag and poll for more

* Append LF to CR on the output path
                    leax      >lf,pc    ; form the address >lf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

ClrFlag             clr       >DataRdy,pc ; We are ready for more data
                    bra       DataLoop  ; Check for more data

TestFlag            tst       >DataRdy,pc ; Is data available yet?
                    bne       Echo      ; Yes, go read it

* Read one character from the user
                    leax      >ChatBuf,pc ; form the address >ChatBuf,pc in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service

                    lda       0,x       ; Get the character read
                    cmpa      #13       ; Is it a CR?
                    bne       SetFlag   ; No, so don't write an LF

* Append an LF to the CR
                    leax      >lf,pc    ; form the address >lf,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

SetFlag             pshs      cc        ; Save the condition codes
                    orcc      #80       ; Disable interrupts
                    tst       >DataRdy,pc ; Is data available yet?
                    bne       SleepRet  ; Yes, echo it to the user
                    lda       #1        ; set a to the constant 1
                    sta       >DataRdy,pc ; Set the data available flag
                    puls      cc        ; restore cc from the stack

* Sleep until the flag is cleared
Sleep               lda       >DataRdy,pc ; Get the data available flag
                    lbeq      DataLoop  ; Flag reset, so continue the loop
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; Sleep the remainder of the time slice
                    bra       Sleep     ; ... until the flag is cleared

SleepRet            puls      cc        ; Restore interrupts
                    lbra      Echo      ; Echo the character to the user

Exit                clrb                ; Clear the error flag...
ErrExit             os9       F$Exit    ; ... and exit

* Interrupt service handler
Icpt                cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Exit2     ; Exit if signal 2
                    cmpb      #3        ; compare b with #3 and set the condition codes
                    beq       Return    ; Return if signal 3
                    clr       Flag,u    ; Clear the flag...
Return              rti                 ; ... and exit the interrupt handler

Exit2               clrb                ; Clear the error flag...
                    os9       F$Exit    ; ... and exit

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
