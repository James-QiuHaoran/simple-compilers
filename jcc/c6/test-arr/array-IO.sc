// array I/O: get, put

array a[4][4], b[4][4], c[4][4];

puts_("enter an int: ");
geti(a[3][3]);
puts_("you entered: "); puti(a[3][3]);

puts_("enter a char: ");
getc(b[3][3]);
puts_("you entered: "); putc(b[3][3]);

puts_("enter a string: ");
getc(dummy); // new line
gets(c[3][3]);
puts_("you entered: "); puts(c[3][3]);
