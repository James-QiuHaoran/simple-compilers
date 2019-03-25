%debug

%{
#include <stdio.h>
int yylex (void);
void yyerror (char const *);
%}

%token y

%%

x:	/* empty */
        | x y { yyerrok; }
	| x error
;

%%

void
yyerror (char const *s) {
  printf ("%s\n", s);
}

int main(int argc, char argv[]) {
  yydebug = --argc ? 1 : 0;
  yyparse();
}
