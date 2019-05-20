	push	sp
	push	3
	add
	pop	sp
	push	100

	pop	sb[0]
	push	100

	pop	sb[1]
	push	200

	pop	sb[2]
	push	sb[0]
	push	sb[1]
	compGE
	j0	L000
	push	"a>b"
	puts
	push	sb[0]
	push	sb[1]
	compEQ
	j0	L001
	push	"a==b"
	puts
L001:
	jmp	L002
L000:
	push	"a<b"
	puts
L002:
	push	sb[2]
	push	sb[0]
	compLT
	j0	L003
	push	"c<a"
	puts
	jmp	L004
L003:
	push	"c>=a"
	puts
L004:
	end
