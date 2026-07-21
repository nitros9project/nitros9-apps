**********************************************************************
* New_user - OS-9 Level 2 BBS command
*
* Syntax: New_user
* Purpose: Collect a prospective caller registration for later sysop validation.
* Uses new_user_form/new_user_message and writes pending-user files.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/21  Codex
* Decoded the registration application and separated linked runtime support.
**********************************************************************

                    nam       New_user
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

* the compiler keeps its global/runtime state relative to Y.  The registration
* application owns six consecutive 80-byte input fields at the end of that area.
RuntimeInputStream  equ       $001B     ; standard-input stream descriptor
RuntimeErrorCode    equ       $01AD     ; last library or OS-9 error code
ApplicantName       equ       $01AF     ; caller's real name
ApplicantCity       equ       $01FF     ; caller's city
ApplicantState      equ       $024F     ; caller's state
ApplicantPhone      equ       $029F     ; caller's telephone number
ApplicantAlias      equ       $02EF     ; requested BBS alias
ApplicantPassword   equ       $033F     ; requested BBS password

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       338       ; reserve 338 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       58        ; reserve 58 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       1418      ; reserve 1418 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /New_user/ ; store an OS-9 high-bit-terminated string
                    fcb       $01       ; store byte data
Routine_001         lda       ,y+       ; load a from ,y+
                    sta       ,u+       ; store a at ,u+
                    leax      -$01,x    ; form the address -$01,x in x
                    bne       Routine_001 ; branch when the values differ or the result is nonzero; target Routine_001
                    rts                 ; return to the caller
start               pshs      y         ; save y on the stack
                    pshs      u         ; save u on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_001          sta       ,u+       ; store a at ,u+
                    decb                ; decrement b
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leau      ,x        ; form the workspace or data address ,x in u
                    leax      >$03AB,x  ; form the address >$03AB,x in x
                    pshs      x         ; save x on the stack
                    leay      >Data_001,pc ; form the address >Data_001,pc in y
                    ldx       ,y++      ; load x from ,y++
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    bsr       Routine_001 ; call subroutine Routine_001
                    ldu       $02,s     ; load u from the current stack frame at $02,s
Branch_002          leau      >WorkByte_002,u ; form the workspace or data address >WorkByte_002,u in u
                    ldx       ,y++      ; load x from ,y++
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    bsr       Routine_001 ; call subroutine Routine_001
                    clra                ; clear a to zero and set the condition codes
Branch_003          cmpu      ,s        ; compare u with ,s and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    sta       ,u+       ; store a at ,u+
                    bra       Branch_003 ; continue execution at Branch_003
Branch_004          ldu       $02,s     ; load u from the current stack frame at $02,s
                    ldd       ,y++      ; load d from ,y++
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    leax      >0,pc     ; form the address 0,pc in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_005          ldd       ,y++      ; load d from ,y++
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_006          leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >WorkWord_007,u ; store x at >WorkWord_007,u
                    sty       >WorkWord_006,u ; store y at >WorkWord_006,u
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_004,u ; store d at >WorkByte_004,u
                    leay      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in y
                    leax      ,s        ; form the address ,s in x
                    lda       ,x+       ; load a from ,x+
Branch_007          ldb       >WorkBuffer_003,u ; load b from >WorkBuffer_003,u
                    cmpb      #29       ; compare b with #29 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
Branch_009          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
Branch_010          lda       ,x+       ; load a from ,x+
                    bra       Branch_009 ; continue execution at Branch_009
Branch_011          cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #39       ; compare a with #39 and set the condition codes
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
Branch_012          stx       ,y++      ; store x at ,y++
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
                    pshs      a         ; save a on the stack
Branch_014          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      ,s        ; compare a with ,s and set the condition codes
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
Branch_015          puls      b         ; restore b from the stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_007 ; continue execution at Branch_007
Branch_013          leax      -$01,x    ; form the address -$01,x in x
                    stx       ,y++      ; store x at ,y++
                    leax      $01,x     ; form the address $01,x in x
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
Branch_016          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    bra       Branch_007 ; continue execution at Branch_007
Branch_008          leax      >WorkWord_006,u ; form the address >WorkWord_006,u in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkByte_004,u ; load d from >WorkByte_004,u
                    pshs      d         ; save d on the stack
                    leay      WorkByte_001,u ; form the address WorkByte_001,u in y
                    bsr       Routine_003 ; call subroutine Routine_003
                    lbsr      RegistrationMain ; call subroutine RegistrationMain
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      ExitProcess ; call subroutine ExitProcess
Routine_003         leax      >$03AB,y  ; form the address >$03AB,y in x
                    stx       >$01A9,y  ; store x at >$01A9,y
                    sts       >$019D,y  ; store s at >$019D,y
                    sts       >$01AB,y  ; store s at >$01AB,y
                    ldd       #-126     ; set d to the constant -126
CheckStackSpace     leax      d,s       ; form the address d,s in x
                    cmpx      >$01AB,y  ; compare x with >$01AB,y and set the condition codes
                    bcc       Branch_018 ; branch when carry is clear; target Branch_018
                    cmpx      >$01A9,y  ; compare x with >$01A9,y and set the condition codes
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    stx       >$01AB,y  ; store x at >$01AB,y
Branch_018          rts                 ; return to the caller
Text_001            fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data
Branch_019          leax      <Text_001,pc ; form the address <Text_001,pc in x
                    ldb       #207      ; set b to the constant 207
                    pshs      b         ; save b on the stack
                    lda       #2        ; set a to the constant 2
                    ldy       #100      ; set y to the constant 100
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      Routine_007 ; call subroutine Routine_007
                    ldd       >$019D,y  ; load d from >$019D,y
                    subd      >$01AB,y  ; subtract from d using >$01AB,y
                    rts                 ; return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AB       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $39       ; store byte data
