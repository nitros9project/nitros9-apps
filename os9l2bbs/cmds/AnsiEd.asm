**********************************************************************
* AnsiEd - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
dpsiz               rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
U000F               rmb       16        ; reserve 16 byte(s) in the module workspace
U001F               rmb       16        ; reserve 16 byte(s) in the module workspace
U002F               rmb       8         ; reserve 8 byte(s) in the module workspace
U0037               rmb       2         ; reserve 2 byte(s) in the module workspace
U0039               rmb       1         ; reserve 1 byte(s) in the module workspace
U003A               rmb       2         ; reserve 2 byte(s) in the module workspace
U003C               rmb       13        ; reserve 13 byte(s) in the module workspace
U0049               rmb       196       ; reserve 196 byte(s) in the module workspace
U010D               rmb       128       ; reserve 128 byte(s) in the module workspace
argv                rmb       2         ; reserve 2 byte(s) in the module workspace
argv_2              rmb       58        ; reserve 58 byte(s) in the module workspace
argc                rmb       1         ; reserve 1 byte(s) in the module workspace
argc_1              rmb       1         ; reserve 1 byte(s) in the module workspace
_sttop              rmb       2         ; reserve 2 byte(s) in the module workspace
memend              rmb       2         ; reserve 2 byte(s) in the module workspace
U01CF               rmb       2         ; reserve 2 byte(s) in the module workspace
U01D1               rmb       6         ; reserve 6 byte(s) in the module workspace
_mtop               rmb       2         ; reserve 2 byte(s) in the module workspace
_stbot              rmb       2         ; reserve 2 byte(s) in the module workspace
U01DB               rmb       2         ; reserve 2 byte(s) in the module workspace
U01DD               rmb       1         ; reserve 1 byte(s) in the module workspace
U01DE               rmb       9         ; reserve 9 byte(s) in the module workspace
U01E7               rmb       50        ; reserve 50 byte(s) in the module workspace
U0219               rmb       2         ; reserve 2 byte(s) in the module workspace
U021B               rmb       2         ; reserve 2 byte(s) in the module workspace
U021D               rmb       2         ; reserve 2 byte(s) in the module workspace
U021F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0221               rmb       2         ; reserve 2 byte(s) in the module workspace
U0223               rmb       2         ; reserve 2 byte(s) in the module workspace
U0225               rmb       8192      ; reserve 8192 byte(s) in the module workspace
U2225               rmb       1840      ; reserve 1840 byte(s) in the module workspace
U2955               rmb       3680      ; reserve 3680 byte(s) in the module workspace
U37B5               rmb       2         ; reserve 2 byte(s) in the module workspace
U37B7               rmb       10        ; reserve 10 byte(s) in the module workspace
U37C1               rmb       10        ; reserve 10 byte(s) in the module workspace
U37CB               rmb       2         ; reserve 2 byte(s) in the module workspace
U37CD               rmb       2         ; reserve 2 byte(s) in the module workspace
U37CF               rmb       1         ; reserve 1 byte(s) in the module workspace
U37D0               rmb       2         ; reserve 2 byte(s) in the module workspace
U37D2               rmb       2         ; reserve 2 byte(s) in the module workspace
U37D4               rmb       2         ; reserve 2 byte(s) in the module workspace
U37D6               rmb       14        ; reserve 14 byte(s) in the module workspace
end                 rmb       1         ; reserve 1 byte(s) in the module workspace
U37E5               rmb       895       ; reserve 895 byte(s) in the module workspace
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

csta10              ldx       0,s       ; get the beginning of data address
                    leau      0,x       ; (tfr x,u)
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
clrbss              cmpu      0,s       ; reached the end?
                    beq       reldt     ; bra if so
                    sta       ,u+       ; clear it
                    bra       clrbss    ; continue execution at clrbss

* now relocate the data-text references
reldt               ldu       $02,s     ; restore to data bottom
                    ldd       ,y++      ; get data-text ref. count
                    beq       reldd     ; branch when the values are equal or the result is zero; target reldd
                    leax      >,pc      ; point to text
                    lbsr      patch     ; patch them

* and the data-data refs.
reldd               ldd       ,y++      ; get the count of data refs.
                    beq       restack   ; bra if none
                    leax      U0000,u   ; u was already pointing there
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
                    leax      0,s       ; point x at params
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
                    cmpa      0,s       ; delimiter?
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
                    leay      U0000,u   ; C progs. assume data & bss offset from y

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
                    ldb       #E$MemFul ; MEMORY FULL error number

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
                    ldd       0,x       ; get the relative reference
                    addd      $02,s     ; add in the base
                    std       0,x       ; store the absolute reference
                    cmpy      0,s       ; reached the top?
                    bne       patch10   ; no - round again

                    leas      $04,s     ; reset the stack
                    rts                 ; and return

main                pshs      u         ; save u on the stack
                    ldd       #-118     ; set d to the constant -118
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      <$FFDE,s  ; adjust the system stack pointer
                    lbsr      L02DF     ; call subroutine L02DF
                    lbsr      L035D     ; call subroutine L035D
                    ldd       <$0026,s  ; load d from the current stack frame at <$0026,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    ble       L01A2     ; branch when the signed value is less than or equal; target L01A2
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0555     ; call subroutine L0555
                    leas      $02,s     ; adjust the system stack pointer
L01A2               lbsr      L07B7     ; call subroutine L07B7
                    ldd       <$0026,s  ; load d from the current stack frame at <$0026,s
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    ble       L01BB     ; branch when the signed value is less than or equal; target L01BB
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $04,x     ; load d from $04,x
                    pshs      d         ; save d on the stack
                    lbsr      L03E2     ; call subroutine L03E2
                    lbra      L0284     ; continue execution at L0284
L01BB               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >savprmpt,pc ; form the address >savprmpt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       L0269     ; branch when the signed value is greater; target L0269
                    ldx       <$0028,s  ; load x from the current stack frame at <$0028,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    leax      $04,s     ; form the address $04,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L3556     ; call subroutine L3556
                    leas      $04,s     ; adjust the system stack pointer
L0269               leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L03E2     ; call subroutine L03E2
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
L0284               leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AFB     ; call subroutine L3AFB
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
                    lbsr      L3B00     ; call subroutine L3B00
                    leas      $02,s     ; adjust the system stack pointer
                    leas      <$0022,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L02DF               pshs      u         ; save u on the stack
                    ldd       #-84      ; set d to the constant -84
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L035D               pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L03BE     ; continue execution at L03BE
L036C               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L03AF     ; continue execution at L03AF
L0370               ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >U0009,y  ; load d from >U0009,y
                    std       0,x       ; store d at 0,x
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    addd      #1        ; add to d using #1
L03AF               std       $01,s     ; store d in the current stack frame at $01,s
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       L0370     ; branch when the signed value is less; target L0370
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L03BE               std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      L036C     ; branch when the signed value is less; target L036C
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    std       >U0007,y  ; store d at >U0007,y
                    lbsr      L20F0     ; call subroutine L20F0
                    leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L03E2               pshs      u         ; save u on the stack
                    ldd       #-99      ; set d to the constant -99
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$0F,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0009,y  ; store d at >U0009,y
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      creat     ; call subroutine creat
                    leas      $04,s     ; adjust the system stack pointer
                    std       $0D,s     ; store d in the current stack frame at $0D,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0420     ; branch when the values differ or the result is nonzero; target L0420
                    ldd       >U01DB,y  ; load d from >U01DB,y
                    pshs      d         ; save d on the stack
                    leax      >CantOpen1,pc ; form the address >CantOpen1,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L2561     ; call subroutine L2561
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #-1       ; set d to the constant -1
                    lbra      L0551     ; continue execution at L0551
L0420               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PutScrn,pc ; form the address >PutScrn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #78       ; compare d with #78 and set the condition codes
                    beq       L04BA     ; branch when the values are equal or the result is zero; target L04BA
                    lbsr      L212A     ; call subroutine L212A
L04BA               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >ClrScrn,pc ; form the address >ClrScrn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    bne       L051E     ; branch when the values differ or the result is nonzero; target L051E
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
L051E               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U000D,y  ; load d from >U000D,y
                    pshs      d         ; save d on the stack
                    leax      >U0225,y  ; form the address >U0225,y in x
                    pshs      x         ; save x on the stack
                    ldd       <$0011,s  ; load d from the current stack frame at <$0011,s
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $0D,s     ; load d from the current stack frame at $0D,s
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
L0551               leas      $0F,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L0555               pshs      u         ; save u on the stack
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
                    bne       L058C     ; branch when the values differ or the result is nonzero; target L058C
                    ldd       >U01DB,y  ; load d from >U01DB,y
                    pshs      d         ; save d on the stack
                    leax      >CantOpen2,pc ; form the address >CantOpen2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L2561     ; call subroutine L2561
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #-1       ; set d to the constant -1
                    lbra      L07B3     ; continue execution at L07B3
L058C               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0219,y  ; store d at >U0219,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U021B,y  ; store d at >U021B,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0221,y  ; store d at >U0221,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0223,y  ; store d at >U0223,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U021D,y  ; store d at >U021D,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U021F,y  ; store d at >U021F,y
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    leax      >ReadFile,pc ; form the address >ReadFile,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L060C     ; continue execution at L060C
L05F5               ldd       #1        ; set d to the constant 1
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
L060C               stb       $01,s     ; store b in the current stack frame at $01,s
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #79       ; compare b with #79 and set the condition codes
                    beq       L061A     ; branch when the values are equal or the result is zero; target L061A
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       L05F5     ; branch when the values differ or the result is nonzero; target L05F5
L061A               ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       L0625     ; branch when the values differ or the result is nonzero; target L0625
                    ldd       #1        ; set d to the constant 1
                    bra       L0627     ; continue execution at L0627
L0625               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L0627               std       >U0007,y  ; store d at >U0007,y
                    leax      >AddLf,pc ; form the address >AddLf,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L065C     ; continue execution at L065C
L0645               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
L065C               stb       0,s       ; store b in the current stack frame at 0,s
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #89       ; compare b with #89 and set the condition codes
                    beq       L066A     ; branch when the values are equal or the result is zero; target L066A
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #78       ; compare b with #78 and set the condition codes
                    bne       L0645     ; branch when the values differ or the result is nonzero; target L0645
L066A               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    lbra      L0790     ; continue execution at L0790
L0675               ldd       >U0007,y  ; load d from >U0007,y
                    bne       L06B2     ; branch when the values differ or the result is nonzero; target L06B2
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       L06B2     ; branch when the signed value is less; target L06B2
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    std       >U000D,y  ; store d at >U000D,y
L06B2               ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #27       ; compare b with #27 and set the condition codes
                    lbne      L076D     ; branch when the values differ or the result is nonzero; target L076D
                    ldd       >U0005,y  ; load d from >U0005,y
                    lbne      L076D     ; branch when the values differ or the result is nonzero; target L076D
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    bne       L0711     ; branch when the values differ or the result is nonzero; target L0711
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       L0711     ; branch when the signed value is less; target L0711
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    std       >U000D,y  ; store d at >U000D,y
L0711               ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #91       ; compare b with #91 and set the condition codes
                    bne       L076D     ; branch when the values differ or the result is nonzero; target L076D
                    ldd       #1        ; set d to the constant 1
                    std       >U0005,y  ; store d at >U0005,y
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    bne       L076D     ; branch when the values differ or the result is nonzero; target L076D
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    blt       L076D     ; branch when the signed value is less; target L076D
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    std       >U000D,y  ; store d at >U000D,y
L076D               ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #89       ; compare b with #89 and set the condition codes
                    bne       L0788     ; branch when the values differ or the result is nonzero; target L0788
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #13       ; compare b with #13 and set the condition codes
                    bne       L0788     ; branch when the values differ or the result is nonzero; target L0788
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #10       ; set d to the constant 10
                    bra       L078B     ; continue execution at L078B
L0788               ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
L078B               pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
L0790               leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $03,s     ; form the address $03,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      read      ; call subroutine read
                    leas      $06,s     ; adjust the system stack pointer
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      L0675     ; branch when the values differ or the result is nonzero; target L0675
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
L07B3               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L07B7               pshs      u         ; save u on the stack
                    ldd       #-120     ; set d to the constant -120
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      <$FFDC,s  ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L14E4     ; continue execution at L14E4
L080D               clra                ; clear a to zero and set the condition codes
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    leax      >Status,pc ; form the address >Status,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    beq       L0861     ; branch when the values are equal or the result is zero; target L0861
                    leax      >Editing,pc ; form the address >Editing,pc in x
                    bra       L0865     ; continue execution at L0865
