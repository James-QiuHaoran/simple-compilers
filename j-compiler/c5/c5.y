%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "calc3.h"
#include "strmap.h"

/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);                         // original
nodeType *nameToNode(char* name);            // new
nodeType *con(int value);                    // original
nodeType *var(long value, varTypeEnum type); // new
nodeType *func(char* name, nodeType *args, nodeType *stmt);

void freeNode(nodeType *p);
void addNode(nodeLinkedListType* list, nodeType* node);

void init();
void start();
void end();

int ex(nodeType *p, int nops, ...);
void execute();                      // new statement and function list execution

int yylex(void);
void yyerror(char *s);

int sym[26];                    /* symbol table */
StrMap* globalSym;              /* global variable symbol table */
StrMap* funcSym;                /* global function symbol table */
StackSym* localSym;             /* local symbol table */

nodeLinkedListType* funcs;   
nodeLinkedListType* stmts;
%}

%union {
    int intValue;               /* integer value (int | char) */
    char strValue[1023];        /* const value (string) */
    char sIndex[12];            /* symbol table index */
    nodeType *nPtr;             /* node pointer */
};

%token <intValue> INTEGER CHAR
%token <strValue> STRING
%token <sIndex> VARIABLE LOCAL_VARIABLE
%token FOR WHILE IF RETURN CALL GETI GETC GETS PUTI PUTC PUTS PUTI_ PUTC_ PUTS_
%nonassoc IFX
%nonassoc ELSE

%left AND OR
%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%nonassoc UMINUS

%type <nPtr> stmt expr stmt_list func params param variable args arg

%%

program:
          main_func                                        { start(); execute(); end(); }
        ;

main_func:  
          main_func stmt                                   { addNode(stmts, $2); }
        | main_func func                                   { addNode(funcs, $2); }
        | /* NULL */
        ;

func:
          LOCAL_VARIABLE '(' params ')' '{' stmt_list '}'  { $$ = func($1, $3, $6); }
        ;

params:
          param                                            { $$ = $1; }
        | params ',' param                                 { $$ = opr(',', 2, $1, $3); }
        ;

param:
          variable                                         { $$ = $1; }
        | /* NULL */                                       { $$ = NULL; }
        ;

variable:
          VARIABLE                                         { $$ = nameToNode($1); }
        | LOCAL_VARIABLE                                   { $$ = nameToNode($1); }
        ;

stmt:
          ';'                                              { $$ = opr(';', 2, NULL, NULL); }
        | expr ';'                                         { $$ = $1; }
        | GETI '(' variable ')' ';'                        { $$ = opr(GETI, 1, $3); }
        | GETC '(' variable ')' ';'                        { $$ = opr(GETC, 1, $3); }
        | GETS '(' variable ')' ';'                        { $$ = opr(GETS, 1, $3); }
        | PUTI '(' arg ')' ';'                             { $$ = opr(PUTI, 1, $3); }
        | PUTI_ '(' arg ')' ';'                            { $$ = opr(PUTI_, 1, $3); }
        | PUTC '(' arg ')' ';'                             { $$ = opr(PUTC, 1, $3); }
        | PUTC_ '(' arg ')' ';'                            { $$ = opr(PUTC_, 1, $3); }
        | PUTS '(' arg ')' ';'                             { $$ = opr(PUTS, 1, $3); }
        | PUTS_ '(' arg ')' ';'                            { $$ = opr(PUTS_, 1, $3); }
        | variable '=' expr ';'                            { $$ = opr('=', 2, $1, $3); }
        | FOR '(' stmt stmt stmt ')' stmt                  { $$ = opr(FOR, 4, $3, $4, $5, $7); }
        | WHILE '(' expr ')' stmt                          { $$ = opr(WHILE, 2, $3, $5); }
        | IF '(' expr ')' stmt %prec IFX                   { $$ = opr(IF, 2, $3, $5); }
        | IF '(' expr ')' stmt ELSE stmt                   { $$ = opr(IF, 3, $3, $5, $7); }
        | LOCAL_VARIABLE '(' params ')' ';'                { $$ = opr(CALL, 2, nameToNode($1), $3); }
        | RETURN expr ';'                                  { $$ = opr(RETURN, 1, $2); }
        | '{' stmt_list '}'                                { $$ = $2; }
        ;

