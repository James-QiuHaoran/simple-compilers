// rev-c.sc
puts_("Please enter a line:\n");

rev(a) {
    if (a != '\n') {
        getc(b);
        rev(b);
        putc_(a);
    }
}

getc(c);
rev(c);

putc('');
