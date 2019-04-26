	push	sp
	push	1
	add
	pop	sp
	push	"Please enter a +ve int <= 12: "
	puts_
	geti
	pop	sb[0]
	push	sb[0]
	push	12
	compLE
	j0	L001
	push	sb[0]
	call	L000, 1
	puti
	jmp	L002
L001:
	push	sb[0]
	puti_
	push	" > 12!!"
	puts
L002:
	end
L000:
	push	fp[-4]
	push	1
	compLT
	j0	L003
	push	1
	ret
L003:
	push	fp[-4]
	push	fp[-4]
	push	1
	sub
	call	L000, 1
	mul
	ret
	ret
