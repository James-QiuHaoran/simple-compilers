	read
	pop	x
	push	x
	push	0
	compEQ
	jz	L000
	push	1
	print
	jmp	L001
L000:
	push	x
	push	1
	compGE
	push	x
	push	12
	compLE
	and
	jz	L002
	push	1
	pop	f
L003:
	push	x
	push	1
	compGT
	jz	L004
	push	f
	push	x
	mul
	pop	f
	push	x
	push	1
	sub
	pop	x
	jmp	L003
L004:
	push	f
	print
L002:
L001:
