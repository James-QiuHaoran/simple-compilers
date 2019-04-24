// test global variable

f() {
  $b = 400;
}

ff() {
  b = 13;
}

a = 12;

outa() {
  puts_("a: ");
  puti(a);
}

outa();

outb() {
  puts_("b: ");
  puti(b);
}

f();

outb();

b = 5;

outb();

ff();

outb();
