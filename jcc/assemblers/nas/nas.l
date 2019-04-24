/* NAS V0.3 */

%option noyywrap caseless

%{
#include "nas.tab.h"
#include <string.h>
void yyerror(char *);
char text[500];
%}

%x S

%%

-?[0-9]+	{
		  yylval.i = atoi(yytext);
		  return INT;
		}
sb		{
		  yylval.i = 0;
		  return REG;
		}
fp		{
		  yylval.i = 1;
		  return REG;
		}
"in"|"ac"		{
		  yylval.i = 2;
		  return REG;
		}
sp		{
		  yylval.i = 3;
		  return REG;
		}
L[0-9]{3}	{
		  yylval.i = atoi(yytext + 1); // L123 -> 123
		  return LABEL;
		}

\"		{ BEGIN S; *text = 0; }
<S>[^"\\]*	{ strcat(text, yytext); }
<S>\"		{ strcpy(yylval.s, text); BEGIN 0; return STRING; }
<S>\\\"		{ strcat(text, "\""); }
<S>\\n		{ strcat(text, "\n"); }
<S>\\t		{ strcat(text, "\t"); }
<S>\\		{ strcat(text, "\\"); }

'\\n'		{ yylval.i = (int) '\n'; return INT; }
'\\t'		{ yylval.i = (int) '\t'; return INT; }
'\\''		{ yylval.i = (int) '\''; return INT; }
''		{ yylval.i = 0; return INT; }
'[^']'		{ yylval.i = (int) yytext[1]; return INT; }

[:\[\],]	return *yytext;
call		return CALL;
ret		return RET;
end		return END;
push		return PUSH;
pop		return POP;
compLT		return LT;
compGT		return GT;
compGE		return GE;
compLE		return LE;
compNE		return NE;
compEQ		return EQ;
j0		return J0;
j1		return J1;
jmp		return JMP;
add		return ADD;
sub		return SUB;
mul		return MUL;
div		return DIV;
mod		return MOD;
neg		return NEG;
and		return AND;
or		return OR;
geti		return GETI;
gets		return GETS;
getc		return GETC;
puti		return PUTI;
puts		return PUTS;
putc		return PUTC;
puti_		return PUTI_;
puts_		return PUTS_;
putc_		return PUTC_;
[; \t\n]+	;
"//".*\n	;
.		yyerror("Unknown character");