Routine_002         pshs      x         ; save x on the stack
                    leax      d,y       ; form the address d,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
Branch_020          ldd       ,y++      ; load d from ,y++
                    leax      d,u       ; form the address d,u in x
                    ldd       ,x        ; load d from ,x
                    addd      $02,s     ; add to d using $02,s
                    std       ,x        ; store d at ,x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bne       Branch_020 ; branch when the values differ or the result is nonzero; target Branch_020
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
RegistrationMain
stk_confirmation    equ       0         ; normalized Y/N response after local allocation
stk_log_stream      equ       1         ; append stream pointer after local allocation
stk_saved_u         equ       3         ; caller's U after local allocation
                    pshs      u         ; preserve the caller frame while the registration program runs
                    ldd       #-77      ; require enough stack headroom for the application frame
                    lbsr      CheckStackSpace ; reject a stack that cannot hold the form workflow
                    leas      -$03,s    ; allocate confirmation byte and output-stream pointer
                    leax      >AppendMode,pc ; select append mode so prior requests remain intact
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldx       $0B,s     ; recover the compiler argv vector
                    ldd       $02,x     ; select argv[1], the pending-user log pathname
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      OpenFileStream ; open the caller-supplied log for append
                    leas      $04,s     ; discard two word-sized library arguments
                    std       $01,s     ; retain the stream pointer in the local frame
                    bne       RegistrationFileReady ; continue only with a valid stream
                    ldd       >RuntimeErrorCode,y ; recover the library error associated with the failed open
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >CannotOpenMessage,pc ; select the human-readable failure reason
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      AbortCannotOpen ; print the diagnostic and terminate with the saved error
                    leas      $04,s     ; discard two word-sized library arguments
RegistrationFileReady ldd       #78       ; seed a non-Y answer so the form runs at least once
                    lbra      NormalizeConfirmation ; enter the common confirmation test
CollectRegistration leax      >RegistrationIntro,pc ; select the registration requirements heading
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >AccuracyPrompt,pc ; select the request for accurate caller information
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >FalseInfoWarning,pc ; select the validation warning shown before the form
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >FormDivider,pc ; select the visual separator before the entry fields
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >NamePrompt,pc ; select the real-name prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >CityPrompt,pc ; select the city prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >StatePrompt,pc ; select the state prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >PhonePrompt,pc ; select the telephone prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >AliasPrompt,pc ; select the requested-alias prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >PasswordPrompt,pc ; select the requested-password prompt
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      ReadInputLine ; collect a NUL-terminated response in the selected field
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >RegistrationSummaryFormat,pc ; select the name and alias preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LocationSummaryFormat,pc ; select the city and state preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >PhoneSummaryFormat,pc ; select the telephone preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >PasswordSummaryFormat,pc ; select the password preview format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ConfirmationPrompt,pc ; select the confirmation question
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >RuntimeInputStream,y ; select the standard-input stream
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      FlushStream ; flush pending terminal output before reading one byte
                    leas      $02,s     ; discard one word-sized library argument
                    ldd       #1        ; request exactly one confirmation character
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      $02,s     ; address the local confirmation byte
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    clra                ; form standard-input path zero for the raw read
                    clrb                ; form standard-input path zero for the raw read
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ReadBytes ; read the single confirmation byte without waiting for a line
                    leas      $06,s     ; discard three word-sized library arguments
                    ldb       ,s        ; recover the confirmation character
                    clra                ; form standard-input path zero for the raw read
                    andb      #223      ; fold a lowercase response to uppercase
NormalizeConfirmation stb       ,s        ; store the normalized confirmation in the local frame
                    ldb       ,s        ; recover the confirmation character
                    cmpb      #89       ; accept only an explicit Y
                    lbne      CollectRegistration ; repeat the entire form after any other response
                    leax      >SavingMessage,pc ; select the saving-status message
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leax      >LogHeading,pc ; select the pending-user record heading
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >LogDivider,pc ; select the pending-user record separator
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ApplicantName,y ; select the real-name field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogNameFormat,pc ; select the real-name record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantCity,y ; select the city field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogCityFormat,pc ; select the city record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantState,y ; select the state field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogStateFormat,pc ; select the state record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPhone,y ; select the telephone field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogPhoneFormat,pc ; select the telephone record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantAlias,y ; select the requested-alias field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogAliasFormat,pc ; select the alias record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >ApplicantPassword,y ; select the requested-password field
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    leax      >LogPasswordFormat,pc ; select the password record format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $05,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $06,s     ; discard three word-sized library arguments
                    leax      >LogBlankLine,pc ; select the record-ending blank line
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    ldd       $03,s     ; recover the log stream beneath temporary arguments
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      WriteFormattedStream ; append the selected labeled line to the pending-user log
                    leas      $04,s     ; discard two word-sized library arguments
                    leax      >ThankYouMessage,pc ; select the completion notice
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $02,s     ; discard one word-sized library argument
                    leas      $03,s     ; release the application locals
                    puls      pc,u      ; restore the caller frame and return
AbortCannotOpen     pshs      u         ; preserve the caller frame for fatal error reporting
                    ldd       #-72      ; require stack headroom for formatted error output
                    lbsr      CheckStackSpace ; reject a stack that cannot hold the form workflow
                    ldd       $04,s     ; recover the diagnostic string argument
                    pshs      d         ; pass the current value as a word-sized argument
                    leax      >StringLineFormat,pc ; select the single-string diagnostic format
                    pshs      x         ; pass the selected pointer through the compiler calling convention
                    lbsr      PrintFormatted ; render the selected prompt, message, or preview
                    leas      $04,s     ; discard two word-sized library arguments
                    ldd       $06,s     ; recover the saved error status
                    pshs      d         ; pass the current value as a word-sized argument
                    lbsr      ExitProcess ; terminate with the open failure status
                    leas      $02,s     ; discard one word-sized library argument
                    puls      pc,u      ; restore the caller frame and return
