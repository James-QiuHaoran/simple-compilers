%option noyywrap

%{
    #include "y.tab.h"
%}

%%

x	{ yylval = 1; return x; }
y	{ yylval = 2; return y; }
z	{ yylval = 4; return z; }
E	{ return E; }
var	{ return var; }
[=;]	{ return *yytext; }
\n
.

%%
