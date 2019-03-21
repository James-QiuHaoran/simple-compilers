// rev-c.as
	push "Please enter a line:"; puts
	push 0; pop in				// in = 0
L001: 	getc; // NO pop fp[in] here !!		// fp[in] = getc
	push fp[in]; push 10; compeq; j1 L002	// if newline goto L002
	push in; push 1; add; pop in 		// in++
	jmp L001
L002:	push in; push 1; sub; pop in		// in--
	push fp[in]; putc_
	push in; j0 L003; jmp L002
L003:	push ''; putc
	end
