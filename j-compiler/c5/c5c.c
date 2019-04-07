#include <stdio.h>
#include <stdarg.h>
#include "calc3.h"
#include "y.tab.h"
#include "strmap.h"

#define SB_I 0
#define FP_I 1
#define IN_I 2
#define SP_I 3

#define SB reg[SB_I]
#define FP reg[FP_I]
#define IN reg[IN_I]
#define SP reg[SP_I]

static int lbl;

static int funcCallLevel;                       // level of function calls
static StackSym* currentFrameSymTab;            // symbol table for current frame
static int isScan;                              // 1: scanning; 0: execution

static int reg[4];
static char regNames[4][3] = {"sb", "fp", "in", "sp"};

int getLabel(char* labelName, char* name);
int getRegName(char* regName, char* name);

int pushArgs(nodeType* argList, int lbl_kept);

void createCallFrame(funcNodeType* func);
void tearDownCallFrame(funcNodeType* func);

void init();
void end();
void freeNode(nodeType *p);

void start();
void preScan(nodeLinkedListType *list);
void moveRegPointer(int regIdx, int offset);
void makeRoomGlobalVariables();
void makeRoomLocalVariables(funcNodeType* func);

int ex(nodeType *p, int nops, ...) {
    int lblx, lbly, lblz, lbl1, lbl2, lbl_init = lbl, lbl_kept;

    char regName[REG_NAME_L];
    char labelName[LABEL_NAME_L];
    char jmpLabelName[LABEL_NAME_L];
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
                    printf("\tpush\t%d\n", p->con.value); 
                    break;
                case varTypeChar:
                    // char
                    printf("\tpush\t\'%c\'\n", (char) p->con.value); 
                    break;
                case varTypeStr:
                    // string
                    printf("\tpush\t\"%s\"\n", p->con.strValue); 
                    break;
                case varTypeNil:
                    // nothing to be done
                    break;
            }
            break;
        // identifiers
        case typeId:      
            getRegName(regName, p->id.varName);
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
                    printf("L%03d:\n", lblx);
                    ex(p->opr.op[1], 1, lbl_kept);
                    printf("\tj0\tL%03d\n", lbly);
                    ex(p->opr.op[3], 1, lbl_init);
                    printf("L%03d:\n", lblz); // for continue
                    ex(p->opr.op[2], 1, lbl_kept);
                    printf("\tjmp\tL%03d\n", lblx);
                    printf("L%03d:\n", lbly);
                    break;
                case WHILE:
                    lbl1 = lbl++;
                    lbl2 = lbl++;
                    printf("L%03d:\n", lbl1);
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tj0\tL%03d\n", lbl2);
                    ex(p->opr.op[1], 1, lbl_init);
                    printf("\tjmp\tL%03d\n", lbl1);
                    printf("L%03d:\n", lbl2);
                    break;
                case IF:
                    lbl1 = lbl++;
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (p->opr.nops > 2) {
                        lbl2 = lbl++;
                        printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        printf("\tjmp\tL%03d\n", lbl2);
                        printf("L%03d:\n", lbl1);
                        ex(p->opr.op[2], 1, lbl_kept);
                        printf("L%03d:\n", lbl2);
                    } else {
                        printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        printf("L%03d:\n", lbl1);
                    }
                    break;
                case GETI:
                    printf("\tgeti\n"); 
                    getRegName(regName, p->opr.op[0]->id.varName);
                    printf("\tpop\t%s\n", regName); 
                    break;
                case GETC: 
                    printf("\tgetc\n"); 
                    getRegName(regName, p->opr.op[0]->id.varName);
                    printf("\tpop\t%s\n", regName); 
                    break;
                case GETS: 
                    printf("\tgets\n"); 
                    getRegName(regName, p->opr.op[0]->id.varName);
                    printf("\tpop\t%s\n", regName); 
                    break;
                case PUTI: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputi\n");
                    break;
                case PUTI_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputi_\n");
                    break;
                case PUTC: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputc\n");
                    break;
                case PUTC_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputc_\n");
                    break;
                case PUTS: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputs\n"); 
                    break;
                case PUTS_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tputs_\n");
                    break;
                case '=':  
                    getRegName(regName, p->opr.op[0]->id.varName);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (p->opr.op[0]->type == typeId) {
                        printf("\tpop\t%s\n", regName);
                    }
                    break;
                case UMINUS:    
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tneg\n");
                    break;
                case CALL:
                    numOfArgs = pushArgs(p->opr.op[1], lbl_kept);
                    getLabel(labelName, p->opr.op[0]->id.varName);
                    printf("\tcall\t%s, %d\n", labelName, numOfArgs);
                    break;
                case RETURN:
                    ex(p->opr.op[0], 1, lbl_kept);
                    printf("\tret\n");
                    break;
                default:
                    ex(p->opr.op[0], 1, lbl_kept);
                    ex(p->opr.op[1], 1, lbl_kept);
                    switch(p->opr.oper) {
                        case '+':   printf("\tadd\n"); break;
                        case '-':   printf("\tsub\n"); break; 
                        case '*':   printf("\tmul\n"); break;
                        case '/':   printf("\tdiv\n"); break;
                        case '%':   printf("\tmod\n"); break;
                        case '<':   printf("\tcompLT\n"); break;
                        case '>':   printf("\tcompGT\n"); break;
                        case GE:    printf("\tcompGE\n"); break;
                        case LE:    printf("\tcompLE\n"); break;
                        case NE:    printf("\tcompNE\n"); break;
                        case EQ:    printf("\tcompEQ\n"); break;
                        case AND:   printf("\tand\n"); break;
                        case OR:    printf("\tor\n"); break;
                    }
            }
            break;
        // functions
        case typeFunc:
            createCallFrame(&p->func);
            ex(p->func.stmt, 1, lbl_kept);
            tearDownCallFrame(&p->func);
            printf("\tret\n");
            break;
    }
    return 0;
}

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
        char label[LABEL_NAME_L];
        int hasDeclared = getLabel(label, curr->func.name);

        // error checking [TODO]
        printf("%s:\n", label);

        ex(curr, 0);
        pfunc = pfunc->next; 
    }
}

