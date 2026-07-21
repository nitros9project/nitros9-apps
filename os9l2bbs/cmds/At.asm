**********************************************************************
* At - OS-9 Level 2 BBS command
*
* Syntax: At yy/mm/dd hh:mm <command>
* Purpose: Wait for a requested date/time and execute the supplied command line.
* Zero date fields select the next occurrence of the requested time.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

DateTimeFieldsLeft  rmb       1         ; remaining YY/MM/DD/HH/MM numeric fields to parse
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
ParsedValue         rmb       2         ; current parsed number; low byte also saves last minute
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
CommandLine         rmb       2         ; command text passed to the child shell
ScheduledTime       rmb       5         ; requested YY/MM/DD/HH/MM tuple
CurrentTime         rmb       5         ; current YY/MM/DD/HH/MM returned by F$Time
ReservedWorkspace   rmb       401       ; retain the command's original minimum data allocation
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
                    lbeq      ErrExit   ; exit with keyboard abort
                    cmpb      #S$Intrpt ; compare b with #S$Intrpt and set the condition codes
                    lbeq      ErrExit   ; exit with keyboard interrupt
                    rti                 ; ignore all other signals

* at mm/dd/yy hh:mm <command line to exec>
* executes the command line once at the specified date and time

* at 00/00/00 hh:mm <command line to exec>
* executes the command line each day at the specified time

start               pshs      x         ; save X
                    leax      >Icpt,pc  ; point to the intercept handler
                    os9       F$Icpt    ; set up the signal intercept handler
                    puls      x         ; restore X

                    leay      ScheduledTime,u ; fill the requested YY/MM/DD/HH/MM tuple
                    lda       #5        ; compare 5 bytes (YY/MM/DD HH:MM)
                    sta       DateTimeFieldsLeft,u ; exactly five numeric fields are required

ParseDateTimeLoop   lbsr      Parse     ; convert the next delimited decimal field
                    stb       ,y+       ; store it in the run time
                    dec       DateTimeFieldsLeft,u ; account for the stored tuple member
                    bne       ParseDateTimeLoop ; continue through minute

* Treat the remainder of the command line
* as the command line to exec
                    stx       CommandLine,u ; remaining parameters are the shell command

* Write "Event scheduled" to the output path
                    leax      >Sched,pc ; form the address >Sched,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A

ChkTime             leax      CurrentTime,u ; refresh the current five-byte clock tuple
                    os9       F$Time    ; get the current time
                    ldb       #5        ; set b to the constant 5
                    leay      ScheduledTime,u ; compare against the requested tuple
                    lda       ,y        ; get the year
                    bne       ChkTime2  ; check the date and time if not zero
                    lda       $01,y     ; get the month
                    bne       ChkTime2  ; check the date and time if not zero
                    lda       $02,y     ; get the day
                    bne       ChkTime2  ; check the date and time if not zero
                    leay      $03,y     ; point to the time portion
                    leax      $03,x     ; point to the time portion
                    ldb       #2        ; compare the hour and minute

* Compare the run time or the run date+time with the current date or current date+time
ChkTime2            lda       ,x+       ; get a time byte
                    cmpa      ,y+       ; do the date/time match?
                    bne       Sleep     ; no match, so sleep for a while
                    decb                ; decrement the counter
                    bne       ChkTime2  ; check the next byte
                    bra       DoShell   ; it's time, shell the parameter

* Sleep for 60 ticks
Sleep               ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    bra       ChkTime   ; continue execution at ChkTime

DoShell             ldx       CommandLine,u ; measure the command passed to Shell
                    clrb                ; clear the counter

* Loop until we find CR in the parameter string
DoShell2            incb                ; increment the counter
                    lda       ,x+       ; get the next character
                    cmpa      #13       ; is it a CR?
                    bne       DoShell2  ; no, loop until we find CR

                    clra                ; clear the most significant byte
                    tfr       d,y       ; size of the parameter area
                    leax      >Shell,pc ; get the address of the module name
                    pshs      u         ; save U
                    ldu       CommandLine,u ; give F$Fork the command text as child parameters
                    lda       #Prgrm+Objct ; type/Language code
                    ldb       #3        ; set the optional data area to 3 pages
                    os9       F$Fork    ; fork the shell

                    puls      u         ; restore U
                    lbcs      ErrExit   ; exit on error

                    os9       F$Wait    ; wait for shell to exit
                    lbcs      ErrExit   ; exit on error

                    leay      ScheduledTime,u ; a zero date requests daily recurrence
                    lda       ,y        ; get the year
                    bne       Exit      ; it's not zero so exit
                    lda       $01,y     ; get the month
                    bne       Exit      ; it's not zero so exit
                    lda       $02,y     ; get the day
                    bne       Exit      ; it's not zero so exit

                    leax      CurrentTime,u ; remember the minute in which the command ran
                    os9       F$Time    ; get the current time
                    lda       $04,x     ; get the minute
                    sta       ParsedValue,u ; reuse parser scratch as the completed minute

