#off1=0
#toff=0
# offset=0
	.text
	.global	put_record
put_record:
	pshs	y
	tfr	d,y
	ldx	(count),u
	leax	1,x
	tfr	x,d
	aslb
	rola
	aslb
	rola
	aslb
	rola
	tfr	d,x
	ldd	(top),u
	pshs	x
	subd	,s++
	tfr	d,x
	sty	,x++
	ldd	4,s
	std	0,x
	puls	y,pc
	.type	put_record,@function
	.size	put_record,$-put_record
# stacksize=2
	.equ	__stack_put_record,2