/* Utility Functions */

// retrieve function labels [TODO: refactor]
int getLabel(char* labelName, char* name) {
    if (sm_exists(funcSym, name)) {
        sm_get(funcSym, name, labelName, LABEL_NAME_L);
        return 1;
    } else {
        sprintf(labelName, "L%03d", lbl++);
        sm_put(funcSym, name, labelName);
        return 0;
    }
}

// retrieve register name [TODO: refactor]
int getRegName(char* regName, char* name) {
    if (funcCallLevel == 0) {
        if (sm_exists(globalSym, name)) {
            sm_get(globalSym, name, regName, REG_NAME_L);
            return 1;
        } else {
            int numOfGlobalVars = sm_get_count(globalSym);
            sprintf(regName, "sb[%d]", numOfGlobalVars);
            sm_put(globalSym, name, regName);
            return 0;
        }
    } else if (name[0] == '$') {
        name = name + 1;
        if (sm_exists(globalSym, name)) {
            sm_get(globalSym, name, regName, REG_NAME_L);
            return 1;
        } else {
            int numOfGlobalVars = sm_get_count(globalSym);
            sprintf(regName, "sb[%d]", numOfGlobalVars);
            sm_put(globalSym, name, regName);
            return 0;
        }
    } else {
        if (sm_exists(currentFrameSymTab->symbol_table, name)) {
            sm_get(currentFrameSymTab->symbol_table, name, regName, REG_NAME_L);
            return 1;
        } else {
            sprintf(regName, "fp[%d]", currentFrameSymTab->num_local_vars++);
            sm_put(currentFrameSymTab->symbol_table, name, regName);
            return 0;
        }
    }
}

// return number of arguments
int pushArgs(nodeType* argList, int lbl_kept) {
    if (argList == NULL) return 0;

    if (argList->type != typeOpr || argList->opr.oper != ',') {
        ex(argList, 1, lbl_kept);       
        return 1;
    }

    int numOfArgs = pushArgs(argList->opr.op[0], lbl_kept);
    ex(argList->opr.op[1], 1, lbl_kept);
    return 1 + numOfArgs;
}

void createCallFrame(funcNodeType* func) {
    // deepen function call level
    funcCallLevel++;

    // create local symbol table
    StackSym* symTab = (StackSym*) malloc(sizeof(StackSym));
    symTab->symbol_table = sm_new(LOCAL_SIZE);
    symTab->lower = currentFrameSymTab;
    currentFrameSymTab = symTab;

    // insert parameters into stack
    nodeType* paramList = func->args;
    int numOfParams = 0;
    char regName[REG_NAME_L];
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
            printf("ERROR\n");
        }
        // assert(numOfParams == func->num_args);
    } else 
        func->num_args = numOfParams;
    currentFrameSymTab->num_args = numOfParams;
    currentFrameSymTab->num_local_vars = 0;

    // push space onto stack for local variables
    if (!isScan) makeRoomLocalVariables(func);
}

void tearDownCallFrame(funcNodeType* func) {
    // keep variable information if scanning
    int numOfLocalVars = currentFrameSymTab->num_local_vars;
    if (!isScan) {
        // execution
        if (numOfLocalVars != func->num_local_vars) {
            // error
            printf("ERROR\n");
            // assert(numOfLocalVars == func->num_local_vars);
        }
    } else 
        func->num_local_vars = numOfLocalVars;

    // clean up
    funcCallLevel--;

    StackSym* prevFrameSymTab = currentFrameSymTab->lower;
    sm_delete(currentFrameSymTab->symbol_table);
    free(currentFrameSymTab);
    currentFrameSymTab = prevFrameSymTab;
}

// program initialization for execution
void init() {
    // init symbol tables
    globalSym = sm_new(GLOBAL_SIZE);
    funcSym = sm_new(FUNC_SIZE);
    localSym = (StackSym*) malloc(sizeof(StackSym));
    localSym->lower = NULL;
    localSym->symbol_table = NULL;
    currentFrameSymTab = localSym;

    // init function & statement lists
    funcs = malloc(sizeof(nodeLinkedListType)); funcs->type = typeFuncList; funcs->num_nodes = 0; funcs->head = funcs->tail = NULL;
    stmts = malloc(sizeof(nodeLinkedListType)); stmts->type = typeStmtList; stmts->num_nodes = 0; stmts->head = stmts->tail = NULL;

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

void start() {
    preScan(stmts);
    preScan(funcs);
    makeRoomGlobalVariables();
}

void preScan(nodeLinkedListType *list) {
    isScan = 1;

    nodeInListType *p = list->head;

    while(p) {
        nodeType *n = p->node;
        ex(n, 0);
        p = p->next; 
    }

    isScan = 0;
}

void moveRegPointer(int regIdx, int offset) {
    printf("\tpush\t%s\n", regNames[regIdx]);
    printf("\tpush\t%d\n", offset);
    printf("\tadd\n");
    printf("\tpop\t%s\n", regNames[regIdx]);
    reg[regIdx] += offset;
}

void makeRoomGlobalVariables() {
    int numOfGlobalVars = sm_get_count(globalSym);
    if (numOfGlobalVars) moveRegPointer(SP_I, numOfGlobalVars);
}

void makeRoomLocalVariables(funcNodeType* func) {
    if (func->num_local_vars) moveRegPointer(SP_I, func->num_local_vars);
}