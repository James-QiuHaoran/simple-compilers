// reference & dereference

array a[100] = 87;

// reference &
b = &a[0];
c = a;
puti_(b); puts_(" should be equal to "); puti(c);

// dereference *
puti_(*b); puts_(" should be equal to "); puti(a[0]);

*b = 78;
puti_(*b); puts_(" should be equal to "); puti(a[0]);

*(b+87) = 877;
puti_(*(b+87)); puts_(" should be equal to "); puti(a[87]);