	push	sp
	push	49
	add
	pop	sp
	push	"enter an int: "
	puts_
	geti
	push	sb
	push	0
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"you entered: "
	puts_
	push	sb
	push	0
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	push	ac[0]
	puti
	push	"enter a char: "
	puts_
	// input getc
	getc
	// save to array b
	push	sb
	push	16
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"you entered: "
	puts_
	push	sb
	push	16
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	push	ac[0]
	putc
	push	"enter a string: "
	puts_
	// input getc
	getc
	// save to variable dummy
	pop	sb[48]
	gets
	push	sb
	push	32
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"you entered: "
	puts_
	push	sb
	push	32
	push	0
	push	3
	add
	push	4
	mul
	push	3
	add
	add
	add
	pop	ac
	push	ac[0]
	puts
	end
