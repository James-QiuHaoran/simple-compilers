%option noyywrap

%{

#include <stdlib.h>
#include "lrcal.tab.h"

%}

%%

[[:digit:]]+	{ yylval = atoi(yytext); return NUMBER; }
[-+()=/*\n]	{ return *yytext; }
.

<<EOF>>	{ return END; }

%%