L0861               leax      >Recording,pc ; form the address >Recording,pc in x
L0865               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0219,y  ; load d from >U0219,y
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    beq       L08B2     ; branch when the values are equal or the result is zero; target L08B2
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0219,y  ; load d from >U0219,y
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >CharDump,pc ; form the address >CharDump,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $04,s     ; adjust the system stack pointer
                    bra       L08BD     ; continue execution at L08BD
L08B2               leax      >Char,pc  ; form the address >Char,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
L08BD               leax      >Attrs,pc ; form the address >Attrs,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L08D9     ; branch when the values are equal or the result is zero; target L08D9
                    leax      >L281F,pc ; form the address >L281F,pc in x
                    bra       L08DD     ; continue execution at L08DD
L08D9               leax      >L2821,pc ; form the address >L2821,pc in x
L08DD               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    anda      #2        ; mask a using #2
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L08F5     ; branch when the values are equal or the result is zero; target L08F5
                    leax      >L2823,pc ; form the address >L2823,pc in x
                    bra       L08F9     ; continue execution at L08F9
L08F5               leax      >L2825,pc ; form the address >L2825,pc in x
L08F9               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    anda      #4        ; mask a using #4
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L0911     ; branch when the values are equal or the result is zero; target L0911
                    leax      >L2827,pc ; form the address >L2827,pc in x
                    bra       L0915     ; continue execution at L0915
L0911               leax      >L2829,pc ; form the address >L2829,pc in x
L0915               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    anda      #8        ; mask a using #8
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L092D     ; branch when the values are equal or the result is zero; target L092D
                    leax      >L282B,pc ; form the address >L282B,pc in x
                    bra       L0931     ; continue execution at L0931
L092D               leax      >L282D,pc ; form the address >L282D,pc in x
L0931               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    anda      #16       ; mask a using #16
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L0949     ; branch when the values are equal or the result is zero; target L0949
                    leax      >L282F,pc ; form the address >L282F,pc in x
                    bra       L094D     ; continue execution at L094D
L0949               leax      >L2831,pc ; form the address >L2831,pc in x
L094D               pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    pshs      d         ; save d on the stack
                    ldd       #256      ; set d to the constant 256
                    lbsr      L36BE     ; call subroutine L36BE
                    beq       L09A2     ; branch when the values are equal or the result is zero; target L09A2
                    ldd       >U0009,y  ; load d from >U0009,y
                    pshs      d         ; save d on the stack
                    ldd       #16       ; set d to the constant 16
                    lbsr      L36BE     ; call subroutine L36BE
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U001F,y  ; form the address >U001F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       >U0009,y  ; load d from >U0009,y
                    clra                ; clear a to zero and set the condition codes
                    andb      #240      ; mask b using #240
                    pshs      d         ; save d on the stack
                    ldd       #16       ; set d to the constant 16
                    lbsr      L3711     ; call subroutine L3711
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U001F,y  ; form the address >U001F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    leax      >ColorsOn,pc ; form the address >ColorsOn,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    bra       L09AD     ; continue execution at L09AD
L09A2               leax      >ColorsBW,pc ; form the address >ColorsBW,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
L09AD               leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
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
                    std       >U0005,y  ; store d at >U0005,y
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L1463     ; continue execution at L1463
L09E5               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
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
                    lbsr      L3ACA     ; call subroutine L3ACA
                    leas      $02,s     ; adjust the system stack pointer
L0AF8               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L3A35     ; call subroutine L3A35
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L0AF8     ; branch when the values are equal or the result is zero; target L0AF8
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3ACF     ; call subroutine L3ACF
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    lbra      L145E     ; continue execution at L145E
L0B26               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Sure,pc  ; form the address >Sure,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AFB     ; call subroutine L3AFB
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
                    lbsr      L3B00     ; call subroutine L3B00
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      exit      ; call subroutine exit
                    lbra      L145E     ; continue execution at L145E
L0C3D               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >LoadPrompt,pc ; form the address >LoadPrompt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       L0CFD     ; branch when the signed value is greater; target L0CFD
                    lbra      L14E4     ; continue execution at L14E4
L0CFD               leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L0555     ; call subroutine L0555
                    lbra      L145E     ; continue execution at L145E
L0D07               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >SavePrompt,pc ; form the address >SavePrompt,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bgt       L0DC7     ; branch when the signed value is greater; target L0DC7
                    lbra      L14E4     ; continue execution at L14E4
L0DC7               leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L03E2     ; call subroutine L03E2
                    lbra      L145E     ; continue execution at L145E
L0DD1               ldd       #65       ; set d to the constant 65
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #65       ; set d to the constant 65
                    lbra      L0FA6     ; continue execution at L0FA6
L0DE9               ldd       #66       ; set d to the constant 66
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #66       ; set d to the constant 66
                    lbra      L0FA6     ; continue execution at L0FA6
L0E01               ldd       #68       ; set d to the constant 68
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #68       ; set d to the constant 68
                    lbra      L0FA6     ; continue execution at L0FA6
L0E19               ldd       #67       ; set d to the constant 67
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #67       ; set d to the constant 67
                    lbra      L0FA6     ; continue execution at L0FA6
L0E31               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PosSaved,pc ; form the address >PosSaved,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      L363F     ; call subroutine L363F
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #115      ; set d to the constant 115
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #115      ; set d to the constant 115
                    lbra      L0FA6     ; continue execution at L0FA6
L0ED6               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >PosRestrd,pc ; form the address >PosRestrd,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      L363F     ; call subroutine L363F
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #117      ; set d to the constant 117
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #117      ; set d to the constant 117
                    bra       L0FA6     ; continue execution at L0FA6
L0F7A               ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #74       ; set d to the constant 74
                    bra       L0FA6     ; continue execution at L0FA6
L0F91               ldd       #107      ; set d to the constant 107
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       #107      ; set d to the constant 107
L0FA6               pshs      d         ; save d on the stack
                    lbsr      L1933     ; call subroutine L1933
                    lbra      L145E     ; continue execution at L145E
L0FAE               lbsr      L14EC     ; call subroutine L14EC
                    lbra      L14E4     ; continue execution at L14E4
L0FB4               ldd       >U0219,y  ; load d from >U0219,y
                    cmpd      >U021D,y  ; compare d with >U021D,y and set the condition codes
                    bne       L0FCC     ; branch when the values differ or the result is nonzero; target L0FCC
                    ldd       >U021B,y  ; load d from >U021B,y
                    cmpd      >U021F,y  ; compare d with >U021F,y and set the condition codes
                    lbeq      L10F3     ; branch when the values are equal or the result is zero; target L10F3
L0FCC               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      L10E9     ; branch when the signed value is greater than or equal; target L10E9
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L3711     ; call subroutine L3711
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L36BE     ; call subroutine L36BE
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L3711     ; call subroutine L3711
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L36BE     ; call subroutine L36BE
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #72       ; set d to the constant 72
                    stb       0,x       ; store b at 0,x
                    bra       L10F3     ; continue execution at L10F3
L10E9               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
L10F3               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0007,y  ; store d at >U0007,y
                    ldd       >U0219,y  ; load d from >U0219,y
                    std       >U021D,y  ; store d at >U021D,y
                    ldd       >U021B,y  ; load d from >U021B,y
                    std       >U021F,y  ; store d at >U021F,y
                    lbra      L14E4     ; continue execution at L14E4
L110C               ldd       #1        ; set d to the constant 1
                    std       >U0007,y  ; store d at >U0007,y
                    lbra      L14E4     ; continue execution at L14E4
L1116               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >MovBuff,pc ; form the address >MovBuff,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    lbsr      L212A     ; call subroutine L212A
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    lbra      L145E     ; continue execution at L145E
L119D               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L252A     ; call subroutine L252A
                    leas      $02,s     ; adjust the system stack pointer
                    leas      <$0024,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L11AC               ldd       #4        ; set d to the constant 4
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
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
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    beq       L12A1     ; branch when the values are equal or the result is zero; target L12A1
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #82       ; compare b with #82 and set the condition codes
                    beq       L12A1     ; branch when the values are equal or the result is zero; target L12A1
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #66       ; compare b with #66 and set the condition codes
                    beq       L12A1     ; branch when the values are equal or the result is zero; target L12A1
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #68       ; compare b with #68 and set the condition codes
                    beq       L12A1     ; branch when the values are equal or the result is zero; target L12A1
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    cmpb      #84       ; compare b with #84 and set the condition codes
                    bne       L12CA     ; branch when the values differ or the result is nonzero; target L12CA
L12A1               leax      >Sure2,pc ; form the address >Sure2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
L12CA               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    cmpd      #89       ; compare d with #89 and set the condition codes
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldb       <$0022,s  ; load b from the current stack frame at <$0022,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L13F0     ; continue execution at L13F0
L12F7               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0009,y  ; store d at >U0009,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AA3     ; call subroutine L3AA3
                    leas      $04,s     ; adjust the system stack pointer
                    lbsr      L035D     ; call subroutine L035D
                    ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    lbra      L13EB     ; continue execution at L13EB
L1328               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AA3     ; call subroutine L3AA3
                    leas      $04,s     ; adjust the system stack pointer
                    lbsr      L035D     ; call subroutine L035D
                    ldd       #74       ; set d to the constant 74
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
L1352               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0009,y  ; store d at >U0009,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U000D,y  ; store d at >U000D,y
                    lbra      L14E4     ; continue execution at L14E4
L1361               ldd       >U0219,y  ; load d from >U0219,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U021B,y  ; load d from >U021B,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >U0219,y  ; load d from >U0219,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >U021B,y  ; load d from >U021B,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,x       ; store d at 0,x
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >L2BE6,pc ; form the address >L2BE6,pc in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L14E4     ; continue execution at L14E4
L13B9               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    std       >U000D,y  ; store d at >U000D,y
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3ADC     ; call subroutine L3ADC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >L2BE8,pc ; form the address >L2BE8,pc in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3ADC     ; call subroutine L3ADC
L13EB               leas      $02,s     ; adjust the system stack pointer
                    lbra      L14E4     ; continue execution at L14E4
L13F0               cmpx      #83       ; compare x with #83 and set the condition codes
                    lbeq      L12F7     ; branch when the values are equal or the result is zero; target L12F7
                    cmpx      #82       ; compare x with #82 and set the condition codes
                    lbeq      L1352     ; branch when the values are equal or the result is zero; target L1352
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      L1328     ; branch when the values are equal or the result is zero; target L1328
                    cmpx      #68       ; compare x with #68 and set the condition codes
                    lbeq      L1361     ; branch when the values are equal or the result is zero; target L1361
                    cmpx      #84       ; compare x with #84 and set the condition codes
                    beq       L13B9     ; branch when the values are equal or the result is zero; target L13B9
                    lbra      L14E4     ; continue execution at L14E4
L1414               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0005,y  ; store d at >U0005,y
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L14E4     ; branch when the values differ or the result is nonzero; target L14E4
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       L1456     ; branch when the signed value is greater than or equal; target L1456
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       <$0023,s  ; load b from the current stack frame at <$0023,s
                    stb       0,x       ; store b at 0,x
                    lbra      L14E4     ; continue execution at L14E4
L1456               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
L145E               leas      $02,s     ; adjust the system stack pointer
                    lbra      L14E4     ; continue execution at L14E4
L1463               cmpx      #-81      ; compare x with #-81 and set the condition codes
                    lbeq      L09E5     ; branch when the values are equal or the result is zero; target L09E5
                    cmpx      #-15      ; compare x with #-15 and set the condition codes
                    lbeq      L0B26     ; branch when the values are equal or the result is zero; target L0B26
                    cmpx      #-20      ; compare x with #-20 and set the condition codes
                    lbeq      L0C3D     ; branch when the values are equal or the result is zero; target L0C3D
                    cmpx      #-21      ; compare x with #-21 and set the condition codes
                    lbeq      L0D07     ; branch when the values are equal or the result is zero; target L0D07
                    cmpx      #12       ; compare x with #12 and set the condition codes
                    lbeq      L0DD1     ; branch when the values are equal or the result is zero; target L0DD1
                    cmpx      #10       ; compare x with #10 and set the condition codes
                    lbeq      L0DE9     ; branch when the values are equal or the result is zero; target L0DE9
                    cmpx      #8        ; compare x with #8 and set the condition codes
                    lbeq      L0E01     ; branch when the values are equal or the result is zero; target L0E01
                    cmpx      #9        ; compare x with #9 and set the condition codes
                    lbeq      L0E19     ; branch when the values are equal or the result is zero; target L0E19
                    cmpx      #-13      ; compare x with #-13 and set the condition codes
                    lbeq      L0E31     ; branch when the values are equal or the result is zero; target L0E31
                    cmpx      #-31      ; compare x with #-31 and set the condition codes
                    lbeq      L0ED6     ; branch when the values are equal or the result is zero; target L0ED6
                    cmpx      #-29      ; compare x with #-29 and set the condition codes
                    lbeq      L0F7A     ; branch when the values are equal or the result is zero; target L0F7A
                    cmpx      #-18      ; compare x with #-18 and set the condition codes
                    lbeq      L0F91     ; branch when the values are equal or the result is zero; target L0F91
                    cmpx      #-25      ; compare x with #-25 and set the condition codes
                    lbeq      L0FAE     ; branch when the values are equal or the result is zero; target L0FAE
                    cmpx      #-14      ; compare x with #-14 and set the condition codes
                    lbeq      L0FB4     ; branch when the values are equal or the result is zero; target L0FB4
                    cmpx      #-27      ; compare x with #-27 and set the condition codes
                    lbeq      L110C     ; branch when the values are equal or the result is zero; target L110C
                    cmpx      #-16      ; compare x with #-16 and set the condition codes
                    lbeq      L1116     ; branch when the values are equal or the result is zero; target L1116
                    cmpx      #-8       ; compare x with #-8 and set the condition codes
                    lbeq      L119D     ; branch when the values are equal or the result is zero; target L119D
                    cmpx      #-6       ; compare x with #-6 and set the condition codes
                    lbeq      L11AC     ; branch when the values are equal or the result is zero; target L11AC
                    lbra      L1414     ; continue execution at L1414
