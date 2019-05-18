// assign string to a variable
x = "this is a string";
puts_("x is assigned to a string: ");
puts(x);

// compare strings
s1 = "abc";
s2 = "abc";
if (s1 == s2) {
  puts("s1 equals s2!");
} else {
  puts("s1 is not equal to s2!");
}

s2 = "cba";
if (s1 == s2) {
  puts("now s1 equals s2!");
} else {
  puts("now s1 is not equal to s2!");
}

// compare string to constant
if (s1 == "cba") {
  puts("s1 = cba");
} else {
  puts("s1 != cba");
}

if (s1 == "abc") {
  puts("s1 = abc");
} else {
  puts("s1 != abc");
}

// string printing functions well
puts("String printing functions well!");
