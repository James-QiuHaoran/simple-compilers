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

static int lbl;       // 
extern int errno;     // error number

static int scanning;  // 1 for scanning; 0 for execution
static int flevel;    // current function call level

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

    char reg[REG_NAME_LEN];
    char labelName[LAB_NAME_LEN];
    char jmpLabelName[LAB_NAME_LEN];
    int num_args;

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
                    if (!scanning)
                        printf("\tpush\t%d\n", p->con.value); 
                    break;
                case varTypeChar:
                    // char
                    if (!scanning)
                        printf("\tpush\t\'%c\'\n", (char) p->con.value); 
                    break;
                case varTypeStr:
                    // string
                    if (!scanning)
                        printf("\tpush\t\"%s\"\n", p->con.strValue); 
                    break;
                case varTypeNil:
                    // nothing to be done
                    break;
            }
            break;
        // identifiers
        case typeId:      
            getRegister(reg, p->id.varName);
            if (!scanning)
                printf("\tpush\t%s\n", reg); 
            break;
        // operators
        case typeOpr:
            switch(p->opr.oper) {
                case FOR:
                    lblz = lbl++;
                    lbly = lbl++;
                    lblx = lbl++;
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("L%03d:\n", lblx);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (!scanning)
                        printf("\tj0\tL%03d\n", lbly);
                    ex(p->opr.op[3], 1, lbl_init);
                    if (!scanning)
                        printf("L%03d:\n", lblz); // for continue
                    ex(p->opr.op[2], 1, lbl_kept);
                    if (!scanning)
                        printf("\tjmp\tL%03d\n", lblx);
                    if (!scanning)
                        printf("L%03d:\n", lbly);
                    break;
                case WHILE:
                    lbl1 = lbl++;
                    lbl2 = lbl++;
                    if (!scanning)
                        printf("L%03d:\n", lbl1);
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tj0\tL%03d\n", lbl2);
                    ex(p->opr.op[1], 1, lbl_init);
                    if (!scanning)
                        printf("\tjmp\tL%03d\n", lbl1);
                    if (!scanning)
                        printf("L%03d:\n", lbl2);
                    break;
                case IF:
                    lbl1 = lbl++;
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (p->opr.nops > 2) {
                        lbl2 = lbl++;
                        if (!scanning)
                            printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!scanning)
                            printf("\tjmp\tL%03d\n", lbl2);
                        if (!scanning)
                            printf("L%03d:\n", lbl1);
                        ex(p->opr.op[2], 1, lbl_kept);
                        if (!scanning)
                            printf("L%03d:\n", lbl2);
                    } else {
                        if (!scanning)
                            printf("\tj0\tL%03d\n", lbl1);
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!scanning)
                            printf("L%03d:\n", lbl1);
                    }
                    break;
                case GETI:
                    if (!scanning)
                        printf("\tgeti\n"); 
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning)
                        printf("\tpop\t%s\n", reg); 
                    break;
                case GETC: 
                    if (!scanning)
                        printf("\tgetc\n"); 
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning)
                        printf("\tpop\t%s\n", reg); 
                    break;
                case GETS: 
                    if (!scanning)
                        printf("\tgets\n"); 
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning)
                        printf("\tpop\t%s\n", reg); 
                    break;
                case PUTI: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputi\n");
                    break;
                case PUTI_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputi_\n");
                    break;
                case PUTC: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputc\n");
                    break;
                case PUTC_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputc_\n");
                    break;
                case PUTS: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputs\n"); 
                    break;
                case PUTS_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tputs_\n");
                    break;
                case '=':  
                    getRegister(reg, p->opr.op[0]->id.varName);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (p->opr.op[0]->type == typeId) {
                        if (!scanning)
                            printf("\tpop\t%s\n", reg);
                    }
                    break;
                case UMINUS:    
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tneg\n");
                    break;
                case CALL:
                    num_args = pushArgsOnStack(p->opr.op[1], lbl_kept);
                    getLabel(labelName, p->opr.op[0]->id.varName);
                    if (!scanning)
                        printf("\tcall\t%s, %d\n", labelName, num_args);
                    break;
                case RETURN:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning)
                        printf("\tret\n");
                    break;
                default:
                    ex(p->opr.op[0], 1, lbl_kept);
                    ex(p->opr.op[1], 1, lbl_kept);
                    switch(p->opr.oper) {
                        case '+': if (!scanning) printf("\tadd\n"); break;
                        case '-': if (!scanning) printf("\tsub\n"); break; 
                        case '*': if (!scanning) printf("\tmul\n"); break;
                        case '/': if (!scanning) printf("\tdiv\n"); break;
                        case '%': if (!scanning) printf("\tmod\n"); break;
                        case '<': if (!scanning) printf("\tcompLT\n"); break;
                        case '>': if (!scanning) printf("\tcompGT\n"); break;
                        case GE:  if (!scanning) printf("\tcompGE\n"); break;
                        case LE:  if (!scanning) printf("\tcompLE\n"); break;
                        case NE:  if (!scanning) printf("\tcompNE\n"); break;
                        case EQ:  if (!scanning) printf("\tcompEQ\n"); break;
                        case AND: if (!scanning) printf("\tand\n"); break;
                        case OR:  if (!scanning) printf("\tor\n"); break;
                    }
            }
            break;
        // functions
        case typeFunc:
            constructFuncFrame(&p->func);
            ex(p->func.stmt, 1, lbl_kept);
            destructFuncFrame(&p->func);
            if (!scanning) 
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
        int ret = getLabel(label, curr->func.name);

        // error checking
        if (ret == -1) {
            // function name the same as the variable declared
            fprintf(stderr, "Function cannot have the same name as the variable declared [errno: %d]\n", errno);
            exit(1);
        } else if (ret == 1) {
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
    if (sm_exists(func_sym_tab, name)) {
        sm_get(func_sym_tab, name, label, LAB_NAME_LEN);
        if (!sm_exists(global_sym_tab, name)) {
            // success
            return 1;
        } else {
            // function name the same as variable name
            return -1;
        }
    } else {
        sprintf(label, "L%03d", lbl++);
        sm_put(func_sym_tab, name, label);
        return 0;
    }
}

