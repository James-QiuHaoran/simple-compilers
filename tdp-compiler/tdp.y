%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>

  #define N 11
  #define move(Delta_x, Delta_y) x += Delta_x; y += Delta_y; // delta can only be 1, -1, 0

  char bed[N][N];
  int x = N/2, y =N/2;
  char *curr_symbol = "*";

  void yyerror(char *);
  int yylex(void);

  void init_bed();                                 // initialize the bed
  void display_bed();                              // display the bed
  void plot();                                     // plot
  void reset_pen();                                // set the pen to the original position
  void reset_bed();                                // set the bed to empty
  void set_pen(char *symbol);                      // set the symbol to print
  void move_to(int i, int j);                      // move to a position
  void move_by(int i, int j);                      // move by vector
  void plot_line(int ix, int iy, int jx, int jy);  // horizontal or vertical line
  void plot_rect(int ix, int iy, int jx, int jy);  // plot a rectangle with the two diagonal points
%}

%token EXIT MOVE PLOT DISPLAY RESET_PEN RESET_BED SET_PEN MOVE_TO PLOT_LINE PLOT_RECT
%token <symbol> SYMBOL
%token <num> NUM

%type <num> value

%union {
  char *symbol;
  int num;
}

%%

commands:
          commands command                    {}
          |                                   /* NULL */
          ;

command:
          MOVE '(' value ',' value ')'        { move_by($3, $5); }
          | DISPLAY                           { display_bed(); printf("\n"); } 
          | PLOT                              { plot(); }
          | RESET_BED                         { reset_bed(); }
          | RESET_PEN                         { reset_pen(); }
          | SET_PEN SYMBOL                    { set_pen($2); }
          | MOVE_TO '(' value ',' value ')'   { move_to($3, $5); }
          | PLOT_LINE '(' value ',' value ')' '(' value ',' value ')' { plot_line($3, $5, $8, $10); }
          | PLOT_RECT '(' value ',' value ')' '(' value ',' value ')' { plot_rect($3, $5, $8, $10); }
          | EXIT                              { exit(0); }
          ;

value:
          NUM                                 { $$ = $1; }
          | '-' NUM                           { $$ = -$2; }
          ;   

%%

// initilized the bed to empty
void init_bed() {
  int i, j;
  for (i=0; i<N; i++)
    for (j=0; j<N; j++) 
      bed[i][j] = '.'; // for easy visualization
}

// display the bed
void display_bed() {
  int i, j;
  for (i=N-1; i>=0; i--) {
    for (j=0; j<N; j++) putchar(bed[i][j]);
      putchar('\n');
  }
}

// plot a symbol
void plot() {
  bed[x][y] = curr_symbol[0];
}

// reset the bed to empty
void reset_bed() {
  int i, j;
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      bed[i][j] = '.';
}

// reset the pen to the start position
void reset_pen() {
  x = N/2;
  y = N/2;
}

// set the symbol printed by the pen
void set_pen(char *symbol) {
  int len = strlen(symbol);
  curr_symbol = malloc(sizeof(char) * len);
  strcpy(curr_symbol, symbol);
  printf("Current symbol is changed to %s\n", curr_symbol);
}

// move to a postion
void move_to(int i, int j) {
  // error checking
  if (i >= N || i < 0 || j >= N || j < 0) {
    yyerror("Out of boundary!");
  } else {
    int x_distance = i > x ? i - x : x - i;
    int y_distance = j > y ? j - y : y - j;
    for (int m = 0; m < x_distance; m++) {
      if (i > x) { move(1,0); }
      if (i < x) { move(-1,0); }
    }
    for (int n = 0; n < y_distance; n++) {
      if (j > y) { move(0,1); }
      if (j < y) { move(0,-1); }
    }
  }
}

// move by a distance vector
void move_by(int i, int j) {
  // error checking
  if (i > 1 || i < -1 || j > 1 || j < -1) {
    yyerror("You can't move by more than 1 step!");
  } else if (x + i >= N || x + i < 0 || y + j >= N || y + j < 0) {
    yyerror("Out of boundary!");
  } else {
    move(i,j);
  }
}

// draw a line
void plot_line(int ix, int iy, int jx, int jy) {
  if (ix < 0 || ix >= N || iy < 0 || iy >= N) yyerror("Out of boundary");
  if (jx < 0 || jx >= N || jy < 0 || jy >= N) yyerror("Out of boundary");
  if (ix == jx) {
    // horizontal
    int start_y = iy < jy ? iy : jy;
    int end_y = iy > jy ? iy : jy;
    move_to(ix, start_y);
    for (int i = start_y; i <= end_y; i++) {
      plot();
      move(0,1);
    }
  } else if (iy == jy) {
    // vertical
    int start_x = ix < jx ? ix : jx;
    int end_x = ix > jx ? ix : jx;
    move_to(start_x, iy);
    for (int i = start_x; i <= end_x; i++) {
      plot();
      move(1,0);
    }
  } else {
    yyerror("Can't handle lines other than horizontal or vertical!");
  }
}

// draw a rectangle
void plot_rect(int ix, int iy, int jx, int jy) {
  if (ix < 0 || ix >= N || iy < 0 || iy >= N) yyerror("Out of boundary");
  if (jx < 0 || jx >= N || jy < 0 || jy >= N) yyerror("Out of boundary");
  int start_y = iy < jy ? iy : jy;
  int end_y = iy > jy ? iy : jy;
  int start_x = ix < jx ? ix : jx;
  int end_x = ix > jx ? ix : jx;
  for (int i = start_y; i <= end_y; i++) {
    plot_line(start_x, i, end_x, i);
  }
}

// reporting errors
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
  printf("Plotting bed with size %d*%d is initialized!\n\n", N, N);
  init_bed();
  display_bed();
  printf("\nStart to paint by entering commands!\n\n");
  yyparse();
}
