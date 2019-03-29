// rev.as
	push "Enter 5 numbers: "; puts_
	geti // = fp[0] 
	geti
	geti
	geti
	geti // = fp[4]
	push 4; pop in // in = 4
L001:
	push in; push 0; complt; j1 L002 // if (in < 0) ...
	push fp[in]; puti
	push in; push 1; sub; pop in // --in
	jmp L001
L002:	end
