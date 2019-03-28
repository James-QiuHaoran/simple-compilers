// recursive fact.as
	push "Please enter a +ve int < 13: "; puts_
	geti
	call L001, 1
	puti
	end

// factorial():
L001:	push fp[-4]
	j0 L002
	push fp[-4]; push 1; sub
	call L001, 1	// recursive call
	push fp[-4]
	mul
	ret
L002:	push 1
	ret
