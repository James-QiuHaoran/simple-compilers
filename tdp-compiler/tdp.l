%{
    #include "y.tab.h"
    #include <stdlib.h>

    void yyerror(char *);
%}

%%

"move"        return MOVE;
"plot"        return PLOT;
"display"     return DISPLAY;
"reset_pen"   return RESET_PEN;
"reset_bed"   return RESET_BED;
"set_pen"     return SET_PEN;
"move_to"     return MOVE_TO;
"plot_line"   return PLOT_LINE;
"plot_rect"   return PLOT_RECT;
"exit"        return EXIT;

[1-9][0-9]* {
              yylval.num = atoi(yytext);
              return NUM;
            }

[0]         {
              yylval.num = atoi(yytext);
              return NUM;
            }

[x*#$o@]    {
              yylval.symbol = yytext;
              return SYMBOL;
            }

[-(),]      {
              return *yytext;
            }

[ \t\n]+  ;

.         {yyerror("Unknown character"); printf("%s\n",yytext);}

%%

int yywrap(void) {
    return 0;
}