AppendMode          fcb       $61       ; ascii "a" selects append mode
                    fcb       $00       ; terminate the compiler-runtime C string
CannotOpenMessage   fcc       "Cannot open file" ; file-open failure text
                    fcb       $00       ; terminate the compiler-runtime C string
RegistrationIntro   fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "To be validated on this system you must enter the following information" ; registration introduction
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
AccuracyPrompt      fcc       "Please enter the information as correctly as possible" ; accuracy reminder
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
FalseInfoWarning    fcc       "any false information will result in your not being validated" ; validation warning
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
FormDivider         fcc       "-------------------------------------------------------------------------" ; form separator
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
NamePrompt          fcc       "Enter your name:==============>" ; real-name prompt
                    fcb       $00       ; terminate the compiler-runtime C string
CityPrompt          fcc       "Enter your city:==============>" ; city prompt
                    fcb       $00       ; terminate the compiler-runtime C string
StatePrompt         fcc       "Enter your state:=============>" ; state prompt
                    fcb       $00       ; terminate the compiler-runtime C string
PhonePrompt         fcc       "Enter your phone #:===========>" ; telephone prompt
                    fcb       $00       ; terminate the compiler-runtime C string
AliasPrompt         fcc       "Enter your alias (if any):====>" ; alias prompt
                    fcb       $00       ; terminate the compiler-runtime C string
PasswordPrompt      fcc       "Enter your desired password:==>" ; password prompt
                    fcb       $00       ; terminate the compiler-runtime C string
RegistrationSummaryFormat fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "You are %s alias %s" ; name/alias preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LocationSummaryFormat fcc       "Calling from %s, %s" ; city/state preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
PhoneSummaryFormat  fcc       "Phone #%s" ; telephone preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
PasswordSummaryFormat fcc       "Password:%s" ; password preview format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
ConfirmationPrompt  fcc       "Is this information correct?" ; confirmation question
                    fcb       $00       ; terminate the compiler-runtime C string
SavingMessage       fcb       $0D       ; embed a carriage return in the formatted output
                    fcc       "One moment please..." ; saving-status text
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogHeading          fcc       "New user log" ; pending-user record heading
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogDivider          fcc       "-----------------------------------------------------" ; pending-user record separator
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogNameFormat       fcc       "User name       :%s" ; real-name log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogCityFormat       fcc       "City            :%s" ; city log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogStateFormat      fcc       "State           :%s" ; state log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogPhoneFormat      fcc       "Phone #         :%s" ; telephone log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogAliasFormat      fcc       "Desired alias   :%s" ; alias log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogPasswordFormat   fcc       "Desired password:%s" ; password log format
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
LogBlankLine        fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
ThankYouMessage     fcc       "Thank you, the sysop will validate you as soon as possible." ; registration completion text
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
StringLineFormat    fcb       $25       ; begin the %s conversion
                    fcb       $73       ; complete the %s conversion
                    fcb       $0D       ; embed a carriage return in the formatted output
                    fcb       $00       ; terminate the compiler-runtime C string
Routine_015         pshs      u         ; save u on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
Branch_024          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #3        ; mask b using #3
                    lbeq      Branch_025 ; branch when the values are equal or the result is zero; target Branch_025
                    leau      WorkBuffer_001,u ; form the workspace or data address WorkBuffer_001,u in u
                    pshs      u         ; save u on the stack
                    leax      >$00DE,y  ; form the address >$00DE,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bhi       Branch_024 ; branch when the unsigned value is higher; target Branch_024
                    ldd       #200      ; set d to the constant 200
                    std       >RuntimeErrorCode,y ; store d at >RuntimeErrorCode,y
                    lbra      Branch_026 ; continue execution at Branch_026
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Routine_016         pshs      u         ; save u on the stack
                    ldu       $08,s     ; load u from the current stack frame at $08,s
                    bne       Branch_027 ; branch when the values differ or the result is nonzero; target Branch_027
                    bsr       Routine_015 ; call subroutine Routine_015
                    tfr       d,u       ; copy the register values specified by d,u
Branch_027          stu       -$02,s    ; store u in the current stack frame at -$02,s
                    beq       Branch_026 ; branch when the values are equal or the result is zero; target Branch_026
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       WorkWord_004,u ; store d at WorkWord_004,u
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldb       $01,x     ; load b from $01,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    beq       Branch_028 ; branch when the values are equal or the result is zero; target Branch_028
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldb       $02,x     ; load b from $02,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       Branch_029 ; branch when the values differ or the result is nonzero; target Branch_029
Branch_028          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #3        ; set selected bits in b using #3
                    bra       Branch_030 ; continue execution at Branch_030
Branch_029          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    cmpb      #114      ; compare b with #114 and set the condition codes
                    beq       Branch_031 ; branch when the values are equal or the result is zero; target Branch_031
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    cmpb      #100      ; compare b with #100 and set the condition codes
                    bne       Branch_032 ; branch when the values differ or the result is nonzero; target Branch_032
Branch_031          ldd       #1        ; set d to the constant 1
                    bra       Branch_033 ; continue execution at Branch_033
Branch_032          ldd       #2        ; set d to the constant 2
Branch_033          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
Branch_030          std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      WorkWord_005,u ; add to d using WorkWord_005,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
Branch_025          tfr       u,d       ; copy the register values specified by u,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_026          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_017         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $0A,s     ; load x from the current stack frame at $0A,s
                    ldb       $01,x     ; load b from $01,x
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_034 ; continue execution at Branch_034
Branch_035          ldx       $0A,s     ; load x from the current stack frame at $0A,s
                    ldb       $02,x     ; load b from $02,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    ldd       #7        ; set d to the constant 7
                    bra       Branch_037 ; continue execution at Branch_037
