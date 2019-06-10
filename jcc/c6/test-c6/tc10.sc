// basic struct: definition & declaration, assignment, evaluation

struct color {
	r, g, b
};

<color> c;

c.r = 255;
c.g = 255;
c.b = 255;

puts_("Color: r="); puti_(c.r); puts_(", g="); puti_(c.g); puts_(", b="); puti(c.b);
