**********************************************************************
* AnsiEd - OS-9 Level 2 BBS command
*
* Syntax: AnsiEd [input] [output]
* Purpose: Edit the final screen image while separately recording the ordered ANSI output stream.
* State: screen/output buffers, cursor and saved cursor, edit/record mode, attributes, and colors.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       AnsiEd
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,_cstart,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
dpsiz               rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_002      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_003      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       13        ; reserve 13 byte(s) in the module workspace
WorkBuffer_005      rmb       196       ; reserve 196 byte(s) in the module workspace
WorkBuffer_006      rmb       128       ; reserve 128 byte(s) in the module workspace
argv                rmb       2         ; reserve 2 byte(s) in the module workspace
argv_2              rmb       58        ; reserve 58 byte(s) in the module workspace
argc                rmb       1         ; reserve 1 byte(s) in the module workspace
argc_1              rmb       1         ; reserve 1 byte(s) in the module workspace
_sttop              rmb       2         ; reserve 2 byte(s) in the module workspace
memend              rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_007      rmb       6         ; reserve 6 byte(s) in the module workspace
_mtop               rmb       2         ; reserve 2 byte(s) in the module workspace
_stbot              rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_008      rmb       9         ; reserve 9 byte(s) in the module workspace
WorkBuffer_009      rmb       50        ; reserve 50 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_010      rmb       8192      ; reserve 8192 byte(s) in the module workspace
WorkBuffer_011      rmb       1840      ; reserve 1840 byte(s) in the module workspace
WorkBuffer_012      rmb       3680      ; reserve 3680 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_013      rmb       10        ; reserve 10 byte(s) in the module workspace
WorkBuffer_014      rmb       10        ; reserve 10 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_016        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_017        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_018        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_015      rmb       14        ; reserve 14 byte(s) in the module workspace
end                 rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_016      rmb       895       ; reserve 895 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /AnsiEd/ ; store an OS-9 high-bit-terminated string
                    fcb       $01       ; store byte data

* ===== cstart.a =====

*
* move bytes (Y=From addr, U=To addr, X=Count)
*
movbytes            lda       ,y+       ; get a byte
                    sta       ,u+       ; put a byte
                    leax      -$01,x    ; dec the count
                    bne       movbytes  ; and round again
                    rts                 ; return to the caller

_cstart             pshs      y         ; save the top of mem
                    pshs      u         ; save the data beginning address

                    clra                ; setup to clear
                    clrb                ; 256 bytes
csta05              sta       ,u+       ; clear dp bytes
                    decb                ; decrement b
                    bne       csta05    ; branch when the values differ or the result is nonzero; target csta05

csta10              ldx       ,s        ; get the beginning of data address
                    leau      ,x        ; (tfr x,u)
                    leax      >$37E4,x  ; get the end of bss address
                    pshs      x         ; save it
                    leay      >etext,pc ; point to dp-data count word

                    ldx       ,y++      ; get count of dp-data to be moved
                    beq       csta15    ; bra if none
                    bsr       movbytes  ; move dp data into position
                    ldu       $02,s     ; get beginning address again
csta15              leau      >dpsiz,u  ; point to where non-dp should start
                    ldx       ,y++      ; get count of non-dp data to be moved
                    beq       clrbss    ; branch when the values are equal or the result is zero; target clrbss
                    bsr       movbytes  ; move non-dp data into position

* Clear the bss area - starts where
* the transferred data finished
                    clra                ; clear a to zero and set the condition codes
clrbss              cmpu      ,s        ; reached the end?
                    beq       reldt     ; bra if so
                    sta       ,u+       ; clear it
                    bra       clrbss    ; continue execution at clrbss

* now relocate the data-text references
reldt               ldu       $02,s     ; restore to data bottom
                    ldd       ,y++      ; get data-text ref. count
                    beq       reldd     ; branch when the values are equal or the result is zero; target reldd
                    leax      >0,pc     ; point to text
                    lbsr      patch     ; patch them

* and the data-data refs.
reldd               ldd       ,y++      ; get the count of data refs.
                    beq       restack   ; bra if none
                    leax      WorkByte_001,u ; u was already pointing there
                    lbsr      patch     ; call subroutine patch

restack             leas      $04,s     ; reset stack
                    puls      x         ; restore 'memend'
                    stx       >memend,u ; store x at >memend,u

* process the params
* the stack pointer is back where it started so is
* pointing at the params
*
* the objective is to insert null chars at the end of each argument
* and fill in the argv vector with pointers to them

* first store the program name address
* (an extra name inserted here for just this purpose
* - undocumented as yet)
                    sty       >argv,u   ; store y at >argv,u

                    ldd       #1        ; at least one arg
                    std       >argc,u   ; store d at >argc,u
                    leay      >argv_2,u ; point y at second slot
                    leax      ,s        ; point x at params
                    lda       ,x+       ; initialize

aloop               ldb       >argc_1,u ; load b from >argc_1,u
                    cmpb      #29       ; about to overflow?
                    beq       final     ; branch when the values are equal or the result is zero; target final
aloop10             cmpa      #13       ; is it EOL?
                    beq       final     ; yes - reached the end of the list

                    cmpa      #32       ; is it a space?
                    beq       aloop20   ; yes - try another
                    cmpa      #44       ; is it a comma?
                    bne       aloop30   ; no - a word has started
aloop20             lda       ,x+       ; yes - bump
                    bra       aloop10   ; and round again

aloop30             cmpa      #34       ; quoted string?
                    beq       aloop40   ; yes
                    cmpa      #39       ; the other one?
                    bne       aloop60   ; no - ordinary

aloop40             stx       ,y++      ; save address in vector
                    inc       >argc_1,u ; bump the arg count
                    pshs      a         ; save delimiter

qloop               lda       ,x+       ; get another
                    cmpa      #13       ; eol?
                    beq       aloop50   ; branch when the values are equal or the result is zero; target aloop50
                    cmpa      ,s        ; delimiter?
                    bne       qloop     ; branch when the values differ or the result is nonzero; target qloop

aloop50             puls      b         ; clean stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       final     ; branch when the values are equal or the result is zero; target final
                    lda       ,x+       ; load a from ,x+
                    bra       aloop     ; continue execution at aloop

aloop60             leax      -$01,x    ; point at first char
                    stx       ,y++      ; put address in vector
                    leax      $01,x     ; bump it back
                    inc       >argc_1,u ; bump the arg count

* at least one non-space char has been seen
aloop70             cmpa      #13       ; have
                    beq       loopend   ; we
                    cmpa      #32       ; reached
                    beq       loopend   ; the end?
                    cmpa      #44       ; comma?
                    beq       loopend   ; branch when the values are equal or the result is zero; target loopend
                    lda       ,x+       ; no - look further
                    bra       aloop70   ; continue execution at aloop70

loopend             clr       -$01,x    ; yes - put in the null byte
                    bra       aloop     ; and look for the next word

* now put the pointers on the stack
final               leax      >argv,u   ; get the address of the arg vector
                    pshs      x         ; goes on the stack first
                    ldd       >argc,u   ; get the arg count
                    pshs      d         ; stack it
                    leay      WorkByte_001,u ; c progs. assume data & bss offset from y

                    bsr       _fixtop   ; set various variables

                    lbsr      main      ; call the program

                    clr       ,-s       ; put a zero
                    clr       ,-s       ; on the stack
                    lbsr      exit      ; and a dummy 'return address'

* no return here
_fixtop             leax      >end,y    ; get the initial memory end address
                    stx       >_mtop,y  ; it's the current memory top
                    sts       >_sttop,y ; this is really two bytes short!
                    sts       >_stbot,y ; store s at >_stbot,y
                    ldd       #-126     ; give ourselves some breating space

* on entry here, d holds the negative of a stack reservation request
_stkcheck           leax      d,s       ; calculate the requested size
                    cmpx      >_stbot,y ; is it lower than already reserved?
                    bcc       stk10     ; no - return
                    cmpx      >_mtop,y  ; yes - is it lower than possible?
                    bcs       fsterr    ; yes - can't cope
                    stx       >_stbot,y ; no - reserve it
stk10               rts                 ; return to the caller

fixserr             fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data

fsterr              leax      <fixserr,pc ; address of error string
                    ldb       #E$MemFul ; memory FULL error number

erexit              pshs      b         ; stack the error number
                    lda       #2        ; standard error output
                    ldy       #100      ; more than necessary
                    os9       I$WritLn  ; write it
                    clr       ,-s       ; clear MSB of status
                    lbsr      _exit     ; and out
* no return here

* stacksize()
* returns the extent of stack requested
* can be used by programmer for guidance
* in sizing memory at compile time
stacksiz            ldd       >_sttop,y ; top of stack on entry
                    subd      >_stbot,y ; subtract current reserved limit
                    rts                 ; return to the caller

* freemem()
* returns the current size of the free memory area
freemem             ldd       >_stbot,y ; load d from >_stbot,y
                    subd      >_mtop,y  ; subtract from d using >_mtop,y
                    rts                 ; return to the caller

* patch - adjust initialized data which refer to memory locations
* entry:
*       y -> list of offsets in the data area to be patched
*       u -> base of data
*       x -> base of either text or data area as appropriate
*       d =  count of offsets in the list
*
* exit:
*       u - unchanged
*       y - past the last entry in the list
*       x and d mangled

patch               pshs      x         ; save the base
                    leax      d,y       ; half way up the list
                    leax      d,x       ; top of list
                    pshs      x         ; save it as place to stop

* we do not come to this routine with
* a zero count (check!) so a test at the loop top
* is unnecessary
patch10             ldd       ,y++      ; get the offset
                    leax      d,u       ; point to location
                    ldd       ,x        ; get the relative reference
                    addd      $02,s     ; add in the base
                    std       ,x        ; store the absolute reference
                    cmpy      ,s        ; reached the top?
                    bne       patch10   ; no - round again

                    leas      $04,s     ; reset the stack
                    rts                 ; and return

main                pshs      u         ; save u on the stack
                    ldd       #-118     ; set d to the constant -118
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      <-$22,s   ; adjust the system stack pointer
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       <$0026,s  ; load d from the current stack frame at <$0026,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    ble       Branch_001 ; branch when the signed value is less than or equal; target Branch_001
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leas      $02,s     ; adjust the system stack pointer
Branch_001          lbsr      Code_001  ; call subroutine Code_001
                    ldd       <$0026,s  ; load d from the current stack frame at <$0026,s
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    ble       Branch_002 ; branch when the signed value is less than or equal; target Branch_002
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $04,x     ; load d from $04,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_004 ; call subroutine Routine_004
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_002          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    ldd       #21       ; set d to the constant 21
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >savprmpt,pc ; form the address >savprmpt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #32       ; set d to the constant 32
                    pshs      d         ; save d on the stack
                    leax      $04,s     ; form the address $04,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      readln    ; call subroutine readln
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       Branch_004 ; branch when the signed value is greater; target Branch_004
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    leax      $04,s     ; form the address $04,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_009 ; call subroutine Routine_009
                    leas      $04,s     ; adjust the system stack pointer
Branch_004          leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
Branch_003          leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Title,pc ; form the address >Title,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Copyright,pc ; form the address >Copyright,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >License,pc ; form the address >License,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Rights,pc ; form the address >Rights,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $02,s     ; adjust the system stack pointer
                    leas      <$0022,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_001         pshs      u         ; save u on the stack
                    ldd       #-84      ; set d to the constant -84
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #23       ; set d to the constant 23
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    pshs      d         ; save d on the stack
                    ldd       #23       ; set d to the constant 23
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_002         pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_006          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_007 ; continue execution at Branch_007
Branch_008          ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    std       ,x        ; store d at ,x
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    addd      #1        ; add to d using #1
Branch_007          std       $01,s     ; store d in the current stack frame at $01,s
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       Branch_008 ; branch when the signed value is less; target Branch_008
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_005          std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      Branch_006 ; branch when the signed value is less; target Branch_006
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_007,y ; store d at >WorkByte_007,y
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_004         pshs      u         ; save u on the stack
                    ldd       #-99      ; set d to the constant -99
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$0F,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      creat     ; call subroutine creat
                    leas      $04,s     ; adjust the system stack pointer
                    std       $0D,s     ; store d in the current stack frame at $0D,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
                    ldd       >WorkWord_006,y ; load d from >WorkWord_006,y
                    pshs      d         ; save d on the stack
                    leax      >CantOpen1,pc ; form the address >CantOpen1,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_015 ; call subroutine Routine_015
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #-1       ; set d to the constant -1
                    lbra      Branch_010 ; continue execution at Branch_010
Branch_009          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #30       ; set d to the constant 30
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #28       ; set d to the constant 28
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #11       ; set d to the constant 11
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PutScrn,pc ; form the address >PutScrn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #78       ; compare d with #78 and set the condition codes
                    beq       Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    lbsr      Routine_016 ; call subroutine Routine_016
