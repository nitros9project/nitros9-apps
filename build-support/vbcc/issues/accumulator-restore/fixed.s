#off1=10
#toff=2
# offset=12
	.text
	.global	maprows
maprows:
	pshs	y
	leas	-12,s
	tfr	d,x
	ldy	#0
	ldd	(height),u
	beq	.l15
	tfr	x,d
	std	2,s
	tfr	a,b
	sex
	tfr	a,b
	std	0,s
.l14:
	tfr	y,d
	std	6,s
	tfr	a,b
	sex
	tfr	a,b
	std	4,s
	ldd	2,s
	pshs	b,a
	ldd	2,s
	pshs	b,a
	ldd	10,s
	pshs	b,a
	ldd	10,s
	pshs	b,a
	lbsr	(__mulint32)
	pshs	b,a;ga
	ldd	(height),u
	std	16,s
	clra
	clrb
	std	14,s
	puls	a,b
	std	18,s
	ldd	14,s
	pshs	b,a
	ldd	14,s
	pshs	b,a
	ldd	22,s
	pshs	b,a
	pshs	x
	lbsr	(__divint32)
	stx	20,s
	std	22,s
	ldd	#3
	pshs	b,a
	ldd	(start),u
	lbsr	(__mulint16)
	pshs	b,a
	ldd	(magnification),u
	lbsr	(__mulint16)
	pshs	b,a;ga
	ldd	28,s
	tfr	d,x
	ldd	0,s
	nega
	negb
	sbca	#0
	leax	d,x
	stx	30,s
	puls	a,b
	leas	20,s
	ldd	8,s
	subd	#0
	blt	.l8
	ldd	8,s
	cmpd	#192
	bge	.l8
	ldd	8,s
	aslb
	rola
	tfr	d,x
	tfr	u,d
	addd	#0+rows
	leax	d,x
	sty	0,x
.l8:
	leay	1,y
	cmpy	(height),u
	blo	.l14
.l15:
	leas	12,s
	puls	y,pc
	.type	maprows,@function
	.size	maprows,$-maprows
