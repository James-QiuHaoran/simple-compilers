%{
#include <stdio.h>
void yyerror(char *);
int yylex(void);
%}

%token var x y z E

%%

P: D S ;
D: D var V ';' { $$ = $1 + $3; } | { $$ = 0; } ;
S: S V '=' E ';' { printf($2 & $0 ? "YES\n" : "NO\n"); } | ;
V: x | y | z ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}
