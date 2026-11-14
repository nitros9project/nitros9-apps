/* LLVM MC6809 ABI: first pointer in X, int return in X; preserve U. */
.text
.globl __uucp_fork
__uucp_fork:
 pshs u,x
 lda 6,x
 ldb 7,x
 ldy 4,x
 ldu 2,x
 ldx ,x
 os9 0x03
 bcs .Lprocess_fail
 ldx ,s
 sta 8,x
 puls x,u
 ldx #0
 rts
.globl __uucp_chain
__uucp_chain:
 pshs u,x
 lda 6,x
 ldb 7,x
 ldy 4,x
 ldu 2,x
 ldx ,x
 os9 0x05
.Lprocess_fail:
 puls x,u
 clra
 tfr d,x
 rts
/* An intercept handler can clobber the 24 bytes of LLVM virtual registers.
 * Preserve those bytes in addition to the kernel's hardware register frame. */
.globl __uucp_signal_receiver
__uucp_signal_receiver:
 tfr u,x
 ldy #24
.Lsave_dp:
 lda ,x+
 pshs a
 leay -1,y
 bne .Lsave_dp
 clra
 tfr d,x
 lbsr uucpbb_dispatch_signal
 leax 24,u
 ldy #24
.Lrestore_dp:
 puls a
 sta ,-x
 leay -1,y
 bne .Lrestore_dp
 rti
.globl __uucp_nmlink
__uucp_nmlink:
 pshs u
 lda 1,x
 ldx 4,x
 os9 0x21
 bra .Lnm_result
.globl __uucp_nmload
__uucp_nmload:
 pshs u
 lda 1,x
 ldx 4,x
 os9 0x22
 bra .Lnm_result
.globl __uucp_munload
__uucp_munload:
 pshs u
 lda 1,x
 ldx 4,x
 os9 0x1d
.Lnm_result:
 puls u
 bcs .Lnm_error
 ldx #0
 rts
.Lnm_error:
 clra
 tfr d,x
 rts
