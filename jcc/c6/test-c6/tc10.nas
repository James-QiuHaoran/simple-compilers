	push	sp
	push	3
	add
	pop	sp
	push	255
	push	sb
	push	0
	add
	push	0
	add

	pop	ac
	pop	ac[0]
	push	255
	push	sb
	push	0
	add
	push	1
	add

	pop	ac
	pop	ac[0]
	push	255
	push	sb
	push	0
	add
	push	2
	add

	pop	ac
	pop	ac[0]
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
