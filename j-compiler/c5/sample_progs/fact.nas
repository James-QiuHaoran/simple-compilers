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
	j0	L004
	push	sb[0]
	call	L002, 1
	puti
	jmp	L005
L004:
	push	sb[0]
	puti_
	push	" > 12!!"
	puts
L005:
	end
L002:
	push	fp[-4]
	push	1
	compLT
	j0	L006
	push	1
	ret
L006:
	push	fp[-4]
	push	fp[-4]
	push	1
	sub
	call	L002, 1
	mul
	ret
	ret