Branch_011          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >ClrScrn,pc ; form the address >ClrScrn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
                    ldd       #27       ; set d to the constant 27
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    ldd       #91       ; set d to the constant 91
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    ldd       #50       ; set d to the constant 50
                    stb       $03,s     ; store b in the current stack frame at $03,s
                    ldd       #74       ; set d to the constant 74
                    stb       $04,s     ; store b in the current stack frame at $04,s
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       <$0011,s  ; load d from the current stack frame at <$0011,s
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
Branch_012          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    pshs      d         ; save d on the stack
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    pshs      x         ; save x on the stack
                    ldd       <$0011,s  ; load d from the current stack frame at <$0011,s
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $0D,s     ; load d from the current stack frame at $0D,s
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
Branch_010          leas      $0F,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_003         pshs      u         ; save u on the stack
                    ldd       #-88      ; set d to the constant -88
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    pshs      d         ; save d on the stack
                    lbsr      open      ; call subroutine open
                    leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
                    ldd       >WorkWord_006,y ; load d from >WorkWord_006,y
                    pshs      d         ; save d on the stack
                    leax      >CantOpen2,pc ; form the address >CantOpen2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_015 ; call subroutine Routine_015
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #-1       ; set d to the constant -1
                    lbra      Branch_014 ; continue execution at Branch_014
Branch_013          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_011,y ; store d at >WorkWord_011,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_012,y ; store d at >WorkWord_012,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_009,y ; store d at >WorkWord_009,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_010,y ; store d at >WorkWord_010,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    pshs      d         ; save d on the stack
                    ldd       #23       ; set d to the constant 23
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    leax      >ReadFile,pc ; form the address >ReadFile,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
Branch_015          stb       $01,s     ; store b in the current stack frame at $01,s
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #79       ; compare b with #79 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
Branch_017          ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       Branch_018 ; branch when the values differ or the result is nonzero; target Branch_018
                    ldd       #1        ; set d to the constant 1
                    bra       Branch_019 ; continue execution at Branch_019
Branch_018          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_019          std       >WorkByte_007,y ; store d at >WorkByte_007,y
                    leax      >AddLf,pc ; form the address >AddLf,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_020 ; continue execution at Branch_020
Branch_021          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
Branch_020          stb       ,s        ; store b in the current stack frame at ,s
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #89       ; compare b with #89 and set the condition codes
                    beq       Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #78       ; compare b with #78 and set the condition codes
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
Branch_022          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    lbra      Branch_023 ; continue execution at Branch_023
Branch_024          ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       Branch_025 ; branch when the signed value is less; target Branch_025
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
Branch_025          ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #27       ; compare b with #27 and set the condition codes
                    lbne      Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    ldd       >WorkByte_005,y ; load d from >WorkByte_005,y
                    lbne      Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    bne       Branch_027 ; branch when the values differ or the result is nonzero; target Branch_027
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       Branch_027 ; branch when the signed value is less; target Branch_027
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
Branch_027          ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #91       ; compare b with #91 and set the condition codes
                    bne       Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_005,y ; store d at >WorkByte_005,y
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    bne       Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       Branch_026 ; branch when the signed value is less; target Branch_026
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
Branch_026          ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #89       ; compare b with #89 and set the condition codes
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #13       ; compare b with #13 and set the condition codes
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #10       ; set d to the constant 10
                    bra       Branch_029 ; continue execution at Branch_029
Branch_028          ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
Branch_029          pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
Branch_023          leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      Branch_024 ; branch when the values differ or the result is nonzero; target Branch_024
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
Branch_014          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Code_001            pshs      u         ; save u on the stack
                    ldd       #-120     ; set d to the constant -120
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      <-$24,s   ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    pshs      d         ; save d on the stack
                    ldd       #23       ; set d to the constant 23
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_030 ; continue execution at Branch_030
Code_002            clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    pshs      d         ; save d on the stack
                    ldd       #23       ; set d to the constant 23
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    leax      >Status,pc ; form the address >Status,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    beq       Branch_031 ; branch when the values are equal or the result is zero; target Branch_031
                    leax      >Editing,pc ; form the address >Editing,pc in x
                    bra       Branch_032 ; continue execution at Branch_032
Branch_031          leax      >Recording,pc ; form the address >Recording,pc in x
Branch_032          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    beq       Branch_033 ; branch when the values are equal or the result is zero; target Branch_033
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >CharDump,pc ; form the address >CharDump,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $04,s     ; adjust the system stack pointer
                    bra       Branch_034 ; continue execution at Branch_034
Branch_033          leax      >Char,pc  ; form the address >Char,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
Branch_034          leax      >Attrs,pc ; form the address >Attrs,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_035 ; branch when the values are equal or the result is zero; target Branch_035
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    bra       Branch_036 ; continue execution at Branch_036
Branch_035          leax      >Text_002,pc ; form the address >Text_002,pc in x
Branch_036          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    anda      #2        ; mask a using #2
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_037 ; branch when the values are equal or the result is zero; target Branch_037
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    bra       Branch_038 ; continue execution at Branch_038
Branch_037          leax      >Text_004,pc ; form the address >Text_004,pc in x
Branch_038          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    anda      #4        ; mask a using #4
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    bra       Branch_040 ; continue execution at Branch_040
Branch_039          leax      >Text_006,pc ; form the address >Text_006,pc in x
Branch_040          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    anda      #8        ; mask a using #8
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    bra       Branch_042 ; continue execution at Branch_042
Branch_041          leax      >Text_008,pc ; form the address >Text_008,pc in x
Branch_042          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    anda      #16       ; mask a using #16
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    bra       Branch_044 ; continue execution at Branch_044
Branch_043          leax      >Text_010,pc ; form the address >Text_010,pc in x
Branch_044          pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    pshs      d         ; save d on the stack
                    ldd       #256      ; set d to the constant 256
                    lbsr      Routine_019 ; call subroutine Routine_019
                    beq       Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    pshs      d         ; save d on the stack
                    ldd       #16       ; set d to the constant 16
                    lbsr      Routine_019 ; call subroutine Routine_019
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_002,y ; form the address >WorkBuffer_002,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    clra                ; clear a to zero and set the condition codes
                    andb      #240      ; mask b using #240
                    pshs      d         ; save d on the stack
                    ldd       #16       ; set d to the constant 16
                    lbsr      Routine_020 ; call subroutine Routine_020
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_002,y ; form the address >WorkBuffer_002,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    leax      >ColorsOn,pc ; form the address >ColorsOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    bra       Branch_046 ; continue execution at Branch_046
Branch_045          leax      >ColorsBW,pc ; form the address >ColorsBW,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
Branch_046          leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      <$0025,s  ; form the address <$0025,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_005,y ; store d at >WorkByte_005,y
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_047 ; continue execution at Branch_047
Branch_048          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #19       ; set d to the constant 19
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #17       ; set d to the constant 17
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #21       ; set d to the constant 21
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Help,pc  ; form the address >Help,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Line,pc  ; form the address >Line,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltG,pc  ; form the address >AltG,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltR,pc  ; form the address >AltR,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltE,pc  ; form the address >AltE,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltC,pc  ; form the address >AltC,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltN,pc  ; form the address >AltN,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltS,pc  ; form the address >AltS,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltA,pc  ; form the address >AltA,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltP,pc  ; form the address >AltP,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltL,pc  ; form the address >AltL,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltK,pc  ; form the address >AltK,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltZ,pc  ; form the address >AltZ,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltX,pc  ; form the address >AltX,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >AltQ,pc  ; form the address >AltQ,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $02,s     ; adjust the system stack pointer
Branch_049          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_022 ; call subroutine Routine_022
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_051          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #18       ; set d to the constant 18
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Sure,pc  ; form the address >Sure,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      <$0025,s  ; form the address <$0025,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Title2,pc ; form the address >Title2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >CpyRite2,pc ; form the address >CpyRite2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >License2,pc ; form the address >License2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Rights2,pc ; form the address >Rights2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      exit      ; call subroutine exit
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_052          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    ldd       #21       ; set d to the constant 21
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >LoadPrompt,pc ; form the address >LoadPrompt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #32       ; set d to the constant 32
                    pshs      d         ; save d on the stack
                    leax      $04,s     ; form the address $04,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      readln    ; call subroutine readln
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       Branch_053 ; branch when the signed value is greater; target Branch_053
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_053          leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_054          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    ldd       #21       ; set d to the constant 21
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SavePrompt,pc ; form the address >SavePrompt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #32       ; set d to the constant 32
                    pshs      d         ; save d on the stack
                    leax      $04,s     ; form the address $04,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      readln    ; call subroutine readln
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       Branch_055 ; branch when the signed value is greater; target Branch_055
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_055          leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_004 ; call subroutine Routine_004
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_056          ldd       #65       ; set d to the constant 65
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #65       ; set d to the constant 65
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_058          ldd       #66       ; set d to the constant 66
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #66       ; set d to the constant 66
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_059          ldd       #68       ; set d to the constant 68
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #68       ; set d to the constant 68
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_060          ldd       #67       ; set d to the constant 67
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #67       ; set d to the constant 67
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_061          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #18       ; set d to the constant 18
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #11       ; set d to the constant 11
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PosSaved,pc ; form the address >PosSaved,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #115      ; set d to the constant 115
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #115      ; set d to the constant 115
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_062          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #18       ; set d to the constant 18
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #11       ; set d to the constant 11
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PosRestrd,pc ; form the address >PosRestrd,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #117      ; set d to the constant 117
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #117      ; set d to the constant 117
                    bra       Branch_057 ; continue execution at Branch_057
Branch_063          ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #74       ; set d to the constant 74
                    bra       Branch_057 ; continue execution at Branch_057
Branch_064          ldd       #107      ; set d to the constant 107
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #107      ; set d to the constant 107
Branch_057          pshs      d         ; save d on the stack
                    lbsr      Routine_025 ; call subroutine Routine_025
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_065          lbsr      Code_003  ; call subroutine Code_003
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_066          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    cmpd      >WorkWord_009,y ; compare d with >WorkWord_009,y and set the condition codes
                    bne       Branch_067 ; branch when the values differ or the result is nonzero; target Branch_067
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    cmpd      >WorkWord_010,y ; compare d with >WorkWord_010,y and set the condition codes
                    lbeq      Branch_068 ; branch when the values are equal or the result is zero; target Branch_068
Branch_067          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      Branch_069 ; branch when the signed value is greater than or equal; target Branch_069
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_020 ; call subroutine Routine_020
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_019 ; call subroutine Routine_019
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_020 ; call subroutine Routine_020
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_019 ; call subroutine Routine_019
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #72       ; set d to the constant 72
                    stb       ,x        ; store b at ,x
                    bra       Branch_068 ; continue execution at Branch_068
Branch_069          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
Branch_068          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_007,y ; store d at >WorkByte_007,y
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    std       >WorkWord_009,y ; store d at >WorkWord_009,y
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    std       >WorkWord_010,y ; store d at >WorkWord_010,y
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_070          ldd       #1        ; set d to the constant 1
                    std       >WorkByte_007,y ; store d at >WorkByte_007,y
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_071          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #30       ; set d to the constant 30
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #28       ; set d to the constant 28
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #11       ; set d to the constant 11
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >MovBuff,pc ; form the address >MovBuff,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    lbsr      Routine_016 ; call subroutine Routine_016
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_072          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      $02,s     ; adjust the system stack pointer
                    leas      <$0024,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_073          ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #30       ; set d to the constant 30
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #8        ; set d to the constant 8
                    pshs      d         ; save d on the stack
                    ldd       #28       ; set d to the constant 28
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Zap,pc   ; form the address >Zap,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >RecBuff,pc ; form the address >RecBuff,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >BothBuffs,pc ; form the address >BothBuffs,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >ScrnChar,pc ; form the address >ScrnChar,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >RecChar,pc ; form the address >RecChar,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Choose,pc ; form the address >Choose,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      <$0024,s  ; form the address <$0024,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    stb       <$0022,s  ; store b in the current stack frame at <$0022,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       <$0023,s  ; store b in the current stack frame at <$0023,s
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    beq       Branch_074 ; branch when the values are equal or the result is zero; target Branch_074
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #82       ; compare b with #82 and set the condition codes
                    beq       Branch_074 ; branch when the values are equal or the result is zero; target Branch_074
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #66       ; compare b with #66 and set the condition codes
                    beq       Branch_074 ; branch when the values are equal or the result is zero; target Branch_074
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #68       ; compare b with #68 and set the condition codes
                    beq       Branch_074 ; branch when the values are equal or the result is zero; target Branch_074
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #84       ; compare b with #84 and set the condition codes
                    bne       Branch_075 ; branch when the values differ or the result is nonzero; target Branch_075
