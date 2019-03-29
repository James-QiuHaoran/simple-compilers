// max.as
	push "Enter 2 numbers: "; puts_
	geti
	geti
	call L001, 2
	puti_ 	// print the return value
	push " is larger"; puts
	end
L001:	push fp[-4]
	push fp[-5]
	compgt
	j1 L002
	push fp[-5]
	ret
L002:	push fp[-4]
	ret
