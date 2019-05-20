	push	sp
	push	2
	add
	pop	sp
	push	12

	pop	sb[0]
	call	L000, 0
	call	L001, 0
	call	L002, 0
	push	5

	pop	sb[1]
	call	L002, 0
	call	L003, 0
	call	L002, 0
	end
L001:
	push	400

	pop	sb[1]
	ret
L003:
	push	13

	pop	sb[1]
	ret
L000:
	push	"a: "
	puts_
	push	sb[0]
	puti
	ret
L002:
	push	"b: "
	puts_
	push	sb[1]
	puti
	ret
