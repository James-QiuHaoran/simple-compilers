#include <stdio.h>
#include <stdarg.h>
#include <errno.h>

#include "calc3.h"
#include "y.tab.h"
#include "strmap.h"

#define SB_ID 0
#define FP_ID 1
#define IN_ID 2
#define SP_ID 3

#define SB reg[SB_ID]
#define FP reg[FP_ID]
#define IN reg[IN_ID]
#define SP reg[SP_ID]

static int reg[4];
static char regLabels[4][3] = {"sb", "fp", "in", "sp"};

static int lbl;
extern int errno;

static int isScan;                              // stage 1: scanning; stage 0: execution
static int flevel;                              // current function call level
static StackSym* currentFrameSymTab;            // symbol table for the current frame

/* program init & end functions */
void init();
void end();
void freeNode(nodeType *p);
void start();
void scan(nodeLinkedListType *list);

/* helper functions */
void mvRegPtr(int idx, int offset);
int getLabel(char* label, char* name);
int getRegister(char* reg, char* name);

int pushArgsOnStack(nodeType* args, int lbl_kept);
void constructFuncFrame(funcNodeType* func);
void destructFuncFrame(funcNodeType* func);

// execution of AST on each node
int ex(nodeType *p, int nops, ...) {
    int lblx, lbly, lblz, lbl1, lbl2, lbl_init = lbl, lbl_kept;

    char regName[REG_NAME_LEN];
    char labelName[LAB_NAME_LEN];
    char jmpLabelName[LAB_NAME_LEN];
    int numOfArgs;

    // retrieve lbl_kept
    va_list ap;
    va_start(ap, nops);
    for (int i = 0; i < nops; i++)
        lbl_kept = va_arg(ap, int);

    if (!p) 
        return 0;

    switch(p->type) {
        // constants
        case typeCon:       
            switch(p->con.type){
                case varTypeInt:
                    // integer
                    if (!isScan)
                        printf("\tpush\t%d\n", p->con.value); 
                    break;
                case varTypeChar:
                    // char
                    if (!isScan)
                        printf("\tpush\t\'%c\'\n", (char) p->con.value); 
                    break;
                case varTypeStr:
                    // string
                    if (!isScan)
                        printf("\tpush\t\"%s\"\n", p->con.strValue); 
                    break;
                case varTypeNil:
                    // nothing to be done
                    break;
            }
            break;
        // identifiers
        case typeId:      
            getRegister(regName, p->id.varName);
            if (!isScan)
                printf("\tpush\t%s\n", regName); 
            break;
        // operators
        case typeOpr:
            switch(p->opr.oper) {
                case FOR:
                    lblz = lbl++;
                    lbly = lbl++;
                    lblx = lbl++;
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("L%03d:\n", lblx);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (!isScan)
                        printf("\tj0\tL%03d\n", lbly);
                    ex(p->opr.op[3], 1, lbl_init);
                    if (!isScan)
                        printf("L%03d:\n", lblz); // for continue
                    ex(p->opr.op[2], 1, lbl_kept);
                    if (!isScan)
                        printf("\tjmp\tL%03d\n", lblx);
                    if (!isScan)
                        printf("L%03d:\n", lbly);
                    break;
                case WHILE:
                    lbl1 = lbl++;
                    lbl2 = lbl++;
                    if (!isScan)
                        printf("L%03d:\n", lbl1);
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tj0\tL%03d\n", lbl2);
                    ex(p->opr.op[1], 1, lbl_init);
                    if (!isScan)
                        printf("\tjmp\tL%03d\n", lbl1);
                    if (!isScan)
                        printf("L%03d:\n", lbl2);
                    break;
                case IF:
                    lbl1 = lbl++;
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (p->opr.nops > 2) {
                        lbl2 = lbl++;
                        if (!isScan)
                            printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!isScan)
                            printf("\tjmp\tL%03d\n", lbl2);
                        if (!isScan)
                            printf("L%03d:\n", lbl1);
                        ex(p->opr.op[2], 1, lbl_kept);
                        if (!isScan)
                            printf("L%03d:\n", lbl2);
                    } else {
                        if (!isScan)
                            printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!isScan)
                            printf("L%03d:\n", lbl1);
                    }
                    break;
                case GETI:
                    if (!isScan)
                        printf("\tgeti\n"); 
                    getRegister(regName, p->opr.op[0]->id.varName);
                    if (!isScan)
                        printf("\tpop\t%s\n", regName); 
                    break;
                case GETC: 
                    if (!isScan)
                        printf("\tgetc\n"); 
                    getRegister(regName, p->opr.op[0]->id.varName);
                    if (!isScan)
                        printf("\tpop\t%s\n", regName); 
                    break;
                case GETS: 
                    if (!isScan)
                        printf("\tgets\n"); 
                    getRegister(regName, p->opr.op[0]->id.varName);
                    if (!isScan)
                        printf("\tpop\t%s\n", regName); 
                    break;
                case PUTI: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputi\n");
                    break;
                case PUTI_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputi_\n");
                    break;
                case PUTC: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputc\n");
                    break;
                case PUTC_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputc_\n");
                    break;
                case PUTS: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputs\n"); 
                    break;
                case PUTS_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tputs_\n");
                    break;
                case '=':  
                    getRegister(regName, p->opr.op[0]->id.varName);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (p->opr.op[0]->type == typeId) {
                        if (!isScan)
                            printf("\tpop\t%s\n", regName);
                    }
                    break;
                case UMINUS:    
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tneg\n");
                    break;
                case CALL:
                    numOfArgs = pushArgsOnStack(p->opr.op[1], lbl_kept);
                    getLabel(labelName, p->opr.op[0]->id.varName);
                    if (!isScan)
                        printf("\tcall\t%s, %d\n", labelName, numOfArgs);
                    break;
                case RETURN:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!isScan)
                        printf("\tret\n");
                    break;
                default:
                    ex(p->opr.op[0], 1, lbl_kept);
                    ex(p->opr.op[1], 1, lbl_kept);
                    switch(p->opr.oper) {
                        case '+': if (!isScan) printf("\tadd\n"); break;
                        case '-': if (!isScan) printf("\tsub\n"); break; 
                        case '*': if (!isScan) printf("\tmul\n"); break;
                        case '/': if (!isScan) printf("\tdiv\n"); break;
                        case '%': if (!isScan) printf("\tmod\n"); break;
                        case '<': if (!isScan) printf("\tcompLT\n"); break;
                        case '>': if (!isScan) printf("\tcompGT\n"); break;
                        case GE:  if (!isScan) printf("\tcompGE\n"); break;
                        case LE:  if (!isScan) printf("\tcompLE\n"); break;
                        case NE:  if (!isScan) printf("\tcompNE\n"); break;
                        case EQ:  if (!isScan) printf("\tcompEQ\n"); break;
                        case AND: if (!isScan) printf("\tand\n"); break;
                        case OR:  if (!isScan) printf("\tor\n"); break;
                    }
            }
            break;
        // functions
        case typeFunc:
            constructFuncFrame(&p->func);
            ex(p->func.stmt, 1, lbl_kept);
            destructFuncFrame(&p->func);
            if (!isScan) 
                printf("\tret\n");
            break;
    }
    return 0;
}

