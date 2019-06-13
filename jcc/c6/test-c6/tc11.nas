	push	sp
	push	5
	add
	pop	sp
	push	255
	pop	sb[3]
	push	0
	pop	sb[4]
	push	"Enter a number (0~255):"
	puts
	geti
	push	sb
	push	0
	add
	push	0
	add

	pop	ac
	pop	ac[0]
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	1
	add

	pop	ac
	pop	ac[0]
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	2
	add

	pop	ac
	pop	ac[0]
L001:
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	1
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	2
	add
	pop	ac
	push	ac[0]
	call	L000, 3
	push	0
	compEQ
	j0	L002
	push	"Color not valid! Enter again:"
	puts
	geti
	push	sb
	push	0
	add
	push	0
	add

	pop	ac
	pop	ac[0]
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	1
	add

	pop	ac
	pop	ac[0]
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	push	sb
	push	0
	add
	push	2
	add

	pop	ac
	pop	ac[0]
	jmp	L001
L002:
	push	"Color: r="
	puts_
	push	sb
	push	0
	add
	push	0
	add
	pop	ac
	push	ac[0]
	puti_
	push	", g="
	puts_
	push	sb
	push	0
	add
	push	1
	add
	pop	ac
	push	ac[0]
	puti_
	push	", b="
	puts_
	push	sb
	push	0
	add
	push	2
	add
	pop	ac
	push	ac[0]
	puti
	end
L000:
	push	fp[-6]
	push	sb[3]
	compGT
	push	fp[-6]
	push	sb[4]
	compLT
	or
	push	fp[-5]
	push	sb[3]
	compGT
	push	fp[-5]
	push	sb[4]
	compLT
	or
	or
	push	fp[-4]
	push	sb[3]
	compGT
	push	fp[-4]
	push	sb[4]
	compLT
	or
	or
	j0	L003
	push	0
	ret
L003:
	push	1
	ret
	ret
