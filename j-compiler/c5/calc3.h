#include "strmap.h"

#define GLOBAL_SIZE 100
#define LOCAL_SIZE 100
#define FUNC_SIZE 100

#define VAR_NAME_LEN 13
#define STR_MAX_LEN 1024
#define LAB_NAME_LEN 6
#define REG_NAME_LEN 100

typedef enum { typeCon, typeId, typeOpr, typeFunc } nodeEnum;
typedef enum { varTypeInt, varTypeChar, varTypeStr, varTypeNil } varTypeEnum;
typedef enum { typeFuncList, typeStmtList } listTypeEnum;

/* constants */
typedef struct conNodeType {
    int value;                  /* value of constant */
    char strValue[STR_MAX_LEN]; /* string value, max 1023 chars*/
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
    struct nodeTypeTag *op[1];  /* operands (expandable) */
} oprNodeType;

/* functions */
typedef struct funcNodeType {
    char name[VAR_NAME_LEN];
    struct nodeTypeTag *args;
    struct nodeTypeTag *stmt;
    int num_args;
    int num_local_vars;
} funcNodeType;

/* nodes, for funcs and stmts */
typedef struct nodeInListType {
    struct nodeTypeTag *node;
    struct nodeInListType *next;
} nodeInListType;

/* linked lists, for funcs and stmts */
typedef struct nodeLinkedListType {
    listTypeEnum type;          /* type of node list */
    int num_nodes;              /* number of nodes */
    struct nodeInListType *head;
    struct nodeInListType *tail;
} nodeLinkedListType;

typedef struct nodeTypeTag {
    nodeEnum type;              /* type of node */

    /* union must be last entry in nodeType */
    /* because operNodeType may dynamically increase */
    union {
        conNodeType con;        /* constants */
        idNodeType id;          /* identifiers */
        oprNodeType opr;        /* operators */
        funcNodeType func;      /* functions*/
    };
} nodeType;

typedef struct StackSym {
    StrMap *symbol_table;
    int num_args;
    int num_local_vars;
    struct StackSym *lower;
} StackSym;

/* symbol tables */
extern StrMap* globalSym;
extern StrMap* funcSym;
extern StackSym* localSym;

/* stack list (functions and statements) */
extern nodeLinkedListType* funcs;
extern nodeLinkedListType* stmts;