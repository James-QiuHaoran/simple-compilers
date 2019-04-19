	push	sp
	push	3
	add
	pop	sp
	push	1
	pop	sb[0]
	push	1
	pop	sb[1]
L001:
	push	sb[1]
	push	100
	compLT
	j0	L000
	push	sb[1]
	pop	sb[2]
L002:
	push	sb[2]
	push	0
	compGT
	j0	L003
	push	sb[2]
	push	2
	div
	pop	sb[2]
	push	sb[2]
	push	1
	compEQ
	j0	L004
	push	1
	neg
	pop	sb[2]
L004:
	jmp	L002
L003:
	push	sb[0]
	push	1
	add
	pop	sb[0]
	push	sb[1]
	push	sb[0]
	add
	pop	sb[1]
	jmp	L001
L000:
	push	sb[1]
	puti_
	push	", "
	puts_
	push	sb[2]
	puti_
	push	", "
	puts_
	push	sb[0]
	puti
	end