L14E4               lbra      L080D     ; continue execution at L080D
                    leas      <$0024,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L14EC               pshs      u         ; save u on the stack
                    ldd       #-86      ; set d to the constant -86
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    bne       L1547     ; branch when the values differ or the result is nonzero; target L1547
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       L153D     ; branch when the signed value is greater than or equal; target L153D
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       0,x       ; store b at 0,x
                    bra       L1547     ; continue execution at L1547
L153D               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
L1547               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    lbra      L17EA     ; continue execution at L17EA
L154E               ldd       #3        ; set d to the constant 3
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
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
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       $01,s     ; load b from the current stack frame at $01,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L17B2     ; continue execution at L17B2
L1676               ldd       #48       ; set d to the constant 48
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L17A9     ; continue execution at L17A9
L1697               ldd       #49       ; set d to the constant 49
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldd       #1        ; set d to the constant 1
                    lbra      L17A9     ; continue execution at L17A9
L16B9               ldd       #52       ; set d to the constant 52
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldd       #4        ; set d to the constant 4
                    lbra      L17A9     ; continue execution at L17A9
L16DB               ldd       #53       ; set d to the constant 53
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldd       #5        ; set d to the constant 5
                    lbra      L17A9     ; continue execution at L17A9
L16FD               ldd       #55       ; set d to the constant 55
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldd       #7        ; set d to the constant 7
                    lbra      L17A9     ; continue execution at L17A9
L171F               ldd       #56       ; set d to the constant 56
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldd       #8        ; set d to the constant 8
                    lbra      L17A9     ; continue execution at L17A9
L1741               lbsr      L1819     ; call subroutine L1819
                    stb       0,s       ; store b in the current stack frame at 0,s
                    ldd       #51       ; set d to the constant 51
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    addd      #30       ; add to d using #30
                    bra       L17A9     ; continue execution at L17A9
L1777               lbsr      L1819     ; call subroutine L1819
                    stb       0,s       ; store b in the current stack frame at 0,s
                    ldd       #52       ; set d to the constant 52
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    addd      #48       ; add to d using #48
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #59       ; set d to the constant 59
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    bne       L17EA     ; branch when the values differ or the result is nonzero; target L17EA
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    addd      #40       ; add to d using #40
L17A9               pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L17EA     ; continue execution at L17EA
L17B2               cmpx      #82       ; compare x with #82 and set the condition codes
                    lbeq      L1676     ; branch when the values are equal or the result is zero; target L1676
                    cmpx      #79       ; compare x with #79 and set the condition codes
                    lbeq      L1697     ; branch when the values are equal or the result is zero; target L1697
                    cmpx      #85       ; compare x with #85 and set the condition codes
                    lbeq      L16B9     ; branch when the values are equal or the result is zero; target L16B9
                    cmpx      #76       ; compare x with #76 and set the condition codes
                    lbeq      L16DB     ; branch when the values are equal or the result is zero; target L16DB
                    cmpx      #86       ; compare x with #86 and set the condition codes
                    lbeq      L16FD     ; branch when the values are equal or the result is zero; target L16FD
                    cmpx      #73       ; compare x with #73 and set the condition codes
                    lbeq      L171F     ; branch when the values are equal or the result is zero; target L171F
                    cmpx      #70       ; compare x with #70 and set the condition codes
                    lbeq      L1741     ; branch when the values are equal or the result is zero; target L1741
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      L1777     ; branch when the values are equal or the result is zero; target L1777
L17EA               ldb       $01,s     ; load b from the current stack frame at $01,s
                    cmpb      #68       ; compare b with #68 and set the condition codes
                    lbne      L154E     ; branch when the values differ or the result is nonzero; target L154E
                    ldd       #109      ; set d to the constant 109
                    pshs      d         ; save d on the stack
                    lbsr      L19C1     ; call subroutine L19C1
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0007,y  ; load d from >U0007,y
                    lbne      L1C74     ; branch when the values differ or the result is nonzero; target L1C74
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #109      ; set d to the constant 109
                    stb       0,x       ; store b at 0,x
                    lbra      L1C74     ; continue execution at L1C74

* -- method --
L1819               pshs      u         ; save u on the stack
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L18DC     ; continue execution at L18DC
L188C               ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B2A     ; call subroutine L3B2A
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    beq       L18BA     ; branch when the values are equal or the result is zero; target L18BA
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U000F,y  ; form the address >U000F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
L18BA               ldd       $01,s     ; load d from the current stack frame at $01,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U001F,y  ; form the address >U001F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    pshs      d         ; save d on the stack
                    leax      >NumString,pc ; form the address >NumString,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    addd      #1        ; add to d using #1
L18DC               std       $01,s     ; store d in the current stack frame at $01,s
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    cmpd      #8        ; compare d with #8 and set the condition codes
                    lblt      L188C     ; branch when the signed value is less; target L188C
                    leax      >ClrNum,pc ; form the address >ClrNum,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      printf    ; call subroutine printf
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >U0049,y  ; form the address >U0049,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L337C     ; call subroutine L337C
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
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    subd      #48       ; subtract from d using #48
                    stb       0,s       ; store b in the current stack frame at 0,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    leas      $03,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L1933               pshs      u         ; save u on the stack
                    ldd       #-70      ; set d to the constant -70
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      L19B6     ; branch when the signed value is greater than or equal; target L19B6
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       0,x       ; store b at 0,x
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    cmpb      #74       ; compare b with #74 and set the condition codes
                    bne       L199B     ; branch when the values differ or the result is nonzero; target L199B
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #50       ; set d to the constant 50
                    stb       0,x       ; store b at 0,x
L199B               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       0,x       ; store b at 0,x
                    lbra      L1C76     ; continue execution at L1C76
L19B6               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    lbra      L1C74     ; continue execution at L1C74

* -- method --
L19C1               pshs      u         ; save u on the stack
                    ldd       #-76      ; set d to the constant -76
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       >U0005,y  ; load d from >U0005,y
                    lbeq      L1B18     ; branch when the values are equal or the result is zero; target L1B18
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       L1A0F     ; branch when the values are equal or the result is zero; target L1A0F
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U01E7,y  ; form the address >U01E7,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >U0003,y  ; load d from >U0003,y
                    addd      #1        ; add to d using #1
                    std       >U0003,y  ; store d at >U0003,y
                    subd      #1        ; subtract from d using #1
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    stb       0,x       ; store b at 0,x
L1A0F               ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #6        ; mask b using #6
                    lbeq      L1AA2     ; branch when the values are equal or the result is zero; target L1AA2
                    ldd       >U0003,y  ; load d from >U0003,y
                    ble       L1A6C     ; branch when the signed value is less than or equal; target L1A6C
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U01E7,y  ; form the address >U01E7,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0003,y  ; load d from >U0003,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U01E7,y  ; form the address >U01E7,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    lbsr      L35CC     ; call subroutine L35CC
                    leas      $02,s     ; adjust the system stack pointer
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       L1A7B     ; continue execution at L1A7B
L1A6C               ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       0,x       ; store b at 0,x
L1A7B               ldd       >U0003,y  ; load d from >U0003,y
                    bgt       L1A87     ; branch when the signed value is greater; target L1A87
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #109      ; compare b with #109 and set the condition codes
                    beq       L1A92     ; branch when the values are equal or the result is zero; target L1A92
L1A87               ldd       >dpsiz,y  ; load d from >dpsiz,y
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; store d at >dpsiz,y
L1A92               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0003,y  ; store d at >U0003,y
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L1C78     ; call subroutine L1C78
                    leas      $02,s     ; adjust the system stack pointer
L1AA2               ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #59       ; compare b with #59 and set the condition codes
                    lbne      L1C74     ; branch when the values differ or the result is nonzero; target L1C74
                    ldd       >U0003,y  ; load d from >U0003,y
                    ble       L1AF5     ; branch when the signed value is less than or equal; target L1AF5
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U01E7,y  ; form the address >U01E7,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0003,y  ; load d from >U0003,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       >dpsiz,y  ; load d from >dpsiz,y
                    pshs      d         ; save d on the stack
                    ldd       #5        ; set d to the constant 5
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U01E7,y  ; form the address >U01E7,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    lbsr      L35CC     ; call subroutine L35CC
                    leas      $02,s     ; adjust the system stack pointer
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    bra       L1B04     ; continue execution at L1B04
L1AF5               ldd       >dpsiz,y  ; load d from >dpsiz,y
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       0,x       ; store b at 0,x
L1B04               ldd       >dpsiz,y  ; load d from >dpsiz,y
                    addd      #1        ; add to d using #1
                    std       >dpsiz,y  ; store d at >dpsiz,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0003,y  ; store d at >U0003,y
                    lbra      L1C74     ; continue execution at L1C74
L1B18               ldd       #1        ; set d to the constant 1
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
                    lbra      L1C5C     ; continue execution at L1C5C
L1B33               ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    std       >U021B,y  ; store d at >U021B,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    lble      L1C74     ; branch when the signed value is less than or equal; target L1C74
                    ldd       #23       ; set d to the constant 23
                    lbra      L1C56     ; continue execution at L1C56
L1B4C               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L1BB3     ; continue execution at L1BB3
L1B51               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1B9E     ; continue execution at L1B9E
L1B55               ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0219,y  ; load d from >U0219,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >U0009,y  ; load d from >U0009,y
                    std       0,x       ; store d at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
L1B9E               std       >U021B,y  ; store d at >U021B,y
                    ldd       >U021B,y  ; load d from >U021B,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       L1B55     ; branch when the signed value is less; target L1B55
                    ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
L1BB3               std       >U0219,y  ; store d at >U0219,y
                    ldd       >U0219,y  ; load d from >U0219,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      L1B51     ; branch when the signed value is less; target L1B51
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0219,y  ; store d at >U0219,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L1C56     ; continue execution at L1C56
L1BCE               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0219,y  ; store d at >U0219,y
                    lbra      L1C74     ; continue execution at L1C74
L1BD7               ldb       $07,s     ; load b from the current stack frame at $07,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    bge       L1BE3     ; branch when the signed value is greater than or equal; target L1BE3
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    lbge      L1C74     ; branch when the signed value is greater than or equal; target L1C74
L1BE3               ldd       >U0007,y  ; load d from >U0007,y
                    beq       L1C2B     ; branch when the values are equal or the result is zero; target L1C2B
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0219,y  ; load d from >U0219,y
                    leax      d,x       ; form the address d,x in x
                    ldb       $07,s     ; load b from the current stack frame at $07,s
                    stb       0,x       ; store b at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >U0009,y  ; load d from >U0009,y
                    std       0,x       ; store d at 0,x
L1C2B               ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
                    std       >U0219,y  ; store d at >U0219,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    blt       L1C74     ; branch when the signed value is less; target L1C74
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0219,y  ; store d at >U0219,y
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    std       >U021B,y  ; store d at >U021B,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       L1C74     ; branch when the signed value is less; target L1C74
                    ldd       #22       ; set d to the constant 22
L1C56               std       >U021B,y  ; store d at >U021B,y
                    bra       L1C74     ; continue execution at L1C74
L1C5C               cmpx      #10       ; compare x with #10 and set the condition codes
                    lbeq      L1B33     ; branch when the values are equal or the result is zero; target L1B33
                    cmpx      #12       ; compare x with #12 and set the condition codes
                    lbeq      L1B4C     ; branch when the values are equal or the result is zero; target L1B4C
                    cmpx      #13       ; compare x with #13 and set the condition codes
                    lbeq      L1BCE     ; branch when the values are equal or the result is zero; target L1BCE
                    lbra      L1BD7     ; continue execution at L1BD7
