	push	sp
	push	3
	add
	pop	sp
	push	1
	pop	sb[0]
	push	1
	pop	sb[1]
L005:
	push	sb[1]
	push	100
	compLT
	j0	L004
	push	sb[1]
	pop	sb[2]
L006:
	push	sb[2]
	push	0
	compGT
	j0	L007
	push	sb[2]
	push	2
	div
	pop	sb[2]
	push	sb[2]
	push	1
	compEQ
	j0	L008
	jmp	L007
L008:
	jmp	L006
L007:
	push	sb[1]
	push	10
	compLT
	j0	L009
	jmp	L003
L009:
	push	sb[0]
	push	1
	add
	pop	sb[0]
L003:
	push	sb[1]
	push	sb[0]
	add
	pop	sb[1]
	jmp	L005
L004:
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
