%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define MAX_SYMBOL 3

    void yyerror(char *);
    int yylex(void);
    char *trans(int symbol);
    char *int2str(int symbol);
    char *sPrint(char *fst, char *snd);
    char *iPrint(int id, char *content);
    char *oPrint(int type, char *symbol);
    char *tPrint(int type, char *fst, char *snd);

    char *tags[10];
    const char lower_s[7] = {'d', 'r', 'm', 'f', 's', 'l', 't'};
    const char upper_s[7] = {'D', 'R', 'M', 'F', 'S', 'L', 'T'};
    const char* lower_abc[7] = {"G,", "A,", "B,", "C", "D", "E", "F"};
    const char* upper_abc[7] = {"G", "A", "B", "c", "d", "e", "f"};
%}

%token <iVal> SYMBOL ID ENLONG

%union {
    char *charPr;
    int iVal;
    int num;
}

%type <charPr> melody tagcall sentence onecomb twocomb syllable

/* %define parse.error verbose */

%%

melody:
         sentence                     {}
         ;

tagcall:
         '(' ID ':' sentence ')'      { $$ = iPrint($2, $4); }
         | '@' ID                     { printf("%s", tags[$2]); $$ = tags[$2]; }
         ;

sentence:
         sentence onecomb           { $$ = sPrint($1, $2); }
         | sentence twocomb           { $$ = sPrint($1, $2); }
         | sentence tagcall           {}
         |                            { $$ = ""; }
         ;

onecomb:    
         '\\' syllable                { $$ = oPrint(0, $2); }
         | '/' syllable               { $$ = oPrint(1, $2); }
         | syllable                   { $$ = $1; }
         ;

twocomb:
         onecomb '>' onecomb        { $$ = tPrint(0, $1, $3); }
         | '!' onecomb onecomb      { $$ = tPrint(1, $2, $3); }
         | '!' onecomb '>' onecomb  { $$ = tPrint(2, $2, $4); }
         ;

syllable:
         SYMBOL                       { $$ = trans($1); }
         | ENLONG                     { $$ = int2str($1); }
         ;

%%

char *trans(int symbol) {
    if (symbol >= 0 && symbol < 7) {
        int len = strlen(lower_abc[symbol]);
        char *res = malloc(sizeof(char) * len);
        strcpy(res, lower_abc[symbol]);
        return res;
    } else if (symbol >= 10 && symbol <17) {
        // printf("test: %d\n", symbol);
        int len = strlen(upper_abc[symbol - 10]);
        char *res = malloc(sizeof(char) * len);
        strcpy(res, upper_abc[symbol-10]);
        return res;
    } else if (symbol == 8) {
        char *res = "z";
        return res;
    } else {
        yyerror("Syntax error");
    }
}

char *int2str(int symbol) {
    char *res = malloc(sizeof(char) * 100);
    sprintf(res, "%d", symbol);
    return res;
}

char *sPrint(char *fst, char *snd) {
    // printf("test\n");
    int len = strlen(fst) + strlen(snd);
    char *res = malloc(sizeof(char) * len);
    strcpy(res, fst);
    strcat(res, snd);

    printf("%s", snd);

    return res;
}

char *iPrint(int id, char *content) {
    // printf("%s\n", content);
    int len = strlen(content);
    char *res = malloc(sizeof(char) * len);
    strcpy(res, content);

    tags[id] = res;

    return res;
}

char *oPrint(int type, char *symbol) {
    int len = strlen(symbol) + 1;
    char *res = malloc(sizeof(char) * len);
    if (type == 0) {
        strcpy(res, "_");
        strcat(res, symbol);
        return res;
    } else if (type == 1) {
        strcpy(res, "^");
        strcat(res, symbol);
        return res;
    }
}

char *tPrint(int type, char *fst, char *snd) {
    if (type == 0) {
        int len = strlen(fst) + strlen(snd) + 1;
        char *res = malloc(sizeof(char) * len);
        strcpy(res, fst);
        strcat(res, ">");
        strcat(res, snd);
        return res;
    } else if (type == 1) {
        int len = strlen(fst) + strlen(snd) + 2;
        char *res = malloc(sizeof(char) * len);
        strcpy(res, fst);
        strcat(res, "/");
        strcat(res, snd);
        strcat(res, "/");
        return res;
    } else if (type == 2) {
        int len = strlen(fst) + strlen(snd) + 6;
        char *res = malloc(sizeof(char) * len);
        strcpy(res, fst);
        strcat(res, "3/4");
        strcat(res, snd);
        strcat(res, "1/4");
        return res;
    }
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("X: 1\n");
    printf("T: This is the title.\n");
    printf("C: This is the composer.\n");
    printf("L: 1/4\n");
    printf("K: G\n");
    yyparse();
    printf("\n");
}