Branch_074          leax      >Sure2,pc ; form the address >Sure2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      <$0025,s  ; form the address <$0025,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
Branch_075          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_076 ; continue execution at Branch_076
Branch_077          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    lbra      Branch_078 ; continue execution at Branch_078
Branch_079          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
Branch_080          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_081          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,x        ; store d at ,x
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_082          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
Branch_078          leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_076          cmpx      #83       ; compare x with #83 and set the condition codes
                    lbeq      Branch_077 ; branch when the values are equal or the result is zero; target Branch_077
                    cmpx      #82       ; compare x with #82 and set the condition codes
                    lbeq      Branch_080 ; branch when the values are equal or the result is zero; target Branch_080
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      Branch_079 ; branch when the values are equal or the result is zero; target Branch_079
                    cmpx      #68       ; compare x with #68 and set the condition codes
                    lbeq      Branch_081 ; branch when the values are equal or the result is zero; target Branch_081
                    cmpx      #84       ; compare x with #84 and set the condition codes
                    beq       Branch_082 ; branch when the values are equal or the result is zero; target Branch_082
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_083          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_005,y ; store d at >WorkByte_005,y
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       Branch_084 ; branch when the signed value is greater than or equal; target Branch_084
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    stb       ,x        ; store b at ,x
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_084          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
Branch_050          leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_047          cmpx      #-81      ; compare x with #-81 and set the condition codes
                    lbeq      Branch_048 ; branch when the values are equal or the result is zero; target Branch_048
                    cmpx      #-15      ; compare x with #-15 and set the condition codes
                    lbeq      Branch_051 ; branch when the values are equal or the result is zero; target Branch_051
                    cmpx      #-20      ; compare x with #-20 and set the condition codes
                    lbeq      Branch_052 ; branch when the values are equal or the result is zero; target Branch_052
                    cmpx      #-21      ; compare x with #-21 and set the condition codes
                    lbeq      Branch_054 ; branch when the values are equal or the result is zero; target Branch_054
                    cmpx      #12       ; compare x with #12 and set the condition codes
                    lbeq      Branch_056 ; branch when the values are equal or the result is zero; target Branch_056
                    cmpx      #10       ; compare x with #10 and set the condition codes
                    lbeq      Branch_058 ; branch when the values are equal or the result is zero; target Branch_058
                    cmpx      #8        ; compare x with #8 and set the condition codes
                    lbeq      Branch_059 ; branch when the values are equal or the result is zero; target Branch_059
                    cmpx      #9        ; compare x with #9 and set the condition codes
                    lbeq      Branch_060 ; branch when the values are equal or the result is zero; target Branch_060
                    cmpx      #-13      ; compare x with #-13 and set the condition codes
                    lbeq      Branch_061 ; branch when the values are equal or the result is zero; target Branch_061
                    cmpx      #-31      ; compare x with #-31 and set the condition codes
                    lbeq      Branch_062 ; branch when the values are equal or the result is zero; target Branch_062
                    cmpx      #-29      ; compare x with #-29 and set the condition codes
                    lbeq      Branch_063 ; branch when the values are equal or the result is zero; target Branch_063
                    cmpx      #-18      ; compare x with #-18 and set the condition codes
                    lbeq      Branch_064 ; branch when the values are equal or the result is zero; target Branch_064
                    cmpx      #-25      ; compare x with #-25 and set the condition codes
                    lbeq      Branch_065 ; branch when the values are equal or the result is zero; target Branch_065
                    cmpx      #-14      ; compare x with #-14 and set the condition codes
                    lbeq      Branch_066 ; branch when the values are equal or the result is zero; target Branch_066
                    cmpx      #-27      ; compare x with #-27 and set the condition codes
                    lbeq      Branch_070 ; branch when the values are equal or the result is zero; target Branch_070
                    cmpx      #-16      ; compare x with #-16 and set the condition codes
                    lbeq      Branch_071 ; branch when the values are equal or the result is zero; target Branch_071
                    cmpx      #-8       ; compare x with #-8 and set the condition codes
                    lbeq      Branch_072 ; branch when the values are equal or the result is zero; target Branch_072
                    cmpx      #-6       ; compare x with #-6 and set the condition codes
                    lbeq      Branch_073 ; branch when the values are equal or the result is zero; target Branch_073
                    lbra      Branch_083 ; continue execution at Branch_083
Branch_030          lbra      Code_002  ; continue execution at Code_002
                    leas      <$0024,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Code_003            pshs      u         ; save u on the stack
                    ldd       #-86      ; set d to the constant -86
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    bne       Branch_085 ; branch when the values differ or the result is nonzero; target Branch_085
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       Branch_086 ; branch when the signed value is greater than or equal; target Branch_086
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       ,x        ; store b at ,x
                    bra       Branch_085 ; continue execution at Branch_085
Branch_086          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
Branch_085          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    lbra      Branch_087 ; continue execution at Branch_087
Branch_088          ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #17       ; set d to the constant 17
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #15       ; set d to the constant 15
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    ldd       #21       ; set d to the constant 21
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SetGraphs,pc ; form the address >SetGraphs,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Line2,pc ; form the address >Line2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >RestGraph,pc ; form the address >RestGraph,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >BoldOn,pc ; form the address >BoldOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >UndrOn,pc ; form the address >UndrOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >BlnkOn,pc ; form the address >BlnkOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >RevVidOn,pc ; form the address >RevVidOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >InvisOn,pc ; form the address >InvisOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SetForClr,pc ; form the address >SetForClr,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SetBckClr,pc ; form the address >SetBckClr,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Done,pc  ; form the address >Done,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SelChoice,pc ; form the address >SelChoice,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_089 ; continue execution at Branch_089
Branch_090          ldd       #48       ; set d to the constant 48
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_092          ldd       #49       ; set d to the constant 49
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldd       #1        ; set d to the constant 1
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_093          ldd       #52       ; set d to the constant 52
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldd       #4        ; set d to the constant 4
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_094          ldd       #53       ; set d to the constant 53
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldd       #5        ; set d to the constant 5
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_095          ldd       #55       ; set d to the constant 55
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldd       #7        ; set d to the constant 7
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_096          ldd       #56       ; set d to the constant 56
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldd       #8        ; set d to the constant 8
                    lbra      Branch_091 ; continue execution at Branch_091
Branch_097          lbsr      Code_004  ; call subroutine Code_004
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #51       ; set d to the constant 51
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    addd      #30       ; add to d using #30
                    bra       Branch_091 ; continue execution at Branch_091
Branch_098          lbsr      Code_004  ; call subroutine Code_004
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #52       ; set d to the constant 52
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    bne       Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    addd      #40       ; add to d using #40
Branch_091          pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_087 ; continue execution at Branch_087
Branch_089          cmpx      #82       ; compare x with #82 and set the condition codes
                    lbeq      Branch_090 ; branch when the values are equal or the result is zero; target Branch_090
                    cmpx      #79       ; compare x with #79 and set the condition codes
                    lbeq      Branch_092 ; branch when the values are equal or the result is zero; target Branch_092
                    cmpx      #85       ; compare x with #85 and set the condition codes
                    lbeq      Branch_093 ; branch when the values are equal or the result is zero; target Branch_093
                    cmpx      #76       ; compare x with #76 and set the condition codes
                    lbeq      Branch_094 ; branch when the values are equal or the result is zero; target Branch_094
                    cmpx      #86       ; compare x with #86 and set the condition codes
                    lbeq      Branch_095 ; branch when the values are equal or the result is zero; target Branch_095
                    cmpx      #73       ; compare x with #73 and set the condition codes
                    lbeq      Branch_096 ; branch when the values are equal or the result is zero; target Branch_096
                    cmpx      #70       ; compare x with #70 and set the condition codes
                    lbeq      Branch_097 ; branch when the values are equal or the result is zero; target Branch_097
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      Branch_098 ; branch when the values are equal or the result is zero; target Branch_098
Branch_087          ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #68       ; compare b with #68 and set the condition codes
                    lbne      Branch_088 ; branch when the values differ or the result is nonzero; target Branch_088
                    ldd       #109      ; set d to the constant 109
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    lbne      Branch_099 ; branch when the values differ or the result is nonzero; target Branch_099
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #109      ; set d to the constant 109
                    stb       ,x        ; store b at ,x
                    lbra      Branch_099 ; continue execution at Branch_099

* -- method --
Code_004            pshs      u         ; save u on the stack
                    ldd       #-87      ; set d to the constant -87
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$03,s    ; adjust the system stack pointer
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #12       ; set d to the constant 12
                    pshs      d         ; save d on the stack
                    ldd       #20       ; set d to the constant 20
                    pshs      d         ; save d on the stack
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #18       ; set d to the constant 18
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #41       ; set d to the constant 41
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_100 ; continue execution at Branch_100
Branch_101          ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    beq       Branch_102 ; branch when the values are equal or the result is zero; target Branch_102
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_001,y ; form the address >WorkBuffer_001,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
Branch_102          ldd       $01,s     ; load d from the current stack frame at $01,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_002,y ; form the address >WorkBuffer_002,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    pshs      d         ; save d on the stack
                    leax      >NumString,pc ; form the address >NumString,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    addd      #1        ; add to d using #1
Branch_100          std       $01,s     ; store d in the current stack frame at $01,s
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    cmpd      #8        ; compare d with #8 and set the condition codes
                    lblt      Branch_101 ; branch when the signed value is less; target Branch_101
                    leax      >ClrNum,pc ; form the address >ClrNum,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    subd      #48       ; subtract from d using #48
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    leas      $03,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_025         pshs      u         ; save u on the stack
                    ldd       #-70      ; set d to the constant -70
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      Branch_103 ; branch when the signed value is greater than or equal; target Branch_103
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       ,x        ; store b at ,x
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    cmpb      #74       ; compare b with #74 and set the condition codes
                    bne       Branch_104 ; branch when the values differ or the result is nonzero; target Branch_104
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #50       ; set d to the constant 50
                    stb       ,x        ; store b at ,x
Branch_104          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       ,x        ; store b at ,x
                    lbra      Branch_105 ; continue execution at Branch_105
Branch_103          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    lbra      Branch_099 ; continue execution at Branch_099

* -- method --
Routine_018         pshs      u         ; save u on the stack
                    ldd       #-76      ; set d to the constant -76
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       >WorkByte_005,y ; load d from >WorkByte_005,y
                    lbeq      Branch_106 ; branch when the values are equal or the result is zero; target Branch_106
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       Branch_107 ; branch when the values are equal or the result is zero; target Branch_107
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_009,y ; form the address >WorkBuffer_009,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    addd      #1        ; add to d using #1
                    std       >WorkByte_003,y ; store d at >WorkByte_003,y
                    subd      #1        ; subtract from d using #1
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    stb       ,x        ; store b at ,x
Branch_107          ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #6        ; mask b using #6
                    lbeq      Branch_108 ; branch when the values are equal or the result is zero; target Branch_108
                    ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    ble       Branch_109 ; branch when the signed value is less than or equal; target Branch_109
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_009,y ; form the address >WorkBuffer_009,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_009,y ; form the address >WorkBuffer_009,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $02,s     ; adjust the system stack pointer
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       Branch_110 ; continue execution at Branch_110
Branch_109          ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       ,x        ; store b at ,x
Branch_110          ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    bgt       Branch_111 ; branch when the signed value is greater; target Branch_111
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #109      ; compare b with #109 and set the condition codes
                    beq       Branch_112 ; branch when the values are equal or the result is zero; target Branch_112
Branch_111          ldd       >dpsiz,y  ; load d from >dpsiz,y
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; store d at >dpsiz,y
Branch_112          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_003,y ; store d at >WorkByte_003,y
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_032 ; call subroutine Routine_032
                    leas      $02,s     ; adjust the system stack pointer
Branch_108          ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #59       ; compare b with #59 and set the condition codes
                    lbne      Branch_099 ; branch when the values differ or the result is nonzero; target Branch_099
                    ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    ble       Branch_113 ; branch when the signed value is less than or equal; target Branch_113
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_009,y ; form the address >WorkBuffer_009,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkByte_003,y ; load d from >WorkByte_003,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_009,y ; form the address >WorkBuffer_009,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $02,s     ; adjust the system stack pointer
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       Branch_114 ; continue execution at Branch_114
Branch_113          ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       ,x        ; store b at ,x
Branch_114          ldd       >dpsiz,y  ; load d from >dpsiz,y
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; store d at >dpsiz,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_003,y ; store d at >WorkByte_003,y
                    lbra      Branch_099 ; continue execution at Branch_099
Branch_106          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_115 ; continue execution at Branch_115
Branch_116          ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    lble      Branch_099 ; branch when the signed value is less than or equal; target Branch_099
                    ldd       #23       ; set d to the constant 23
                    lbra      Branch_117 ; continue execution at Branch_117
Branch_118          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_119 ; continue execution at Branch_119
Branch_120          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_121 ; continue execution at Branch_121
Branch_122          ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    std       ,x        ; store d at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
Branch_121          std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       Branch_122 ; branch when the signed value is less; target Branch_122
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
Branch_119          std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      Branch_120 ; branch when the signed value is less; target Branch_120
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_117 ; continue execution at Branch_117
Branch_123          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    lbra      Branch_099 ; continue execution at Branch_099
Branch_124          ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    bge       Branch_125 ; branch when the signed value is greater than or equal; target Branch_125
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    lbge      Branch_099 ; branch when the signed value is greater than or equal; target Branch_099
Branch_125          ldd       >WorkByte_007,y ; load d from >WorkByte_007,y
                    beq       Branch_126 ; branch when the values are equal or the result is zero; target Branch_126
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    leax      d,x       ; form the address d,x in x
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    std       ,x        ; store d at ,x
Branch_126          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    blt       Branch_099 ; branch when the signed value is less; target Branch_099
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       Branch_099 ; branch when the signed value is less; target Branch_099
                    ldd       #22       ; set d to the constant 22
