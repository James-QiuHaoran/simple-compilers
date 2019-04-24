	push	sp
	push	2
	add
	pop	sp
	push	"Enter two numbers:
"
	puts_
	geti
	pop	sb[0]
	geti
	pop	sb[1]
	push	sb[0]
	push	sb[1]
	call	L000, 2
	puti
	end
L000:
	push	fp[-5]
	push	fp[-4]
	compGE
	j0	L001
	push	fp[-5]
	ret
	jmp	L002
L001:
	push	fp[-4]
	ret
L002:
	ret
