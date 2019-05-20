	push	sp
	push	10
	add
	pop	sp
	push	78
	push	sb
	push	0
	add
	pop	ac
	pop	ac[0]
	push	ac[0]
	pop	ac[1]
	push	ac[1]
	pop	ac[2]
	push	ac[2]
	pop	ac[3]
	push	87
	push	sb
	push	4
	add
	pop	ac
	pop	ac[0]
	push	ac[0]
	pop	ac[1]
	push	ac[1]
	pop	ac[2]
	push	ac[2]
	pop	ac[3]
	push	ac[3]
	pop	ac[4]
	push	0

	pop	sb[9]
L011:
	push	sb[9]
	push	4
	compLT
	j0	L010
	push	"a["
	puts_
	push	sb[9]
	puti_
	push	"] = "
	puts_
	push	sb
	push	0
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	puti
	push	"b["
	puts_
	push	sb[9]
	puti_
	push	"] = "
	puts_
	push	sb
	push	4
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	puti
L009:
	push	sb[9]
	push	1
	add

	pop	sb[9]
	jmp	L011
L010:
	push	0

	pop	sb[9]
L014:
	push	sb[9]
	push	4
	compLT
	j0	L013
	push	"i = "
	puts_
	push	sb[9]
	puti
	push	sb
	push	0
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	puti_
	push	"(a[i]) should be equal to "
	puts_
	push	78
	puti
	push	sb
	push	0
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	push	sb
	push	4
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	add
	puti_
	push	"(a[i]+b[i]) should be equal to "
	puts_
	push	78
	push	87
	add
	puti
	push	sb
	push	4
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	push	100
	add
	push	sb
	push	0
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	pop	ac[0]
	push	sb
	push	0
	push	0
	push	sb[9]
	add
	add
	add

	pop	ac
	push	ac[0]
	puti_
	push	"(a[i]) now should be equal to "
	puts_
	push	187
	puti
L012:
	push	sb[9]
	push	1
	add

	pop	sb[9]
	jmp	L014
L013:
	push	"i = "
	puts_
	push	sb[9]
	puti
	push	1

	pop	sb[9]
L017:
	push	sb[9]
	push	6
	compLT
	j0	L016
	push	sb
	push	4
	push	0
	push	sb[9]
	push	1
	sub
	add
	add
	add

	pop	ac
	push	ac[0]
	puti_
	push	" should be equal to "
	puts_
	push	87
	push	100
	add
	puti
L015:
	push	sb[9]
	push	1
	add

	pop	sb[9]
	jmp	L017
L016:
	end