Branch_117          std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    bra       Branch_099 ; continue execution at Branch_099
Branch_115          cmpx      #10       ; compare x with #10 and set the condition codes
                    lbeq      Branch_116 ; branch when the values are equal or the result is zero; target Branch_116
                    cmpx      #12       ; compare x with #12 and set the condition codes
                    lbeq      Branch_118 ; branch when the values are equal or the result is zero; target Branch_118
                    cmpx      #13       ; compare x with #13 and set the condition codes
                    lbeq      Branch_123 ; branch when the values are equal or the result is zero; target Branch_123
                    lbra      Branch_124 ; continue execution at Branch_124
Branch_099          leas      $02,s     ; adjust the system stack pointer
Branch_105          puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_032         pshs      u         ; save u on the stack
                    ldd       #-79      ; set d to the constant -79
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_005,y ; store d at >WorkByte_005,y
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_127 ; continue execution at Branch_127
Branch_128          ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; save d on the stack
                    ldb       >WorkBuffer_008,y ; load b from >WorkBuffer_008,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       >WorkBuffer_008,y ; load b from >WorkBuffer_008,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_130          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_131 ; continue execution at Branch_131
Branch_132          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_033 ; call subroutine Routine_033
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    bge       Branch_133 ; branch when the signed value is greater than or equal; target Branch_133
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
Branch_133          ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_131          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       Branch_132 ; branch when the signed value is greater; target Branch_132
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_134          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_135 ; continue execution at Branch_135
Branch_136          ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       Branch_137 ; branch when the signed value is less; target Branch_137
                    ldd       #22       ; set d to the constant 22
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    bra       Branch_138 ; continue execution at Branch_138
Branch_137          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_034 ; call subroutine Routine_034
                    leas      $02,s     ; adjust the system stack pointer
Branch_138          ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_135          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       Branch_136 ; branch when the signed value is greater; target Branch_136
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_139          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_140 ; continue execution at Branch_140
Branch_141          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    cmpd      #79       ; compare d with #79 and set the condition codes
                    ble       Branch_142 ; branch when the signed value is less than or equal; target Branch_142
                    ldd       #79       ; set d to the constant 79
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    bra       Branch_143 ; continue execution at Branch_143
Branch_142          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_035 ; call subroutine Routine_035
                    leas      $02,s     ; adjust the system stack pointer
Branch_143          ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_140          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       Branch_141 ; branch when the signed value is greater; target Branch_141
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_144          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_145 ; continue execution at Branch_145
Branch_146          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #-1       ; add to d using #-1
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    bge       Branch_147 ; branch when the signed value is greater than or equal; target Branch_147
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    bra       Branch_148 ; continue execution at Branch_148
Branch_147          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
                    leas      $02,s     ; adjust the system stack pointer
Branch_148          ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_145          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >WorkByte_012,y ; load b from >WorkByte_012,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       Branch_146 ; branch when the signed value is greater; target Branch_146
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_149          ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    std       >WorkWord_011,y ; store d at >WorkWord_011,y
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    std       >WorkWord_012,y ; store d at >WorkWord_012,y
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_150          ldd       >WorkWord_011,y ; load d from >WorkWord_011,y
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    ldd       >WorkWord_012,y ; load d from >WorkWord_012,y
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_151          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_152 ; continue execution at Branch_152
Branch_153          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_154 ; continue execution at Branch_154
Branch_155          ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    std       ,x        ; store d at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    addd      #1        ; add to d using #1
Branch_154          std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       Branch_155 ; branch when the signed value is less; target Branch_155
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    addd      #1        ; add to d using #1
Branch_152          std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      Branch_153 ; branch when the signed value is less; target Branch_153
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_008,y ; store d at >WorkWord_008,y
                    std       >WorkWord_007,y ; store d at >WorkWord_007,y
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_156          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_036 ; call subroutine Routine_036
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_007,y ; load d from >WorkWord_007,y
                    bra       Branch_157 ; continue execution at Branch_157
Branch_158          ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_008,y ; load d from >WorkWord_008,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,x        ; store d at ,x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_157          std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    blt       Branch_158 ; branch when the signed value is less; target Branch_158
                    lbra      Branch_129 ; continue execution at Branch_129
Branch_159          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_160 ; continue execution at Branch_160
Branch_161          ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_162 ; continue execution at Branch_162
Branch_163          ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_037 ; call subroutine Routine_037
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_038 ; call subroutine Routine_038
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_165          ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    ora       #16       ; set selected bits in a using #16
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_166          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_039 ; call subroutine Routine_039
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    ora       #1        ; set selected bits in a using #1
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_167          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_040 ; call subroutine Routine_040
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    ora       #2        ; set selected bits in a using #2
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_168          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    ora       #4        ; set selected bits in a using #4
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_169          ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_001,y ; form the address >WorkBuffer_001,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    ora       #8        ; set selected bits in a using #8
                    lbra      Branch_164 ; continue execution at Branch_164
Branch_170          ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    cmpb      #30       ; compare b with #30 and set the condition codes
                    lblt      Branch_171 ; branch when the signed value is less; target Branch_171
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    cmpb      #38       ; compare b with #38 and set the condition codes
                    bge       Branch_171 ; branch when the signed value is greater than or equal; target Branch_171
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    addd      #-30      ; add to d using #-30
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_001,y ; form the address >WorkBuffer_001,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_026 ; call subroutine Routine_026
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    andb      #15       ; mask b using #15
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    addd      #-30      ; add to d using #-30
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    lbra      Branch_172 ; continue execution at Branch_172
Branch_171          ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    cmpb      #40       ; compare b with #40 and set the condition codes
                    lblt      Branch_173 ; branch when the signed value is less; target Branch_173
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    lbge      Branch_173 ; branch when the signed value is greater than or equal; target Branch_173
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >WorkBuffer_001,y ; form the address >WorkBuffer_001,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >WorkByte_009,y ; load d from >WorkByte_009,y
                    andb      #240      ; mask b using #240
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
Branch_172          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
Branch_164          std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    bra       Branch_173 ; continue execution at Branch_173
Branch_162          stx       -$02,s    ; store x in the current stack frame at -$02,s
                    lbeq      Branch_163 ; branch when the values are equal or the result is zero; target Branch_163
                    cmpx      #1        ; compare x with #1 and set the condition codes
                    lbeq      Branch_165 ; branch when the values are equal or the result is zero; target Branch_165
                    cmpx      #4        ; compare x with #4 and set the condition codes
                    lbeq      Branch_166 ; branch when the values are equal or the result is zero; target Branch_166
                    cmpx      #5        ; compare x with #5 and set the condition codes
                    lbeq      Branch_167 ; branch when the values are equal or the result is zero; target Branch_167
                    cmpx      #7        ; compare x with #7 and set the condition codes
                    lbeq      Branch_168 ; branch when the values are equal or the result is zero; target Branch_168
                    cmpx      #8        ; compare x with #8 and set the condition codes
                    lbeq      Branch_169 ; branch when the values are equal or the result is zero; target Branch_169
                    lbra      Branch_170 ; continue execution at Branch_170
Branch_173          ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
Branch_160          std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      >dpsiz,y  ; compare d with >dpsiz,y and set the condition codes
                    lblt      Branch_161 ; branch when the signed value is less; target Branch_161
                    bra       Branch_129 ; continue execution at Branch_129
Branch_127          cmpx      #72       ; compare x with #72 and set the condition codes
                    lbeq      Branch_128 ; branch when the values are equal or the result is zero; target Branch_128
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_128 ; branch when the values are equal or the result is zero; target Branch_128
                    cmpx      #65       ; compare x with #65 and set the condition codes
                    lbeq      Branch_130 ; branch when the values are equal or the result is zero; target Branch_130
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      Branch_134 ; branch when the values are equal or the result is zero; target Branch_134
                    cmpx      #67       ; compare x with #67 and set the condition codes
                    lbeq      Branch_139 ; branch when the values are equal or the result is zero; target Branch_139
                    cmpx      #68       ; compare x with #68 and set the condition codes
                    lbeq      Branch_144 ; branch when the values are equal or the result is zero; target Branch_144
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_149 ; branch when the values are equal or the result is zero; target Branch_149
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_150 ; branch when the values are equal or the result is zero; target Branch_150
                    cmpx      #74       ; compare x with #74 and set the condition codes
                    lbeq      Branch_151 ; branch when the values are equal or the result is zero; target Branch_151
                    cmpx      #107      ; compare x with #107 and set the condition codes
                    lbeq      Branch_156 ; branch when the values are equal or the result is zero; target Branch_156
                    cmpx      #109      ; compare x with #109 and set the condition codes
                    lbeq      Branch_159 ; branch when the values are equal or the result is zero; target Branch_159
Branch_129          bsr       Routine_014 ; call subroutine Routine_014
                    leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_014         pshs      u         ; save u on the stack
                    ldd       #-66      ; set d to the constant -66
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_174 ; continue execution at Branch_174
Branch_175          ldd       ,s        ; load d from the current stack frame at ,s
                    leax      >WorkByte_012,y ; form the address >WorkByte_012,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       ,x        ; store b at ,x
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
Branch_174          std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       Branch_175 ; branch when the signed value is less; target Branch_175
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >dpsiz,y  ; store d at >dpsiz,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkByte_003,y ; store d at >WorkByte_003,y
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_016         pshs      u         ; save u on the stack
                    ldd       #-80      ; set d to the constant -80
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$08,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_176 ; continue execution at Branch_176
Branch_177          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_178 ; continue execution at Branch_178
Branch_179          ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    lbeq      Branch_180 ; branch when the values are equal or the result is zero; target Branch_180
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      $06,s     ; compare d with $06,s and set the condition codes
                    bne       Branch_181 ; branch when the values differ or the result is nonzero; target Branch_181
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      $04,s     ; compare d with $04,s and set the condition codes
                    lbeq      Branch_182 ; branch when the values are equal or the result is zero; target Branch_182
Branch_181          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      Branch_183 ; branch when the signed value is greater than or equal; target Branch_183
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       ,x        ; store b at ,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       Branch_184 ; branch when the signed value is less; target Branch_184
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_020 ; call subroutine Routine_020
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
Branch_184          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_019 ; call subroutine Routine_019
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       ,x        ; store b at ,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       Branch_185 ; branch when the signed value is less; target Branch_185
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_020 ; call subroutine Routine_020
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
Branch_185          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_019 ; call subroutine Routine_019
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #72       ; set d to the constant 72
                    stb       ,x        ; store b at ,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_182 ; continue execution at Branch_182
Branch_183          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
Branch_182          ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       ,x        ; load d from ,x
                    cmpd      >WorkByte_009,y ; compare d with >WorkByte_009,y and set the condition codes
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_041 ; call subroutine Routine_041
                    leas      $02,s     ; adjust the system stack pointer
Branch_186          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #1        ; add to d using #1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #79       ; compare d with #79 and set the condition codes
                    ble       Branch_180 ; branch when the signed value is less than or equal; target Branch_180
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #22       ; compare d with #22 and set the condition codes
                    ble       Branch_187 ; branch when the signed value is less than or equal; target Branch_187
                    ldd       #22       ; set d to the constant 22
                    std       ,s        ; store d in the current stack frame at ,s
Branch_187          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_180          ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_011,y ; form the address >WorkBuffer_011,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leax      >WorkBuffer_012,y ; form the address >WorkBuffer_012,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,x        ; store d at ,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
Branch_178          std       $06,s     ; store d in the current stack frame at $06,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      Branch_179 ; branch when the signed value is less; target Branch_179
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #1        ; add to d using #1
Branch_176          std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    lblt      Branch_177 ; branch when the signed value is less; target Branch_177
                    leas      $08,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_041         pshs      u         ; save u on the stack
                    ldd       #-70      ; set d to the constant -70
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       Branch_188 ; branch when the signed value is greater than or equal; target Branch_188
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       ,x        ; store b at ,x
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       ,x        ; store b at ,x
                    bra       Branch_189 ; continue execution at Branch_189
Branch_188          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
Branch_189          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #16       ; mask a using #16
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_190 ; branch when the values are equal or the result is zero; target Branch_190
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_190          ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_191 ; branch when the values are equal or the result is zero; target Branch_191
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_191          ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #2        ; mask a using #2
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_192 ; branch when the values are equal or the result is zero; target Branch_192
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_192          ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #4        ; mask a using #4
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_193 ; branch when the values are equal or the result is zero; target Branch_193
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_193          ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #240      ; mask b using #240
                    beq       Branch_194 ; branch when the values are equal or the result is zero; target Branch_194
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #240      ; mask b using #240
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    addd      #30       ; add to d using #30
                    pshs      d         ; save d on the stack
                    bsr       Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_194          ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    beq       Branch_195 ; branch when the values are equal or the result is zero; target Branch_195
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    addd      #40       ; add to d using #40
                    pshs      d         ; save d on the stack
                    bsr       Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
