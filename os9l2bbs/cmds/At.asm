**********************************************************************
* At - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       At
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

cntr_1              rmb       1         ; reserve 1 byte(s) in the module workspace
digit               rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
Param               rmb       2         ; reserve 2 byte(s) in the module workspace
RunTime             rmb       5         ; reserve 5 byte(s) in the module workspace
CurTime             rmb       5         ; reserve 5 byte(s) in the module workspace
stack               rmb       401       ; reserve 401 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /At/ ; store an OS-9 high-bit-terminated string

Usage               fcc       "Usage is: At YY/MM/DD HH:MM <commandline>" ; store literal character data
                    fcb       $0D       ; store byte data

Sched               fcc       "Event scheduled" ; store literal character data
                    fcb       $0D       ; store byte data

Shell               fcc       "Shell" ; store literal character data
                    fcb       $0D       ; store byte data

* Signal intercept routine
Icpt                cmpb      #S$Abort  ; compare b with #S$Abort and set the condition codes
                    lbeq      ErrExit   ; Exit with keyboard abort
                    cmpb      #S$Intrpt ; compare b with #S$Intrpt and set the condition codes
                    lbeq      ErrExit   ; Exit with keyboard interrupt
                    rti                 ; Ignore all other signals

* at mm/dd/yy hh:mm <command line to exec>
* executes the command line once at the specified date and time

* at 00/00/00 hh:mm <command line to exec>
* executes the command line each day at the specified time

start               pshs      x         ; Save X
                    leax      >Icpt,pc  ; Point to the intercept handler
                    os9       F$Icpt    ; Set up the signal intercept handler
                    puls      x         ; Restore X

                    leay      RunTime,u ; Get the time to run
                    lda       #5        ; Compare 5 bytes (YY/MM/DD HH:MM)
                    sta       cntr_1,u  ; Store the counter

L006D               lbsr      Parse     ; Parse a byte
                    stb       ,y+       ; Store it in the run time
                    dec       cntr_1,u  ; Decrement the counter
                    bne       L006D     ; Parse the next byte

* Treat the remainder of the command line
* as the command line to exec
                    stx       Param,u   ; store x at Param,u

* Write "Event scheduled" to the output path
                    leax      >Sched,pc ; form the address >Sched,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service

ChkTime             leax      CurTime,u ; form the address CurTime,u in x
                    os9       F$Time    ; Get the current time
                    ldb       #5        ; set b to the constant 5
                    leay      RunTime,u ; Get the time to run
                    lda       0,y       ; Get the year
                    bne       ChkTime2  ; Check the date and time if not zero
                    lda       $01,y     ; Get the month
                    bne       ChkTime2  ; Check the date and time if not zero
                    lda       $02,y     ; Get the day
                    bne       ChkTime2  ; Check the date and time if not zero
                    leay      $03,y     ; Point to the time portion
                    leax      $03,x     ; Point to the time portion
                    ldb       #2        ; Compare the hour and minute

* Compare the run time or the run date+time with the current date or current date+time
ChkTime2            lda       ,x+       ; Get a time byte
                    cmpa      ,y+       ; Do the date/time match?
                    bne       Sleep     ; No match, so sleep for a while
                    decb                ; Decrement the counter
                    bne       ChkTime2  ; Check the next byte
                    bra       DoShell   ; It's time, shell the parameter

* Sleep for 60 ticks
Sleep               ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    bra       ChkTime   ; continue execution at ChkTime

DoShell             ldx       Param,u   ; Point to the parameter
                    clrb                ; Clear the counter

* Loop until we find CR in the parameter string
DoShell2            incb                ; Increment the counter
                    lda       ,x+       ; Get the next character
                    cmpa      #13       ; Is it a CR?
                    bne       DoShell2  ; No, loop until we find CR

                    clra                ; Clear the most significant byte
                    tfr       d,y       ; Size of the parameter area
                    leax      >Shell,pc ; Get the address of the module name
                    pshs      u         ; Save U
                    ldu       Param,u   ; Point to the parameters to the shell
                    lda       #Prgrm+Objct ; Type/Language code
                    ldb       #3        ; Set the optional data area to 3 pages
                    os9       F$Fork    ; Fork the shell

                    puls      u         ; Restore U
                    lbcs      ErrExit   ; Exit on error

                    os9       F$Wait    ; Wait for shell to exit
                    lbcs      ErrExit   ; Exit on error

                    leay      RunTime,u ; Get the time to run
                    lda       0,y       ; Get the year
                    bne       Exit      ; It's not zero so exit
                    lda       $01,y     ; Get the month
                    bne       Exit      ; It's not zero so exit
                    lda       $02,y     ; Get the day
                    bne       Exit      ; It's not zero so exit

                    leax      CurTime,u ; form the address CurTime,u in x
                    os9       F$Time    ; Get the current time
                    lda       $04,x     ; Get the minute
                    sta       U0002,u   ; Store it in the data area

