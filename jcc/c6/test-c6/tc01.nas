	push	sp
	push	3
	add
	pop	sp
	push	"this is a string"
	pop	sb[0]
	push	"x is assigned to a string: "
	puts_
	push	sb[0]
	puts
	push	"abc"
	pop	sb[1]
	push	"abc"
	pop	sb[2]
	push	sb[1]
	push	sb[2]
	compEQ
	j0	L000
	push	"s1 equals s2!"
	puts
	jmp	L001
L000:
	push	"s1 is not equal to s2!"
	puts
L001:
	push	"String printing functions well!"
	puts
	end