Branch_036          ldd       #4        ; set d to the constant 4
                    bra       Branch_037 ; continue execution at Branch_037
Branch_038          ldd       #3        ; set d to the constant 3
Branch_037          std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_039 ; continue execution at Branch_039
Branch_040          leax      $04,s     ; form the address $04,s in x
                    lbra      Branch_041 ; continue execution at Branch_041
Branch_034          stx       -$02,s    ; store x in the current stack frame at -$02,s
                    beq       Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    beq       Branch_035 ; branch when the values are equal or the result is zero; target Branch_035
                    cmpx      #43       ; compare x with #43 and set the condition codes
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    bra       Branch_040 ; continue execution at Branch_040
Branch_039          ldb       [<$0A,s]  ; load b from the current stack frame at [<$0A,s]
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_042 ; continue execution at Branch_042
Branch_043          ldd       ,s        ; load d from the current stack frame at ,s
                    orb       #1        ; set selected bits in b using #1
                    bra       Branch_044 ; continue execution at Branch_044
Branch_045          ldd       ,s        ; load d from the current stack frame at ,s
                    orb       #2        ; set selected bits in b using #2
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_047 ; continue execution at Branch_047
Branch_046          ldd       ,s        ; load d from the current stack frame at ,s
                    orb       #2        ; set selected bits in b using #2
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_020 ; call subroutine Routine_020
                    bra       Branch_048 ; continue execution at Branch_048
Branch_049          ldd       ,s        ; load d from the current stack frame at ,s
                    orb       #129      ; set selected bits in b using #129
Branch_044          pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
Branch_048          leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    bra       Branch_047 ; continue execution at Branch_047
Branch_041          leas      -$04,x    ; adjust the system stack pointer
Branch_050          ldd       #203      ; set d to the constant 203
                    std       >RuntimeErrorCode,y ; store d at >RuntimeErrorCode,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_051 ; continue execution at Branch_051
Branch_042          cmpx      #114      ; compare x with #114 and set the condition codes
                    lbeq      Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    cmpx      #97       ; compare x with #97 and set the condition codes
                    lbeq      Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    cmpx      #119      ; compare x with #119 and set the condition codes
                    beq       Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    bra       Branch_050 ; continue execution at Branch_050
Branch_047          ldd       $02,s     ; load d from the current stack frame at $02,s
Branch_051          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcc       "4@O_4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "K" ; store literal character data
OpenFileStream      pshs      u         ; save u on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $04,s     ; adjust the system stack pointer
                    tfr       d,u       ; copy the register values specified by d,u
                    cmpu      #-1       ; compare u with #-1 and set the condition codes
                    bne       Branch_052 ; branch when the values differ or the result is nonzero; target Branch_052
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_053 ; continue execution at Branch_053
Branch_052          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_054 ; continue execution at Branch_054
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FE       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $2C       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
Branch_054          pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_016 ; call subroutine Routine_016
                    leas      $06,s     ; adjust the system stack pointer
Branch_053          puls      pc,u      ; restore pc,u and return to the caller
ReadInputLine       pshs      u,d       ; save u,d on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    bra       Branch_055 ; continue execution at Branch_055
Branch_056          ldd       ,s        ; load d from the current stack frame at ,s
                    stb       ,u+       ; store b at ,u+
Branch_055          leax      >$000E,y  ; form the address >$000E,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $02,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #13       ; compare d with #13 and set the condition codes
                    beq       Branch_057 ; branch when the values are equal or the result is zero; target Branch_057
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_056 ; branch when the values differ or the result is nonzero; target Branch_056
Branch_057          ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_058 ; branch when the values differ or the result is nonzero; target Branch_058
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_059 ; continue execution at Branch_059
Branch_058          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       WorkByte_001,u ; store b at WorkByte_001,u
                    ldd       $06,s     ; load d from the current stack frame at $06,s
Branch_059          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2|" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $19       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "03_" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $2F       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "?2b" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $EC       ; store byte data
                    fcc       "h2d5" ; store literal character data
                    fcb       $C0       ; store byte data
PrintFormatted      pshs      u         ; save u on the stack
                    leax      >RuntimeInputStream,y ; form the address >RuntimeInputStream,y in x
                    stx       >$038F,y  ; store x at >$038F,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       Branch_060 ; continue execution at Branch_060
WriteFormattedStream pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >$038F,y  ; store d at >$038F,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
Branch_060          pshs      d         ; save d on the stack
                    leax      >Data_008,pc ; form the address >Data_008,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_022 ; call subroutine Routine_022
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcc       "0h4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0C       ; store byte data
                    fcc       "2fO_" ; store literal character data
                    fcb       $E7       ; store byte data
                    fcb       $B9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Routine_022         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       Branch_061 ; continue execution at Branch_061
Branch_062          ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      Branch_063 ; branch when the values are equal or the result is zero; target Branch_063
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_061          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       Branch_062 ; branch when the values differ or the result is nonzero; target Branch_062
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_064 ; branch when the values differ or the result is nonzero; target Branch_064
                    ldd       #1        ; set d to the constant 1
                    std       >$03A5,y  ; store d at >$03A5,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_065 ; continue execution at Branch_065
Branch_064          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$03A5,y  ; store d at >$03A5,y
Branch_065          ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       Branch_066 ; branch when the values differ or the result is nonzero; target Branch_066
                    ldd       #48       ; set d to the constant 48
                    bra       Branch_067 ; continue execution at Branch_067