// execute AST
void execute() {
    // statements
    nodeInListType *pstmt = stmts->head;

    while(pstmt) {
        nodeType *curr = pstmt->node;
        ex(curr, 0);
        pstmt = pstmt->next; 
    }

    printf("\tend\n");

    // functions
    nodeInListType *pfunc = funcs->head;

    while(pfunc) {
        nodeType *curr = pfunc->node;

        // label function & register function name
        char label[LAB_NAME_LEN];
        int hasDeclared = getLabel(label, curr->func.name);

        // error checking
        if (hasDeclared == 1) {
            // function has been declared
            printf("%s:\n", label);
        } else {
            // unknown functions
            fprintf(stderr, "Undeclared functions [errno: %d]\n", errno);
            exit(1);
        }

        ex(curr, 0);
        pfunc = pfunc->next; 
    }
}

// retrieve function label names
int getLabel(char* label, char* name) {
    if (sm_exists(funcSym, name)) {
        sm_get(funcSym, name, label, LAB_NAME_LEN);
        return 1;
    } else {
        sprintf(label, "L%03d", lbl++);
        sm_put(funcSym, name, label);
        return 0;
    }
}

// retrieve register name
int getRegister(char* reg, char* name) {
    if (flevel == 0) {
        // main function -> global variable
        if (sm_exists(globalSym, name)) {
            sm_get(globalSym, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            int numOfGlobalVars = sm_get_count(globalSym);
            sprintf(reg, "sb[%d]", numOfGlobalVars);
            sm_put(globalSym, name, reg);
            return 0;
        }
    } else if (name[0] == '$') {
        // declare global variables inside a function
        if (sm_exists(globalSym, name + 1)) {
            sm_get(globalSym, name + 1, reg, REG_NAME_LEN);
            return 1;
        } else {
            int numOfGlobalVars = sm_get_count(globalSym);
            sprintf(reg, "sb[%d]", numOfGlobalVars);
            sm_put(globalSym, name + 1, reg);
            return 0;
        }
    } else {
        // first lookup whether the variable exists in local symbol table
        if (sm_exists(currentFrameSymTab->symbol_table, name)) {
            sm_get(currentFrameSymTab->symbol_table, name, reg, REG_NAME_LEN);
            return 1;
        } else if (sm_exists(globalSym, name)) {
            // then check whether it's in the global symbol table
            sm_get(globalSym, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            // otherwise create the local variable in the local table
            sprintf(reg, "fp[%d]", currentFrameSymTab->num_local_vars++);
            sm_put(currentFrameSymTab->symbol_table, name, reg);
            return 0;
        }
    }
}

// return number of arguments
int pushArgsOnStack(nodeType* args, int lbl_kept) {
    if (args == NULL) 
        return 0;

    if (args->type != typeOpr || args->opr.oper != ',') {
        ex(args, 1, lbl_kept);       
        return 1;
    }

    int numOfArgs = pushArgsOnStack(args->opr.op[0], lbl_kept);
    ex(args->opr.op[1], 1, lbl_kept);

    return 1 + numOfArgs;
}

// [TODO]
void constructFuncFrame(funcNodeType* func) {
    // deepen function call level
    flevel++;

    // create local symbol table
    StackSym* symTab = (StackSym*) malloc(sizeof(StackSym));
    symTab->symbol_table = sm_new(LOCAL_TAB_SIZE);
    symTab->lower = currentFrameSymTab;
    currentFrameSymTab = symTab;

    // insert parameters into stack
    nodeType* paramList = func->args;
    int numOfParams = 0;
    char regName[REG_NAME_LEN];
    while (paramList != NULL && paramList->type == typeOpr && paramList->opr.oper == ',') {
        sprintf(regName, "fp[%d]", -4 - numOfParams++);
        sm_put(currentFrameSymTab->symbol_table, paramList->opr.op[1]->id.varName, regName);
        paramList = paramList->opr.op[0];
    }
    if (paramList != NULL) {
        sprintf(regName, "fp[%d]", -4 - numOfParams++);
        sm_put(currentFrameSymTab->symbol_table, paramList->id.varName, regName);
    }

    // store meta data
    if (!isScan) {
        // execution
        if (numOfParams != func->num_args) {
            // error
            fprintf(stderr, "Number of parameters mismatch [errno: %d]\n", errno);
            exit(1);
        }
    } else 
        func->num_args = numOfParams;
    currentFrameSymTab->num_args = numOfParams;
    currentFrameSymTab->num_local_vars = 0;

    // push space onto stack for local variables
    if (!isScan) {
        if (func->num_local_vars) {
            mvRegPtr(SP_I, func->num_local_vars);
        }
    }
}

// [TODO]
void destructFuncFrame(funcNodeType* func) {
    // keep variable information if scanning
    int numOfLocalVars = currentFrameSymTab->num_local_vars;
    if (!isScan) {
        // execution
        if (numOfLocalVars != func->num_local_vars) {
            // error
            fprintf(stderr, "Number of local variables mismatch [errno: %d]\n", errno);
            exit(1);
        }
    } else 
        func->num_local_vars = numOfLocalVars;

    // clean up
    flevel--;

    StackSym* prevFrameSymTab = currentFrameSymTab->lower;
    sm_delete(currentFrameSymTab->symbol_table);
    free(currentFrameSymTab);
    currentFrameSymTab = prevFrameSymTab;
}

// program initialization for execution
void init() {
    // init symbol tables
    globalSym = sm_new(GLOBAL_TAB_SIZE);
    funcSym = sm_new(FUNC_TAB_SIZE);

    localSym = (StackSym*) malloc(sizeof(StackSym));
    localSym->lower = NULL;
    localSym->symbol_table = NULL;
    currentFrameSymTab = localSym;

    // init function & statement lists
    funcs = malloc(sizeof(nodeLinkedListType)); 
    funcs->type = typeFuncList; 
    funcs->num_nodes = 0; 
    funcs->head = funcs->tail = NULL;

    stmts = malloc(sizeof(nodeLinkedListType)); 
    stmts->type = typeStmtList; 
    stmts->num_nodes = 0; 
    stmts->head = stmts->tail = NULL;

    // init pointer values
    SB = FP = IN = SP = 0;
}

// terminate and wrap up
void end() {
    // delete symbol tables
    sm_delete(globalSym);
    sm_delete(funcSym);

    // free the local symbol table
    free(localSym);

    // free the node lists for functions
    nodeInListType *trash = funcs->head;

    while (trash) {
        freeNode(trash->node);
        funcs->head = trash->next;
        free(trash);
        trash = funcs->head;
    }

    free(funcs);

    // free the node lists for statements
    trash = stmts->head;

    while (trash) {
        freeNode(trash->node);
        stmts->head = trash->next;
        free(trash);
        trash = stmts->head;
    }

    free(stmts);

    // exit
    exit(0);
}

// start to compile: scanning
void start() {
    scan(stmts);
    scan(funcs);

    // make room for global variables
    int numOfGlobalVars = sm_get_count(globalSym);
    if (numOfGlobalVars) {
        mvRegPtr(SP_ID, numOfGlobalVars);
    }
}

// scanner
void scan(nodeLinkedListType *list) {
    isScan = 1;

    nodeInListType *p = list->head;

    while(p) {
        nodeType *n = p->node;
        ex(n, 0);
        p = p->next; 
    }

    isScan = 0;
}

// move register pointer
void mvRegPtr(int idx, int offset) {
    printf("\tpush\t%s\n", regLabels[idx]);
    printf("\tpush\t%d\n", offset);
    printf("\tadd\n");
    printf("\tpop\t%s\n", regLabels[idx]);

    reg[idx] += offset;
}