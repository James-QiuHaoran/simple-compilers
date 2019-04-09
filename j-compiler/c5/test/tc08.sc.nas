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
	push	sp
	push	1
	add
	pop	sp
	push	fp[-4]
	push	1
	add
	pop	fp[0]
	push	fp[0]
	puti
	push	fp[0]
	ret
	ret
