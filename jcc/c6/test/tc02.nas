	push	sp
	push	3
	add
	pop	sp
	push	"Enter a char:
"
	puts_
	// input getc
	getc
	// save to variable a
	pop	sb[0]
	push	sb[0]
	pop	sb[1]
	push	'X'
	pop	sb[2]
	push	sb[1]
	putc_
	push	sb[2]
	putc
	end
