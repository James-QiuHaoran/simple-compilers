// multidimentional array

element(arr, a, b, c, d) {
  puts_(arr);
  puts_("[");
  puti_(a); putc_(',');
  puti_(b); putc_(',');
  puti_(c); putc_(',');
  puti_(d);
  puts_("]");
}

// declaration, initialization
array a[3][3][3][3] = 78, b[3][3][3][3] = 87;

// offset arithmetics, assignment
for (i = 0; i < 3; i = i + 1;) {
  for (j = 0; j < 3; j = j + 1;) {
    for (k = 0; k < 3; k = k + 1;) {
      for (l = 0; l < 3; l = l + 1;) {
        element("a", i, j, k, l); puts_(" = "); 
        puti_(a[i][j][k][l]); puts_(" should be equal to "); puti(78);
        element("a", i, j, k, l); puts_(" + "); element("b", i, j, k, l); puts_(" = "); 
        puti_(a[i][j][k][l] + b[i][j][k][l]); puts_(" should be equal to "); puti(78 + 87);
        a[i][j][k][l] = b[i][j][k][l] + 100;
      }
    }
  }
}

for (i = 1; i < 4; i = i + 1;) {
    puti_(a[i-1][i-1][i-1][i-1]); puts_(" should be equal to "); puti(87 + 100);
}