%{
#include <stdlib.h>
#include <ctype.h>

#include "calc3.h"
#include "y.tab.h"

void yyerror(char *);

char stringVarContent[1023]; // a string cannot exceed 1024 chars
%}

%x STR

%%

^[a-z]+[a-zA-Z0-9]*  { 
                       // need to remove leading zeros? ^ -> ^[ \t\n]*
                       // int idx = 0;
                       // while (isspace(yytext[idx])) idx++;

                       // lowercase
                       char* res = yytext; // + idx if needed
                       for ( ; *res; ++res) *res = tolower(*res);

                       strcpy(yylval.sKey, yytext); // + idx if needed
                       return LOCAL_VARIABLE;
                     }

$[a-z]+[a-zA-Z0-9]*  { 
                       // lowercase
                       char* res = yytext;
                       for ( ; *res; ++res) *res = tolower(*res);

                       strcpy(yylval.sKey, yytext);
                       return VARIABLE;
                     }

0                    {
                       yylval.varValue = (long) atoi(yytext); /* yylval.iValue = atoi(yytext); */
                       return INTEGER;
                     }

[1-9][0-9]*          {
                       yylval.varValue = (long) atoi(yytext); /* yylval.iValue = atoi(yytext); */
                       return INTEGER;
                     }

''                   { yylval.varValue = 0; return CHAR; }
'\\n'                { yylval.varValue = (int) '\n'; return CHAR; }
'\\t'                { yylval.varValue = (int) '\t'; return CHAR; }
'\\a'                { yylval.varValue = (int) '\a'; return CHAR; }
'\\b'                { yylval.varValue = (int) '\b'; return CHAR; }
'\\''                { yylval.varValue = (int) '\''; return CHAR; }
'\\v'                { yylval.varValue = (int) '\v'; return CHAR; }
'\\f'                { yylval.varValue = (int) '\f'; return CHAR; }
'\\r'                { yylval.varValue = (int) '\r'; return CHAR; }
'[^']'               { yylval.varValue = (int) yytext[1]; return CHAR; }

\"                   { BEGIN STR; *stringVarContent = 0; }
<STR>[^"\\]*         { strcat(stringVarContent, yytext); }
<STR>\"              { strcpy(yylval.varStrValue, stringVarContent); BEGIN 0; return STRING; }
<STR>\\\"            { strcat(stringVarContent, "\""); }
<STR>\\              { strcat(stringVarContent, "\\"); }
<STR>\\n             { strcat(stringVarContent, "\n"); }
<STR>\\t             { strcat(stringVarContent, "\t"); }
<STR>\\a             { strcat(stringVarContent, "\a"); }
<STR>\\b             { strcat(stringVarContent, "\b"); }

[-()<>=+*/;{}.%]     {
                       return *yytext;
                     }

">="                   return GE;
"<="                   return LE;
"=="                   return EQ;
"!="                   return NE;
"for"                  return FOR;
"while"                return WHILE;
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

\/\/.*\n               ;   /* skip comments */

[ \t\n]+               ;   /* ignore whitespace */

.                      yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}