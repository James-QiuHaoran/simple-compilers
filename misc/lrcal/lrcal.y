%{
#include <stdio.h>
#include <stdlib.h>
%}
%token NUMBER END
%{ 
  void yyerror(char *); 
  int yylex(void); 
%} 

%% 

prog: 
  expr { printf("=%d\n", $1); } '\n' prog
  | END { printf("BYE!\n"); exit(0); }
  ; 
expr: 
  term '+' expr { $$ = $1 + $3; }
  | term '-' expr { $$ = $1 - $3; } 
  | term { $$ = $1; }
  ; 
term:
  factor '*' term { $$ = $1 * $3; }
  | factor '/' term { $$ = $1 / $3; }
  | factor { $$ = $1; }
  ;
factor:
  NUMBER { $$ = $1; }
  | '(' expr ')' { $$ = $2; }
  ;

%% 

void yyerror(char *s) { fprintf(stderr, "%s\n", s); } 

int main(void) { 
  yyparse(); 
} 
