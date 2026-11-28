 .section .text.near,"acrx"
 .global nearfun
nearfun:
 ldd #4660
 rts
 .section .text.far,"acrx"
 .space 40000
 .global farfun
farfun:
 lbsr nearfun
 rts