L1C74               leas      $02,s     ; adjust the system stack pointer
L1C76               puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L1C78               pshs      u         ; save u on the stack
                    ldd       #-79      ; set d to the constant -79
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0005,y  ; store d at >U0005,y
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L209D     ; continue execution at L209D
L1C90               ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; save d on the stack
                    ldb       >U01DE,y  ; load b from >U01DE,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B2A     ; call subroutine L3B2A
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       >U01DE,y  ; load b from >U01DE,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >U0219,y  ; store d at >U0219,y
                    ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    addd      #-1       ; add to d using #-1
                    std       >U021B,y  ; store d at >U021B,y
                    lbra      L20EA     ; continue execution at L20EA
L1CC9               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1CEF     ; continue execution at L1CEF
L1CCD               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AE0     ; call subroutine L3AE0
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #-1       ; add to d using #-1
                    std       >U021B,y  ; store d at >U021B,y
                    bge       L1CEA     ; branch when the signed value is greater than or equal; target L1CEA
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U021B,y  ; store d at >U021B,y
L1CEA               ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L1CEF               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       L1CCD     ; branch when the signed value is greater; target L1CCD
                    lbra      L20EA     ; continue execution at L20EA
L1CFE               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1D2B     ; continue execution at L1D2B
L1D02               ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
                    std       >U021B,y  ; store d at >U021B,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       L1D1C     ; branch when the signed value is less; target L1D1C
                    ldd       #22       ; set d to the constant 22
                    std       >U021B,y  ; store d at >U021B,y
                    bra       L1D26     ; continue execution at L1D26
L1D1C               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AE4     ; call subroutine L3AE4
                    leas      $02,s     ; adjust the system stack pointer
L1D26               ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L1D2B               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       L1D02     ; branch when the signed value is greater; target L1D02
                    lbra      L20EA     ; continue execution at L20EA
L1D3A               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1D67     ; continue execution at L1D67
L1D3E               ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
                    std       >U0219,y  ; store d at >U0219,y
                    cmpd      #79       ; compare d with #79 and set the condition codes
                    ble       L1D58     ; branch when the signed value is less than or equal; target L1D58
                    ldd       #79       ; set d to the constant 79
                    std       >U0219,y  ; store d at >U0219,y
                    bra       L1D62     ; continue execution at L1D62
L1D58               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD4     ; call subroutine L3AD4
                    leas      $02,s     ; adjust the system stack pointer
L1D62               ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L1D67               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       L1D3E     ; branch when the signed value is greater; target L1D3E
                    lbra      L20EA     ; continue execution at L20EA
L1D76               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1D9E     ; continue execution at L1D9E
L1D7A               ldd       >U0219,y  ; load d from >U0219,y
                    addd      #-1       ; add to d using #-1
                    std       >U0219,y  ; store d at >U0219,y
                    bge       L1D8F     ; branch when the signed value is greater than or equal; target L1D8F
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0219,y  ; store d at >U0219,y
                    bra       L1D99     ; continue execution at L1D99
L1D8F               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3ADC     ; call subroutine L3ADC
                    leas      $02,s     ; adjust the system stack pointer
L1D99               ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L1D9E               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       >U01DD,y  ; load b from >U01DD,y
                    sex                 ; sign-extend b into d
                    cmpd      $03,s     ; compare d with $03,s and set the condition codes
                    bgt       L1D7A     ; branch when the signed value is greater; target L1D7A
                    lbra      L20EA     ; continue execution at L20EA
L1DAD               ldd       >U0219,y  ; load d from >U0219,y
                    std       >U0221,y  ; store d at >U0221,y
                    ldd       >U021B,y  ; load d from >U021B,y
                    std       >U0223,y  ; store d at >U0223,y
                    lbra      L20EA     ; continue execution at L20EA
L1DC0               ldd       >U0221,y  ; load d from >U0221,y
                    std       >U0219,y  ; store d at >U0219,y
                    ldd       >U0223,y  ; load d from >U0223,y
                    std       >U021B,y  ; store d at >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B2A     ; call subroutine L3B2A
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L20EA     ; continue execution at L20EA
L1DE5               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L1E56     ; continue execution at L1E56
L1DF4               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L1E41     ; continue execution at L1E41
L1DF8               ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       >U0219,y  ; load d from >U0219,y
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       >U0219,y  ; load d from >U0219,y
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       >U0009,y  ; load d from >U0009,y
                    std       0,x       ; store d at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    addd      #1        ; add to d using #1
L1E41               std       >U021B,y  ; store d at >U021B,y
                    ldd       >U021B,y  ; load d from >U021B,y
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    blt       L1DF8     ; branch when the signed value is less; target L1DF8
                    ldd       >U0219,y  ; load d from >U0219,y
                    addd      #1        ; add to d using #1
L1E56               std       >U0219,y  ; store d at >U0219,y
                    ldd       >U0219,y  ; load d from >U0219,y
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      L1DF4     ; branch when the signed value is less; target L1DF4
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U021B,y  ; store d at >U021B,y
                    std       >U0219,y  ; store d at >U0219,y
                    lbra      L20EA     ; continue execution at L20EA
L1E73               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AC6     ; call subroutine L3AC6
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0219,y  ; load d from >U0219,y
                    bra       L1EC4     ; continue execution at L1EC4
L1E83               ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       >U021B,y  ; load d from >U021B,y
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
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
                    std       0,x       ; store d at 0,x
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L1EC4               std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    blt       L1E83     ; branch when the signed value is less; target L1E83
                    lbra      L20EA     ; continue execution at L20EA
L1ED1               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L208E     ; continue execution at L208E
L1ED6               ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L205D     ; continue execution at L205D
L1EE6               ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AA3     ; call subroutine L3AA3
                    leas      $04,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B0A     ; call subroutine L3B0A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B14     ; call subroutine L3B14
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B00     ; call subroutine L3B00
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L2057     ; continue execution at L2057
L1F26               ldd       >U0009,y  ; load d from >U0009,y
                    ora       #16       ; set selected bits in a using #16
                    lbra      L2057     ; continue execution at L2057
L1F2F               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B05     ; call subroutine L3B05
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    ora       #1        ; set selected bits in a using #1
                    lbra      L2057     ; continue execution at L2057
L1F42               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3B0F     ; call subroutine L3B0F
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    ora       #2        ; set selected bits in a using #2
                    lbra      L2057     ; continue execution at L2057
L1F55               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AFB     ; call subroutine L3AFB
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    ora       #4        ; set selected bits in a using #4
                    lbra      L2057     ; continue execution at L2057
L1F68               ldd       >U0009,y  ; load d from >U0009,y
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U000F,y  ; form the address >U000F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    ora       #8        ; set selected bits in a using #8
                    lbra      L2057     ; continue execution at L2057
L1F8E               ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    cmpb      #30       ; compare b with #30 and set the condition codes
                    lblt      L1FF5     ; branch when the signed value is less; target L1FF5
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    cmpb      #38       ; compare b with #38 and set the condition codes
                    bge       L1FF5     ; branch when the signed value is greater than or equal; target L1FF5
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    addd      #-30      ; add to d using #-30
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U000F,y  ; form the address >U000F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A9F     ; call subroutine L3A9F
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    andb      #15       ; mask b using #15
                    std       >U0009,y  ; store d at >U0009,y
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
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
                    lbra      L2053     ; continue execution at L2053
L1FF5               ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    cmpb      #40       ; compare b with #40 and set the condition codes
                    lblt      L2089     ; branch when the signed value is less; target L2089
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    lbge      L2089     ; branch when the signed value is greater than or equal; target L2089
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    leax      >U000F,y  ; form the address >U000F,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AA3     ; call subroutine L3AA3
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >U0009,y  ; load d from >U0009,y
                    andb      #240      ; mask b using #240
                    std       >U0009,y  ; store d at >U0009,y
                    pshs      d         ; save d on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    addd      #-40      ; add to d using #-40
L2053               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
L2057               std       >U0009,y  ; store d at >U0009,y
                    bra       L2089     ; continue execution at L2089
L205D               stx       -$02,s    ; store x in the current stack frame at -$02,s
                    lbeq      L1EE6     ; branch when the values are equal or the result is zero; target L1EE6
                    cmpx      #1        ; compare x with #1 and set the condition codes
                    lbeq      L1F26     ; branch when the values are equal or the result is zero; target L1F26
                    cmpx      #4        ; compare x with #4 and set the condition codes
                    lbeq      L1F2F     ; branch when the values are equal or the result is zero; target L1F2F
                    cmpx      #5        ; compare x with #5 and set the condition codes
                    lbeq      L1F42     ; branch when the values are equal or the result is zero; target L1F42
                    cmpx      #7        ; compare x with #7 and set the condition codes
                    lbeq      L1F55     ; branch when the values are equal or the result is zero; target L1F55
                    cmpx      #8        ; compare x with #8 and set the condition codes
                    lbeq      L1F68     ; branch when the values are equal or the result is zero; target L1F68
                    lbra      L1F8E     ; continue execution at L1F8E
L2089               ldd       $03,s     ; load d from the current stack frame at $03,s
                    addd      #1        ; add to d using #1
L208E               std       $03,s     ; store d in the current stack frame at $03,s
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    cmpd      >dpsiz,y  ; compare d with >dpsiz,y and set the condition codes
                    lblt      L1ED6     ; branch when the signed value is less; target L1ED6
                    bra       L20EA     ; continue execution at L20EA
L209D               cmpx      #72       ; compare x with #72 and set the condition codes
                    lbeq      L1C90     ; branch when the values are equal or the result is zero; target L1C90
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      L1C90     ; branch when the values are equal or the result is zero; target L1C90
                    cmpx      #65       ; compare x with #65 and set the condition codes
                    lbeq      L1CC9     ; branch when the values are equal or the result is zero; target L1CC9
                    cmpx      #66       ; compare x with #66 and set the condition codes
                    lbeq      L1CFE     ; branch when the values are equal or the result is zero; target L1CFE
                    cmpx      #67       ; compare x with #67 and set the condition codes
                    lbeq      L1D3A     ; branch when the values are equal or the result is zero; target L1D3A
                    cmpx      #68       ; compare x with #68 and set the condition codes
                    lbeq      L1D76     ; branch when the values are equal or the result is zero; target L1D76
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      L1DAD     ; branch when the values are equal or the result is zero; target L1DAD
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      L1DC0     ; branch when the values are equal or the result is zero; target L1DC0
                    cmpx      #74       ; compare x with #74 and set the condition codes
                    lbeq      L1DE5     ; branch when the values are equal or the result is zero; target L1DE5
                    cmpx      #107      ; compare x with #107 and set the condition codes
                    lbeq      L1E73     ; branch when the values are equal or the result is zero; target L1E73
                    cmpx      #109      ; compare x with #109 and set the condition codes
                    lbeq      L1ED1     ; branch when the values are equal or the result is zero; target L1ED1
L20EA               bsr       L20F0     ; call subroutine L20F0
                    leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L20F0               pshs      u         ; save u on the stack
                    ldd       #-66      ; set d to the constant -66
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$02,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L2110     ; continue execution at L2110
L20FE               ldd       0,s       ; load d from the current stack frame at 0,s
                    leax      >U01DD,y  ; form the address >U01DD,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #1        ; set d to the constant 1
                    stb       0,x       ; store b at 0,x
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
L2110               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       L20FE     ; branch when the signed value is less; target L20FE
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >dpsiz,y  ; store d at >dpsiz,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U0003,y  ; store d at >U0003,y
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L212A               pshs      u         ; save u on the stack
                    ldd       #-80      ; set d to the constant -80
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$08,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L2396     ; continue execution at L2396
L2141               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L2385     ; continue execution at L2385
L2146               ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    lbeq      L2348     ; branch when the values are equal or the result is zero; target L2348
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      $06,s     ; compare d with $06,s and set the condition codes
                    bne       L2170     ; branch when the values differ or the result is nonzero; target L2170
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      $04,s     ; compare d with $04,s and set the condition codes
                    lbeq      L22AD     ; branch when the values are equal or the result is zero; target L22AD
L2170               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #8        ; add to d using #8
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      L22A3     ; branch when the signed value is greater than or equal; target L22A3
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       0,x       ; store b at 0,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       L21E4     ; branch when the signed value is less; target L21E4
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L3711     ; call subroutine L3711
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
L21E4               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L36BE     ; call subroutine L36BE
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       0,x       ; store b at 0,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       L2258     ; branch when the signed value is less; target L2258
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L3711     ; call subroutine L3711
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
L2258               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #1        ; add to d using #1
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L36BE     ; call subroutine L36BE
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #72       ; set d to the constant 72
                    stb       0,x       ; store b at 0,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L22AD     ; continue execution at L22AD
