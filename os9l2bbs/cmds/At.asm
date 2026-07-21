**********************************************************************
* At - OS-9 Level 2 BBS command
*
* syntax: At yy/mm/dd hh:mm <command>
* purpose: wait for a requested date/time and execute the supplied command line.
* a zero date runs the command daily at the requested hour and minute.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       At
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

DateTimeFieldsLeft  rmb       1         ; remaining YY/MM/DD/HH/MM numeric fields to parse
DigitCounter        rmb       1         ; repeated-add counter for decimal conversion
ParsedValue         rmb       2         ; current parsed number; low byte also saves last minute
DecimalPlace        rmb       2         ; decimal multiplier built as 1, 10, 100, and so on
CommandLine         rmb       2         ; command text passed to the child shell
ScheduledTime       rmb       5         ; requested YY/MM/DD/HH/MM tuple
CurrentTime         rmb       5         ; current YY/MM/DD/HH/MM returned by F$Time
ReservedWorkspace   rmb       401       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /At/      ; os-9 module name

UsageMessage        fcc       "Usage is: At YY/MM/DD HH:MM <commandline>" ; required command syntax
                    fcb       C$CR      ; terminate the usage line

ScheduledMessage    fcc       "Event scheduled" ; confirmation emitted after parsing
                    fcb       C$CR      ; terminate the confirmation line

ShellModuleName     fcc       "Shell"   ; command interpreter forked at the target time
                    fcb       C$CR      ; terminate the module name

* Signal intercept routine
HandleSignal        cmpb      #S$Abort  ; propagate a keyboard abort as the process status
                    lbeq      ExitWithStatus ; terminate instead of resuming the wait
                    cmpb      #S$Intrpt ; also honor keyboard interrupt
                    lbeq      ExitWithStatus ; return its signal code in B
                    rti                 ; ignore unrelated signals and resume waiting

* at mm/dd/yy hh:mm <command line to exec>
* executes the command line once at the specified date and time

* at 00/00/00 hh:mm <command line to exec>
* executes the command line each day at the specified time

start               pshs      x         ; preserve the command-line scan pointer
                    leax      >HandleSignal,pc ; select the abort/interrupt handler
                    os9       F$Icpt    ; make long scheduler waits interruptible
                    puls      x         ; recover the command-line scan pointer

                    leay      ScheduledTime,u ; fill the requested YY/MM/DD/HH/MM tuple
                    lda       #5        ; compare 5 bytes (YY/MM/DD HH:MM)
                    sta       DateTimeFieldsLeft,u ; exactly five numeric fields are required

ParseDateTimeLoop   lbsr      ParseDecimalField ; convert the next delimited decimal field
                    stb       ,y+       ; append its low byte to the scheduled tuple
                    dec       DateTimeFieldsLeft,u ; account for the stored tuple member
                    bne       ParseDateTimeLoop ; continue through minute

* Treat the remainder of the command line
* as the command line to exec
                    stx       CommandLine,u ; remaining parameters are the shell command

* Write "Event scheduled" to the output path
                    leax      >ScheduledMessage,pc ; select the confirmation text
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; confirm that the event is armed

CheckScheduledTime  leax      CurrentTime,u ; receive the current five-byte clock tuple
                    os9       F$Time    ; sample year through minute
                    ldb       #5        ; default to comparing date and time
                    leay      ScheduledTime,u ; compare against the requested tuple
                    lda       ,y        ; inspect the requested year
                    bne       CompareTimeFields ; a nonzero date requests one exact event
                    lda       1,y       ; inspect the requested month
                    bne       CompareTimeFields ; partially specified dates remain exact
                    lda       2,y       ; inspect the requested day
                    bne       CompareTimeFields ; compare all five fields when nonzero
                    leay      3,y       ; select only scheduled hour and minute
                    leax      3,x       ; select only current hour and minute
                    ldb       #2        ; compare the two time fields for daily mode

* Compare the run time or the run date+time with the current date or current date+time
CompareTimeFields   lda       ,x+       ; fetch the next current clock field
                    cmpa      ,y+       ; require the scheduled value at this position
                    bne       SleepBeforeRetry ; a mismatch means the event is not due
                    decb                ; account for the matching field
                    bne       CompareTimeFields ; finish the selected tuple
                    bra       LaunchShell ; run the command once the tuple matches

