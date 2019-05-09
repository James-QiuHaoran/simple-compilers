# 2D Plotting - TDP

This is a compiler for interface controlling a 2D plotting platform.

## Commands

- plot: plot a symbol
- move(x, y): move by (x, y) where x and y can be 1, 0, -1;
- display: display the bed;
- reset_bed: reset the bed back to empty;
- reset_pen: reset the position of the pen;
- set_pen s: set symbol to plot, choosing from "x*#$o@";
- move_to(x, y): move to position (x, y) where (x, y) is in boundary;
- plot_line (x1, y1) (x2, y2): draw a horizontal or vertical line;
- plot_rect (x1, y1) (x2, y2): draw a rectangle with two diagonal points;
- exit: exit the program interface

This simple command parser does error checking for your input commands such as "out of boundary" checking.

## How to Run

```
bison -y -d tdp.y
flex tdp.l
gcc -c y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o tdp
```

Or, you could run `./build.sh` to generate the executable `tdp`.

## Sample Program

`demo.tdp` is a sample program demonstrating supported features.

Run `./tdp < demo.tdp` to see the demo.

## Contact

- Author: Haoran Qiu (3035234478)
- Email: jamesqiu@hku.hk