Branch_066          ldd       #32       ; set d to the constant 32
Branch_067          std       >$03A7,y  ; store d at >$03A7,y
                    bra       Branch_068 ; continue execution at Branch_068
Branch_069          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_023 ; call subroutine Routine_023
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
Branch_068          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_069 ; branch when the values differ or the result is nonzero; target Branch_069
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       Branch_070 ; branch when the values differ or the result is nonzero; target Branch_070
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_071 ; continue execution at Branch_071
Branch_072          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_023 ; call subroutine Routine_023
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_071          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_072 ; branch when the values differ or the result is nonzero; target Branch_072
                    bra       Branch_073 ; continue execution at Branch_073
Branch_070          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_073          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_074 ; continue execution at Branch_074
Branch_075          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    bra       Branch_076 ; continue execution at Branch_076
Branch_077          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_025 ; call subroutine Routine_025
Branch_076          std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_078 ; continue execution at Branch_078
Branch_079          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    pshs      d         ; save d on the stack
                    ldx       <$0017,s  ; load x from the current stack frame at <$0017,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    lbra      Branch_080 ; continue execution at Branch_080
Branch_081          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    lbra      Branch_080 ; continue execution at Branch_080
Branch_082          ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       Branch_083 ; branch when the values differ or the result is nonzero; target Branch_083
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_083          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_084 ; continue execution at Branch_084
Branch_085          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      Branch_086 ; continue execution at Branch_086
Branch_087          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_088 ; branch when the values are equal or the result is zero; target Branch_088
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_089 ; continue execution at Branch_089
Branch_090          ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       Branch_091 ; branch when the values are equal or the result is zero; target Branch_091
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
Branch_089          ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_090 ; branch when the values differ or the result is nonzero; target Branch_090
Branch_091          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_092 ; continue execution at Branch_092
Branch_088          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       Branch_084 ; continue execution at Branch_084
Branch_093          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_094 ; continue execution at Branch_094
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
Branch_094          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
Branch_080          leas      $04,s     ; adjust the system stack pointer
Branch_084          pshs      d         ; save d on the stack
Branch_078          ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $06,s     ; adjust the system stack pointer
Branch_092          lbra      Branch_061 ; continue execution at Branch_061
Branch_095          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
Branch_086          pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_061 ; continue execution at Branch_061
Branch_074          cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      Branch_075 ; branch when the values are equal or the result is zero; target Branch_075
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_077 ; branch when the values are equal or the result is zero; target Branch_077
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_079 ; branch when the values are equal or the result is zero; target Branch_079
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      Branch_079 ; branch when the values are equal or the result is zero; target Branch_079
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_081 ; branch when the values are equal or the result is zero; target Branch_081
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      Branch_085 ; branch when the values are equal or the result is zero; target Branch_085
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_087 ; branch when the values are equal or the result is zero; target Branch_087
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      Branch_093 ; branch when the values are equal or the result is zero; target Branch_093
                    bra       Branch_095 ; continue execution at Branch_095
Branch_063          leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_024         pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       Branch_096 ; branch when the signed value is greater than or equal; target Branch_096
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       Branch_097 ; branch when the signed value is greater than or equal; target Branch_097
                    leax      >Text_025,pc ; form the address >Text_025,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_032 ; call subroutine Routine_032
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_098 ; continue execution at Branch_098
Branch_097          ldd       #45       ; set d to the constant 45
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_096          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_099 ; continue execution at Branch_099
Routine_027         pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_100 ; continue execution at Branch_100
Branch_101          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
Branch_100          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       Branch_101 ; branch when the signed value is less; target Branch_101
                    leax      >$0001,y  ; form the address >$0001,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       Branch_102 ; continue execution at Branch_102
Branch_103          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_104          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       Branch_103 ; branch when the signed value is greater than or equal; target Branch_103
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    beq       Branch_105 ; branch when the values are equal or the result is zero; target Branch_105
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_105          ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_106 ; branch when the values are equal or the result is zero; target Branch_106
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
Branch_106          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_102          ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$0009,y  ; compare d with >$0009,y and set the condition codes
                    bne       Branch_104 ; branch when the values differ or the result is nonzero; target Branch_104
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       WorkByte_001,u ; store b at WorkByte_001,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_025         pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
Branch_107          ldd       $06,s     ; load d from the current stack frame at $06,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #7        ; mask b using #7
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bne       Branch_107 ; branch when the values differ or the result is nonzero; target Branch_107
                    bra       Branch_108 ; continue execution at Branch_108
Branch_109          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_108          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_109 ; branch when the unsigned value is lower or equal; target Branch_109
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
Branch_099          leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
Branch_098          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_026         pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
Branch_110          ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       Branch_111 ; branch when the signed value is less than or equal; target Branch_111
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       Branch_112 ; branch when the values are equal or the result is zero; target Branch_112
                    ldd       #65       ; set d to the constant 65
                    bra       Branch_113 ; continue execution at Branch_113
Branch_112          ldd       #97       ; set d to the constant 97
Branch_113          addd      #-10      ; add to d using #-10
                    bra       Branch_114 ; continue execution at Branch_114
Branch_111          ldd       #48       ; set d to the constant 48
Branch_114          addd      ,s++      ; add to d using ,s++
                    stb       ,u+       ; store b at ,u+
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    anda      #15       ; mask a using #15
                    std       $08,s     ; store d in the current stack frame at $08,s
                    bne       Branch_110 ; branch when the values differ or the result is nonzero; target Branch_110
                    bra       Branch_115 ; continue execution at Branch_115
Branch_116          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
Branch_115          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_116 ; branch when the unsigned value is lower or equal; target Branch_116
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      Branch_117 ; continue execution at Branch_117
Routine_029         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       Branch_118 ; branch when the values differ or the result is nonzero; target Branch_118
                    bra       Branch_119 ; continue execution at Branch_119