* Sleep for 60 ticks
SleepBeforeRetry    ldx       #60       ; poll at one-second intervals
                    os9       F$Sleep   ; yield instead of busy-waiting
                    bra       CheckScheduledTime ; sample the clock again

LaunchShell         ldx       CommandLine,u ; measure the command passed to Shell
                    clrb                ; initialize the one-byte parameter count

* Loop until we find CR in the parameter string
MeasureCommandLine  incb                ; include the next byte in the parameter length
                    lda       ,x+       ; scan the command text
                    cmpa      #C$CR     ; does this byte terminate the parameters?
                    bne       MeasureCommandLine ; count through the final CR

                    clra                ; zero-extend the parameter count into D
                    tfr       d,y       ; supply the parameter-area size to F$Fork
                    leax      >ShellModuleName,pc ; select the OS-9 command interpreter
                    pshs      u         ; preserve At's workspace pointer
                    ldu       CommandLine,u ; give F$Fork the command text as child parameters
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    ldb       #3        ; grant Shell the original three-page minimum
                    os9       F$Fork    ; execute the scheduled command through Shell

                    puls      u         ; recover At's workspace pointer
                    lbcs      ExitWithStatus ; propagate a fork failure

                    os9       F$Wait    ; wait for the scheduled command to finish
                    lbcs      ExitWithStatus ; propagate a wait failure

                    leay      ScheduledTime,u ; a zero date requests daily recurrence
                    lda       ,y        ; inspect the requested year
                    bne       ExitSuccess ; an exact-date event runs only once
                    lda       1,y       ; inspect the requested month
                    bne       ExitSuccess ; a nonzero date disables recurrence
                    lda       2,y       ; inspect the requested day
                    bne       ExitSuccess ; leave after the one scheduled execution

                    leax      CurrentTime,u ; remember the minute in which the command ran
                    os9       F$Time    ; refresh the clock after Shell returns
                    lda       4,x       ; capture the minute that just fired
                    sta       ParsedValue,u ; reuse parser scratch as the completed minute

WaitForNextMinute   ldx       #60       ; delay one second between clock samples
                    os9       F$Sleep   ; prevent a tight recurrence loop
                    leax      CurrentTime,u ; wait until the minute advances before rearming
                    os9       F$Time    ; refresh the current clock tuple
                    lda       4,x       ; inspect its minute field
                    cmpa      ParsedValue,u ; avoid firing repeatedly during the same minute
                    beq       WaitForNextMinute ; remain disarmed throughout that minute
                    lbra      CheckScheduledTime ; rearm the daily event

ExitSuccess         clrb                ; report normal completion
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

* Parse one decimal date/time field.
* Entry: X scans the remaining parameter string.
* Exit:  B contains the converted byte; X points past its delimiter.
* Uses ParsedValue, DecimalPlace, and DigitCounter as conversion scratch.
ParseDecimalField   pshs      y         ; preserve the scheduled-tuple cursor

* Find the first character in the date/time string
FindDate            lda       ,x+       ; get the next character
                    cmpa      #C$CR     ; a premature line end means fields are missing
                    lbeq      ShowHelp  ; reject an incomplete date/time tuple
                    cmpa      #'0'      ; skip separators below the decimal range
                    bcs       FindDate  ; continue past a nonnumeric separator
                    cmpa      #'9'      ; skip separators above the decimal range
                    bhi       FindDate  ; continue past a nonnumeric separator
                    leax      -1,x      ; return X to the field's first digit

* Find the last digit of the year
FindFieldEnd        lda       ,x+       ; scan across the decimal token
                    cmpa      #'0'      ; bytes below zero delimit the field
                    bcs       ConvertNumericToken ; delimiter marks the end of this field
                    cmpa      #'9'      ; bytes above nine also delimit it
                    bhi       ConvertNumericToken ; delimiter marks the end of this field
                    bra       FindFieldEnd ; continue until the following delimiter

ConvertNumericToken pshs      x         ; preserve the next-field pointer while scanning backward
                    leax      -1,x      ; back up from the delimiter to the last digit
                    clr       ParsedValue,u ; start the 16-bit result at zero
                    clr       ParsedValue+1,u ; clear the low byte of the result
                    ldd       #1        ; seed the rightmost decimal place as units
                    std       DecimalPlace,u ; rightmost digit contributes units