L22A3               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
L22AD               ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       0,x       ; load d from 0,x
                    cmpd      >U0009,y  ; compare d with >U0009,y and set the condition codes
                    beq       L22F7     ; branch when the values are equal or the result is zero; target L22F7
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
                    leax      d,x       ; form the address d,x in x
                    tfr       x,d       ; copy the register values specified by x,d
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    addd      ,s++      ; add to d using ,s++
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    lbsr      L23A6     ; call subroutine L23A6
                    leas      $02,s     ; adjust the system stack pointer
L22F7               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #1        ; add to d using #1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #79       ; compare d with #79 and set the condition codes
                    ble       L2348     ; branch when the signed value is less than or equal; target L2348
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #22       ; compare d with #22 and set the condition codes
                    ble       L2344     ; branch when the signed value is less than or equal; target L2344
                    ldd       #22       ; set d to the constant 22
                    std       0,s       ; store d in the current stack frame at 0,s
L2344               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
L2348               ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #80       ; set d to the constant 80
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2225,y  ; form the address >U2225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #160      ; set d to the constant 160
                    lbsr      L365D     ; call subroutine L365D
                    leax      >U2955,y  ; form the address >U2955,y in x
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
                    std       0,x       ; store d at 0,x
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
L2385               std       $06,s     ; store d in the current stack frame at $06,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    cmpd      #80       ; compare d with #80 and set the condition codes
                    lblt      L2146     ; branch when the signed value is less; target L2146
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #1        ; add to d using #1
L2396               std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #23       ; compare d with #23 and set the condition codes
                    lblt      L2141     ; branch when the signed value is less; target L2141
                    leas      $08,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L23A6               pshs      u         ; save u on the stack
                    ldd       #-70      ; set d to the constant -70
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #2        ; add to d using #2
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    bge       L23EF     ; branch when the signed value is greater than or equal; target L23EF
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #27       ; set d to the constant 27
                    stb       0,x       ; store b at 0,x
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #91       ; set d to the constant 91
                    stb       0,x       ; store b at 0,x
                    bra       L23F9     ; continue execution at L23F9
L23EF               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
L23F9               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #16       ; mask a using #16
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L2415     ; branch when the values are equal or the result is zero; target L2415
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L2415               ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L2428     ; branch when the values are equal or the result is zero; target L2428
                    ldd       #4        ; set d to the constant 4
                    pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L2428               ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #2        ; mask a using #2
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L243B     ; branch when the values are equal or the result is zero; target L243B
                    ldd       #5        ; set d to the constant 5
                    pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L243B               ldd       $04,s     ; load d from the current stack frame at $04,s
                    anda      #4        ; mask a using #4
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L244E     ; branch when the values are equal or the result is zero; target L244E
                    ldd       #7        ; set d to the constant 7
                    pshs      d         ; save d on the stack
                    lbsr      L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L244E               ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #240      ; mask b using #240
                    beq       L246B     ; branch when the values are equal or the result is zero; target L246B
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
                    bsr       L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L246B               ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    beq       L2480     ; branch when the values are equal or the result is zero; target L2480
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    addd      #40       ; add to d using #40
                    pshs      d         ; save d on the stack
                    bsr       L249A     ; call subroutine L249A
                    leas      $02,s     ; adjust the system stack pointer
L2480               ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >U0009,y  ; store d at >U0009,y
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #-1       ; add to d using #-1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #109      ; set d to the constant 109
                    stb       0,x       ; store b at 0,x
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L249A               pshs      u         ; save u on the stack
                    ldd       #-72      ; set d to the constant -72
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #3        ; add to d using #3
                    cmpd      #8192     ; compare d with #8192 and set the condition codes
                    lbge      L251E     ; branch when the signed value is greater than or equal; target L251E
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    blt       L24DE     ; branch when the signed value is less; target L24DE
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L3711     ; call subroutine L3711
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
L24DE               ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L36BE     ; call subroutine L36BE
                    addd      #48       ; add to d using #48
                    stb       [,s++]    ; store b in the current stack frame at [,s++]
                    ldd       >U000D,y  ; load d from >U000D,y
                    addd      #1        ; add to d using #1
                    std       >U000D,y  ; store d at >U000D,y
                    subd      #1        ; subtract from d using #1
                    leax      >U0225,y  ; form the address >U0225,y in x
                    leax      d,x       ; form the address d,x in x
                    ldd       #59       ; set d to the constant 59
                    stb       0,x       ; store b at 0,x
                    bra       L2528     ; continue execution at L2528
L251E               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AD8     ; call subroutine L3AD8
                    leas      $02,s     ; adjust the system stack pointer
L2528               puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L252A               pshs      u         ; save u on the stack
                    ldd       #-106     ; set d to the constant -106
                    lbsr      _stkcheck ; call subroutine _stkcheck
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L37B9     ; call subroutine L37B9
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       <$0025,s  ; load b from the current stack frame at <$0025,s
                    stb       $04,s     ; store b in the current stack frame at $04,s
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L37F4     ; call subroutine L37F4
                    leas      $06,s     ; adjust the system stack pointer
                    leas      <$0020,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller

* -- method --
L2561               pshs      u         ; save u on the stack
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
                    lbsr      L3A52     ; call subroutine L3A52
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
                    lbsr      L3A52     ; call subroutine L3A52
                    leas      <$0010,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3AEC     ; call subroutine L3AEC
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L3545     ; call subroutine L3545
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       #2        ; set d to the constant 2
                    lbsr      L3711     ; call subroutine L3711
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
                    lbsr      L3A82     ; call subroutine L3A82
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L3A82     ; call subroutine L3A82
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
                    fcc       "Read file to [O]utput buffer or [s]creen buffer" ; store literal character data
                    fcb       $00       ; store byte data
AddLf               fcb       $0D       ; store byte data
                    fcc       "Add line feeds to carriage returns?" ; store literal character data
                    fcb       $00       ; store byte data
Status              fcc       "x=%2d y=%2d   Status:" ; store literal character data
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
L281F               fcc       "u" ; store literal character data
                    fcb       $00       ; store byte data
L2821               fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
L2823               fcc       "L" ; store literal character data
                    fcb       $00       ; store byte data
L2825               fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
L2827               fcc       "V" ; store literal character data
                    fcb       $00       ; store byte data
L2829               fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
L282B               fcc       "I" ; store literal character data
                    fcb       $00       ; store byte data
L282D               fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
L282F               fcc       "O" ; store literal character data
                    fcb       $00       ; store byte data
L2831               fcc       " " ; store literal character data
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
AltE                fcc       " [ALT][e] - Edit mode" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltC                fcc       " [ALT][C] - Clear screen" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltN                fcc       " [ALT][N] - Clear to end of line" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltS                fcc       " [ALT][s] - Save cursor position" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltA                fcc       " [ALT][a] - Restore cursor position" ; store literal character data
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
AltX                fcc       " [ALT][x] - Save & Exit" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
AltQ                fcc       " [ALT][q] - Quit without save" ; store literal character data
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
                    fcc       "Zap:   s> Screen Buffer" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
RecBuff             fcc       "       R> Record Buffer" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
BothBuffs           fcc       "       b> Both   buffers" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
ScrnChar            fcc       "       d> Screen Character" ; store literal character data
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
L2BE6               fcc       " " ; store literal character data
                    fcb       $00       ; store byte data
L2BE8               fcc       " " ; store literal character data
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
UndrOn              fcc       "[u] - Underscore on" ; store literal character data
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
SetForClr           fcc       "[f] - Set foreground color" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
SetBckClr           fcc       "[b] - Set background color" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Done                fcc       "[d] - Done" ; store literal character data
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
                    leax      >U0049,y  ; form the address >U0049,y in x
                    stx       >U37B5,y  ; store x at >U37B5,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       L2D6D     ; continue execution at L2D6D
                    pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >U37B5,y  ; store d at >U37B5,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
L2D6D               pshs      d         ; save d on the stack
                    leax      >L3225,pc ; form the address >L3225,pc in x
                    pshs      x         ; save x on the stack
                    bsr       L2D9F     ; call subroutine L2D9F
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >U37B5,y  ; store d at >U37B5,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    leax      >L3238,pc ; form the address >L3238,pc in x
                    pshs      x         ; save x on the stack
                    bsr       L2D9F     ; call subroutine L2D9F
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [>$37B5,y] ; store b at [>$37B5,y]
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    puls      pc,u      ; restore pc,u and return to the caller
L2D9F               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       L2DB7     ; continue execution at L2DB7
L2DA7               ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      L2FE8     ; branch when the values are equal or the result is zero; target L2FE8
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
L2DB7               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       L2DA7     ; branch when the values differ or the result is nonzero; target L2DA7
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L2DDC     ; branch when the values differ or the result is nonzero; target L2DDC
                    ldd       #1        ; set d to the constant 1
                    std       >U37CB,y  ; store d at >U37CB,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L2DE2     ; continue execution at L2DE2
L2DDC               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >U37CB,y  ; store d at >U37CB,y
L2DE2               ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       L2DED     ; branch when the values differ or the result is nonzero; target L2DED
                    ldd       #48       ; set d to the constant 48
                    bra       L2DF0     ; continue execution at L2DF0
L2DED               ldd       #32       ; set d to the constant 32
L2DF0               std       >U37CD,y  ; store d at >U37CD,y
                    bra       L2E10     ; continue execution at L2E10
L2DF6               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L365D     ; call subroutine L365D
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
L2E10               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L2DF6     ; branch when the values differ or the result is nonzero; target L2DF6
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       L2E59     ; branch when the values differ or the result is nonzero; target L2E59
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L2E43     ; continue execution at L2E43
L2E2D               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L365D     ; call subroutine L365D
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
L2E43               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L2E2D     ; branch when the values differ or the result is nonzero; target L2E2D
                    bra       L2E5D     ; continue execution at L2E5D
L2E59               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
L2E5D               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L2F8B     ; continue execution at L2F8B
L2E65               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L2FEC     ; call subroutine L2FEC
                    bra       L2E8D     ; continue execution at L2E8D
L2E7A               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L30A9     ; call subroutine L30A9
L2E8D               std       0,s       ; store d in the current stack frame at 0,s
                    lbra      L2F71     ; continue execution at L2F71
L2E92               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    pshs      d         ; save d on the stack
                    ldx       <$0017,s  ; load x from the current stack frame at <$0017,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L30F1     ; call subroutine L30F1
                    lbra      L2F6D     ; continue execution at L2F6D
L2EB8               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L3030     ; call subroutine L3030
                    lbra      L2F6D     ; continue execution at L2F6D
L2ED4               ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       L2EDD     ; branch when the values differ or the result is nonzero; target L2EDD
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
L2EDD               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L353A     ; call subroutine L353A
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L2F6F     ; continue execution at L2F6F
L2EF7               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      L2F81     ; continue execution at L2F81
L2F04               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       L2F4C     ; branch when the values are equal or the result is zero; target L2F4C
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L2F26     ; continue execution at L2F26
L2F1A               ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       L2F32     ; branch when the values are equal or the result is zero; target L2F32
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
L2F26               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L2F1A     ; branch when the values differ or the result is nonzero; target L2F1A
L2F32               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      L315C     ; call subroutine L315C
                    leas      $08,s     ; adjust the system stack pointer
                    bra       L2F7B     ; continue execution at L2F7B
L2F4C               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       L2F6F     ; continue execution at L2F6F
L2F54               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L2F5C     ; continue execution at L2F5C
                    leas      -$0B,x    ; adjust the system stack pointer
L2F5C               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L34FC     ; call subroutine L34FC
L2F6D               leas      $04,s     ; adjust the system stack pointer
L2F6F               pshs      d         ; save d on the stack
L2F71               ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      L31BE     ; call subroutine L31BE
                    leas      $06,s     ; adjust the system stack pointer
L2F7B               lbra      L2DB7     ; continue execution at L2DB7
L2F7E               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
L2F81               pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L2DB7     ; continue execution at L2DB7
L2F8B               cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      L2E65     ; branch when the values are equal or the result is zero; target L2E65
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L2E7A     ; branch when the values are equal or the result is zero; target L2E7A
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L2E92     ; branch when the values are equal or the result is zero; target L2E92
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      L2E92     ; branch when the values are equal or the result is zero; target L2E92
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      L2EB8     ; branch when the values are equal or the result is zero; target L2EB8
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      L2ED4     ; branch when the values are equal or the result is zero; target L2ED4
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      L2ED4     ; branch when the values are equal or the result is zero; target L2ED4
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      L2ED4     ; branch when the values are equal or the result is zero; target L2ED4
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      L2ED4     ; branch when the values are equal or the result is zero; target L2ED4
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      L2ED4     ; branch when the values are equal or the result is zero; target L2ED4
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      L2EF7     ; branch when the values are equal or the result is zero; target L2EF7
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      L2F04     ; branch when the values are equal or the result is zero; target L2F04
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      L2F54     ; branch when the values are equal or the result is zero; target L2F54
                    bra       L2F7E     ; continue execution at L2F7E