Branch_120          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_119          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_120 ; branch when the signed value is greater; target Branch_120
                    bra       Branch_118 ; continue execution at Branch_118
Branch_121          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_118          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_121 ; branch when the values differ or the result is nonzero; target Branch_121
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       Branch_122 ; branch when the values are equal or the result is zero; target Branch_122
                    bra       Branch_123 ; continue execution at Branch_123
Branch_124          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_123          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_124 ; branch when the signed value is greater; target Branch_124
Branch_122          puls      pc,u      ; restore pc,u and return to the caller
Routine_031         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_033 ; call subroutine Routine_033
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       Branch_125 ; branch when the values differ or the result is nonzero; target Branch_125
                    bra       Branch_126 ; continue execution at Branch_126
Branch_127          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_126          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_127 ; branch when the signed value is greater; target Branch_127
                    bra       Branch_125 ; continue execution at Branch_125
Branch_128          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_125          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    bne       Branch_128 ; branch when the values differ or the result is nonzero; target Branch_128
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       Branch_129 ; branch when the values are equal or the result is zero; target Branch_129
                    bra       Branch_130 ; continue execution at Branch_130
Branch_131          ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_130          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_131 ; branch when the signed value is greater; target Branch_131
Branch_129          puls      pc,u      ; restore pc,u and return to the caller
Data_008            fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
Branch_117          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Text_025            fcc       "-32768" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $14       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $03       ; store byte data
                    fcc       "M2b" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcc       "0g4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AD       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $4A       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $CA       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $DC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $EB       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $0B       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $BE       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $9B       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $79       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "F2d" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $3B       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "K" ; store literal character data
Routine_034         pshs      u,d       ; save u,d on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_132 ; continue execution at Branch_132
Branch_133          tfr       u,d       ; copy the register values specified by u,d
                    leau      WorkBuffer_001,u ; form the workspace or data address WorkBuffer_001,u in u
                    pshs      d         ; save d on the stack
                    bsr       Routine_035 ; call subroutine Routine_035
                    leas      $02,s     ; adjust the system stack pointer
Branch_132          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       Branch_133 ; branch when the signed value is less; target Branch_133
                    lbra      Branch_134 ; continue execution at Branch_134
Routine_035         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       Branch_135 ; branch when the values are equal or the result is zero; target Branch_135
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    bne       Branch_136 ; branch when the values differ or the result is nonzero; target Branch_136
Branch_135          ldd       #-1       ; set d to the constant -1
                    lbra      Branch_134 ; continue execution at Branch_134
Branch_136          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       Branch_137 ; branch when the values are equal or the result is zero; target Branch_137
                    pshs      u         ; save u on the stack
                    bsr       FlushStream ; call subroutine FlushStream
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_138 ; continue execution at Branch_138
Branch_137          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_138          std       ,s        ; store d in the current stack frame at ,s
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_036 ; call subroutine Routine_036
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bra       Branch_134 ; continue execution at Branch_134
FlushStream         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_139 ; branch when the values are equal or the result is zero; target Branch_139
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_140 ; branch when the values are equal or the result is zero; target Branch_140
Branch_139          ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_140          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_141 ; branch when the values differ or the result is nonzero; target Branch_141
                    pshs      u         ; save u on the stack
                    lbsr      Routine_037 ; call subroutine Routine_037
                    leas      $02,s     ; adjust the system stack pointer
Branch_141          pshs      u         ; save u on the stack
                    bsr       Routine_038 ; call subroutine Routine_038
Branch_134          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_038         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_142 ; branch when the values differ or the result is nonzero; target Branch_142
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_142 ; branch when the values are equal or the result is zero; target Branch_142
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_039 ; call subroutine Routine_039
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $08,s     ; adjust the system stack pointer
Branch_142          ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      Branch_143 ; branch when the values are equal or the result is zero; target Branch_143
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      Branch_143 ; branch when the values are equal or the result is zero; target Branch_143
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_144 ; branch when the values are equal or the result is zero; target Branch_144
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bra       Branch_145 ; continue execution at Branch_145
Branch_146          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_040 ; call subroutine Routine_040
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_147 ; branch when the values differ or the result is nonzero; target Branch_147
                    leax      $04,s     ; form the address $04,s in x
                    bra       Branch_148 ; continue execution at Branch_148
Branch_147          ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      ,s        ; subtract from d using ,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      ,s        ; add to d using ,s
Branch_145          std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       Branch_146 ; branch when the values differ or the result is nonzero; target Branch_146
                    bra       Branch_143 ; continue execution at Branch_143
Branch_144          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_041 ; call subroutine Routine_041
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       Branch_143 ; branch when the values are equal or the result is zero; target Branch_143
                    bra       Branch_149 ; continue execution at Branch_149
Branch_148          leas      -$04,x    ; adjust the system stack pointer
Branch_149          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #32       ; set selected bits in b using #32
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       #-1       ; set d to the constant -1
                    bra       Branch_150 ; continue execution at Branch_150
Branch_143          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #1        ; set selected bits in a using #1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    addd      WorkWord_005,u ; add to d using WorkWord_005,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_150          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_039         pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_021         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_151 ; branch when the values are equal or the result is zero; target Branch_151
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_151 ; branch when the values differ or the result is nonzero; target Branch_151
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bcc       Branch_152 ; branch when carry is clear; target Branch_152
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    lbra      Branch_153 ; continue execution at Branch_153
Branch_152          pshs      u         ; save u on the stack
                    lbsr      Routine_042 ; call subroutine Routine_042
                    lbra      Branch_154 ; continue execution at Branch_154
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $05       ; store byte data
Branch_151          ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "d2|4@" ; store literal character data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $93       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $95       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d5" ; store literal character data
                    fcb       $C0       ; store byte data
