	push	sp
	push	1
	add
	pop	sp
	push	"Please enter a line:
"
	puts_
	// input getc
	getc
	// save to variable c
	pop	sb[0]
	push	sb[0]
	call	L000, 1
	push	' '
	putc
	end
L000:
	push	sp
	push	2
	add
	pop	sp
	push	fp[-4]
	push	'
'
	compNE
	j0	L001
	// input getc
	getc
	// save to variable b
	pop	fp[0]
	push	fp[0]
	call	L000, 1
	push	fp[-4]
	putc_
L001:
	ret