Branch_195          ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >WorkByte_009,y ; store d at >WorkByte_009,y
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #-1       ; add to d using #-1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #109      ; set d to the constant 109
                    stb       ,x        ; store b at ,x
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_029         pshs      u         ; save u on the stack
                    ldd       #-72      ; set d to the constant -72
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      Branch_196 ; branch when the signed value is greater than or equal; target Branch_196
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       Branch_197 ; branch when the signed value is less; target Branch_197
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_020 ; call subroutine Routine_020
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
Branch_197          ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_019 ; call subroutine Routine_019
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >WorkWord_002,y ; load d from >WorkWord_002,y
                    addd      #1        ; add to d using #1
                    std       >WorkWord_002,y ; store d at >WorkWord_002,y
                    subd      #1        ; subtract from d using #1
                    leax      >WorkBuffer_010,y ; form the address >WorkBuffer_010,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       ,x        ; store b at ,x
                    bra       Branch_198 ; continue execution at Branch_198
Branch_196          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $02,s     ; adjust the system stack pointer
Branch_198          puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_006         pshs      u         ; save u on the stack
                    ldd       #-106     ; set d to the constant -106
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_042 ; call subroutine Routine_042
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       <$0025,s  ; load b from the current stack frame at <$0025,s
                    stb       $04,s     ; store b in the current stack frame at $04,s
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_043 ; call subroutine Routine_043
                    leas      $06,s     ; adjust the system stack pointer
                    leas      <$0020,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
Routine_015         pshs      u         ; save u on the stack
                    ldd       #-85      ; set d to the constant -85
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$01,s    ; adjust the system stack pointer
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #6        ; set d to the constant 6
                    pshs      d         ; save d on the stack
                    ldd       #40       ; set d to the constant 40
                    pshs      d         ; save d on the stack
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #38       ; set d to the constant 38
                    pshs      d         ; save d on the stack
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    ldd       #11       ; set d to the constant 11
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_007 ; call subroutine Routine_007
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_044 ; call subroutine Routine_044
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #2        ; set d to the constant 2
                    lbsr      Routine_020 ; call subroutine Routine_020
                    pshs      d         ; save d on the stack
                    ldd       #19       ; set d to the constant 19
                    subd      ,s++      ; subtract from d using ,s++
                    pshs      d         ; save d on the stack
                    leax      >Spaces,pc ; form the address >Spaces,pc in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    leax      >String,pc ; form the address >String,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $07,s     ; load d from the current stack frame at $07,s
                    pshs      d         ; save d on the stack
                    leax      >ErrNum,pc ; form the address >ErrNum,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leas      $01,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcc       "Black" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Red" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Green" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Yellow" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Blue" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Magenta" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "Cyan" ; store literal character data
                    fcb       $00       ; store byte data
                    fcc       "White" ; store literal character data
                    fcb       $00       ; store byte data
savprmpt            fcb       $0D       ; store byte data
                    fcc       " Filename to save:" ; store literal character data
                    fcb       $00       ; store byte data
Title               fcc       "Ansi Graphic" ; store literal character data
                    fcb       $7F       ; store byte data
                    fcc       " Editor, Version 1.0      " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Copyright           fcc       "Copyright (c) 1989, By Keith Alphonso  " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
License             fcc       "Licensed to Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Rights              fcc       "All rights reserved                    " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
CantOpen1           fcc       "Cannot open output file" ; store literal character data
                    fcb       $00       ; store byte data
PutScrn             fcb       $0D       ; store byte data
                    fcc       "Put Screen into Buffer?" ; store literal character data
                    fcb       $00       ; store byte data
ClrScrn             fcb       $0D       ; store byte data
                    fcc       "Start with clear screen?" ; store literal character data
                    fcb       $00       ; store byte data
CantOpen2           fcc       "Cannot open file" ; store literal character data
                    fcb       $00       ; store byte data
ReadFile            fcb       $0D       ; store byte data
                    fcc       "Read file to [O]utput buffer or [S]creen buffer" ; store literal character data
                    fcb       $00       ; store byte data
AddLf               fcb       $0D       ; store byte data
                    fcc       "Add line feeds to carriage returns?" ; store literal character data
                    fcb       $00       ; store byte data
Status              fcc       "X=%2d Y=%2d   Status:" ; store literal character data
                    fcb       $00       ; store byte data
Editing             fcc       "EDITING  " ; store literal character data
                    fcb       $00       ; store byte data
Recording           fcc       "RECORDING" ; store literal character data
                    fcb       $00       ; store byte data
CharDump            fcc       "  Char:%1c" ; store literal character data
                    fcb       $00       ; store byte data
Char                fcc       "  Char: " ; store literal character data
                    fcb       $00       ; store byte data
Attrs               fcc       "  Attrs:" ; store literal character data
                    fcb       $00       ; store byte data
Text_001            fcc       "U" ; store literal character data
                    fcb       $00       ; store byte data
Text_002            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
Text_003            fcc       "L" ; store literal character data
                    fcb       $00       ; store byte data
Text_004            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
Text_005            fcc       "V" ; store literal character data
                    fcb       $00       ; store byte data
Text_006            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
Text_007            fcc       "I" ; store literal character data
                    fcb       $00       ; store byte data
Text_008            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
Text_009            fcc       "O" ; store literal character data
                    fcb       $00       ; store byte data
Text_010            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
ColorsOn            fcc       " Colors:%7s on %7s" ; store literal character data
                    fcb       $00       ; store byte data
ColorsBW            fcc       " Colors:White   on Black  " ; store literal character data
                    fcb       $00       ; store byte data
Help                fcc       "           Ansi-Editor  Help" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Line                fcc       "--------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltG                fcc       " [ALT][G] - Set graphics" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltR                fcc       " [ALT][R] - Record mode" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltE                fcc       " [ALT][E] - Edit mode" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltC                fcc       " [ALT][C] - Clear screen" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltN                fcc       " [ALT][N] - Clear to end of line" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltS                fcc       " [ALT][S] - Save cursor position" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltA                fcc       " [ALT][A] - Restore cursor position" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltP                fcc       " [ALT][P] - Put screen into buffer" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltL                fcc       " [ALT][L] - Load from file" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltK                fcc       " [ALT][K] - Save to file" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltZ                fcc       " [ALT][Z] - Zap buffers" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltX                fcc       " [ALT][X] - Save & Exit" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltQ                fcc       " [ALT][Q] - Quit without save" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Sure                fcb       $0D       ; store byte data
                    fcc       "  Are you sure?" ; store literal character data
                    fcb       $00       ; store byte data
Title2              fcc       "ANSI Graphics Editor, Version 1.0      " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
CpyRite2            fcc       "Copyright (c) 1989, By Keith Alphonso  " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
License2            fcc       "Licensed to Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Rights2             fcc       "All rights reserved                    " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
LoadPrompt          fcb       $0D       ; store byte data
                    fcc       " Filename to load:" ; store literal character data
                    fcb       $00       ; store byte data
SavePrompt          fcb       $0D       ; store byte data
                    fcc       " Filename to save:" ; store literal character data
                    fcb       $00       ; store byte data
PosSaved            fcb       $0D       ; store byte data
                    fcc       "Position Saved!!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
PosRestrd           fcb       $0D       ; store byte data
                    fcc       "Position Restored" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
MovBuff             fcb       $0D       ; store byte data
                    fcc       " Moving screen buffer..." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Zap                 fcb       $0D       ; store byte data
                    fcc       "Zap:   S> Screen Buffer" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
RecBuff             fcc       "       R> Record Buffer" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
BothBuffs           fcc       "       B> Both   buffers" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
ScrnChar            fcc       "       D> Screen Character" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
RecChar             fcc       "       T> Record Character" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Choose              fcc       "Your Choice:" ; store literal character data
                    fcb       $00       ; store byte data
Sure2               fcb       $0C       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "     Are you sure?" ; store literal character data
                    fcb       $00       ; store byte data
Text_011            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
Text_012            fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
SetGraphs           fcc       "             Set  Graphics" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Line2               fcc       "           -----------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
RestGraph           fcc       "[R] - Reset Graphics (white on black)" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
BoldOn              fcc       "[O] - Bold on" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
UndrOn              fcc       "[U] - Underscore on" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
BlnkOn              fcc       "[L] - Blink on" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
RevVidOn            fcc       "[V] - Reverse Video on" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
InvisOn             fcc       "[I] - Invisible on" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
SetForClr           fcc       "[F] - Set foreground color" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
SetBckClr           fcc       "[B] - Set background color" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Done                fcc       "[D] - Done" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
SelChoice           fcb       $0D       ; store byte data
                    fcc       "Select your choice:" ; store literal character data
                    fcb       $00       ; store byte data
NumString           fcc       "%1d: %s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
ClrNum              fcb       $0D       ; store byte data
                    fcc       "Color #:" ; store literal character data
                    fcb       $00       ; store byte data
Spaces              fcc       "                    " ; store literal character data
                    fcb       $00       ; store byte data
String              fcc       "%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
ErrNum              fcb       $0D       ; store byte data
                    fcc       "               ERROR %03d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
printf              pshs      u         ; save u on the stack
                    leax      >WorkBuffer_005,y ; form the address >WorkBuffer_005,y in x
                    stx       >WorkWord_013,y ; store x at >WorkWord_013,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       Branch_199 ; continue execution at Branch_199
                    pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >WorkWord_013,y ; store d at >WorkWord_013,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
Branch_199          pshs      d         ; save d on the stack
                    leax      >Code_005,pc ; form the address >Code_005,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_045 ; call subroutine Routine_045
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >WorkWord_013,y ; store d at >WorkWord_013,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    leax      >Code_006,pc ; form the address >Code_006,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_045 ; call subroutine Routine_045
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [>$37B5,y] ; store b at [>$37B5,y]
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_045         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       Branch_200 ; continue execution at Branch_200
Branch_201          ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      Branch_202 ; branch when the values are equal or the result is zero; target Branch_202
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_200          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       Branch_201 ; branch when the values differ or the result is nonzero; target Branch_201
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_203 ; branch when the values differ or the result is nonzero; target Branch_203
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_014,y ; store d at >WorkWord_014,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_204 ; continue execution at Branch_204
Branch_203          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >WorkWord_014,y ; store d at >WorkWord_014,y
Branch_204          ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       Branch_205 ; branch when the values differ or the result is nonzero; target Branch_205
                    ldd       #48       ; set d to the constant 48
                    bra       Branch_206 ; continue execution at Branch_206
Branch_205          ldd       #32       ; set d to the constant 32
Branch_206          std       >WorkWord_015,y ; store d at >WorkWord_015,y
                    bra       Branch_207 ; continue execution at Branch_207
Branch_208          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_013 ; call subroutine Routine_013
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
Branch_207          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_208 ; branch when the values differ or the result is nonzero; target Branch_208
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       Branch_209 ; branch when the values differ or the result is nonzero; target Branch_209
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_210 ; continue execution at Branch_210
Branch_211          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_013 ; call subroutine Routine_013
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_210          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_211 ; branch when the values differ or the result is nonzero; target Branch_211
                    bra       Branch_212 ; continue execution at Branch_212
Branch_209          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_212          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_213 ; continue execution at Branch_213
Branch_214          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_046 ; call subroutine Routine_046
                    bra       Branch_215 ; continue execution at Branch_215
Branch_216          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_047 ; call subroutine Routine_047
Branch_215          std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_217 ; continue execution at Branch_217
Branch_218          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
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
                    lbsr      Routine_048 ; call subroutine Routine_048
                    lbra      Branch_219 ; continue execution at Branch_219
Branch_220          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_049 ; call subroutine Routine_049
                    lbra      Branch_219 ; continue execution at Branch_219
Branch_221          ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       Branch_222 ; branch when the values differ or the result is nonzero; target Branch_222
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_222          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_050 ; call subroutine Routine_050
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_223 ; continue execution at Branch_223
Branch_224          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      Branch_225 ; continue execution at Branch_225
Branch_226          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_227 ; branch when the values are equal or the result is zero; target Branch_227
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_228 ; continue execution at Branch_228
Branch_229          ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       Branch_230 ; branch when the values are equal or the result is zero; target Branch_230
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
Branch_228          ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_229 ; branch when the values differ or the result is nonzero; target Branch_229
Branch_230          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_051 ; call subroutine Routine_051
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_231 ; continue execution at Branch_231
Branch_227          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       Branch_223 ; continue execution at Branch_223
Branch_232          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_233 ; continue execution at Branch_233
                    leas      -$0B,x    ; adjust the system stack pointer
Branch_233          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_052 ; call subroutine Routine_052
Branch_219          leas      $04,s     ; adjust the system stack pointer
Branch_223          pshs      d         ; save d on the stack
Branch_217          ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_053 ; call subroutine Routine_053
                    leas      $06,s     ; adjust the system stack pointer