Routine_042         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #128      ; mask a using #128
                    andb      #49       ; mask b using #49
                    cmpd      #-32767   ; compare d with #-32767 and set the condition codes
                    beq       Branch_155 ; branch when the values are equal or the result is zero; target Branch_155
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #49       ; mask b using #49
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbne      Branch_156 ; branch when the values differ or the result is nonzero; target Branch_156
                    pshs      u         ; save u on the stack
                    lbsr      Routine_037 ; call subroutine Routine_037
                    leas      $02,s     ; adjust the system stack pointer
Branch_155          leax      >$000E,y  ; form the address >$000E,y in x
                    pshs      x         ; save x on the stack
                    cmpu      ,s++      ; compare u with ,s++ and set the condition codes
                    bne       Branch_157 ; branch when the values differ or the result is nonzero; target Branch_157
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_157 ; branch when the values are equal or the result is zero; target Branch_157
                    leax      >RuntimeInputStream,y ; form the address >RuntimeInputStream,y in x
                    pshs      x         ; save x on the stack
                    lbsr      FlushStream ; call subroutine FlushStream
                    leas      $02,s     ; adjust the system stack pointer
Branch_157          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       Branch_158 ; branch when the values are equal or the result is zero; target Branch_158
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_159 ; branch when the values are equal or the result is zero; target Branch_159
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    bra       Branch_160 ; continue execution at Branch_160
Branch_159          leax      >ReadBytes,pc ; form the address >ReadBytes,pc in x
Branch_160          tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       ,x        ; call subroutine ,x
                    bra       Branch_161 ; continue execution at Branch_161
Branch_158          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    pshs      x         ; save x on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      ReadBytes ; call subroutine ReadBytes
Branch_161          leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bgt       Branch_162 ; branch when the signed value is greater; target Branch_162
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_163 ; branch when the values are equal or the result is zero; target Branch_163
                    ldd       #32       ; set d to the constant 32
                    bra       Branch_164 ; continue execution at Branch_164
Branch_163          ldd       #16       ; set d to the constant 16
Branch_164          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkWord_003,u ; store d at WorkWord_003,u
Branch_156          ldd       #-1       ; set d to the constant -1
                    bra       Branch_154 ; continue execution at Branch_154
Branch_162          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      ,s        ; add to d using ,s
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldb       [<$02,u]  ; load b from [<$02,u]
                    clra                ; clear a to zero and set the condition codes
Branch_154          leas      $02,s     ; adjust the system stack pointer
Branch_153          puls      pc,u      ; restore pc,u and return to the caller
Routine_037         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       Branch_165 ; branch when the values differ or the result is nonzero; target Branch_165
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_043 ; call subroutine Routine_043
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       Branch_166 ; branch when the values differ or the result is nonzero; target Branch_166
                    ldd       #64       ; set d to the constant 64
                    bra       Branch_167 ; continue execution at Branch_167
Branch_166          ldd       #128      ; set d to the constant 128
Branch_167          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leas      <$0020,s  ; adjust the system stack pointer
Branch_165          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #128      ; set selected bits in a using #128
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       Branch_168 ; branch when the values are equal or the result is zero; target Branch_168
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_168          ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    bne       Branch_169 ; branch when the values differ or the result is nonzero; target Branch_169
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_170 ; branch when the values are equal or the result is zero; target Branch_170
                    ldd       #128      ; set d to the constant 128
                    bra       Branch_171 ; continue execution at Branch_171
Branch_170          ldd       #256      ; set d to the constant 256
Branch_171          std       WorkWord_005,u ; store d at WorkWord_005,u
Branch_169          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bne       Branch_172 ; branch when the values differ or the result is nonzero; target Branch_172
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_044 ; call subroutine Routine_044
                    leas      $02,s     ; adjust the system stack pointer
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_173 ; branch when the values are equal or the result is zero; target Branch_173
Branch_172          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #8        ; set selected bits in b using #8
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    bra       Branch_174 ; continue execution at Branch_174
Branch_173          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #4        ; set selected bits in b using #4
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_005,u ; store d at WorkWord_005,u
Branch_174          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      WorkWord_005,u ; add to d using WorkWord_005,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_030         pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_175 ; continue execution at Branch_175
Branch_176          ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >Data_010,pc ; form the address >Data_010,pc in x
                    bra       Branch_177 ; continue execution at Branch_177
Branch_178          ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$000C,y  ; store b at >$000C,y
                    leax      >$000B,y  ; form the address >$000B,y in x
Branch_177          tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_175          cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    bra       Branch_178 ; continue execution at Branch_178
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Data_010            fcb       $00       ; store byte data
Routine_028         pshs      u         ; save u on the stack
                    leax      >Data_011,pc ; form the address >Data_011,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Data_011            fcb       $00       ; store byte data
Routine_033         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
Branch_179          ldb       ,u+       ; load b from ,u+
                    bne       Branch_179 ; branch when the values differ or the result is nonzero; target Branch_179
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_032         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_180          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_180 ; branch when the values differ or the result is nonzero; target Branch_180
                    bra       Branch_181 ; continue execution at Branch_181
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2~" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F4       ; store byte data
Branch_181          ldd       $06,s     ; load d from the current stack frame at $06,s
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_5" ; store literal character data
                    fcb       $C0       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $41       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Routine_023         tsta                ; set condition codes from a without changing it
                    bne       Branch_182 ; branch when the values differ or the result is nonzero; target Branch_182
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       Branch_182 ; branch when the values differ or the result is nonzero; target Branch_182
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       ,s        ; load x from the current stack frame at ,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
Branch_182          pshs      d         ; save d on the stack
                    ldd       #0        ; set d to the constant 0
                    pshs      d         ; save d on the stack
                    pshs      d         ; save d on the stack
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_183 ; branch when carry is clear; target Branch_183
                    inc       ,s        ; increment the value at ,s
