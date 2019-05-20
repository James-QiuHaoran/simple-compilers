	push	sp
	push	1
	add
	pop	sp
	call	L000, 0
	call	L001, 0
	end
L000:
	push	10

	pop	sb[0]
	ret
L001:
	push	sb[0]
	puti
	ret
