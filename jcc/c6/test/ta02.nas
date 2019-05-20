	push	sp
	push	4
	add
	pop	sp
	push	1123
	pop	sb[0]
	push	sb[0]
	puti
	push	4567
	pop	sb[0]
	push	sb[0]
	puti
	push	3
	call	L000, 1
	pop	sb[1]
	push	sb[1]
	puti
	push	6
	pop	sb[2]
	push	sb[2]
	puti
	push	sb[2]
	call	L000, 1
	pop	sb[3]
	push	sb[2]
	puti
	push	sb[3]
	puti
	end
L000:
	push	fp[-4]
	puti
	push	5
	pop	fp[-4]
	push	fp[-4]
	puti
	push	fp[-4]
	ret
	ret