L2FE8               leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L2FEC               pshs      u,d       ; save u,d on the stack
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       L3021     ; branch when the signed value is greater than or equal; target L3021
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       L3016     ; branch when the signed value is greater than or equal; target L3016
                    leax      >L324A,pc ; form the address >L324A,pc in x
                    pshs      x         ; save x on the stack
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L3556     ; call subroutine L3556
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L30ED     ; continue execution at L30ED
L3016               ldd       #45       ; set d to the constant 45
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L3021               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       L3030     ; call subroutine L3030
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L30E7     ; continue execution at L30E7
L3030               pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L304D     ; continue execution at L304D
L303E               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >U002F,y  ; subtract from d using >U002F,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
L304D               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       L303E     ; branch when the signed value is less; target L303E
                    leax      >U002F,y  ; form the address >U002F,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       L308F     ; continue execution at L308F
L3059               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
L3060               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       L3059     ; branch when the signed value is greater than or equal; target L3059
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    beq       L3079     ; branch when the values are equal or the result is zero; target L3079
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
L3079               ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L3084     ; branch when the values are equal or the result is zero; target L3084
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
L3084               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
L308F               ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >U0037,y  ; compare d with >U0037,y and set the condition codes
                    bne       L3060     ; branch when the values differ or the result is nonzero; target L3060
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       U0000,u   ; store b at U0000,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L30A9               pshs      u,d       ; save u,d on the stack
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    leau      >U37C1,y  ; form the workspace or data address >U37C1,y in u
L30B5               ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       L30B5     ; branch when the values differ or the result is nonzero; target L30B5
                    bra       L30D7     ; continue execution at L30D7
L30CD               ldb       U0000,u   ; load b from U0000,u
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L30D7               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >U37C1,y  ; form the address >U37C1,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L30CD     ; branch when the unsigned value is lower or equal; target L30CD
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
L30E7               leax      >U37B7,y  ; form the address >U37B7,y in x
                    tfr       x,d       ; copy the register values specified by x,d
L30ED               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L30F1               pshs      u,x,d     ; save u,x,d on the stack
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >U37C1,y  ; form the workspace or data address >U37C1,y in u
L30FD               ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       0,s       ; store d in the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       L311F     ; branch when the signed value is less than or equal; target L311F
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       L3117     ; branch when the values are equal or the result is zero; target L3117
                    ldd       #65       ; set d to the constant 65
                    bra       L311A     ; continue execution at L311A
L3117               ldd       #97       ; set d to the constant 97
L311A               addd      #-10      ; add to d using #-10
                    bra       L3122     ; continue execution at L3122
L311F               ldd       #48       ; set d to the constant 48
L3122               addd      ,s++      ; add to d using ,s++
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
                    bne       L30FD     ; branch when the values differ or the result is nonzero; target L30FD
                    bra       L3142     ; continue execution at L3142
L3138               ldb       U0000,u   ; load b from U0000,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
L3142               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >U37C1,y  ; form the address >U37C1,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L3138     ; branch when the unsigned value is lower or equal; target L3138
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >U37B7,y  ; form the address >U37B7,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      L3234     ; continue execution at L3234
L315C               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >U37CB,y  ; load d from >U37CB,y
                    bne       L3191     ; branch when the values differ or the result is nonzero; target L3191
                    bra       L3179     ; continue execution at L3179
L316E               ldd       >U37CD,y  ; load d from >U37CD,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L3179               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L316E     ; branch when the signed value is greater; target L316E
                    bra       L3191     ; continue execution at L3191
L3187               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L3191               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L3187     ; branch when the values differ or the result is nonzero; target L3187
                    ldd       >U37CB,y  ; load d from >U37CB,y
                    beq       L31BC     ; branch when the values are equal or the result is zero; target L31BC
                    bra       L31B0     ; continue execution at L31B0
L31A5               ldd       >U37CD,y  ; load d from >U37CD,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L31B0               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L31A5     ; branch when the signed value is greater; target L31A5
L31BC               puls      pc,u      ; restore pc,u and return to the caller
L31BE               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L3545     ; call subroutine L3545
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >U37CB,y  ; load d from >U37CB,y
                    bne       L3200     ; branch when the values differ or the result is nonzero; target L3200
                    bra       L31E8     ; continue execution at L31E8
L31DD               ldd       >U37CD,y  ; load d from >U37CD,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L31E8               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L31DD     ; branch when the signed value is greater; target L31DD
                    bra       L3200     ; continue execution at L3200
L31F6               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L3200               ldb       U0000,u   ; load b from U0000,u
                    bne       L31F6     ; branch when the values differ or the result is nonzero; target L31F6
                    ldd       >U37CB,y  ; load d from >U37CB,y
                    beq       L3223     ; branch when the values are equal or the result is zero; target L3223
                    bra       L3217     ; continue execution at L3217
L320C               ldd       >U37CD,y  ; load d from >U37CD,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L3217               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L320C     ; branch when the signed value is greater; target L320C
L3223               puls      pc,u      ; restore pc,u and return to the caller
L3225               pshs      u         ; save u on the stack
                    ldd       >U37B5,y  ; load d from >U37B5,y
                    pshs      d         ; save d on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L3251     ; call subroutine L3251
L3234               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L3238               pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    ldx       >U37B5,y  ; load x from >U37B5,y
                    leax      $01,x     ; form the address $01,x in x
                    stx       >U37B5,y  ; store x at >U37B5,y
                    stb       -$01,x    ; store b at -$01,x
                    puls      pc,u      ; restore pc,u and return to the caller
L324A               fcc       "-32768" ; store literal character data
                    fcb       $00       ; store byte data
L3251               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    andb      #34       ; mask b using #34
                    cmpd      #-32766   ; compare d with #-32766 and set the condition codes
                    beq       L3275     ; branch when the values are equal or the result is zero; target L3275
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    lbne      L338D     ; branch when the values differ or the result is nonzero; target L338D
                    pshs      u         ; save u on the stack
                    lbsr      L346C     ; call subroutine L346C
                    leas      $02,s     ; adjust the system stack pointer
L3275               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #4        ; mask b using #4
                    beq       L32B1     ; branch when the values are equal or the result is zero; target L32B1
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L3296     ; branch when the values are equal or the result is zero; target L3296
                    leax      >writln,pc ; form the address >writln,pc in x
                    bra       L329A     ; continue execution at L329A
L3296               leax      >write,pc ; form the address >write,pc in x
L329A               tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       0,x       ; call subroutine 0,x
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L32F2     ; branch when the values differ or the result is nonzero; target L32F2
                    ldd       U0006,u   ; load d from U0006,u
                    orb       #32       ; set selected bits in b using #32
                    std       U0006,u   ; store d at U0006,u
                    lbra      L338D     ; continue execution at L338D
L32B1               ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L32C1     ; branch when the values differ or the result is nonzero; target L32C1
                    pshs      u         ; save u on the stack
                    lbsr      L33AA     ; call subroutine L33AA
                    leas      $02,s     ; adjust the system stack pointer
L32C1               ldd       U0000,u   ; load d from U0000,u
                    addd      #1        ; add to d using #1
                    std       U0000,u   ; store d at U0000,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    stb       0,x       ; store b at 0,x
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    bcc       L32E7     ; branch when carry is clear; target L32E7
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L32F2     ; branch when the values are equal or the result is zero; target L32F2
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      #13       ; compare d with #13 and set the condition codes
                    bne       L32F2     ; branch when the values differ or the result is nonzero; target L32F2
L32E7               pshs      u         ; save u on the stack
                    lbsr      L33AA     ; call subroutine L33AA
                    std       ,s++      ; store d in the current stack frame at ,s++
                    lbne      L338D     ; branch when the values differ or the result is nonzero; target L338D
L32F2               ldd       $04,s     ; load d from the current stack frame at $04,s
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    ldd       #8        ; set d to the constant 8
                    lbsr      L3787     ; call subroutine L3787
                    pshs      d         ; save d on the stack
                    lbsr      L3251     ; call subroutine L3251
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L3251     ; call subroutine L3251
                    lbra      L3464     ; continue execution at L3464
L3319               pshs      u,d       ; save u,d on the stack
                    leau      >U003C,y  ; form the workspace or data address >U003C,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L332F     ; continue execution at L332F
L3325               tfr       u,d       ; copy the register values specified by u,d
                    leau      U000D,u   ; form the workspace or data address U000D,u in u
                    pshs      d         ; save d on the stack
                    bsr       L3342     ; call subroutine L3342
                    leas      $02,s     ; adjust the system stack pointer
L332F               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       L3325     ; branch when the signed value is less; target L3325
                    lbra      L33A6     ; continue execution at L33A6
L3342               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       L3352     ; branch when the values are equal or the result is zero; target L3352
                    ldd       U0006,u   ; load d from U0006,u
                    bne       L3358     ; branch when the values differ or the result is nonzero; target L3358
L3352               ldd       #-1       ; set d to the constant -1
                    lbra      L33A6     ; continue execution at L33A6
L3358               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       L3367     ; branch when the values are equal or the result is zero; target L3367
                    pshs      u         ; save u on the stack
                    bsr       L337C     ; call subroutine L337C
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L3369     ; continue execution at L3369
L3367               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L3369               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      close     ; call subroutine close
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U0006,u   ; store d at U0006,u
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bra       L33A6     ; continue execution at L33A6
L337C               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L338D     ; branch when the values are equal or the result is zero; target L338D
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L3392     ; branch when the values are equal or the result is zero; target L3392
L338D               ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
L3392               ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L33A2     ; branch when the values differ or the result is nonzero; target L33A2
                    pshs      u         ; save u on the stack
                    lbsr      L346C     ; call subroutine L346C
                    leas      $02,s     ; adjust the system stack pointer
L33A2               pshs      u         ; save u on the stack
                    bsr       L33AA     ; call subroutine L33AA
L33A6               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L33AA               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L33DC     ; branch when the values differ or the result is nonzero; target L33DC
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    beq       L33DC     ; branch when the values are equal or the result is zero; target L33DC
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L3468     ; call subroutine L3468
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L38FE     ; call subroutine L38FE
                    leas      $08,s     ; adjust the system stack pointer
L33DC               ldd       U0000,u   ; load d from U0000,u
                    subd      U0002,u   ; subtract from d using U0002,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      L3454     ; branch when the values are equal or the result is zero; target L3454
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      L3454     ; branch when the values are equal or the result is zero; target L3454
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L342B     ; branch when the values are equal or the result is zero; target L342B
                    ldd       U0002,u   ; load d from U0002,u
                    bra       L3423     ; continue execution at L3423
L33FC               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0000,u   ; load d from U0000,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      writln    ; call subroutine writln
                    leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L3419     ; branch when the values differ or the result is nonzero; target L3419
                    leax      $04,s     ; form the address $04,s in x
                    bra       L3443     ; continue execution at L3443
L3419               ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      0,s       ; subtract from d using 0,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       U0000,u   ; load d from U0000,u
                    addd      0,s       ; add to d using 0,s
L3423               std       U0000,u   ; store d at U0000,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       L33FC     ; branch when the values differ or the result is nonzero; target L33FC
                    bra       L3454     ; continue execution at L3454
L342B               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      write     ; call subroutine write
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       L3454     ; branch when the values are equal or the result is zero; target L3454
                    bra       L3445     ; continue execution at L3445
L3443               leas      -$04,x    ; adjust the system stack pointer
L3445               ldd       U0006,u   ; load d from U0006,u
                    orb       #32       ; set selected bits in b using #32
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    std       U0000,u   ; store d at U0000,u
                    ldd       #-1       ; set d to the constant -1
                    bra       L3464     ; continue execution at L3464
L3454               ldd       U0006,u   ; load d from U0006,u
                    ora       #1        ; set selected bits in a using #1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0002,u   ; load d from U0002,u
                    std       U0000,u   ; store d at U0000,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L3464               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L3468               pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
L346C               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       L34A4     ; branch when the values differ or the result is nonzero; target L34A4
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L37B9     ; call subroutine L37B9
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       L3498     ; branch when the values differ or the result is nonzero; target L3498
                    ldd       #64       ; set d to the constant 64
                    bra       L349B     ; continue execution at L349B
