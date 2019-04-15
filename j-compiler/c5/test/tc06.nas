	push	sp
	push	3
	add
	pop	sp
	push	1
	pop	sb[0]
	push	1
	pop	sb[1]
L008:
	push	sb[1]
	push	100
	compLT
	j0	L007
	push	sb[1]
	pop	sb[2]
L009:
	push	sb[2]
	push	0
	compGT
	j0	L010
	push	sb[2]
	push	2
	div
	pop	sb[2]
	push	sb[2]
	push	1
	compEQ
	j0	L011
	push	1
	neg
	pop	sb[2]
L011:
	jmp	L009
L010:
	push	sb[0]
	push	1
	add
	pop	sb[0]
L006:
	push	sb[1]
	push	sb[0]
	add
	pop	sb[1]
	jmp	L008
L007:
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
