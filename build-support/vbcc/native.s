; VBCC D/stack ABI to the OS-9 register packet. Preserve process DP/Y/U.
 .text
 .global vbcall
vbcall:
 pshs dp,y,u
 ldx 7,s
 pshs x
 lda #0x39
 pshs a
 pshs b
 ldd #0x103f
 pshs d
 ldd 1,x
 ldy 6,x
 ldu 8,x
 ldx 4,x
 jsr ,s
 pshs cc,d,dp,x,y,u
 ldx 14,s
 leay ,s
 ldu #10
copy_regs:
 ldb ,y+
 stb ,x+
 leau -1,u
 cmpu #0
 bne copy_regs
 clra
 ldb ,s
 bitb #1
 beq success
 ldb 2,s
 bra done
success:
 clrb
done:
 leas 16,s
 puls dp,y,u,pc
 .global __cmoc_data_base
__cmoc_data_base:
 tfr u,d
 rts
 .global __cmoc_signal_receiver
 .global __cmoc_dispatch_signal
__cmoc_signal_receiver:
 clra
 lbsr __cmoc_dispatch_signal
 rti
 .global getsp
getsp:
 leax 2,s
 tfr x,d
 rts
 .global __cmoc_snapshot
__cmoc_snapshot:
 tfr d,x
 pshs cc,d,dp,x,y,u
 leay ,s
 ldu #10
snapcopy:
 ldb ,y+
 stb ,x+
 leau -1,u
 cmpu #0
 bne snapcopy
 ldx 4,s
 leay 12,s
 sty 10,x
 puls cc,d,dp,x,y,u,pc
