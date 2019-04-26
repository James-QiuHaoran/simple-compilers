// max.sc
max(x, y) {
    if (x >= y)
        return x;
    else
        return y;
}


puts_("Enter two numbers:\n");
geti(x);
geti(y);

// print the max
puti(max(x, y));
