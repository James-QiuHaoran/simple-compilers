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
	j0	L005
	push	"a>b"
	puts
	push	sb[0]
	push	sb[1]
	compEQ
	j0	L007
	push	"a==b"
	puts
L007:
	jmp	L006
L005:
	push	"a<b"
	puts
L006:
	push	sb[2]
	push	sb[0]
	compLT
	j0	L008
	push	"c<a"
	puts
	jmp	L009
L008:
	push	"c>=a"
	puts
L009:
	end
