// factorial
fact(n) {
  if(n<1) return 1;
  return n * fact(n-1);
}

puts_("Please enter a +ve int <= 12: ");
geti(n);
if (n <= 12) {
	puti(fact(n));
} else {
	puti_(n); 
	puts(" > 12!!");
}
