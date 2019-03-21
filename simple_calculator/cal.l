%{ 
#include <stdlib.h> 
void yyerror(char *); 
#include "cal.tab.h"
%} 
%% 
  /* variables */
[a-z][-]+ {
  printf("test: %d\n", strlen(yytext)); 
  yylval = *yytext - 'a'; 
  return VARIABLE; 
} 

  /* integers */ 
[0-9]+ { 
  yylval = atoi(yytext); 
  return INTEGER; 
} 

  /* operators */ 
[ - +()=/*\n] { return *yytext; } 

  /* skip whitespace */ 
[ \t] ;
 
  /* anything else is an error */ 
. yyerror("invalid character");
%%

int yywrap(void) {
    return 1;
}