Branch_231          lbra      Branch_200 ; continue execution at Branch_200
Branch_234          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
Branch_225          pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_200 ; continue execution at Branch_200
Branch_213          cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      Branch_214 ; branch when the values are equal or the result is zero; target Branch_214
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_216 ; branch when the values are equal or the result is zero; target Branch_216
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_218 ; branch when the values are equal or the result is zero; target Branch_218
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      Branch_218 ; branch when the values are equal or the result is zero; target Branch_218
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_220 ; branch when the values are equal or the result is zero; target Branch_220
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      Branch_224 ; branch when the values are equal or the result is zero; target Branch_224
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_226 ; branch when the values are equal or the result is zero; target Branch_226
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      Branch_232 ; branch when the values are equal or the result is zero; target Branch_232
                    bra       Branch_234 ; continue execution at Branch_234
Branch_202          leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_046         pshs      u,d       ; save u,d on the stack
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       Branch_235 ; branch when the signed value is greater than or equal; target Branch_235
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       Branch_236 ; branch when the signed value is greater than or equal; target Branch_236
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    pshs      x         ; save x on the stack
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_009 ; call subroutine Routine_009
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_237 ; continue execution at Branch_237
Branch_236          ldd       #45       ; set d to the constant 45
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_235          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       Routine_049 ; call subroutine Routine_049
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_238 ; continue execution at Branch_238
Routine_049         pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_239 ; continue execution at Branch_239
Branch_240          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >WorkBuffer_003,y ; subtract from d using >WorkBuffer_003,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
Branch_239          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       Branch_240 ; branch when the signed value is less; target Branch_240
                    leax      >WorkBuffer_003,y ; form the address >WorkBuffer_003,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       Branch_241 ; continue execution at Branch_241
Branch_242          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_243          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       Branch_242 ; branch when the signed value is greater than or equal; target Branch_242
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    beq       Branch_244 ; branch when the values are equal or the result is zero; target Branch_244
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_244          ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_245 ; branch when the values are equal or the result is zero; target Branch_245
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
Branch_245          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_241          ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >WorkWord_003,y ; compare d with >WorkWord_003,y and set the condition codes
                    bne       Branch_243 ; branch when the values differ or the result is nonzero; target Branch_243
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       WorkByte_001,u ; store b at WorkByte_001,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_047         pshs      u,d       ; save u,d on the stack
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >WorkBuffer_014,y ; form the workspace or data address >WorkBuffer_014,y in u
Branch_246          ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       Branch_246 ; branch when the values differ or the result is nonzero; target Branch_246
                    bra       Branch_247 ; continue execution at Branch_247
Branch_248          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_247          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >WorkBuffer_014,y ; form the address >WorkBuffer_014,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_248 ; branch when the unsigned value is lower or equal; target Branch_248
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
Branch_238          leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    tfr       x,d       ; copy the register values specified by x,d
Branch_237          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_048         pshs      u,x,d     ; save u,x,d on the stack
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >WorkBuffer_014,y ; form the workspace or data address >WorkBuffer_014,y in u
Branch_249          ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       Branch_250 ; branch when the signed value is less than or equal; target Branch_250
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       Branch_251 ; branch when the values are equal or the result is zero; target Branch_251
                    ldd       #65       ; set d to the constant 65
                    bra       Branch_252 ; continue execution at Branch_252
Branch_251          ldd       #97       ; set d to the constant 97
Branch_252          addd      #-10      ; add to d using #-10
                    bra       Branch_253 ; continue execution at Branch_253
Branch_250          ldd       #48       ; set d to the constant 48
Branch_253          addd      ,s++      ; add to d using ,s++
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
                    bne       Branch_249 ; branch when the values differ or the result is nonzero; target Branch_249
                    bra       Branch_254 ; continue execution at Branch_254
Branch_255          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
Branch_254          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >WorkBuffer_014,y ; form the address >WorkBuffer_014,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_255 ; branch when the unsigned value is lower or equal; target Branch_255
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >WorkBuffer_013,y ; form the address >WorkBuffer_013,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      Branch_256 ; continue execution at Branch_256
Routine_051         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >WorkWord_014,y ; load d from >WorkWord_014,y
                    bne       Branch_257 ; branch when the values differ or the result is nonzero; target Branch_257
                    bra       Branch_258 ; continue execution at Branch_258
Branch_259          ldd       >WorkWord_015,y ; load d from >WorkWord_015,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_258          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_259 ; branch when the signed value is greater; target Branch_259
                    bra       Branch_257 ; continue execution at Branch_257
Branch_260          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_257          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_260 ; branch when the values differ or the result is nonzero; target Branch_260
                    ldd       >WorkWord_014,y ; load d from >WorkWord_014,y
                    beq       Branch_261 ; branch when the values are equal or the result is zero; target Branch_261
                    bra       Branch_262 ; continue execution at Branch_262
Branch_263          ldd       >WorkWord_015,y ; load d from >WorkWord_015,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_262          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_263 ; branch when the signed value is greater; target Branch_263
Branch_261          puls      pc,u      ; restore pc,u and return to the caller
Routine_053         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_044 ; call subroutine Routine_044
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >WorkWord_014,y ; load d from >WorkWord_014,y
                    bne       Branch_264 ; branch when the values differ or the result is nonzero; target Branch_264
                    bra       Branch_265 ; continue execution at Branch_265
Branch_266          ldd       >WorkWord_015,y ; load d from >WorkWord_015,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_265          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_266 ; branch when the signed value is greater; target Branch_266
                    bra       Branch_264 ; continue execution at Branch_264
Branch_267          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_264          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    bne       Branch_267 ; branch when the values differ or the result is nonzero; target Branch_267
                    ldd       >WorkWord_014,y ; load d from >WorkWord_014,y
                    beq       Branch_268 ; branch when the values are equal or the result is zero; target Branch_268
                    bra       Branch_269 ; continue execution at Branch_269
Branch_270          ldd       >WorkWord_015,y ; load d from >WorkWord_015,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_269          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_270 ; branch when the signed value is greater; target Branch_270
Branch_268          puls      pc,u      ; restore pc,u and return to the caller
Code_005            pshs      u         ; save u on the stack
                    ldd       >WorkWord_013,y ; load d from >WorkWord_013,y
                    pshs      d         ; save d on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_054 ; call subroutine Routine_054
Branch_256          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Code_006            pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    ldx       >WorkWord_013,y ; load x from >WorkWord_013,y
                    leax      $01,x     ; form the address $01,x in x
                    stx       >WorkWord_013,y ; store x at >WorkWord_013,y
                    stb       -$01,x    ; store b at -$01,x
                    puls      pc,u      ; restore pc,u and return to the caller
Text_013            fcc       "-32768" ; store literal character data
                    fcb       $00       ; store byte data
Routine_054         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    anda      #128      ; mask a using #128
                    andb      #34       ; mask b using #34
                    cmpd      #-32766   ; compare d with #-32766 and set the condition codes
                    beq       Branch_271 ; branch when the values are equal or the result is zero; target Branch_271
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    lbne      Branch_272 ; branch when the values differ or the result is nonzero; target Branch_272
                    pshs      u         ; save u on the stack
                    lbsr      Routine_055 ; call subroutine Routine_055
                    leas      $02,s     ; adjust the system stack pointer
Branch_271          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #4        ; mask b using #4
                    beq       Branch_273 ; branch when the values are equal or the result is zero; target Branch_273
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_274 ; branch when the values are equal or the result is zero; target Branch_274
                    leax      >writln,pc ; form the address >writln,pc in x
                    bra       Branch_275 ; continue execution at Branch_275
Branch_274          leax      >write,pc ; form the address >write,pc in x
Branch_275          tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       ,x        ; call subroutine ,x
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_276 ; branch when the values differ or the result is nonzero; target Branch_276
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    orb       #32       ; set selected bits in b using #32
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    lbra      Branch_272 ; continue execution at Branch_272
Branch_273          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_277 ; branch when the values differ or the result is nonzero; target Branch_277
                    pshs      u         ; save u on the stack
                    lbsr      Routine_056 ; call subroutine Routine_056
                    leas      $02,s     ; adjust the system stack pointer
Branch_277          ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    stb       ,x        ; store b at ,x
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkByte_004,u ; compare d with WorkByte_004,u and set the condition codes
                    bcc       Branch_278 ; branch when carry is clear; target Branch_278
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_276 ; branch when the values are equal or the result is zero; target Branch_276
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #13       ; compare d with #13 and set the condition codes
                    bne       Branch_276 ; branch when the values differ or the result is nonzero; target Branch_276
Branch_278          pshs      u         ; save u on the stack
                    lbsr      Routine_056 ; call subroutine Routine_056
                    std       ,s++      ; store d in the current stack frame at ,s++
                    lbne      Branch_272 ; branch when the values differ or the result is nonzero; target Branch_272
Branch_276          ldd       $04,s     ; load d from the current stack frame at $04,s
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    ldd       #8        ; set d to the constant 8
                    lbsr      Routine_057 ; call subroutine Routine_057
                    pshs      d         ; save d on the stack
                    lbsr      Routine_054 ; call subroutine Routine_054
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_054 ; call subroutine Routine_054
                    lbra      Branch_279 ; continue execution at Branch_279
Routine_058         pshs      u,d       ; save u,d on the stack
                    leau      >WorkBuffer_004,y ; form the workspace or data address >WorkBuffer_004,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_280 ; continue execution at Branch_280
Branch_281          tfr       u,d       ; copy the register values specified by u,d
                    leau      WorkWord_002,u ; form the workspace or data address WorkWord_002,u in u
                    pshs      d         ; save d on the stack
                    bsr       Routine_059 ; call subroutine Routine_059
                    leas      $02,s     ; adjust the system stack pointer
Branch_280          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       Branch_281 ; branch when the signed value is less; target Branch_281
                    lbra      Branch_282 ; continue execution at Branch_282
Routine_059         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       Branch_283 ; branch when the values are equal or the result is zero; target Branch_283
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bne       Branch_284 ; branch when the values differ or the result is nonzero; target Branch_284
Branch_283          ldd       #-1       ; set d to the constant -1
                    lbra      Branch_282 ; continue execution at Branch_282
Branch_284          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       Branch_285 ; branch when the values are equal or the result is zero; target Branch_285
                    pshs      u         ; save u on the stack
                    bsr       Routine_008 ; call subroutine Routine_008
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_286 ; continue execution at Branch_286
Branch_285          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_286          std       ,s        ; store d in the current stack frame at ,s
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bra       Branch_282 ; continue execution at Branch_282
Routine_008         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_272 ; branch when the values are equal or the result is zero; target Branch_272
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_287 ; branch when the values are equal or the result is zero; target Branch_287
Branch_272          ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_287          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_288 ; branch when the values differ or the result is nonzero; target Branch_288
                    pshs      u         ; save u on the stack
                    lbsr      Routine_055 ; call subroutine Routine_055
                    leas      $02,s     ; adjust the system stack pointer
Branch_288          pshs      u         ; save u on the stack
                    bsr       Routine_056 ; call subroutine Routine_056
Branch_282          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_056         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_289 ; branch when the values differ or the result is nonzero; target Branch_289
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkByte_004,u ; compare d with WorkByte_004,u and set the condition codes
                    beq       Branch_289 ; branch when the values are equal or the result is zero; target Branch_289
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_060 ; call subroutine Routine_060
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_061 ; call subroutine Routine_061
                    leas      $08,s     ; adjust the system stack pointer
Branch_289          ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    subd      WorkByte_002,u ; subtract from d using WorkByte_002,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      Branch_290 ; branch when the values are equal or the result is zero; target Branch_290
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      Branch_290 ; branch when the values are equal or the result is zero; target Branch_290
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_291 ; branch when the values are equal or the result is zero; target Branch_291
                    ldd       WorkByte_002,u ; load d from WorkByte_002,u
                    bra       Branch_292 ; continue execution at Branch_292
Branch_293          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    lbsr      writln    ; call subroutine writln
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_294 ; branch when the values differ or the result is nonzero; target Branch_294
                    leax      $04,s     ; form the address $04,s in x
                    bra       Branch_295 ; continue execution at Branch_295
Branch_294          ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      ,s        ; subtract from d using ,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      ,s        ; add to d using ,s
Branch_292          std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       Branch_293 ; branch when the values differ or the result is nonzero; target Branch_293
                    bra       Branch_290 ; continue execution at Branch_290
Branch_291          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_002,u ; load d from WorkByte_002,u
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       Branch_290 ; branch when the values are equal or the result is zero; target Branch_290
                    bra       Branch_296 ; continue execution at Branch_296
Branch_295          leas      -$04,x    ; adjust the system stack pointer
Branch_296          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    orb       #32       ; set selected bits in b using #32
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       #-1       ; set d to the constant -1
                    bra       Branch_279 ; continue execution at Branch_279
Branch_290          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    ora       #1        ; set selected bits in a using #1
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    ldd       WorkByte_002,u ; load d from WorkByte_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_279          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_060         pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_055         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       Branch_297 ; branch when the values differ or the result is nonzero; target Branch_297
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_042 ; call subroutine Routine_042
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       Branch_298 ; branch when the values differ or the result is nonzero; target Branch_298
                    ldd       #64       ; set d to the constant 64
                    bra       Branch_299 ; continue execution at Branch_299
