%{
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"
void yyerror(char *);
%}

%%

[a-z]       { 
                yylval.sIndex = *yytext - 'a';
                return VARIABLE;
            }

0           {
                yylval.varValue = (long) atoi(yytext); /* yylval.iValue = atoi(yytext); */
                return INTEGER;
            }

[1-9][0-9]* {
                yylval.varValue = (long) atoi(yytext); /* yylval.iValue = atoi(yytext); */
                return INTEGER;
            }

'.?'        {
                if (yyleng == 2)
                    yylval.varValue = 0;  // empty
                else
                    yylval.varValue = (long) yytext[1];
                return CHAR;
            }

\".*\"      {
                yytext[yyleng - 1] = '\0';
                yylval.varValue = (long) (yytext + 1);
                return STRING;
            }

[-()<>=+*/] {
                return *yytext;
            }

[;{}.%]     {
                return *yytext;
            }

">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"for"           return FOR;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"print"         return PRINT;
"read"          return READ;
"&&"            return AND;
"||"            return OR;

\/\/.*\n        ;   /* skip comments */

[ \t\n]+        ;   /* ignore whitespace */

.               yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}