Branch_183          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_184 ; branch when carry is clear; target Branch_184
                    inc       ,s        ; increment the value at ,s
Branch_184          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      ,s        ; add to d using ,s
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leas      $08,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcc       "gbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "dbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d9]'" ; store literal character data
                    fcb       $F0       ; store byte data
                    fcc       "hcibZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $E7       ; store byte data
Routine_043         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_185 ; branch when the values are equal or the result is zero; target Branch_185
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_187 ; branch when the values are equal or the result is zero; target Branch_187
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       Branch_187 ; branch when the values are equal or the result is zero; target Branch_187
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_188 ; continue execution at Branch_188
Branch_187          pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_189 ; branch when carry is clear; target Branch_189
                    puls      u         ; restore u from the stack
                    lbra      Branch_188 ; continue execution at Branch_188
Branch_189          stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_185          ldx       $06,s     ; load x from the current stack frame at $06,s
Branch_186          os9       I$GetStt  ; query status code B for path A
                    lbra      Branch_190 ; continue execution at Branch_190
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $D0       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $CA       ; store byte data
Routine_018         ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_188 ; branch when carry reports an error or unsigned underflow; target Branch_188
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Routine_036         lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; close path A
                    lbra      Branch_190 ; continue execution at Branch_190
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A9       ; store byte data
Routine_020         ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    bcs       Branch_191 ; branch when carry reports an error or unsigned underflow; target Branch_191
Branch_192          tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Branch_191          cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      Branch_188 ; branch when the values differ or the result is nonzero; target Branch_188
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      Branch_188 ; branch when the values differ or the result is nonzero; target Branch_188
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_188 ; branch when carry reports an error or unsigned underflow; target Branch_188
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      ,x        ; form the workspace or data address ,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u,a       ; restore u,a from the stack
                    bcc       Branch_192 ; branch when carry is clear; target Branch_192
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; close path A
                    puls      b         ; restore b from the stack
                    lbra      Branch_188 ; continue execution at Branch_188
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $87       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5B       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O9" ; store literal character data
ReadBytes           pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcc       Branch_193 ; branch when carry is clear; target Branch_193
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       Branch_194 ; branch when the values differ or the result is nonzero; target Branch_194
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
Branch_194          puls      y,x       ; restore y,x from the stack
                    lbra      Branch_188 ; continue execution at Branch_188
Branch_193          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
Data_009            fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcc       "h4 " ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8B       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $DD       ; store byte data
Routine_041         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_195 ; branch when the values are equal or the result is zero; target Branch_195
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; write Y bytes from X to path A
Branch_196          bcc       Branch_195 ; branch when carry is clear; target Branch_195
                    puls      y         ; restore y from the stack
                    lbra      Branch_188 ; continue execution at Branch_188
Branch_195          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_040         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_195 ; branch when the values are equal or the result is zero; target Branch_195
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_196 ; continue execution at Branch_196
Routine_019         pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       Branch_197 ; branch when the values differ or the result is nonzero; target Branch_197
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       Branch_198 ; continue execution at Branch_198
Branch_197          cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       Branch_199 ; branch when the values are equal or the result is zero; target Branch_199
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_200 ; branch when the values are equal or the result is zero; target Branch_200
                    ldb       #247      ; set b to the constant 247
Branch_201          clra                ; clear a to zero and set the condition codes
                    std       >RuntimeErrorCode,y ; store d at >RuntimeErrorCode,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_200          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_201 ; branch when carry reports an error or unsigned underflow; target Branch_201
                    bra       Branch_198 ; continue execution at Branch_198
Branch_199          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_201 ; branch when carry reports an error or unsigned underflow; target Branch_201
Branch_198          tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A3,y  ; store d at >$01A3,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       Branch_201 ; branch when the result is negative; target Branch_201
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A1,y  ; store d at >$01A1,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    bcs       Branch_201 ; branch when carry reports an error or unsigned underflow; target Branch_201
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       " 5 $" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "2b9" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $AC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $86       ; store byte data
Routine_044         ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01A9,y  ; add to d using >$01A9,y
                    bcs       Branch_202 ; branch when carry reports an error or unsigned underflow; target Branch_202
                    cmpd      >$01AB,y  ; compare d with >$01AB,y and set the condition codes
                    bcc       Branch_202 ; branch when carry is clear; target Branch_202
                    pshs      d         ; save d on the stack
                    ldx       >$01A9,y  ; load x from >$01A9,y
                    clra                ; clear a to zero and set the condition codes
Branch_203          cmpx      ,s        ; compare x with ,s and set the condition codes
                    bcc       Branch_204 ; branch when carry is clear; target Branch_204
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_203 ; continue execution at Branch_203
Branch_204          ldd       >$01A9,y  ; load d from >$01A9,y
                    puls      x         ; restore x from the stack
                    stx       >$01A9,y  ; store x at >$01A9,y
                    rts                 ; return to the caller
Branch_202          ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_188          clra                ; clear a to zero and set the condition codes
                    std       >RuntimeErrorCode,y ; store d at >RuntimeErrorCode,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_190          bcs       Branch_188 ; branch when carry reports an error or unsigned underflow; target Branch_188
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
ExitProcess         lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_034 ; call subroutine Routine_034
Routine_007         ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; terminate the process with status B
Code_001            rts                 ; return to the caller
Data_001            fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5E       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $78       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "0               HHHHHHHHHH       BBBBBB" ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcc       "      DDDDDD" ; store literal character data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "    " ; store literal character data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcc       "New_user" ; store literal character data
                    fcb       $00       ; store byte data

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