Branch_298          ldd       #128      ; set d to the constant 128
Branch_299          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    leas      <$0020,s  ; adjust the system stack pointer
Branch_297          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    ora       #128      ; set selected bits in a using #128
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       Branch_300 ; branch when the values are equal or the result is zero; target Branch_300
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_300          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bne       Branch_301 ; branch when the values differ or the result is nonzero; target Branch_301
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_302 ; branch when the values are equal or the result is zero; target Branch_302
                    ldd       #128      ; set d to the constant 128
                    bra       Branch_303 ; continue execution at Branch_303
Branch_302          ldd       #256      ; set d to the constant 256
Branch_303          std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_301          ldd       WorkByte_002,u ; load d from WorkByte_002,u
                    bne       Branch_304 ; branch when the values differ or the result is nonzero; target Branch_304
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_062 ; call subroutine Routine_062
                    leas      $02,s     ; adjust the system stack pointer
                    std       WorkByte_002,u ; store d at WorkByte_002,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_305 ; branch when the values are equal or the result is zero; target Branch_305
Branch_304          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    orb       #8        ; set selected bits in b using #8
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    bra       Branch_306 ; continue execution at Branch_306
Branch_305          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    orb       #4        ; set selected bits in b using #4
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    leax      WorkByte_010,u ; form the address WorkByte_010,u in x
                    stx       WorkByte_002,u ; store x at WorkByte_002,u
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_306          ldd       WorkByte_002,u ; load d from WorkByte_002,u
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_052         pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_307 ; continue execution at Branch_307
Branch_308          ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    bra       Branch_309 ; continue execution at Branch_309
Branch_310          ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >WorkWord_004,y ; store b at >WorkWord_004,y
                    leax      >WorkByte_011,y ; form the address >WorkByte_011,y in x
Branch_309          tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_307          cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_308 ; branch when the values are equal or the result is zero; target Branch_308
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_308 ; branch when the values are equal or the result is zero; target Branch_308
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_308 ; branch when the values are equal or the result is zero; target Branch_308
                    bra       Branch_310 ; continue execution at Branch_310
                    puls      pc,u      ; restore pc,u and return to the caller
Data_001            fcb       $00       ; store byte data
Routine_050         pshs      u         ; save u on the stack
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Data_002            fcb       $00       ; store byte data
Routine_044         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
Branch_311          ldb       ,u+       ; load b from ,u+
                    bne       Branch_311 ; branch when the values differ or the result is nonzero; target Branch_311
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_009         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_312          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_312 ; branch when the values differ or the result is nonzero; target Branch_312
                    bra       Branch_313 ; continue execution at Branch_313
                    pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_314          ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       Branch_314 ; branch when the values differ or the result is nonzero; target Branch_314
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #-1       ; add to d using #-1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_315          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_315 ; branch when the values differ or the result is nonzero; target Branch_315
Branch_313          ldd       $06,s     ; load d from the current stack frame at $06,s
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    bra       Branch_316 ; continue execution at Branch_316
Branch_317          ldx       $06,s     ; load x from the current stack frame at $06,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       Branch_318 ; branch when the values differ or the result is nonzero; target Branch_318
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_318          leau      dpsiz,u   ; form the workspace or data address dpsiz,u in u
Branch_316          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       Branch_317 ; branch when the values are equal or the result is zero; target Branch_317
                    ldb       [<$06,s]  ; load b from the current stack frame at [<$06,s]
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    sex                 ; sign-extend b into d
                    subd      ,s++      ; subtract from d using ,s++
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_031         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $01,s     ; store d in the current stack frame at $01,s
Branch_319          ldb       ,u+       ; load b from ,u+
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    beq       Branch_319 ; branch when the values are equal or the result is zero; target Branch_319
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #9        ; compare b with #9 and set the condition codes
                    lbeq      Branch_319 ; branch when the values are equal or the result is zero; target Branch_319
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_320 ; branch when the values differ or the result is nonzero; target Branch_320
                    ldd       #1        ; set d to the constant 1
                    bra       Branch_321 ; continue execution at Branch_321
Branch_320          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_321          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    beq       Branch_322 ; branch when the values are equal or the result is zero; target Branch_322
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       Branch_323 ; branch when the values differ or the result is nonzero; target Branch_323
                    bra       Branch_322 ; continue execution at Branch_322
Branch_324          ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_013 ; call subroutine Routine_013
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
Branch_322          ldb       ,u+       ; load b from ,u+
                    stb       ,s        ; store b in the current stack frame at ,s
Branch_323          ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    leax      >WorkBuffer_006,y ; form the address >WorkBuffer_006,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_324 ; branch when the values differ or the result is nonzero; target Branch_324
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    beq       Branch_325 ; branch when the values are equal or the result is zero; target Branch_325
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       Branch_326 ; continue execution at Branch_326
Branch_325          ldd       $01,s     ; load d from the current stack frame at $01,s
Branch_326          leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_024         pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_327 ; branch when the values are equal or the result is zero; target Branch_327
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_013 ; call subroutine Routine_013
                    bra       Branch_328 ; continue execution at Branch_328
Branch_327          ldd       #1        ; set d to the constant 1
Branch_328          pshs      d         ; save d on the stack
                    lbsr      sleep     ; call subroutine sleep
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_013         tsta                ; set condition codes from a without changing it
                    bne       Branch_329 ; branch when the values differ or the result is nonzero; target Branch_329
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       Branch_329 ; branch when the values differ or the result is nonzero; target Branch_329
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       ,s        ; load x from the current stack frame at ,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
Branch_329          pshs      d         ; save d on the stack
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
                    bcc       Branch_330 ; branch when carry is clear; target Branch_330
                    inc       ,s        ; increment the value at ,s
Branch_330          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_331 ; branch when carry is clear; target Branch_331
                    inc       ,s        ; increment the value at ,s
Branch_331          lda       $04,s     ; load a from the current stack frame at $04,s
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
                    clr       >WorkByte_013,y ; clear >WorkByte_013,y to zero and set the condition codes
                    leax      >Code_007,pc ; form the address >Code_007,pc in x
                    stx       >WorkWord_016,y ; store x at >WorkWord_016,y
                    bra       Branch_332 ; continue execution at Branch_332
Routine_019         leax      >Routine_020,pc ; form the address >Routine_020,pc in x
                    stx       >WorkWord_016,y ; store x at >WorkWord_016,y
                    clr       >WorkByte_013,y ; clear >WorkByte_013,y to zero and set the condition codes
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bpl       Branch_332 ; branch when the result is nonnegative; target Branch_332
                    inc       >WorkByte_013,y ; increment the value at >WorkByte_013,y
Branch_332          subd      #0        ; subtract from d using #0
                    bne       Branch_333 ; branch when the values differ or the result is nonzero; target Branch_333
                    puls      x         ; restore x from the stack
                    ldd       ,s++      ; load d from the current stack frame at ,s++
                    jmp       ,x        ; continue execution at ,x
Branch_333          ldx       $02,s     ; load x from the current stack frame at $02,s
                    pshs      x         ; save x on the stack
                    jsr       [>$37D0,y] ; call subroutine [>$37D0,y]
                    ldd       ,s        ; load d from the current stack frame at ,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tfr       x,d       ; copy the register values specified by x,d
                    tst       >WorkByte_013,y ; set condition codes from >WorkByte_013,y without changing it
                    beq       Branch_334 ; branch when the values are equal or the result is zero; target Branch_334
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
Branch_334          std       ,s++      ; store d in the current stack frame at ,s++
                    rts                 ; return to the caller
Code_007            subd      #0        ; subtract from d using #0
                    beq       Branch_335 ; branch when the values are equal or the result is zero; target Branch_335
                    pshs      d         ; save d on the stack
                    leas      -$02,s    ; adjust the system stack pointer
                    clr       ,s        ; clear ,s to zero and set the condition codes
                    clr       $01,s     ; clear $01,s to zero and set the condition codes
                    bra       Branch_336 ; continue execution at Branch_336
Branch_335          puls      d         ; restore d from the stack
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       #45       ; set d to the constant 45
                    lbra      send      ; continue execution at send
Routine_020         subd      #0        ; subtract from d using #0
                    beq       Branch_335 ; branch when the values are equal or the result is zero; target Branch_335
                    pshs      d         ; save d on the stack
                    leas      -$02,s    ; adjust the system stack pointer
                    clr       ,s        ; clear ,s to zero and set the condition codes
                    clr       $01,s     ; clear $01,s to zero and set the condition codes
                    tsta                ; set condition codes from a without changing it
                    bpl       Branch_337 ; branch when the result is nonnegative; target Branch_337
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    inc       $01,s     ; increment the value at $01,s
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_337          ldd       $06,s     ; load d from the current stack frame at $06,s
                    bpl       Branch_336 ; branch when the result is nonnegative; target Branch_336
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    com       $01,s     ; complement the value at $01,s
                    std       $06,s     ; store d in the current stack frame at $06,s
Branch_336          lda       #1        ; set a to the constant 1
Branch_338          inca                ; increment a
                    asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    bpl       Branch_338 ; branch when the result is nonnegative; target Branch_338
                    sta       ,s        ; store a in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    clr       $06,s     ; clear $06,s to zero and set the condition codes
                    clr       $07,s     ; clear $07,s to zero and set the condition codes
Branch_339          subd      $02,s     ; subtract from d using $02,s
                    bcc       Branch_340 ; branch when carry is clear; target Branch_340
                    addd      $02,s     ; add to d using $02,s
                    andcc     #254      ; clear selected condition-code bits using #254
                    bra       Branch_341 ; continue execution at Branch_341
Branch_340          orcc      #1        ; set selected condition-code bits using #1
Branch_341          rol       $07,s     ; rotate left through carry the value at $07,s
                    rol       $06,s     ; rotate left through carry the value at $06,s
                    lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    dec       ,s        ; decrement the value at ,s
                    bne       Branch_339 ; branch when the values differ or the result is nonzero; target Branch_339
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tst       $01,s     ; set condition codes from $01,s without changing it
                    beq       Branch_342 ; branch when the values are equal or the result is zero; target Branch_342
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
Branch_342          ldx       $04,s     ; load x from the current stack frame at $04,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    leas      $06,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       Branch_343 ; branch when the values are equal or the result is zero; target Branch_343
Branch_344          asr       $02,s     ; shift right arithmetically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       Branch_344 ; branch when the values differ or the result is nonzero; target Branch_344
                    bra       Branch_343 ; continue execution at Branch_343
Routine_057         tstb                ; set condition codes from b without changing it
                    beq       Branch_343 ; branch when the values are equal or the result is zero; target Branch_343
Branch_345          lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       Branch_345 ; branch when the values differ or the result is nonzero; target Branch_345
Branch_343          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       Branch_343 ; branch when the values are equal or the result is zero; target Branch_343
Branch_346          asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    decb                ; decrement b
                    bne       Branch_346 ; branch when the values differ or the result is nonzero; target Branch_346
                    bra       Branch_343 ; continue execution at Branch_343
send                std       >WorkWord_006,y ; store d at >WorkWord_006,y
                    pshs      y,b       ; save y,b on the stack
                    os9       F$ID      ; retrieve the current process and user IDs
                    puls      y,b       ; restore y,b from the stack
                    os9       F$Send    ; send signal B to process A
                    rts                 ; return to the caller
Routine_042         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_347 ; branch when the values are equal or the result is zero; target Branch_347
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       Branch_348 ; branch when the values are equal or the result is zero; target Branch_348
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       Branch_348 ; branch when the values are equal or the result is zero; target Branch_348
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_349 ; branch when the values are equal or the result is zero; target Branch_349
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       Branch_349 ; branch when the values are equal or the result is zero; target Branch_349
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_350 ; continue execution at Branch_350
Branch_349          pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_351 ; branch when carry is clear; target Branch_351
                    puls      u         ; restore u from the stack
                    lbra      Branch_350 ; continue execution at Branch_350
Branch_351          stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_347          ldx       $06,s     ; load x from the current stack frame at $06,s
Branch_348          os9       I$GetStt  ; query status code B for path A
                    lbra      Branch_352 ; continue execution at Branch_352
Routine_043         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_353 ; branch when the values are equal or the result is zero; target Branch_353
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_354 ; branch when the values are equal or the result is zero; target Branch_354
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_350 ; continue execution at Branch_350
Branch_353          ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$SetStt  ; apply status operation B to path A
                    lbra      Branch_352 ; continue execution at Branch_352
Branch_354          pshs      u         ; save u on the stack
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u         ; restore u from the stack
                    lbra      Branch_352 ; continue execution at Branch_352
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_355 ; branch when carry reports an error or unsigned underflow; target Branch_355
                    os9       I$Close   ; close path A
Branch_355          lbra      Branch_352 ; continue execution at Branch_352
open                ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
close               lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; close path A
                    lbra      Branch_352 ; continue execution at Branch_352
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    os9       I$MakDir  ; create the directory named at X
                    lbra      Branch_352 ; continue execution at Branch_352
