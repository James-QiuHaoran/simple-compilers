/*
 * wc.l - word (and line and char) count
 * 
 * flex wc.l ; gcc -o mywc lex.yy.c -lfl ; ./mywc
 */

%{
  int chars = 0;
  int words = 0;
  int lines = 0;
%}

%%
	/* [:alnum:] == [a-zA-Z0-9] */
[[:alnum:]]+	{ words++; chars += strlen(yytext); }
\n		{ lines++; chars++; } 
.		{ chars++; } 

%%

main() {
  yylex();
  printf("L=%d W=%d C=%d\n", lines, words, chars);
}
