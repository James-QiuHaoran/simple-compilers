	push	sp
	push	3
	add
	pop	sp
	push	'c'
	pop	sb[0]
	push	27
	pop	sb[1]
	push	"hello, world!"
	pop	sb[2]
	push	sb[0]
	putc
	push	sb[1]
	puti
	push	sb[2]
	puts
	end