creat               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    bcs       Branch_356 ; branch when carry reports an error or unsigned underflow; target Branch_356
Branch_357          tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Branch_356          cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      Branch_350 ; branch when the values differ or the result is nonzero; target Branch_350
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      Branch_350 ; branch when the values differ or the result is nonzero; target Branch_350
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      ,x        ; form the workspace or data address ,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u,a       ; restore u,a from the stack
                    bcc       Branch_357 ; branch when carry is clear; target Branch_357
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; close path A
                    puls      b         ; restore b from the stack
                    lbra      Branch_350 ; continue execution at Branch_350
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Delete  ; delete the path named at X
                    lbra      Branch_352 ; continue execution at Branch_352
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Dup     ; duplicate path A into the next free path number
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
read                pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; read up to Y bytes from path A into X
Branch_358          bcc       Code_008  ; branch when carry is clear; target Code_008
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       Branch_359 ; branch when the values differ or the result is nonzero; target Branch_359
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
Branch_359          puls      y,x       ; restore y,x from the stack
                    lbra      Branch_350 ; continue execution at Branch_350
Code_008            tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
readln              pshs      y         ; save y on the stack
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bra       Branch_358 ; continue execution at Branch_358
write               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_360 ; branch when the values are equal or the result is zero; target Branch_360
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; write Y bytes from X to path A
Branch_361          bcc       Branch_360 ; branch when carry is clear; target Branch_360
                    puls      y         ; restore y from the stack
                    lbra      Branch_350 ; continue execution at Branch_350
Branch_360          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
writln              pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_360 ; branch when the values are equal or the result is zero; target Branch_360
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_361 ; continue execution at Branch_361
Routine_061         pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       Branch_362 ; branch when the values differ or the result is nonzero; target Branch_362
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       Branch_363 ; continue execution at Branch_363
Branch_362          cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       Branch_364 ; branch when the values are equal or the result is zero; target Branch_364
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       getstat   ; branch when the values are equal or the result is zero; target getstat
                    ldb       #247      ; set b to the constant 247
Branch_365          clra                ; clear a to zero and set the condition codes
                    std       >WorkWord_006,y ; store d at >WorkWord_006,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >WorkWord_005,y ; form the address >WorkWord_005,y in x
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
getstat             lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_365 ; branch when carry reports an error or unsigned underflow; target Branch_365
                    bra       Branch_363 ; continue execution at Branch_363
Branch_364          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_365 ; branch when carry reports an error or unsigned underflow; target Branch_365
Branch_363          tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >WorkBuffer_007,y ; store d at >WorkBuffer_007,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       Branch_365 ; branch when the result is negative; target Branch_365
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >WorkWord_005,y ; store d at >WorkWord_005,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    bcs       Branch_365 ; branch when carry reports an error or unsigned underflow; target Branch_365
                    leax      >WorkWord_005,y ; form the address >WorkWord_005,y in x
                    puls      pc,u      ; restore pc,u and return to the caller
                    rts                 ; return to the caller
                    ldx       #0        ; set x to the constant 0
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbra      Branch_350 ; continue execution at Branch_350
                    rts                 ; return to the caller
                    pshs      u,y       ; save u,y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       F$CRC     ; update the CRC accumulator over Y bytes at X
                    puls      pc,u,y    ; restore pc,u,y and return to the caller
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    os9       F$PErr    ; print the error message for status B
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    rts                 ; return to the caller
sleep               ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    tfr       x,d       ; copy the register values specified by x,d
                    rts                 ; return to the caller
                    ldd       >memend,y ; load d from >memend,y
                    pshs      d         ; save d on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >WorkWord_017,y ; compare d with >WorkWord_017,y and set the condition codes
                    bcs       Branch_366 ; branch when carry reports an error or unsigned underflow; target Branch_366
                    addd      >memend,y ; add to d using >memend,y
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    os9       F$Mem     ; resize process memory to D pages
                    tfr       y,d       ; copy the register values specified by y,d
                    puls      y         ; restore y from the stack
                    bcc       Branch_367 ; branch when carry is clear; target Branch_367
                    ldd       #-1       ; set d to the constant -1
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
Branch_367          std       >memend,y ; store d at >memend,y
                    addd      >WorkWord_017,y ; add to d using >WorkWord_017,y
                    subd      ,s        ; subtract from d using ,s
                    std       >WorkWord_017,y ; store d at >WorkWord_017,y
Branch_366          leas      $02,s     ; adjust the system stack pointer
                    ldd       >WorkWord_017,y ; load d from >WorkWord_017,y
                    pshs      d         ; save d on the stack
                    subd      $04,s     ; subtract from d using $04,s
                    std       >WorkWord_017,y ; store d at >WorkWord_017,y
                    ldd       >memend,y ; load d from >memend,y
                    subd      ,s++      ; subtract from d using ,s++
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    ldx       ,s        ; load x from the current stack frame at ,s
Branch_368          sta       ,x+       ; store a at ,x+
                    cmpx      >memend,y ; compare x with >memend,y and set the condition codes
                    bcs       Branch_368 ; branch when carry reports an error or unsigned underflow; target Branch_368
                    puls      pc,d      ; restore pc,d and return to the caller
Routine_062         ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >_mtop,y  ; add to d using >_mtop,y
                    bcs       Branch_369 ; branch when carry reports an error or unsigned underflow; target Branch_369
                    cmpd      >_stbot,y ; compare d with >_stbot,y and set the condition codes
                    bcc       Branch_369 ; branch when carry is clear; target Branch_369
                    pshs      d         ; save d on the stack
                    ldx       >_mtop,y  ; load x from >_mtop,y
                    clra                ; clear a to zero and set the condition codes
Branch_370          cmpx      ,s        ; compare x with ,s and set the condition codes
                    bcc       Branch_371 ; branch when carry is clear; target Branch_371
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_370 ; continue execution at Branch_370
Branch_371          ldd       >_mtop,y  ; load d from >_mtop,y
                    puls      x         ; restore x from the stack
                    stx       >_mtop,y  ; store x at >_mtop,y
                    rts                 ; return to the caller
Branch_369          ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_350          clra                ; clear a to zero and set the condition codes
                    std       >WorkWord_006,y ; store d at >WorkWord_006,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_352          bcs       Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
exit                lbsr      Code_009  ; call subroutine Code_009
                    lbsr      Routine_058 ; call subroutine Routine_058
_exit               ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; terminate the process with status B
Code_009            rts                 ; return to the caller
Routine_022         lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_350 ; branch when carry reports an error or unsigned underflow; target Branch_350
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
                    ldd       #6944     ; set d to the constant 6944
                    bsr       Routine_063 ; call subroutine Routine_063
                    ldb       #9        ; set b to the constant 9
                    tst       $05,s     ; set condition codes from $05,s without changing it
                    ble       Branch_372 ; branch when the signed value is less than or equal; target Branch_372
                    ldb       #10       ; set b to the constant 10
Branch_372          lbra      Branch_373 ; continue execution at Branch_373
Routine_005         ldd       #6946     ; set d to the constant 6946
                    bsr       Routine_063 ; call subroutine Routine_063
                    ldb       #9        ; set b to the constant 9
                    bra       Branch_372 ; continue execution at Branch_372
Routine_063         leax      >WorkWord_018,y ; form the address >WorkWord_018,y in x
                    std       ,x++      ; store d at ,x++
                    lda       $07,s     ; load a from the current stack frame at $07,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    std       ,x++      ; store d at ,x++
                    lda       $0B,s     ; load a from the current stack frame at $0B,s
                    ldb       $0D,s     ; load b from the current stack frame at $0D,s
                    std       ,x++      ; store d at ,x++
                    lda       $0F,s     ; load a from the current stack frame at $0F,s
                    ldb       <$0011,s  ; load b from the current stack frame at <$0011,s
                    std       ,x++      ; store d at ,x++
                    lda       <$0013,s  ; load a from the current stack frame at <$0013,s
                    ldb       <$0015,s  ; load b from the current stack frame at <$0015,s
                    std       ,x        ; store d at ,x
                    rts                 ; return to the caller
                    ldd       #6948     ; set d to the constant 6948
                    bra       Branch_374 ; continue execution at Branch_374
Routine_010         ldd       #6947     ; set d to the constant 6947
                    bra       Branch_374 ; continue execution at Branch_374
                    ldd       #6945     ; set d to the constant 6945
Branch_374          std       >WorkWord_018,y ; store d at >WorkWord_018,y
                    ldb       #2        ; set b to the constant 2
                    lbra      Branch_373 ; continue execution at Branch_373
                    ldd       #6960     ; set d to the constant 6960
                    std       >WorkWord_018,y ; store d at >WorkWord_018,y
                    ldb       #2        ; set b to the constant 2
                    lbra      Branch_373 ; continue execution at Branch_373
Routine_026         ldb       #50       ; set b to the constant 50
                    bra       Branch_375 ; continue execution at Branch_375
Routine_027         ldb       #51       ; set b to the constant 51
                    bra       Branch_375 ; continue execution at Branch_375
                    ldb       #52       ; set b to the constant 52
                    bra       Branch_375 ; continue execution at Branch_375
                    ldb       #47       ; set b to the constant 47
Branch_375          lda       #27       ; set a to the constant 27
                    std       >WorkWord_018,y ; store d at >WorkWord_018,y
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >WorkBuffer_015,y ; store b at >WorkBuffer_015,y
                    ldb       #3        ; set b to the constant 3
                    lbra      Branch_373 ; continue execution at Branch_373
                    ldb       #1        ; set b to the constant 1
                    bra       Branch_376 ; continue execution at Branch_376
                    ldb       #3        ; set b to the constant 3
                    bra       Branch_376 ; continue execution at Branch_376
Routine_036         ldb       #4        ; set b to the constant 4
                    bra       Branch_376 ; continue execution at Branch_376
Routine_021         ldd       #1312     ; set d to the constant 1312
                    bra       Branch_377 ; continue execution at Branch_377
Routine_023         ldd       #1313     ; set d to the constant 1313
                    bra       Branch_377 ; continue execution at Branch_377
Routine_035         ldb       #6        ; set b to the constant 6
                    bra       Branch_376 ; continue execution at Branch_376
Routine_017         ldb       #7        ; set b to the constant 7
                    bra       Branch_376 ; continue execution at Branch_376
Routine_028         ldb       #8        ; set b to the constant 8
                    bra       Branch_376 ; continue execution at Branch_376
Routine_033         ldb       #9        ; set b to the constant 9
                    bra       Branch_376 ; continue execution at Branch_376
Routine_034         ldb       #10       ; set b to the constant 10
                    bra       Branch_376 ; continue execution at Branch_376
                    ldb       #11       ; set b to the constant 11
                    bra       Branch_376 ; continue execution at Branch_376
Routine_007         ldb       #12       ; set b to the constant 12
                    bra       Branch_376 ; continue execution at Branch_376
                    ldb       #13       ; set b to the constant 13
Branch_376          stb       >WorkWord_018,y ; store b at >WorkWord_018,y
                    ldb       #1        ; set b to the constant 1
                    lbra      Branch_373 ; continue execution at Branch_373
Routine_011         ldd       #7968     ; set d to the constant 7968
                    bra       Branch_377 ; continue execution at Branch_377
Routine_012         ldd       #7969     ; set d to the constant 7969
                    bra       Branch_377 ; continue execution at Branch_377
Routine_039         ldd       #7970     ; set d to the constant 7970
                    bra       Branch_377 ; continue execution at Branch_377
Routine_037         ldd       #7971     ; set d to the constant 7971
                    bra       Branch_377 ; continue execution at Branch_377
Routine_040         ldd       #7972     ; set d to the constant 7972
                    bra       Branch_377 ; continue execution at Branch_377
Routine_038         ldd       #7973     ; set d to the constant 7973
                    bra       Branch_377 ; continue execution at Branch_377
                    ldd       #7984     ; set d to the constant 7984
                    bra       Branch_377 ; continue execution at Branch_377
                    ldd       #7985     ; set d to the constant 7985
Branch_377          std       >WorkWord_018,y ; store d at >WorkWord_018,y
                    ldb       #2        ; set b to the constant 2
                    lbra      Branch_373 ; continue execution at Branch_373
Routine_030         leax      >WorkWord_018,y ; form the address >WorkWord_018,y in x
                    ldb       #2        ; set b to the constant 2
                    stb       ,x+       ; store b at ,x+
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; store b at ,x+
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; store b at ,x+
                    ldb       #3        ; set b to the constant 3
                    lbra      Branch_373 ; continue execution at Branch_373
Branch_373          clra                ; clear a to zero and set the condition codes
                    leax      >WorkWord_018,y ; form the address >WorkWord_018,y in x
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y         ; restore y from the stack
                    bcs       Branch_378 ; branch when carry reports an error or unsigned underflow; target Branch_378
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_378          clra                ; clear a to zero and set the condition codes
                    std       >WorkWord_006,y ; store d at >WorkWord_006,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller

* initialization data

etext               fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $8C       ; store byte data
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
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "&?&E&I&O&V&[&c&h'" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "7lx" ; store literal character data
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
                    fcb       $08       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $2D       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $2B       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $29       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $23       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $21       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "7AnsiEd" ; store literal character data
                    fcb       $00       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
