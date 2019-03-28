%{
#include <stdio.h>
void yyerror(char *);
int yylex(void);

int dl = 0;
%}

%token var x y z E

%%

P: D S ;
D: var V ';' D { dl += $2; } | ;
S: V '=' E ';' S { printf($1 & dl ? "YES\n" : "NO\n"); } | ;
V: x | y | z ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}