Wait                ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; Sleep for 60 ticks
                    leax      CurTime,u ; form the address CurTime,u in x
                    os9       F$Time    ; Get the current time
                    lda       $04,x     ; load a from $04,x
                    cmpa      U0002,u   ; Have we slept enough?
                    beq       Wait      ; No, sleep some more
                    lbra      ChkTime   ; Check the time again

Exit                clrb                ; Clear the error flag...
ErrExit             os9       F$Exit    ; ... and exit

* Y = U0008
* A = 5
* U0000 = 5
Parse               pshs      y         ; Save Y

* Find the first character in the date/time string
FindDate            lda       ,x+       ; Get the next character
                    cmpa      #13       ; Is it a CR?
                    lbeq      ShowHelp  ; Yes, invalid command line parameters
                    cmpa      #48       ; Is it less than '0'?
                    bcs       FindDate  ; Yes, skip this character
                    cmpa      #57       ; Is it greater than '9'?
                    bhi       FindDate  ; Yes, skip this character
                    leax      -$01,x    ; Back to the start of the date/time string

* Find the last digit of the year
Loop                lda       ,x+       ; Get the character at X
                    cmpa      #48       ; Is it less than '0'?
                    bcs       L012B     ; Yes, jump
                    cmpa      #57       ; Is it greater than '9'?
                    bhi       L012B     ; Yes, jump
                    bra       Loop      ; Repeat for the next character

L012B               pshs      x         ; Save X
                    leax      -$01,x    ; Back up to the last digit
                    clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0004,u   ; store d at U0004,u

PrsNum              lda       ,-x       ; Get a digit
                    cmpa      #48       ; Is it less than '0'?
                    bcs       Return    ; Yes, invalid digit
                    cmpa      #57       ; Is it greater than '9'?
                    bhi       Return    ; Yes, invalid digit

                    suba      #48       ; Convert it to a number
                    sta       digit,u   ; Store the number
                    ldd       #0        ; Clear D

* Convert nn to a binary number
L0149               tst       digit,u   ; Is the digit zero?
                    beq       L0153     ; Yes, don't do the math
                    addd      U0004,u   ; Add 1
                    dec       digit,u   ; Decrement the digit
                    bra       L0149     ; And round again

L0153               addd      U0002,u   ; add to d using U0002,u
                    std       U0002,u   ; store d at U0002,u
                    lda       #10       ; set a to the constant 10
                    sta       digit,u   ; store a at digit,u
                    ldd       #0        ; set d to the constant 0

L015E               tst       digit,u   ; Have we reached zero?
                    beq       L0168     ; Yes, jump out of the loop
                    addd      U0004,u   ; Add 10 to D
                    dec       digit,u   ; Decrement the digit
                    bra       L015E     ; And round again

L0168               std       U0004,u   ; Store the translated number
                    bra       PrsNum    ; Back to the top

Return              ldd       U0002,u   ; load d from U0002,u
                    puls      x         ; Restore X
                    puls      pc,y      ; Restore Y and return

* I can't find any code paths that reach here
unused              std       U0002,u   ; store d at U0002,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    lbsr      unused_1  ; call subroutine unused_1
                    ldd       #1000     ; set d to the constant 1000
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #100      ; set d to the constant 100
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #10       ; set d to the constant 10
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #1        ; set d to the constant 1
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       unused_1  ; call subroutine unused_1
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller

unused_1            subd      U0004,u   ; subtract from d using U0004,u
                    bcs       unused_2  ; branch when carry reports an error or unsigned underflow; target unused_2
                    inc       0,x       ; increment the value at 0,x
                    bra       unused_1  ; continue execution at unused_1

unused_2            addd      U0004,u   ; add to d using U0004,u
                    std       U0002,u   ; store d at U0002,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

* Print the usage syntax and exit
ShowHelp            leax      >Usage,pc ; form the address >Usage,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
