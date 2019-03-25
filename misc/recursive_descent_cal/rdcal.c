// Recursive-descent top-down calculator
//   that follows strictly the translation steps
//   (i.e., first few slides of L8)

// To compile: flex rdcal.l; gcc -o rdcal lex.yy.c rdcal.c

#include <stdio.h>
#include <stdlib.h>

enum {NUM=1, LB, RB, ADD, SUB, MUL, DIV, NL, END};

extern int yylex();
extern int tokenValue;

int Term(), Factor(), Expr();

int next; // lookahead

int getToken() { next = yylex(); }

void reportError() { printf("Something wrong!\n"); exit(0); }

int match(int x) {
  int i = tokenValue;
  if (next == x) {
    getToken(); return i;
  }
  else
    reportError();
}

void Prog() {
  switch(next) {
  case LB: case NUM: // First()
    printf("=%d\n", Expr()); match(NL); Prog();
  case END: // Follow()
    printf("Bye!\n"); exit(0);
  }
  reportError();
}

int Expr() {
  int i, j;
  i = Term(); // Term factored out
  switch(next) {
  case ADD:
    match(ADD); j = Expr(); return i+j;
  case SUB:
    match(SUB); j = Expr(); return i-j;
  case RB: case NL: // Follow()
    return i;
  }
  reportError();
}

int Term() {
  int i, j;
  i = Factor();
  switch(next) {
  case MUL:
    match(MUL); j = Term(); return i*j;
  case DIV:
    match(DIV); j = Term(); return i/j;
  case NL: case RB: case ADD: case SUB: // Follow()
    return i;
  }
  reportError();
}
  
int Factor() {
  int i;
  switch(next) {
  case NUM:
    return match(NUM);
  case LB:
    match(LB); i = Expr(); match(RB); return i;
  }
  reportError();
}
  
int main() {
  getToken();
  Prog();
}
