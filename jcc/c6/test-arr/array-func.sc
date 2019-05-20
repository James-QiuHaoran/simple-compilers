// array in function: array pointer as parameter, assignment within

dec(b) {
	b[1] = b[1] - 1;
}

array a[4][4][4][4] = 10;

for (i = 0; i < 10; i = i + 1;) {
	puti_(a[1][1][1][1]); puts_(" decrement 1 = ");
	dec(a[1][1][1]);
	puti(a[1][1][1][1]);
}
