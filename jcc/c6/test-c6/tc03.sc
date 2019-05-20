// char array
array a[2][100];

for (i = 'a'; i <= 'z'; i = i + 1;) {
	a[0][i - 'a'] = i;
	a[1][i - 'a'] = i - 'a' + 'A';
	puts_("a[0]["); puti_(i - 'a'); puts_("] = "); putc(a[0][i - 'a']);
	puts_("a[1]["); puti_(i - 'a'); puts_("] = "); putc(a[1][i - 'a']);
}

// reassignment
puti('z' - 'a' + 1);
a[0]['z' - 'a' + 1] = '\0';
a[1]['z' - 'a' + 1] = '\0';

// reference
puts_("lower case alphabet: "); puts(a[0]);
puts_("UPPER CASE ALPHABET: "); puts(a[1]);

// I/O support
array b[50];
puts_("enter a string: "); gets(b[0]);
puts_("you entered: "); puts(b[0]);