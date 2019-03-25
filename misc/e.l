%option noyywrap

%{ 
  #include "e1.tab.h" 
%} 

%%

y		return y;
[^[:space:]]	return *yytext;
[[:space:]]	;

%%
