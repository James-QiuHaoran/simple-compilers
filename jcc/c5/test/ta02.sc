x = 1123;
puti(x);
x = 4567;
puti(x);

func(a) {
  puti(a);
  a = 5;
  puti(a);
  return a;
}

i = func(3);
puti(i);

y = 6;
puti(y);
j = func(y);
puti(y);
puti(j);