// retrieve register name
int getRegister(char* reg, char* name) {
    if (flevel == 0) {
        // main function -> global variable
        if (sm_exists(global_sym_tab, name)) {
            sm_get(global_sym_tab, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            sprintf(reg, "sb[%d]", sm_get_count(global_sym_tab));
            sm_put(global_sym_tab, name, reg);
            return 0;
        }
    } else if (name[0] == '$') {
        // declare global variables inside a function
        if (sm_exists(global_sym_tab, name + 1)) {
            sm_get(global_sym_tab, name + 1, reg, REG_NAME_LEN);
            return 1;
        } else {
            sprintf(reg, "sb[%d]", sm_get_count(global_sym_tab));
            sm_put(global_sym_tab, name + 1, reg);
            return 0;
        }
    } else {
        // first lookup whether the variable exists in local symbol table
        if (sm_exists(local_sym_tab->symbol_table, name)) {
            sm_get(local_sym_tab->symbol_table, name, reg, REG_NAME_LEN);
            return 1;
        } else if (sm_exists(global_sym_tab, name)) {
            // then check whether it's in the global symbol table
            sm_get(global_sym_tab, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            // otherwise create the local variable in the local table
            sprintf(reg, "fp[%d]", local_sym_tab->num_local_vars++);
            sm_put(local_sym_tab->symbol_table, name, reg);
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

    int num_args = pushArgsOnStack(args->opr.op[0], lbl_kept);
    ex(args->opr.op[1], 1, lbl_kept);

    num_args += 1;

    return num_args;
}

// create a frame for a function
void constructFuncFrame(funcNodeType* func) {
    // increment the level of function call
    flevel++;

    // init
    StackSym* symTab = (StackSym*) malloc(sizeof(StackSym));

    symTab->symbol_table = sm_new(LOCAL_TAB_SIZE);
    symTab->lower = local_sym_tab;
    
    char reg[REG_NAME_LEN];

    // current local symbol table
    local_sym_tab = symTab;

    // push arguments on the stack
    int num_params = 0;
    int idx_fp = 0;
    nodeType* params = func->args;

    while (params != NULL && params->type == typeOpr && params->opr.oper == ',') {
        idx_fp = -4 - num_params++;
        sprintf(reg, "fp[%d]", idx_fp);
        sm_put(local_sym_tab->symbol_table, params->opr.op[1]->id.varName, reg);
        params = params->opr.op[0];
    }

    if (params != NULL) {
        idx_fp = -4 - num_params++;
        sprintf(reg, "fp[%d]", idx_fp);
        sm_put(local_sym_tab->symbol_table, params->id.varName, reg);
    }

    // check and save meta data
    if (!scanning) {
        // execution
        if (num_params != func->num_args) {
            // error
            fprintf(stderr, "Number of parameters mismatch [errno: %d]\n", errno);
            exit(1);
        }
    } else {
        // scanning
        func->num_args = num_params;
    }

    local_sym_tab->num_args = num_params;
    local_sym_tab->num_local_vars = 0;

    // move stack pointer for local variables in the function
    if (!scanning) {
        if (func->num_local_vars) {
            mvRegPtr(SP_ID, func->num_local_vars);
        }
    }
}

// destruct the function frame created
void destructFuncFrame(funcNodeType* func) {
    int num_local_vars = local_sym_tab->num_local_vars;

    if (!scanning) {
        // execution
        if (num_local_vars != func->num_local_vars) {
            // error
            fprintf(stderr, "Number of local variables mismatch [errno: %d]\n", errno);
            exit(1);
        }
    } else {
        // scanning
        func->num_local_vars = num_local_vars;
    }

    // decrement function level after execution
    flevel--;

    // delete the function frame
    StackSym* prev = local_sym_tab->lower;
    sm_delete(local_sym_tab->symbol_table);
    free(local_sym_tab);

    // update current frame
    local_sym_tab = prev;
}

// program initialization for execution
void init() {
    // init symbol tables
    global_sym_tab = sm_new(GLOBAL_TAB_SIZE);
    func_sym_tab = sm_new(FUNC_TAB_SIZE);

    local_sym_tab = (StackSym*) malloc(sizeof(StackSym));
    local_sym_tab->lower = NULL;
    local_sym_tab->symbol_table = NULL;

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
    sm_delete(global_sym_tab);
    sm_delete(func_sym_tab);

    // free the local symbol table
    free(local_sym_tab);

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
    int numOfGlobalVars = sm_get_count(global_sym_tab);
    if (numOfGlobalVars) {
        mvRegPtr(SP_ID, numOfGlobalVars);
    }
}

// scanner
void scan(nodeLinkedListType *list) {
    scanning = 1;

    nodeInListType *p = list->head;

    while(p) {
        nodeType *n = p->node;
        ex(n, 0);
        p = p->next; 
    }

    scanning = 0;
}

// move register pointer
void mvRegPtr(int idx, int offset) {
    printf("\tpush\t%s\n", regLabels[idx]);
    printf("\tpush\t%d\n", offset);
    printf("\tadd\n");
    printf("\tpop\t%s\n", regLabels[idx]);

    reg[idx] += offset;
}