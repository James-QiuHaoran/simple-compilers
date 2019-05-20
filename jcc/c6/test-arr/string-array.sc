// static string: assignment to variable/array element, assignment to pointer (treated as char array), concatination

array a[2], b[2][6], c[100];

a[0] = "Hello world!";
a[1] = "Bye world!";

puts(a[0]);
puts(a[1]);

b[0] = "Hello world";
puts(b);
b[1] = "Kitty";
puts(b);

puts("Hotel? " + "Trivago.");
c = "Hotel? " + "Trivago.";
puts(c);