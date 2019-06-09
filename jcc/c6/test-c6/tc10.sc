// struct IO: get & put

struct color {
	r, g, b
};

isValid(r, g, b) {
	if ((r > @max || r < @min) || (g > @max || g < @min) || (b > @max || b < @min)) {
		return 0;
	}
	return 1;
}

<color> c;

max = 255, min = 0;

puts("Enter a color:");
puts_("r="); geti(c.r); puts_("g="); geti(c.g); puts_("b="); geti(c.b);

while (isValid(c.r, c.g, c.b) == 0) {
	puts("Color not valid! Enter again:");
	puts_("r="); geti(c.r); puts_("g="); geti(c.g); puts_("b="); geti(c.b);
}

puts_("Color: r="); puti_(c.r); puts_(", g="); puti_(c.g); puts_(", b="); puti(c.b);
