	push	sp
	push	2
	add
	pop	sp
	push	999
	pop	sb[0]
	push	sb[0]
	call	L000, 1
	push	sb[0]
	call	L001, 1
	pop	sb[1]
	push	sb[1]
	puti
	end
L000:
	push	fp[-4]
	puti
	ret
L001:
	push	fp[-4]
	push	1
	add
	pop	sb[0]
	push	sb[0]
	puti
	push	sb[0]
	ret
	ret