arg:
          expr                                             { $$ = $1; }
        | /* NULL */                                       { $$ = NULL; }
        ;

stmt_list:
          stmt                                             { $$ = $1; }
        | stmt_list stmt                                   { $$ = opr(';', 2, $1, $2); }
        ;

expr:
          INTEGER                                          { $$ = var($1, varTypeInt); }
        | CHAR                                             { $$ = var($1, varTypeChar); }
        | STRING                                           { $$ = var((long) $1, varTypeStr); }
        | variable                                         { $$ = $1; }
        | '-' expr %prec UMINUS                            { $$ = opr(UMINUS, 1, $2); }
        | expr '+' expr                                    { $$ = opr('+', 2, $1, $3); }
        | expr '-' expr                                    { $$ = opr('-', 2, $1, $3); }
        | expr '*' expr                                    { $$ = opr('*', 2, $1, $3); }
        | expr '%' expr                                    { $$ = opr('%', 2, $1, $3); }
        | expr '/' expr                                    { $$ = opr('/', 2, $1, $3); }
        | expr '<' expr                                    { $$ = opr('<', 2, $1, $3); }
        | expr '>' expr                                    { $$ = opr('>', 2, $1, $3); }
        | expr GE expr                                     { $$ = opr(GE, 2, $1, $3); }
        | expr LE expr                                     { $$ = opr(LE, 2, $1, $3); }
        | expr NE expr                                     { $$ = opr(NE, 2, $1, $3); }
        | expr EQ expr                                     { $$ = opr(EQ, 2, $1, $3); }
        | expr AND expr                                    { $$ = opr(AND, 2, $1, $3); }
        | expr OR expr                                     { $$ = opr(OR, 2, $1, $3); }
        | '(' expr ')'                                     { $$ = $2; }
        | VARIABLE '(' args ')'                            { $$ = opr(CALL, 2, nameToNode($1), $3); }
        ;

args:   
          arg                                              { $$ = $1; }
        | args ',' arg                                     { $$ = opr(',', 2, $1, $3); }
        ;

%%

#define SIZEOF_NODETYPE ((char *)&p->con - (char *)p)

// original con -> nodeType *var(long value, varTypeEnum type)
nodeType *con(int value) {
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(conNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeCon;
    p->con.value = value;

    return p;
}

// original con -> nodeType *var(long value, varTypeEnum type)
nodeType *var(long value, varTypeEnum type) {
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(conNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeCon;
    p->con.type = type;
    if (type == varTypeStr) { 
        strcpy(p->con.strValue, (char*) value); 
    } else {
        p->con.value = (int) value;
    }

    return p;
}

nodeType *func(char* name, nodeType *args, nodeType *stmt) {
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(funcNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeFunc;
    strcpy(p->func.name, name);
    p->func.num_args = 0;
    p->func.num_local_vars = 0;
    p->func.args = args;
    p->func.stmt = stmt;

    return p;
}

// original id -> nodeType *nameToNode(char* name)
nodeType *nameToNode(char* name) {
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(idNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeId;
    strcpy(p->id.varName, name);
    p->id.type = varTypeNil;

    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    size_t nodeSize;
    int i;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(oprNodeType) +
        (nops - 1) * sizeof(nodeType*);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
}

void addNode(nodeLinkedListType* list, nodeType* node) {
    nodeInListType *p;

    /* allocate memory for the node */
    if ((p = malloc(sizeof(nodeInListType))) == NULL)
        yyerror("out of memory");

    // linked list
    p->node = node;
    p->next = NULL;
    if (list->tail) {
        list->tail->next = p;
        list->tail = p;
    } else {
        list->head = p;
        list->tail = p;
    }
    list->num_nodes++;
}

void freeNode(nodeType *p) {
    if (!p) return;
    if (p->type == typeOpr) {
        for (int i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }
    free(p);
}

void yyerror(char *s) {
    fprintf(stdout, "%s\n", s);
}

int main(int argc, char **argv) {
    extern FILE* yyin;
    yyin = fopen(argv[1], "r");

    // initialization for the compiler
    init();

    yyparse();
    return 0;
}