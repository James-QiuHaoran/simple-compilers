#include "strmap.h"

#define LBL_NAME_LEN 8
#define REG_NAME_LEN 128
#define VAR_NAME_LEN 14
#define STR_MAX_LEN 1024
#define DIM_STR_LEN 128

#define GLOBAL_TAB_SIZE 256
#define LOCAL_TAB_SIZE 256
#define FUNC_TAB_SIZE 256

#define STR_HASH_LEN 4

typedef enum { typeCon, typeId, typeArr, typeOpr, typeFunc } nodeEnum;
typedef enum { varTypeInt, varTypeFloat, varTypeChar, varTypeStr, varTypeNil } varTypeEnum;
typedef enum { typeFuncList, typeStmtList } listTypeEnum;

/* constants */
typedef struct conNodeType {
    int value;                  /* value of constant */
    double fValue;
    char strValue[STR_MAX_LEN]; /* string value, max 1024 chars*/
    int strValueHash;           /* hash value for the string content */
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

/* arrays */
typedef struct arrNodeType {
    struct arrOffsetListNodeType *offsetListHead;
    struct arrOffsetListNodeType *offsetListTail;
    char name[VAR_NAME_LEN];
    int dimension;
    int size;
} arrNodeType;

typedef struct arrOffsetListNodeType {
    struct nodeType *offset;
    struct arrOffsetListNodeType *next;
} arrOffsetListNodeType;

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
        arrNodeType arr;        /* arrays */
        oprNodeType opr;        /* operators */
        funcNodeType func;      /* functions*/
    };
} nodeType;

/* stacks - including symbol tables */
typedef struct StackSym {
    StrMap *symbol_table;
    StrMap *arr_dim_sym_tab;
    int num_args;
    int num_local_vars;
    struct StackSym *lower;
} StackSym;

/* symbol table including dimension table */
typedef struct SymTab {
    StrMap *symbol_table;
    StrMap *arr_dim_sym_tab;
    int size;
} SymTab;

/* symbol tables */
extern SymTab* global_sym_tab;
extern SymTab* func_sym_tab;
extern StackSym* local_sym_tab;

/* strings */
extern StrMap* string_tab;
extern StrMap* string_var_tab;

/* stack list (functions and statements) */
extern nodeLinkedListType* funcs;
extern nodeLinkedListType* stmts;