	push	sp
	push	5
	add
	pop	sp
	push	10
	push	sb
	push	0
	add
	pop	ac
	pop	ac[0]
	push	ac[0]
	pop	ac[1]
	push	ac[1]
	pop	ac[2]
	push	ac[2]
	pop	ac[3]
	push	0
	pop	sb[4]
L006:
	push	sb[4]
	push	10
	compLT
	j0	L005
	push	"a[1] = "
	puts_
	push	sb
	push	0
	push	0
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	puti_
	push	" decrement 1 = "
	puts_
	push	sb
	push	0
	add
	call	L003, 1
	push	sb
	push	0
	push	0
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	puti
L004:
	push	sb[4]
	push	1
	add
	pop	sb[4]
	jmp	L006
L005:
	end
L003:
	push	fp[-4]
	push	0
	push	1
	add
	add
	pop	ac
	push	ac[0]
	push	1
	sub
	push	fp[-4]
	push	0
	push	1
	add
	add
	pop	ac
	pop	ac[0]
	ret
