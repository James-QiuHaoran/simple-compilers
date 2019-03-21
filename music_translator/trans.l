/* scanner for simple music notation */

%{
    #include "y.tab.h"
    #include <stdlib.h>

    void yyerror(char *);
    int transform(int original);
%}

%%

[drmfslt]     {
                  yylval.num = transform(*yytext - 'a');
                  return SYMBOL;
              }

[DRMFSLT]     {
                  yylval.num = transform(*yytext - 'A') + 10;
                  return SYMBOL;
              }

[1-9]         {
                  yylval.num = atoi(yytext);
                  return ID;
              }

[0]           {
                  yylval.num = 8;
                  return SYMBOL;
              }

[(:)/\!@>]    {
                  return *yytext;
              }

[-]+          {
                  yylval.num = strlen(yytext) + 1;
                  return ENLONG;
              }

[ \t\n]+      ;

.             yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}

int transform(int original) {
    if (original == 3) {            /* Dd */
        return 0;
    } else if (original == 17) {    /* Rr */
        return 1;
    } else if (original == 12) {    /* Mm */
        return 2;
    } else if (original == 5) {     /* Ff */
        return 3;
    } else if (original == 18) {    /* Ss */
        return 4;
    } else if (original == 11) {    /* Ll */
        return 5;
    } else if (original == 19) {    /* Tt */
        return 6;
    } else {
        return -1;
    }
}