Wait                ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; sleep for 60 ticks
                    leax      CurrentTime,u ; wait until the minute advances before rearming
                    os9       F$Time    ; get the current time
                    lda       $04,x     ; load a from $04,x
                    cmpa      ParsedValue,u ; avoid firing repeatedly during the same minute
                    beq       Wait      ; no, sleep some more
                    lbra      ChkTime   ; check the time again

Exit                clrb                ; clear the error flag...
ErrExit             os9       F$Exit    ; ... and exit

* Parse one decimal date/time field.
* Entry: X scans the remaining parameter string.
* Exit:  B contains the converted byte; X points past its delimiter.
* Uses ParsedValue, DecimalPlace, and DigitCounter as conversion scratch.
Parse               pshs      y         ; save Y

* Find the first character in the date/time string
FindDate            lda       ,x+       ; get the next character
                    cmpa      #13       ; is it a CR?
                    lbeq      ShowHelp  ; yes, invalid command line parameters
                    cmpa      #48       ; is it less than '0'?
                    bcs       FindDate  ; yes, skip this character
                    cmpa      #57       ; is it greater than '9'?
                    bhi       FindDate  ; yes, skip this character
                    leax      -$01,x    ; back to the start of the date/time string

* Find the last digit of the year
Loop                lda       ,x+       ; get the character at X
                    cmpa      #48       ; is it less than '0'?
                    bcs       ConvertNumericToken ; delimiter marks the end of this field
                    cmpa      #57       ; is it greater than '9'?
                    bhi       ConvertNumericToken ; delimiter marks the end of this field
                    bra       Loop      ; repeat for the next character

ConvertNumericToken pshs      x         ; preserve the next-field pointer while scanning backward
                    leax      -$01,x    ; back up to the last digit
                    clr       ParsedValue,u ; start the 16-bit result at zero
                    clr       ParsedValue+1,u ; clear the low byte of the result
                    ldd       #1        ; set d to the constant 1
                    std       DecimalPlace,u ; rightmost digit contributes units

PrsNum              lda       ,-x       ; get a digit
                    cmpa      #48       ; is it less than '0'?
                    bcs       Return    ; yes, invalid digit
                    cmpa      #57       ; is it greater than '9'?
                    bhi       Return    ; yes, invalid digit

                    suba      #48       ; convert it to a number
                    sta       DigitCounter,u ; repeated addition implements digit multiplication
                    ldd       #0        ; clear D

* Convert nn to a binary number
AddDigitContribution tst       DigitCounter,u ; zero contributes nothing at this decimal place
                    beq       AccumulateDigit ; merge the completed contribution into the result
                    addd      DecimalPlace,u ; add one decimal-place unit
                    dec       DigitCounter,u ; one less unit remains for this digit
                    bra       AddDigitContribution ; form digit multiplied by its place value

AccumulateDigit     addd      ParsedValue,u ; include lower-order digits already converted
                    std       ParsedValue,u ; retain the running binary result
                    lda       #10       ; set a to the constant 10
                    sta       DigitCounter,u ; build the next decimal place by multiplying by ten
                    ldd       #0        ; set d to the constant 0

ScaleDecimalPlace   tst       DigitCounter,u ; ten additions produce the next place value
                    beq       ParsePreviousDigit ; use the completed multiplier
                    addd      DecimalPlace,u ; accumulate another copy of the old place value
                    dec       DigitCounter,u ; count down the multiply-by-ten loop
                    bra       ScaleDecimalPlace ; continue constructing the next place value

ParsePreviousDigit  std       DecimalPlace,u ; next digit is one decimal place to the left
                    bra       PrsNum    ; back to the top

Return              ldd       ParsedValue,u ; return the converted binary value in D
                    puls      x         ; restore X
                    puls      pc,y      ; restore Y and return

* I can't find any code paths that reach here
unused              std       ParsedValue,u ; unreachable binary-to-decimal helper input
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       DecimalPlace,u ; begin with the ten-thousands place
                    ldd       ParsedValue,u ; recover the value being rendered
                    lbsr      unused_1  ; call subroutine unused_1
                    ldd       #1000     ; set d to the constant 1000
                    std       DecimalPlace,u ; select the thousands place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #100      ; set d to the constant 100
                    std       DecimalPlace,u ; select the hundreds place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #10       ; set d to the constant 10
                    std       DecimalPlace,u ; select the tens place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       unused_1  ; call subroutine unused_1
                    ldd       #1        ; set d to the constant 1
                    std       DecimalPlace,u ; select the units place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       unused_1  ; call subroutine unused_1
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    rts                 ; return to the caller

unused_1            subd      DecimalPlace,u ; count how many units fit in this decimal place
                    bcs       unused_2  ; branch when carry reports an error or unsigned underflow; target unused_2
                    inc       ,x        ; increment the value at ,x
                    bra       unused_1  ; continue execution at unused_1

unused_2            addd      DecimalPlace,u ; restore the first subtraction that went negative
                    std       ParsedValue,u ; save the remainder for the next place
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

* Print the usage syntax and exit
ShowHelp            leax      >Usage,pc ; form the address >Usage,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
