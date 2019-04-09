// functions with 1 argument
f(a) {
  puti(a);
}

b = 999;
f(b);

func(a) {
  b = a + 1;
  puti(b);
  return b;
}

c = func(b);
puti(c);
