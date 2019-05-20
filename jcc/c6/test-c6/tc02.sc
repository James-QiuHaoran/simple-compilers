// basic array functionality test
// declaration, initialization
array a[4] = 78, b[5] = 87;
for (i = 0; i < 4; i = i + 1;) {
    puts_("a["); puti_(i); puts_("] = "); puti(a[i]);
    puts_("b["); puti_(i); puts_("] = "); puti(b[i]);
}

// offset arithmetics, assignment
for (i = 0; i < 4; i = i + 1;) {
    puts_("i = "); puti(i);
    puti_(a[i]); puts_("(a[i]) should be equal to "); puti(78);
    puti_(a[i] + b[i]); puts_("(a[i]+b[i]) should be equal to "); puti(78 + 87);
    a[i] = b[i] + 100;
    puti_(a[i]); puts_("(a[i]) now should be equal to "); puti(187);
}
puts_("i = "); puti(i);
for (i = 1; i < 6; i = i + 1;) {
    puti_(b[i-1]); puts_(" should be equal to "); puti(87 + 100);
}
