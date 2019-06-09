	push	sp
	push	6
	add
	pop	sp
	push	10.234000
	pop	sb[0]
	push	sb[0]
	putf
	push	1.234000
	push	sb[0]
	add
	pop	sb[1]
	push	sb[1]
	putf
	push	"Enter a float number: "
	puts
	getf
	pop	sb[2]
	push	sb[2]
	putf
	push	1
	pop	sb[0]
	push	2
	pop	sb[1]
	push	sb[0]
	push	sb[1]
	rdiv
	putf
	push	3
	pop	sb[2]
	push	sb[1]
	push	sb[2]
	rdiv
	putf_
	push	" = 2 div 3"
	puts
	push	2.300000
	push	sb
	push	3
	add
	pop	ac
	pop	ac[0]
	push	ac[0]
	pop	ac[1]
	push	ac[1]
	pop	ac[2]
	push	sb
	push	3
	push	0
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	putf
	end
