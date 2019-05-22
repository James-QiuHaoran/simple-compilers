%{
#include <stdlib.h>
#include <ctype.h>

#include "calc3.h"
#include "y.tab.h"

void yyerror(char *);

char stringVarContent[STR_MAX_LEN]; // a string cannot exceed 1024 chars
%}

%x STR

%%

0                    {
                       yylval.intValue = (long) atoi(yytext);
                       return INTEGER;
                     }

[1-9][0-9]*          {
                       yylval.intValue = (long) atoi(yytext);
                       return INTEGER;
                     }

''                   { yylval.intValue = 0; return CHAR; }
'\\n'                { yylval.intValue = (int) '\n'; return CHAR; }
'\\t'                { yylval.intValue = (int) '\t'; return CHAR; }
'\\a'                { yylval.intValue = (int) '\a'; return CHAR; }
'\\b'                { yylval.intValue = (int) '\b'; return CHAR; }
'\\''                { yylval.intValue = (int) '\''; return CHAR; }
'\\v'                { yylval.intValue = (int) '\v'; return CHAR; }
'\\f'                { yylval.intValue = (int) '\f'; return CHAR; }
'\\r'                { yylval.intValue = (int) '\r'; return CHAR; }
'\\0'                { yylval.intValue = 0; return INTEGER; }
'[^']'               { yylval.intValue = (int) yytext[1]; return CHAR; }

\"                   { BEGIN STR; *stringVarContent = 0; }
<STR>[^"\\]*         { strcat(stringVarContent, yytext); }
<STR>\"              { strcpy(yylval.strValue, stringVarContent); BEGIN 0; return STRING; }
<STR>\\\"            { strcat(stringVarContent, "\""); }
<STR>\\              { strcat(stringVarContent, "\\"); }
<STR>\\n             { strcat(stringVarContent, "\n"); }
<STR>\\t             { strcat(stringVarContent, "\t"); }
<STR>\\a             { strcat(stringVarContent, "\a"); }
<STR>\\b             { strcat(stringVarContent, "\b"); }

[-()<>=+*/;{}.%,&]   {
                       return *yytext;
                     }
[\[\]]               {
                       return *yytext;
                     }

">="                   return GE;
"<="                   return LE;
"=="                   return EQ;
"!="                   return NE;
"for"                  return FOR;
"while"                return WHILE;
"break"                return BREAK;
"continue"             return CONTINUE;
"if"                   return IF;
"else"                 return ELSE;
"geti"                 return GETI;
"getc"                 return GETC;
"gets"                 return GETS;
"puti"                 return PUTI;
"putc"                 return PUTC;
"puts"                 return PUTS;
"puti_"                return PUTI_;
"putc_"                return PUTC_;
"puts_"                return PUTS_;
"&&"                   return AND;
"||"                   return OR;
"return"               return RETURN;
"array"                return ARRAY_DECL;

^[a-z]+[a-zA-Z0-9]*  { 
                       /* case insensitive */
                       char* res = yytext;
                       for ( ; *res; ++res) *res = tolower(*res);

                       strcpy(yylval.sIndex, yytext);
                       return LEFT_VARIABLE;
                     }

$?[a-z]+[a-zA-Z0-9]* { 
                       /* case insensitive */
                       char* res = yytext;
                       for ( ; *res; ++res) *res = tolower(*res);

                       strcpy(yylval.sIndex, yytext);
                       return RIGHT_VARIABLE;
                     }

\/\/.*\n               ;   /* skip comments */

[ \t\n]+               ;   /* ignore whitespace */

.                      { printf("Unknown character: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}