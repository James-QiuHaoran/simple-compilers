#include "strmap.h"

#define LBL_NAME_LEN 8
#define REG_NAME_LEN 128
#define VAR_NAME_LEN 13
#define STR_MAX_LEN 1024

#define GLOBAL_TAB_SIZE 256
#define LOCAL_TAB_SIZE 256
#define FUNC_TAB_SIZE 256

typedef enum { typeCon, typeId, typeOpr, typeFunc } nodeEnum;
typedef enum { varTypeInt, varTypeChar, varTypeStr, varTypeNil } varTypeEnum;
typedef enum { typeFuncList, typeStmtList } listTypeEnum;

/* constants */
typedef struct conNodeType {
    int value;                  /* value of constant */
    char strValue[STR_MAX_LEN]; /* string value, max 1024 chars*/
    varTypeEnum type;
} conNodeType;

/* identifiers */
typedef struct idNodeType {
    char varName[VAR_NAME_LEN]; /* subscript to sym array */
    varTypeEnum type;
} idNodeType;

/* operators */
typedef struct oprNodeType {
    int oper;                   /* operator */
    int nops;                   /* number of operands */
    struct nodeType *op[1];     /* operands */
} oprNodeType;

/* functions */
typedef struct funcNodeType {
    char name[VAR_NAME_LEN];
    struct nodeType *args;
    struct nodeType *stmt;
    int num_args;
    int num_local_vars;
} funcNodeType;

/* linked list of nodes, for funcs and stmts */
typedef struct nodeInListType {
    struct nodeType *node;
    struct nodeInListType *next;
} nodeInListType;

/* linked lists, for funcs and stmts */
typedef struct nodeLinkedListType {
    listTypeEnum type;
    int num_nodes;
    struct nodeInListType *head;
    struct nodeInListType *tail;
} nodeLinkedListType;

/* nodes for constants, identifiers, operators, and funcs */
typedef struct nodeType {
    nodeEnum type;

    /* union must be last entry in nodeType */
    /* because operNodeType may dynamically increase */
    union {
        conNodeType con;        /* constants */
        idNodeType id;          /* identifiers */
        oprNodeType opr;        /* operators */
        funcNodeType func;      /* functions*/
    };
} nodeType;

/* stacks - including symbol tables */
typedef struct StackSym {
    StrMap *symbol_table;
    int num_args;
    int num_local_vars;
    struct StackSym *lower;
} StackSym;

/* symbol tables */
extern StrMap* global_sym_tab;
extern StrMap* func_sym_tab;
extern StackSym* local_sym_tab;

/* stack list (functions and statements) */
extern nodeLinkedListType* funcs;
extern nodeLinkedListType* stmts;