ParsePreviousDigitBackward lda ,-x       ; fetch one digit while moving left
                    cmpa      #'0'      ; a lower delimiter precedes the token
                    bcs       ReturnParsedField ; finish the conversion there
                    cmpa      #'9'      ; an upper delimiter also precedes the token
                    bhi       ReturnParsedField ; finish the conversion there

                    suba      #'0'      ; reduce ASCII to a binary digit
                    sta       DigitCounter,u ; repeated addition implements digit multiplication
                    ldd       #0        ; initialize this digit's contribution

* Convert nn to a binary number
AddDigitContribution tst       DigitCounter,u ; zero contributes nothing at this decimal place
                    beq       AccumulateDigit ; merge the completed contribution into the result
                    addd      DecimalPlace,u ; add one decimal-place unit
                    dec       DigitCounter,u ; one less unit remains for this digit
                    bra       AddDigitContribution ; form digit multiplied by its place value

AccumulateDigit     addd      ParsedValue,u ; include lower-order digits already converted
                    std       ParsedValue,u ; retain the running binary result
                    lda       #10       ; multiply the place value by ten next
                    sta       DigitCounter,u ; build the next decimal place by multiplying by ten
                    ldd       #0        ; initialize the next-place accumulator

ScaleDecimalPlace   tst       DigitCounter,u ; ten additions produce the next place value
                    beq       AdvanceDecimalPlace ; use the completed multiplier
                    addd      DecimalPlace,u ; accumulate another copy of the old place value
                    dec       DigitCounter,u ; count down the multiply-by-ten loop
                    bra       ScaleDecimalPlace ; continue constructing the next place value

AdvanceDecimalPlace std       DecimalPlace,u ; next digit is one decimal place to the left
                    bra       ParsePreviousDigitBackward ; continue toward the token start

ReturnParsedField   ldd       ParsedValue,u ; return the converted value in D/B
                    puls      x         ; recover the saved next-field pointer
                    puls      pc,y      ; restore the tuple cursor and return

* no reachable call site enters this preserved five-digit formatter. It renders
* D as zero-padded decimal at X by repeated subtraction from 10000 through 1.
FormatDecimalUnreferenced std ParsedValue,u ; retain the value being rendered
                    lda       #'0'      ; seed all five output columns with ASCII zero
                    sta       ,x        ; initialize the ten-thousands column
                    sta       1,x       ; initialize the thousands column
                    sta       2,x       ; initialize the hundreds column
                    sta       3,x       ; initialize the tens column
                    sta       4,x       ; initialize the units column
                    ldd       #10000    ; begin with the ten-thousands place
                    std       DecimalPlace,u ; begin with the ten-thousands place
                    ldd       ParsedValue,u ; recover the value being rendered
                    lbsr      RenderDecimalDigit ; emit the ten-thousands digit
                    ldd       #1000     ; move to the thousands place
                    std       DecimalPlace,u ; select the thousands place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       RenderDecimalDigit ; emit the thousands digit
                    ldd       #100      ; move to the hundreds place
                    std       DecimalPlace,u ; select the hundreds place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       RenderDecimalDigit ; emit the hundreds digit
                    ldd       #10       ; move to the tens place
                    std       DecimalPlace,u ; select the tens place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       RenderDecimalDigit ; emit the tens digit
                    ldd       #1        ; finish with the units place
                    std       DecimalPlace,u ; select the units place
                    ldd       ParsedValue,u ; recover the remaining value
                    bsr       RenderDecimalDigit ; emit the units digit
                    lda       #C$CR     ; terminate the five-digit text
                    sta       ,x        ; append CR after the units column
                    rts                 ; return to a hypothetical formatter caller

RenderDecimalDigit  subd      DecimalPlace,u ; remove one unit of the current place
                    bcs       FinishDecimalDigit ; stop when the subtraction underflows
                    inc       ,x        ; advance this ASCII digit
                    bra       RenderDecimalDigit ; count another unit at this place

FinishDecimalDigit  addd      DecimalPlace,u ; restore the first subtraction that underflowed
                    std       ParsedValue,u ; save the remainder for the next place
                    leax      1,x       ; advance to the next output column
                    rts                 ; return to the fixed-width formatter

* Print the usage syntax and exit
ShowHelp            leax      >UsageMessage,pc ; select the required syntax
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain the malformed command line
                    clrb                ; preserve the original successful help status
                    os9       F$Exit    ; terminate after displaying usage

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
