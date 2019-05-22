// passing array to function

dec(b) {
    b[1] = b[1] - 1;
}

array a[4] = 10;

for (i = 0; i < 10; i = i + 1;) {
    puts_("a[1] = "); puti_(a[1]); puts_(" decrement 1 = ");
    dec(a);
    puti(a[1]);
}