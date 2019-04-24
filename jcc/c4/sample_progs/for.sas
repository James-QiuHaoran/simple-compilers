	push	3
	pop	i
L000:
	push	i
	push	6
	compLT
	jz	L001
	push	0
	pop	j
L002:
	push	j
	push	i
	compLE
	jz	L003
	push	j
	print
	push	j
	push	1
	add
	pop	j
	jmp	L002
L003:
	push	i
	push	1
	add
	pop	i
	jmp	L000
L001:
