#include <stdio.h>
#include <stdarg.h>
#include <errno.h>

#include "calc3.h"
#include "y.tab.h"
#include "strmap.h"

static int lbl = 0;       // label
extern int errno;         // error number

static int scanning = 0;  // 1 for scanning; 0 for execution
static int flevel = 0;    // current function call level

/* program init & end functions */
void init();
void end();
void freeNode(nodeType *p);
void start();
void scan(nodeLinkedListType *list);

/* helper functions */
int getLabel(char* label, char* name);
int getRegister(char* reg, char* name);
int pushArgsOnStack(nodeType* args, int lbl_kept);
void constructFuncFrame(funcNodeType* func);
void destructFuncFrame(funcNodeType* func);
void mvSPRegPtr(int offset);

/* function definitions */
// execution of AST on each node
int ex(nodeType *p, int nops, ...) {
    int lbl1, lbl2, lbl_init = lbl, lbl_kept;

    char reg[REG_NAME_LEN];
    char labelName[LBL_NAME_LEN];
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
                    if (!scanning) fprintf(stdout, "\tpush\t%d\n", p->con.value); 
                    break;
                case varTypeChar:
                    // char
                    if (!scanning) fprintf(stdout, "\tpush\t\'%c\'\n", (char) p->con.value); 
                    break;
                case varTypeStr:
                    // string
                    if (!scanning) fprintf(stdout, "\tpush\t\"%s\"\n", p->con.strValue); 
                    break;
                case varTypeNil:
                    // nothing to be done
                    break;
            }
            break;
        // identifiers
        case typeId:      
            getRegister(reg, p->id.varName);
            if (!scanning) fprintf(stdout, "\tpush\t%s\n", reg); 
            break;
        // operators
        case typeOpr:
            switch(p->opr.oper) {
                case FOR:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1 = lbl++); }
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl2 = lbl++); }
                    ex(p->opr.op[3], 1, lbl_init);
                    ex(p->opr.op[2], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl1); fprintf(stdout, "L%03d:\n", lbl2); }
                    break;
                case WHILE:
                    if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1 = lbl++); }
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl2 = lbl++); }
                    ex(p->opr.op[1], 1, lbl_init);
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl1); fprintf(stdout, "L%03d:\n", lbl2); }
                    break;
                case IF:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (p->opr.nops > 2) {
                        if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl1 = lbl++); }
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl2 = lbl++); fprintf(stdout, "L%03d:\n", lbl1); }
                        ex(p->opr.op[2], 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "L%03d:\n", lbl2); }
                    } else {
                        if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl1 = lbl++); }
                        ex(p->opr.op[1], 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1); }
                    }
                    break;
                case GETI:
                    if (!scanning) { fprintf(stdout, "\tgeti\n"); }
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    break;
                case GETC: 
                    if (!scanning) { fprintf(stdout, "\tgetc\n"); }
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    break;
                case GETS: 
                    if (!scanning) { fprintf(stdout, "\tgets\n"); }
                    getRegister(reg, p->opr.op[0]->id.varName);
                    if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    break;
                case PUTI: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputi\n"); }
                    break;
                case PUTI_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputi_\n"); }
                    break;
                case PUTC: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputc\n"); }
                    break;
                case PUTC_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputc_\n"); }
                    break;
                case PUTS: 
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputs\n"); }
                    break;
                case PUTS_:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputs_\n"); }
                    break;
                case '=':  
                    getRegister(reg, p->opr.op[0]->id.varName);
                    ex(p->opr.op[1], 1, lbl_kept);
                    if (p->opr.op[0]->type == typeId) {
                        if (!scanning) fprintf(stdout, "\tpop\t%s\n", reg);
                    }
                    break;
                case UMINUS:    
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) fprintf(stdout, "\tneg\n");
                    break;
                case CALL:
                    num_args = pushArgsOnStack(p->opr.op[1], lbl_kept);
                    getLabel(labelName, p->opr.op[0]->id.varName);
                    if (!scanning) fprintf(stdout, "\tcall\t%s, %d\n", labelName, num_args);
                    break;
                case RETURN:
                    ex(p->opr.op[0], 1, lbl_kept);
                    if (!scanning) fprintf(stdout, "\tret\n");
                    break;
                default:
                    ex(p->opr.op[0], 1, lbl_kept);
                    ex(p->opr.op[1], 1, lbl_kept);
                    switch(p->opr.oper) {
                        case '+': if (!scanning) fprintf(stdout, "\tadd\n"); break;
                        case '-': if (!scanning) fprintf(stdout, "\tsub\n"); break; 
                        case '*': if (!scanning) fprintf(stdout, "\tmul\n"); break;
                        case '/': if (!scanning) fprintf(stdout, "\tdiv\n"); break;
                        case '%': if (!scanning) fprintf(stdout, "\tmod\n"); break;
                        case '<': if (!scanning) fprintf(stdout, "\tcompLT\n"); break;
                        case '>': if (!scanning) fprintf(stdout, "\tcompGT\n"); break;
                        case GE:  if (!scanning) fprintf(stdout, "\tcompGE\n"); break;
                        case LE:  if (!scanning) fprintf(stdout, "\tcompLE\n"); break;
                        case NE:  if (!scanning) fprintf(stdout, "\tcompNE\n"); break;
                        case EQ:  if (!scanning) fprintf(stdout, "\tcompEQ\n"); break;
                        case AND: if (!scanning) fprintf(stdout, "\tand\n"); break;
                        case OR:  if (!scanning) fprintf(stdout, "\tor\n"); break;
                    }
            }
            break;
        // functions
        case typeFunc:
            constructFuncFrame(&p->func);
            ex(p->func.stmt, 1, lbl_kept);
            destructFuncFrame(&p->func);
            if (!scanning) fprintf(stdout, "\tret\n");
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

    fprintf(stdout, "\tend\n");

    // functions
    nodeInListType *pfunc = funcs->head;

    while(pfunc) {
        nodeType *curr = pfunc->node;

        // label function & register function name
        char label[LBL_NAME_LEN];
        int ret = getLabel(label, curr->func.name);

        // error checking
        if (ret == -1) {
            // function name the same as the variable declared
            fprintf(stderr, "Function cannot have the same name as the variable declared [errno: %d]\n", errno);
            exit(1);
        } else if (ret == 1) {
            // function has been declared
            fprintf(stdout, "%s:\n", label);
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
        sm_get(func_sym_tab, name, label, LBL_NAME_LEN);
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
            mvSPRegPtr(func->num_local_vars);
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
        mvSPRegPtr(numOfGlobalVars);
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
void mvSPRegPtr(int offset) {
    fprintf(stdout, "\tpush\t%s\n", "sp");
    fprintf(stdout, "\tpush\t%d\n", offset);
    fprintf(stdout, "\tadd\n");
    fprintf(stdout, "\tpop\t%s\n", "sp");
}