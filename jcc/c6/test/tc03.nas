	push	sp
	push	3
	add
	pop	sp
	push	"Enter a string:
"
	puts_
	gets
	pop	sb[0]
	push	sb[0]

	pop	sb[1]
	push	"test!"

	pop	sb[2]
	push	sb[1]
	puts_
	push	sb[2]
	puts
	end
