	push	sp
	push	3
	add
	pop	sp
	push	"Enter an integer:
"
	puts_
	geti
	pop	sb[0]
	push	sb[0]

	pop	sb[1]
	push	99999

	pop	sb[2]
	push	sb[1]
	puti_
	push	sb[2]
	puti
	end