L3498               ldd       #128      ; set d to the constant 128
L349B               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
                    leas      <$0020,s  ; adjust the system stack pointer
L34A4               ldd       U0006,u   ; load d from U0006,u
                    ora       #128      ; set selected bits in a using #128
                    std       U0006,u   ; store d at U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       L34B1     ; branch when the values are equal or the result is zero; target L34B1
                    puls      pc,u      ; restore pc,u and return to the caller
L34B1               ldd       U000B,u   ; load d from U000B,u
                    bne       L34C6     ; branch when the values differ or the result is nonzero; target L34C6
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L34C1     ; branch when the values are equal or the result is zero; target L34C1
                    ldd       #128      ; set d to the constant 128
                    bra       L34C4     ; continue execution at L34C4
L34C1               ldd       #256      ; set d to the constant 256
L34C4               std       U000B,u   ; store d at U000B,u
L34C6               ldd       U0002,u   ; load d from U0002,u
                    bne       L34DB     ; branch when the values differ or the result is nonzero; target L34DB
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    lbsr      L39EE     ; call subroutine L39EE
                    leas      $02,s     ; adjust the system stack pointer
                    std       U0002,u   ; store d at U0002,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L34E3     ; branch when the values are equal or the result is zero; target L34E3
L34DB               ldd       U0006,u   ; load d from U0006,u
                    orb       #8        ; set selected bits in b using #8
                    std       U0006,u   ; store d at U0006,u
                    bra       L34F2     ; continue execution at L34F2
L34E3               ldd       U0006,u   ; load d from U0006,u
                    orb       #4        ; set selected bits in b using #4
                    std       U0006,u   ; store d at U0006,u
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
L34F2               ldd       U0002,u   ; load d from U0002,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    std       U0000,u   ; store d at U0000,u
                    puls      pc,u      ; restore pc,u and return to the caller
L34FC               pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       L3522     ; continue execution at L3522
L3505               ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >L3539,pc ; form the address >L3539,pc in x
                    bra       L351E     ; continue execution at L351E
L3514               ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >U003A,y  ; store b at >U003A,y
                    leax      >U0039,y  ; form the address >U0039,y in x
L351E               tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L3522               cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       L3505     ; branch when the values are equal or the result is zero; target L3505
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L3505     ; branch when the values are equal or the result is zero; target L3505
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L3505     ; branch when the values are equal or the result is zero; target L3505
                    bra       L3514     ; continue execution at L3514
                    puls      pc,u      ; restore pc,u and return to the caller
L3539               fcb       $00       ; store byte data
L353A               pshs      u         ; save u on the stack
                    leax      >L3544,pc ; form the address >L3544,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L3544               fcb       $00       ; store byte data
L3545               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
L3549               ldb       ,u+       ; load b from ,u+
                    bne       L3549     ; branch when the values differ or the result is nonzero; target L3549
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
L3556               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L3560               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L3560     ; branch when the values differ or the result is nonzero; target L3560
                    bra       L3595     ; continue execution at L3595
                    pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L3578               ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       L3578     ; branch when the values differ or the result is nonzero; target L3578
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #-1       ; add to d using #-1
                    std       0,s       ; store d in the current stack frame at 0,s
L3589               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L3589     ; branch when the values differ or the result is nonzero; target L3589
L3595               ldd       $06,s     ; load d from the current stack frame at $06,s
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    bra       L35B1     ; continue execution at L35B1
L35A1               ldx       $06,s     ; load x from the current stack frame at $06,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       L35AF     ; branch when the values differ or the result is nonzero; target L35AF
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
L35AF               leau      dpsiz,u   ; form the workspace or data address dpsiz,u in u
L35B1               ldb       U0000,u   ; load b from U0000,u
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       L35A1     ; branch when the values are equal or the result is zero; target L35A1
                    ldb       [<$06,s]  ; load b from the current stack frame at [<$06,s]
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       U0000,u   ; load b from U0000,u
                    sex                 ; sign-extend b into d
                    subd      ,s++      ; subtract from d using ,s++
                    puls      pc,u      ; restore pc,u and return to the caller
L35CC               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $01,s     ; store d in the current stack frame at $01,s
L35D6               ldb       ,u+       ; load b from ,u+
                    stb       0,s       ; store b in the current stack frame at 0,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    beq       L35D6     ; branch when the values are equal or the result is zero; target L35D6
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #9        ; compare b with #9 and set the condition codes
                    lbeq      L35D6     ; branch when the values are equal or the result is zero; target L35D6
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L35F1     ; branch when the values differ or the result is nonzero; target L35F1
                    ldd       #1        ; set d to the constant 1
                    bra       L35F3     ; continue execution at L35F3
L35F1               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L35F3               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    beq       L3619     ; branch when the values are equal or the result is zero; target L3619
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       L361D     ; branch when the values differ or the result is nonzero; target L361D
                    bra       L3619     ; continue execution at L3619
L3603               ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L365D     ; call subroutine L365D
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
L3619               ldb       ,u+       ; load b from ,u+
                    stb       0,s       ; store b in the current stack frame at 0,s
L361D               ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    leax      >U010D,y  ; form the address >U010D,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L3603     ; branch when the values differ or the result is nonzero; target L3603
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    beq       L3639     ; branch when the values are equal or the result is zero; target L3639
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       L363B     ; continue execution at L363B
L3639               ldd       $01,s     ; load d from the current stack frame at $01,s
L363B               leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L363F               pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       L3651     ; branch when the values are equal or the result is zero; target L3651
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L365D     ; call subroutine L365D
                    bra       L3654     ; continue execution at L3654
L3651               ldd       #1        ; set d to the constant 1
L3654               pshs      d         ; save d on the stack
                    lbsr      sleep     ; call subroutine sleep
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L365D               tsta                ; set condition codes from a without changing it
                    bne       L3672     ; branch when the values differ or the result is nonzero; target L3672
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       L3672     ; branch when the values differ or the result is nonzero; target L3672
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       0,s       ; store d in the current stack frame at 0,s
                    puls      pc,d      ; restore pc,d and return to the caller
L3672               pshs      d         ; save d on the stack
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
                    bcc       L368F     ; branch when carry is clear; target L368F
                    inc       0,s       ; increment the value at 0,s
L368F               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       L369C     ; branch when carry is clear; target L369C
                    inc       0,s       ; increment the value at 0,s
L369C               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      0,s       ; add to d using 0,s
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leas      $08,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    clr       >U37CF,y  ; clear >U37CF,y to zero and set the condition codes
                    leax      >L36F8,pc ; form the address >L36F8,pc in x
                    stx       >U37D0,y  ; store x at >U37D0,y
                    bra       L36D2     ; continue execution at L36D2
L36BE               leax      >L3711,pc ; form the address >L3711,pc in x
                    stx       >U37D0,y  ; store x at >U37D0,y
                    clr       >U37CF,y  ; clear >U37CF,y to zero and set the condition codes
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bpl       L36D2     ; branch when the result is nonnegative; target L36D2
                    inc       >U37CF,y  ; increment the value at >U37CF,y
L36D2               subd      #0        ; subtract from d using #0
                    bne       L36DD     ; branch when the values differ or the result is nonzero; target L36DD
                    puls      x         ; restore x from the stack
                    ldd       ,s++      ; load d from the current stack frame at ,s++
                    jmp       0,x       ; continue execution at 0,x
L36DD               ldx       $02,s     ; load x from the current stack frame at $02,s
                    pshs      x         ; save x on the stack
                    jsr       [>$37D0,y] ; call subroutine [>$37D0,y]
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tfr       x,d       ; copy the register values specified by x,d
                    tst       >U37CF,y  ; set condition codes from >U37CF,y without changing it
                    beq       L36F5     ; branch when the values are equal or the result is zero; target L36F5
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
L36F5               std       ,s++      ; store d in the current stack frame at ,s++
                    rts                 ; return to the caller
L36F8               subd      #0        ; subtract from d using #0
                    beq       L3707     ; branch when the values are equal or the result is zero; target L3707
                    pshs      d         ; save d on the stack
                    leas      -$02,s    ; adjust the system stack pointer
                    clr       0,s       ; clear 0,s to zero and set the condition codes
                    clr       $01,s     ; clear $01,s to zero and set the condition codes
                    bra       L3735     ; continue execution at L3735
L3707               puls      d         ; restore d from the stack
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       #45       ; set d to the constant 45
                    lbra      send      ; continue execution at send
L3711               subd      #0        ; subtract from d using #0
                    beq       L3707     ; branch when the values are equal or the result is zero; target L3707
                    pshs      d         ; save d on the stack
                    leas      -$02,s    ; adjust the system stack pointer
                    clr       0,s       ; clear 0,s to zero and set the condition codes
                    clr       $01,s     ; clear $01,s to zero and set the condition codes
                    tsta                ; set condition codes from a without changing it
                    bpl       L3729     ; branch when the result is nonnegative; target L3729
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    inc       $01,s     ; increment the value at $01,s
                    std       $02,s     ; store d in the current stack frame at $02,s
L3729               ldd       $06,s     ; load d from the current stack frame at $06,s
                    bpl       L3735     ; branch when the result is nonnegative; target L3735
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    com       $01,s     ; complement the value at $01,s
                    std       $06,s     ; store d in the current stack frame at $06,s
L3735               lda       #1        ; set a to the constant 1
L3737               inca                ; increment a
                    asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    bpl       L3737     ; branch when the result is nonnegative; target L3737
                    sta       0,s       ; store a in the current stack frame at 0,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    clr       $06,s     ; clear $06,s to zero and set the condition codes
                    clr       $07,s     ; clear $07,s to zero and set the condition codes
L3746               subd      $02,s     ; subtract from d using $02,s
                    bcc       L3750     ; branch when carry is clear; target L3750
                    addd      $02,s     ; add to d using $02,s
                    andcc     #254      ; clear selected condition-code bits using #254
                    bra       L3752     ; continue execution at L3752
L3750               orcc      #1        ; set selected condition-code bits using #1
L3752               rol       $07,s     ; rotate left through carry the value at $07,s
                    rol       $06,s     ; rotate left through carry the value at $06,s
                    lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    dec       0,s       ; decrement the value at 0,s
                    bne       L3746     ; branch when the values differ or the result is nonzero; target L3746
                    std       $02,s     ; store d in the current stack frame at $02,s
                    tst       $01,s     ; set condition codes from $01,s without changing it
                    beq       L376C     ; branch when the values are equal or the result is zero; target L376C
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
L376C               ldx       $04,s     ; load x from the current stack frame at $04,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    stx       $06,s     ; store x in the current stack frame at $06,s
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    leas      $06,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       L3791     ; branch when the values are equal or the result is zero; target L3791
L377E               asr       $02,s     ; shift right arithmetically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       L377E     ; branch when the values differ or the result is nonzero; target L377E
                    bra       L3791     ; continue execution at L3791
L3787               tstb                ; set condition codes from b without changing it
                    beq       L3791     ; branch when the values are equal or the result is zero; target L3791
L378A               lsr       $02,s     ; shift right logically the value at $02,s
                    ror       $03,s     ; rotate right through carry the value at $03,s
                    decb                ; decrement b
                    bne       L378A     ; branch when the values differ or the result is nonzero; target L378A
L3791               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    tstb                ; set condition codes from b without changing it
                    beq       L3791     ; branch when the values are equal or the result is zero; target L3791
L37A1               asl       $03,s     ; shift left the value at $03,s
                    rol       $02,s     ; rotate left through carry the value at $02,s
                    decb                ; decrement b
                    bne       L37A1     ; branch when the values differ or the result is nonzero; target L37A1
                    bra       L3791     ; continue execution at L3791
send                std       >U01DB,y  ; store d at >U01DB,y
                    pshs      y,b       ; save y,b on the stack
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    puls      y,b       ; restore y,b from the stack
                    os9       F$Send    ; invoke the OS-9 F$Send service
                    rts                 ; return to the caller
L37B9               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L37EC     ; branch when the values are equal or the result is zero; target L37EC
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       L37EE     ; branch when the values are equal or the result is zero; target L37EE
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       L37EE     ; branch when the values are equal or the result is zero; target L37EE
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L37D4     ; branch when the values are equal or the result is zero; target L37D4
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       L37D4     ; branch when the values are equal or the result is zero; target L37D4
                    ldb       #208      ; set b to the constant 208
                    lbra      L3A1B     ; continue execution at L3A1B
L37D4               pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L37E0     ; branch when carry is clear; target L37E0
                    puls      u         ; restore u from the stack
                    lbra      L3A1B     ; continue execution at L3A1B
