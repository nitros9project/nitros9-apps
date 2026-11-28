#off1=4
#toff=0
# offset=4
	.text
	.global	put_record
put_record:
	leas	-4,s
	std	0,s
	ldd	(count),u
	addd	#1
	aslb
	rola
	aslb
	rola
	aslb
	rola
	pshs	b,a;ga
	ldx	(top),u
	nega
	negb
	sbca	#0
	leax	d,x
	puls	a,b
	stx	2,s
	ldd	0,s
	std	[2,s]
	ldx	2,s
	ldd	6,s
	std	2,x
.l1:
	leas	4,s
	rts
	.type	put_record,@function
	.size	put_record,$-put_record
# stacksize=6
	.equ	__stack_put_record,6
