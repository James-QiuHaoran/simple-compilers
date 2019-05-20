	push	sp
	push	251
	add
	pop	sp
	push	'a'
	pop	sb[200]
L009:
	push	sb[200]
	push	'z'
	compLE
	j0	L008
	push	sb[200]
	push	sb
	push	0
	push	0
	push	0
	add
	push	100
	mul
	push	sb[200]
	push	'a'
	sub
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	sb[200]
	push	'a'
	sub
	push	'A'
	add
	push	sb
	push	0
	push	0
	push	1
	add
	push	100
	mul
	push	sb[200]
	push	'a'
	sub
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"a[0]["
	puts_
	push	sb[200]
	push	'a'
	sub
	puti_
	push	"] = "
	puts_
	push	sb
	push	0
	push	0
	push	0
	add
	push	100
	mul
	push	sb[200]
	push	'a'
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	putc
	push	"a[1]["
	puts_
	push	sb[200]
	push	'a'
	sub
	puti_
	push	"] = "
	puts_
	push	sb
	push	0
	push	0
	push	1
	add
	push	100
	mul
	push	sb[200]
	push	'a'
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	putc
L007:
	push	sb[200]
	push	1
	add
	pop	sb[200]
	jmp	L009
L008:
	push	'z'
	push	'a'
	sub
	push	1
	add
	puti
	push	0
	push	sb
	push	0
	push	0
	push	0
	add
	push	100
	mul
	push	'z'
	push	'a'
	sub
	push	1
	add
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	0
	push	sb
	push	0
	push	0
	push	1
	add
	push	100
	mul
	push	'z'
	push	'a'
	sub
	push	1
	add
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"lower case alphabet: "
	puts_
	push	sb
	push	0
	push	0
	push	0
	add
	push	100
	mul
	add
	add
	pop	ac
L010:
	push	ac[0]
	push	0
	compLE
	j1	L011
	push	ac[0]
	putc_
	push	ac
	push	1
	add
	pop	ac
	jmp	L010
L011:
	push	0
	putc
	push	"UPPER CASE ALPHABET: "
	puts_
	push	sb
	push	0
	push	0
	push	1
	add
	push	100
	mul
	add
	add
	pop	ac
L012:
	push	ac[0]
	push	0
	compLE
	j1	L013
	push	ac[0]
	putc_
	push	ac
	push	1
	add
	pop	ac
	jmp	L012
L013:
	push	0
	putc
	push	"enter a string: "
	puts_
	gets
	push	sb
	push	201
	push	0
	push	0
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"you entered: "
	puts_
	push	sb
	push	201
	push	0
	push	0
	add
	add
	add
	pop	ac
	push	ac[0]
	puts
	end