L37E0               stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L37EC               ldx       $06,s     ; load x from the current stack frame at $06,s
L37EE               os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbra      L3A24     ; continue execution at L3A24
L37F4               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L3803     ; branch when the values are equal or the result is zero; target L3803
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L380B     ; branch when the values are equal or the result is zero; target L380B
                    ldb       #208      ; set b to the constant 208
                    lbra      L3A1B     ; continue execution at L3A1B
L3803               ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    lbra      L3A24     ; continue execution at L3A24
L380B               pshs      u         ; save u on the stack
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u         ; restore u from the stack
                    lbra      L3A24     ; continue execution at L3A24
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L3825     ; branch when carry reports an error or unsigned underflow; target L3825
                    os9       I$Close   ; invoke the OS-9 I$Close service
L3825               lbra      L3A24     ; continue execution at L3A24
open                ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
close               lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L3A24     ; continue execution at L3A24
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    os9       I$MakDir  ; invoke the OS-9 I$MakDir service
                    lbra      L3A24     ; continue execution at L3A24
creat               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    bcs       L385C     ; branch when carry reports an error or unsigned underflow; target L385C
L3858               tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L385C               cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      L3A1B     ; branch when the values differ or the result is nonzero; target L3A1B
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      L3A1B     ; branch when the values differ or the result is nonzero; target L3A1B
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      0,x       ; form the workspace or data address 0,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u,a       ; restore u,a from the stack
                    bcc       L3858     ; branch when carry is clear; target L3858
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    puls      b         ; restore b from the stack
                    lbra      L3A1B     ; continue execution at L3A1B
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbra      L3A24     ; continue execution at L3A24
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
read                pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; invoke the OS-9 I$Read service
L38B2               bcc       L38C1     ; branch when carry is clear; target L38C1
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       L38BC     ; branch when the values differ or the result is nonzero; target L38BC
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
L38BC               puls      y,x       ; restore y,x from the stack
                    lbra      L3A1B     ; continue execution at L3A1B
L38C1               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
readln              pshs      y         ; save y on the stack
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bra       L38B2     ; continue execution at L38B2
write               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L38EA     ; branch when the values are equal or the result is zero; target L38EA
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
L38E3               bcc       L38EA     ; branch when carry is clear; target L38EA
                    puls      y         ; restore y from the stack
                    lbra      L3A1B     ; continue execution at L3A1B
L38EA               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
writln              pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L38EA     ; branch when the values are equal or the result is zero; target L38EA
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L38E3     ; continue execution at L38E3
L38FE               pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       L390C     ; branch when the values differ or the result is nonzero; target L390C
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       L3940     ; continue execution at L3940
L390C               cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       L3937     ; branch when the values are equal or the result is zero; target L3937
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       getstat   ; branch when the values are equal or the result is zero; target getstat
                    ldb       #247      ; set b to the constant 247
L391A               clra                ; clear a to zero and set the condition codes
                    std       >U01DB,y  ; store d at >U01DB,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >U01CF,y  ; form the address >U01CF,y in x
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
getstat             lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L391A     ; branch when carry reports an error or unsigned underflow; target L391A
                    bra       L3940     ; continue execution at L3940
L3937               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L391A     ; branch when carry reports an error or unsigned underflow; target L391A
L3940               tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >U01D1,y  ; store d at >U01D1,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       L391A     ; branch when the result is negative; target L391A
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >U01CF,y  ; store d at >U01CF,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    bcs       L391A     ; branch when carry reports an error or unsigned underflow; target L391A
                    leax      >U01CF,y  ; form the address >U01CF,y in x
                    puls      pc,u      ; restore pc,u and return to the caller
                    rts                 ; return to the caller
                    ldx       #0        ; set x to the constant 0
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lbra      L3A1B     ; continue execution at L3A1B
                    rts                 ; return to the caller
                    pshs      u,y       ; save u,y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       F$CRC     ; invoke the OS-9 F$CRC service
                    puls      pc,u,y    ; restore pc,u,y and return to the caller
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    os9       F$PErr    ; invoke the OS-9 F$PErr service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    rts                 ; return to the caller
sleep               ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    tfr       x,d       ; copy the register values specified by x,d
                    rts                 ; return to the caller
                    ldd       >memend,y ; load d from >memend,y
                    pshs      d         ; save d on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >U37D2,y  ; compare d with >U37D2,y and set the condition codes
                    bcs       L39CB     ; branch when carry reports an error or unsigned underflow; target L39CB
                    addd      >memend,y ; add to d using >memend,y
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    os9       F$Mem     ; invoke the OS-9 F$Mem service
                    tfr       y,d       ; copy the register values specified by y,d
                    puls      y         ; restore y from the stack
                    bcc       L39BD     ; branch when carry is clear; target L39BD
                    ldd       #-1       ; set d to the constant -1
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
L39BD               std       >memend,y ; store d at >memend,y
                    addd      >U37D2,y  ; add to d using >U37D2,y
                    subd      0,s       ; subtract from d using 0,s
                    std       >U37D2,y  ; store d at >U37D2,y
L39CB               leas      $02,s     ; adjust the system stack pointer
                    ldd       >U37D2,y  ; load d from >U37D2,y
                    pshs      d         ; save d on the stack
                    subd      $04,s     ; subtract from d using $04,s
                    std       >U37D2,y  ; store d at >U37D2,y
                    ldd       >memend,y ; load d from >memend,y
                    subd      ,s++      ; subtract from d using ,s++
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    ldx       0,s       ; load x from the current stack frame at 0,s
L39E4               sta       ,x+       ; store a at ,x+
                    cmpx      >memend,y ; compare x with >memend,y and set the condition codes
                    bcs       L39E4     ; branch when carry reports an error or unsigned underflow; target L39E4
                    puls      pc,d      ; restore pc,d and return to the caller
L39EE               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >_mtop,y  ; add to d using >_mtop,y
                    bcs       L3A17     ; branch when carry reports an error or unsigned underflow; target L3A17
                    cmpd      >_stbot,y ; compare d with >_stbot,y and set the condition codes
                    bcc       L3A17     ; branch when carry is clear; target L3A17
                    pshs      d         ; save d on the stack
                    ldx       >_mtop,y  ; load x from >_mtop,y
                    clra                ; clear a to zero and set the condition codes
L3A04               cmpx      0,s       ; compare x with 0,s and set the condition codes
                    bcc       L3A0C     ; branch when carry is clear; target L3A0C
                    sta       ,x+       ; store a at ,x+
                    bra       L3A04     ; continue execution at L3A04
L3A0C               ldd       >_mtop,y  ; load d from >_mtop,y
                    puls      x         ; restore x from the stack
                    stx       >_mtop,y  ; store x at >_mtop,y
                    rts                 ; return to the caller
L3A17               ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L3A1B               clra                ; clear a to zero and set the condition codes
                    std       >U01DB,y  ; store d at >U01DB,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L3A24               bcs       L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
exit                lbsr      L3A34     ; call subroutine L3A34
                    lbsr      L3319     ; call subroutine L3319
_exit               ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L3A34               rts                 ; return to the caller
L3A35               lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L3A1B     ; branch when carry reports an error or unsigned underflow; target L3A1B
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
                    ldd       #6944     ; set d to the constant 6944
                    bsr       L3A5B     ; call subroutine L3A5B
                    ldb       #9        ; set b to the constant 9
                    tst       $05,s     ; set condition codes from $05,s without changing it
                    ble       L3A4F     ; branch when the signed value is less than or equal; target L3A4F
                    ldb       #10       ; set b to the constant 10
L3A4F               lbra      L3B43     ; continue execution at L3B43
L3A52               ldd       #6946     ; set d to the constant 6946
                    bsr       L3A5B     ; call subroutine L3A5B
                    ldb       #9        ; set b to the constant 9
                    bra       L3A4F     ; continue execution at L3A4F
L3A5B               leax      >U37D4,y  ; form the address >U37D4,y in x
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
                    std       0,x       ; store d at 0,x
                    rts                 ; return to the caller
                    ldd       #6948     ; set d to the constant 6948
                    bra       L3A8A     ; continue execution at L3A8A
L3A82               ldd       #6947     ; set d to the constant 6947
                    bra       L3A8A     ; continue execution at L3A8A
                    ldd       #6945     ; set d to the constant 6945
L3A8A               std       >U37D4,y  ; store d at >U37D4,y
                    ldb       #2        ; set b to the constant 2
                    lbra      L3B43     ; continue execution at L3B43
                    ldd       #6960     ; set d to the constant 6960
                    std       >U37D4,y  ; store d at >U37D4,y
                    ldb       #2        ; set b to the constant 2
                    lbra      L3B43     ; continue execution at L3B43
L3A9F               ldb       #50       ; set b to the constant 50
                    bra       L3AAD     ; continue execution at L3AAD
L3AA3               ldb       #51       ; set b to the constant 51
                    bra       L3AAD     ; continue execution at L3AAD
                    ldb       #52       ; set b to the constant 52
                    bra       L3AAD     ; continue execution at L3AAD
                    ldb       #47       ; set b to the constant 47
L3AAD               lda       #27       ; set a to the constant 27
                    std       >U37D4,y  ; store d at >U37D4,y
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >U37D6,y  ; store b at >U37D6,y
                    ldb       #3        ; set b to the constant 3
                    lbra      L3B43     ; continue execution at L3B43
                    ldb       #1        ; set b to the constant 1
                    bra       L3AF2     ; continue execution at L3AF2
                    ldb       #3        ; set b to the constant 3
                    bra       L3AF2     ; continue execution at L3AF2
L3AC6               ldb       #4        ; set b to the constant 4
                    bra       L3AF2     ; continue execution at L3AF2
L3ACA               ldd       #1312     ; set d to the constant 1312
                    bra       L3B21     ; continue execution at L3B21
L3ACF               ldd       #1313     ; set d to the constant 1313
                    bra       L3B21     ; continue execution at L3B21
L3AD4               ldb       #6        ; set b to the constant 6
                    bra       L3AF2     ; continue execution at L3AF2
L3AD8               ldb       #7        ; set b to the constant 7
                    bra       L3AF2     ; continue execution at L3AF2
L3ADC               ldb       #8        ; set b to the constant 8
                    bra       L3AF2     ; continue execution at L3AF2
L3AE0               ldb       #9        ; set b to the constant 9
                    bra       L3AF2     ; continue execution at L3AF2
L3AE4               ldb       #10       ; set b to the constant 10
                    bra       L3AF2     ; continue execution at L3AF2
                    ldb       #11       ; set b to the constant 11
                    bra       L3AF2     ; continue execution at L3AF2
L3AEC               ldb       #12       ; set b to the constant 12
                    bra       L3AF2     ; continue execution at L3AF2
                    ldb       #13       ; set b to the constant 13
L3AF2               stb       >U37D4,y  ; store b at >U37D4,y
                    ldb       #1        ; set b to the constant 1
                    lbra      L3B43     ; continue execution at L3B43
L3AFB               ldd       #7968     ; set d to the constant 7968
                    bra       L3B21     ; continue execution at L3B21
L3B00               ldd       #7969     ; set d to the constant 7969
                    bra       L3B21     ; continue execution at L3B21
L3B05               ldd       #7970     ; set d to the constant 7970
                    bra       L3B21     ; continue execution at L3B21
L3B0A               ldd       #7971     ; set d to the constant 7971
                    bra       L3B21     ; continue execution at L3B21
L3B0F               ldd       #7972     ; set d to the constant 7972
                    bra       L3B21     ; continue execution at L3B21
L3B14               ldd       #7973     ; set d to the constant 7973
                    bra       L3B21     ; continue execution at L3B21
                    ldd       #7984     ; set d to the constant 7984
                    bra       L3B21     ; continue execution at L3B21
                    ldd       #7985     ; set d to the constant 7985
L3B21               std       >U37D4,y  ; store d at >U37D4,y
                    ldb       #2        ; set b to the constant 2
                    lbra      L3B43     ; continue execution at L3B43
L3B2A               leax      >U37D4,y  ; form the address >U37D4,y in x
                    ldb       #2        ; set b to the constant 2
                    stb       ,x+       ; store b at ,x+
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; store b at ,x+
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    addb      #32       ; add to b using #32
                    stb       ,x+       ; store b at ,x+
                    ldb       #3        ; set b to the constant 3
                    lbra      L3B43     ; continue execution at L3B43
L3B43               clra                ; clear a to zero and set the condition codes
                    leax      >U37D4,y  ; form the address >U37D4,y in x
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y         ; restore y from the stack
                    bcs       L3B58     ; branch when carry reports an error or unsigned underflow; target L3B58
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L3B58               clra                ; clear a to zero and set the condition codes
                    std       >U01DB,y  ; store d at >U01DB,y
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
                    fcc       "&?&e&I&O&V&[&c&h'" ; store literal character data
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
