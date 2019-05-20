	push	sp
	push	3
	add
	pop	sp
	push	10

	pop	sb[0]
	push	15

	pop	sb[1]
	push	40

	pop	sb[2]
	push	sb[0]
	push	sb[2]
	push	sb[2]
	push	sb[1]
	call	L000, 4

	pop	sb[2]
	push	sb[2]
	puti
	end
L000:
	push	fp[-7]
	push	fp[-6]
	add
	push	fp[-5]
	push	fp[-4]
	add
	mul
	ret
	ret
