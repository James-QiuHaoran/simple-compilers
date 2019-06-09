#include <stdio.h>
#include <stdarg.h>
#include <errno.h>
#include <assert.h>

#include "calc3.h"
#include "y.tab.h"
#include "strmap.h"

static int lbl = 0;       // label
extern int errno;         // error number

static int scanning = 0;  // 1 for scanning; 0 for execution
static int flevel = 0;    // current function call level

static int debug = 0;     // 1 for debugging mode and 0 otherwise

/* program init & end functions */
void init();
void end();
void freeNode(nodeType *p);
void start();
void scan(nodeLinkedListType *list);

/* helper functions */
int getLabel(char* label, char* name);
int getHash(char* name);
int getRegister(char* reg, char* name, int size);
int pushArgsOnStack(nodeType* args, int lbl_kept);
void constructFuncFrame(funcNodeType* func);
void destructFuncFrame(funcNodeType* func);
void mvSPRegPtr(int offset);

int isArrayPtr(nodeType* p);
StrMap* getArrDimSymTab();
void declareArray(char* reg, arrNodeType* array, int lbl_kept);
void putCharArray(nodeType* p, int hasNewLine, int lbl_kept);
void getCharArray(nodeType* p, int lbl_kept);
void assignCharArray(nodeType* p, char* str, int lbl_kept);
void assignArray(nodeType* p);
void pushPtrValue(nodeType* p, int lbl_kept);
void pushPtr(nodeType* p, int lbl_kept);
void pushBasePtr(nodeType* p);

/* function definitions */
// execution of AST on each node
int ex(nodeType *p, int exType, int nops, ...) {
    int lbl1, lbl2, lbl3, lbl_init = lbl, lbl_kept;

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
            if (debug) fprintf(stdout, "\t// push constants\n");
            switch(p->con.type){
                case varTypeInt:
                    // integer
                    if (!scanning) fprintf(stdout, "\tpush\t%d\n", p->con.value); 
                    break;
                case varTypeFloat:
                    // float number
                    if (!scanning) fprintf(stdout, "\tpush\t%f\n", p->con.fValue);
                    break;
                case varTypeChar:
                    // char
                    if (!scanning) fprintf(stdout, "\tpush\t\'%c\'\n", (char) p->con.value); 
                    break;
                case varTypeStr:
                    // string
                    if (exType == 0) {
                        // for string comparison
                        if (!scanning) fprintf(stdout, "\tpush\t%d\n", p->con.strValueHash);    
                    } else {
                        if (!scanning) fprintf(stdout, "\tpush\t\"%s\"\n", p->con.strValue); 
                    }
                    break;
                case varTypeNil:
                    // nothing to be done
                    break;
            }
            break;
        // identifiers
        case typeId:
            if (exType == 0) {
                // string comparison
                int hashVal = getHash(p->id.varName);
                if (!scanning) fprintf(stdout, "\tpush\t%d\n", hashVal);
            } else {
                // normal case
                if (isArrayPtr(p)) {
                    if (debug) fprintf(stdout, "\t// push pointer %s\n", p->id.varName);
                    pushPtr(p, lbl_kept);
                } else {
                    if (debug) fprintf(stdout, "\t// push variable %s\n", p->id.varName);
                    getRegister(reg, p->id.varName, 1);
                    if (!scanning) fprintf(stdout, "\tpush\t%s\n", reg);
                }
            }
            break;
        // arrays
        case typeArr:
            if (isArrayPtr(p)) {
                // a pointer
                if (debug) fprintf(stdout, "\t// push pointer %s\n", p->arr.name);
                pushPtr(p, lbl_kept);
            } else {
                // an array
                if (debug) fprintf(stdout, "\t// push array %s\n", p->arr.name);
                pushPtrValue(p, lbl_kept);
            }
            break;
        // operators
        case typeOpr:
            switch(p->opr.oper) {
                case FOR:
                    if (debug) fprintf(stdout, "\t// for loop\n");
                    lbl3 = lbl++;
                    lbl2 = lbl++;
                    lbl1 = lbl++;
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1); }
                    ex(p->opr.op[1], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl2); }
                    ex(p->opr.op[3], -1, 1, lbl_init);
                    if (!scanning) { fprintf(stdout, "L%03d:\n", lbl3); }
                    ex(p->opr.op[2], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl1); fprintf(stdout, "L%03d:\n", lbl2); }
                    break;
                case WHILE:
                    if (debug) fprintf(stdout, "\t// while loop\n");
                    if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1 = lbl++); }
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl2 = lbl++); }
                    ex(p->opr.op[1], -1, 1, lbl_init);
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl1); fprintf(stdout, "L%03d:\n", lbl2); }
                    break;
                case IF:
                    if (debug) fprintf(stdout, "\t// if statement\n");
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (p->opr.nops > 2) {
                        if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl1 = lbl++); }
                        ex(p->opr.op[1], -1, 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl2 = lbl++); fprintf(stdout, "L%03d:\n", lbl1); }
                        ex(p->opr.op[2], -1, 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "L%03d:\n", lbl2); }
                    } else {
                        if (!scanning) { fprintf(stdout, "\tj0\tL%03d\n", lbl1 = lbl++); }
                        ex(p->opr.op[1], -1, 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "L%03d:\n", lbl1); }
                    }
                    break;
                case CONTINUE:
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl_kept); }
                    break;
                case BREAK:
                    if (!scanning) { fprintf(stdout, "\tjmp\tL%03d\n", lbl_kept + 1); }
                    break;
                case GETI:
                    if (debug) fprintf(stdout, "\t// input geti\n");
                    if (!scanning) { fprintf(stdout, "\tgeti\n"); }
                    if (p->opr.op[0]->type == typeId) {
                        if (debug) fprintf(stdout, "\t// save to variable %s\n", p->opr.op[0]->id.varName);
                        getRegister(reg, p->opr.op[0]->id.varName, 1);
                        if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    } else if (p->opr.op[0]->type == typeArr) {
                        if (debug) fprintf(stdout, "\t// save to array %s\n", p->opr.op[0]->arr.name);
                        pushPtr(p->opr.op[0], lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                    }
                    break;
                case GETC:
                    if (!scanning) fprintf(stdout, "\t// input getc\n");
                    if (!scanning) { fprintf(stdout, "\tgetc\n"); }
                    if (p->opr.op[0]->type == typeId) {
                        if (!scanning) fprintf(stdout, "\t// save to variable %s\n", p->opr.op[0]->id.varName);
                        getRegister(reg, p->opr.op[0]->id.varName, 1);
                        if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    } else if (p->opr.op[0]->type == typeArr) {
                        if (!scanning) fprintf(stdout, "\t// save to array %s\n", p->opr.op[0]->arr.name);
                        pushPtr(p->opr.op[0], lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                    }
                    break;
                case GETS:
                    if (!isArrayPtr(p->opr.op[0])) {
                        if (debug) fprintf(stdout, "\t// input gets\n");
                        if (!scanning) { fprintf(stdout, "\tgets\n"); }
                        if (p->opr.op[0]->type == typeId) {
                            if (debug) fprintf(stdout, "\t// save to variable %s\n", p->opr.op[0]->id.varName);
                            getRegister(reg, p->opr.op[0]->id.varName, 1);
                            if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                        } else if (p->opr.op[0]->type == typeArr) {
                            if (debug) fprintf(stdout, "\t// save to array %s\n", p->opr.op[0]->arr.name);
                            pushPtr(p->opr.op[0], lbl_kept);
                            if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                        }
                    } else {
                        // get char array
                        if (debug) fprintf(stdout, "\t// gets - save to char array\n");
                        getCharArray(p->opr.op[0], lbl_kept);
                    }
                    break;
                case GETF:
                    if (debug) fprintf(stdout, "\t// input getf\n");
                    if (!scanning) { fprintf(stdout, "\tgetf\n"); }
                    if (p->opr.op[0]->type == typeId) {
                        if (debug) fprintf(stdout, "\t// save to variable %s\n", p->opr.op[0]->id.varName);
                        getRegister(reg, p->opr.op[0]->id.varName, 1);
                        if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                    } else if (p->opr.op[0]->type == typeArr) {
                        if (debug) fprintf(stdout, "\t// save to array %s\n", p->opr.op[0]->arr.name);
                        pushPtr(p->opr.op[0], lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                    }
                    break;
                case PUTI: 
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputi\n"); }
                    break;
                case PUTI_:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputi_\n"); }
                    break;
                case PUTF:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputf\n"); }
                    break;
                case PUTF_:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputf_\n"); }
                    break;
                case PUTC: 
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputc\n"); }
                    break;
                case PUTC_:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tputc_\n"); }
                    break;
                case PUTS:
                    if (!isArrayPtr(p->opr.op[0])) {
                        // normal strings
                        ex(p->opr.op[0], -1, 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tputs\n"); } 
                    } else {
                        // char arrays
                        putCharArray(p->opr.op[0], 1, lbl_kept);
                    }
                    break;
                case PUTS_:
                    if (!isArrayPtr(p->opr.op[0])) {
                        // normal strings
                        ex(p->opr.op[0], -1, 1, lbl_kept);
                        if (!scanning) { fprintf(stdout, "\tputs_\n"); } 
                    } else {
                        // char arrays
                        putCharArray(p->opr.op[0], 0, lbl_kept);
                    }
                    break;
                case '=':
                    if (p->opr.op[0]->type != typeOpr) {
                        if (!isArrayPtr(p->opr.op[0]) || p->opr.op[1]->type != typeCon || p->opr.op[1]->con.type != varTypeStr) {
                            if (p->opr.op[0]->type == typeId) {
                                // variable assignment
                                StrMap* arr_dim_sym_tab = getArrDimSymTab();
                                if (sm_exists(arr_dim_sym_tab, p->opr.op[0]->id.varName)) {
                                    fprintf(stderr, "Variable cannot have the same name as the array declared [errno: %d]\n", errno);
                                    exit(1);
                                }
                                if (debug) printf("\t// variable assignment: %s\n", p->opr.op[0]->id.varName);
                                getRegister(reg, p->opr.op[0]->id.varName, 1);
                                ex(p->opr.op[1], -1, 1, lbl_kept);
                                if (!scanning) { fprintf(stdout, "\tpop\t%s\n", reg); }
                            } else if (p->opr.op[0]->type == typeArr) {
                                // array assignment
                                if (debug) printf("\t// array assignment: %s\n", p->opr.op[0]->arr.name);
                                ex(p->opr.op[1], -1, 1, lbl_kept);
                                pushPtr(p->opr.op[0], lbl_kept);
                                if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                            }
                        } else {
                            // char array assignment
                            if (debug) printf("\t// char array assignment\n");
                            assignCharArray(p->opr.op[0], p->opr.op[1]->con.strValue, lbl_kept);
                        }
                    } else {
                        switch (p->opr.op[0]->opr.oper) {
                            case ARRAY_DECL:
                                // array declaration and assignment
                                if (debug) printf("\t// array declaration assignment\n");
                                ex(p->opr.op[0], -1, 1, lbl_kept);
                                // calculate expression
                                ex(p->opr.op[1], -1, 1, lbl_kept);
                                if (!scanning) assignArray(p->opr.op[0]->opr.op[0]);
                                break;
                            case DEREF:
                                // dereference assignment
                                if (debug) printf("\t// dereference assignment\n");
                                ex(p->opr.op[1], -1, 1, lbl_kept);
                                ex(p->opr.op[0]->opr.op[0], -1, 1, lbl_kept);
                                if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }
                                break;
                            default:
                                break;
                        }
                    }
                    break;
                case UMINUS:    
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tneg\n"); }
                    break;
                case REF:
                    assert((p->opr.op[0]->type == typeId || p->opr.op[0]->type == typeArr) && !isArrayPtr(p->opr.op[0]));
                    pushPtr(p->opr.op[0], lbl_kept);
                    break;
                case DEREF:
                    // dereference at right hand side
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpush\tac[0]\n"); }
                    break;
                case CALL:
                    num_args = pushArgsOnStack(p->opr.op[1], lbl_kept);
                    int ret = getLabel(labelName, p->opr.op[0]->id.varName);
                    // error checking
                    if (ret == -1) {
                        // function name the same as the variable declared
                        fprintf(stderr, "Function cannot have the same name as the variable declared [errno: %d]\n", errno);
                        exit(1);
                    } else if (ret == 1) {
                        // function has been declared
                        if (!scanning) { fprintf(stdout, "\tcall\t%s, %d\n", labelName, num_args); }
                    } else if (ret != 0){
                        // unknown functions
                        fprintf(stderr, "Undeclared functions [errno: %d]\n", errno);
                        exit(1);
                    }
                    break;
                case RETURN:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    if (!scanning) { fprintf(stdout, "\tret\n"); }
                    break;
                case ARRAY_DECL:
                    if (scanning) declareArray(reg, &p->opr.op[0]->arr, lbl_kept);
                    break;
                case ',':
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    ex(p->opr.op[1], -1, 1, lbl_kept);
                    break;
                case EQ:
                    if (p->opr.op[1]->type == typeCon && p->opr.op[1]->con.type == varTypeStr ||
                        p->opr.op[0]->type == typeCon && p->opr.op[0]->con.type == varTypeStr ||
                        sm_exists(string_var_tab, p->opr.op[1]->id.varName) ||
                        sm_exists(string_var_tab, p->opr.op[0]->id.varName)) {
                        // for string comparison
                        ex(p->opr.op[0], 0, 1, lbl_kept);
                        ex(p->opr.op[1], 0, 1, lbl_kept);
                    } else {
                        // for int/char comparison
                        ex(p->opr.op[0], -1, 1, lbl_kept);
                        ex(p->opr.op[1], -1, 1, lbl_kept);
                    }
                    if (!scanning) { fprintf(stdout, "\tcompEQ\n"); }
                    break;
                default:
                    ex(p->opr.op[0], -1, 1, lbl_kept);
                    ex(p->opr.op[1], -1, 1, lbl_kept);
                    switch(p->opr.oper) {
                        case '+': if (!scanning) fprintf(stdout, "\tadd\n"); break;
                        case '-': if (!scanning) fprintf(stdout, "\tsub\n"); break; 
                        case '*': if (!scanning) fprintf(stdout, "\tmul\n"); break;
                        case '/': if (!scanning) fprintf(stdout, "\tdiv\n"); break;
                        case RDIV: if (!scanning) fprintf(stdout, "\trdiv\n"); break;
                        case '%': if (!scanning) fprintf(stdout, "\tmod\n"); break;
                        case '<': if (!scanning) fprintf(stdout, "\tcompLT\n"); break;
                        case '>': if (!scanning) fprintf(stdout, "\tcompGT\n"); break;
                        case GE:  if (!scanning) fprintf(stdout, "\tcompGE\n"); break;
                        case LE:  if (!scanning) fprintf(stdout, "\tcompLE\n"); break;
                        case NE:  if (!scanning) fprintf(stdout, "\tcompNE\n"); break;
                        case AND: if (!scanning) fprintf(stdout, "\tand\n"); break;
                        case OR:  if (!scanning) fprintf(stdout, "\tor\n"); break;
                    }
            }
            break;
        // functions
        case typeFunc:
            if (debug) fprintf(stdout, "\t// declare function\n");
            constructFuncFrame(&p->func);
            ex(p->func.stmt, -1, 1, lbl_kept);
            destructFuncFrame(&p->func);
            if (!scanning) { fprintf(stdout, "\tret\n"); }
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
        ex(curr, -1, 0);
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
        } else if (ret != 0){
            // unknown functions
            fprintf(stderr, "Undeclared functions [errno: %d]\n", errno);
            exit(1);
        }

        ex(curr, -1, 0);
        pfunc = pfunc->next; 
    }
}

// retrieve function label names
int getLabel(char* label, char* name) {
    if (sm_exists(func_sym_tab->symbol_table, name)) {
        sm_get(func_sym_tab->symbol_table, name, label, LBL_NAME_LEN);
        if (!sm_exists(global_sym_tab->symbol_table, name)) {
            // success
            return 1;
        } else {
            // function name the same as variable name
            return -1;
        }
    } else {
        // define new functions
        sprintf(label, "L%03d", lbl++);
        sm_put(func_sym_tab->symbol_table, name, label);
        return 0;
    }
}

// retrieve string hash value
int getHash(char* name) {
    if (sm_exists(string_var_tab, name)) {
        char stringContent[STR_MAX_LEN];
        sm_get(string_var_tab, name, stringContent, STR_MAX_LEN);
        if (sm_exists(string_tab, stringContent)) {
            char stringHash[STR_HASH_LEN];
            sm_get(string_tab, stringContent, stringHash, STR_HASH_LEN);            
            return atoi(stringHash);
        } else {
            return -1;
        }
    } else {
        return -1;
    }
}

// retrieve register name
int getRegister(char* reg, char* name, int size) {
    if (flevel == 0) {
        // main function -> global variable
        if (sm_exists(global_sym_tab->symbol_table, name)) {
            sm_get(global_sym_tab->symbol_table, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            if (size <= 0) {
                fprintf(stderr, "Wrong size [errno: %d]\n", errno);
                exit(1);
            }
            sprintf(reg, "sb[%d]", global_sym_tab->size); // sm_get_count(global_sym_tab->symbol_table));
            sm_put(global_sym_tab->symbol_table, name, reg);
            global_sym_tab->size += size;
            return 0;
        }
    } else if (name[0] == '$') {
        // declare global variables inside a function
        if (sm_exists(global_sym_tab->symbol_table, name + 1)) {
            sm_get(global_sym_tab->symbol_table, name + 1, reg, REG_NAME_LEN);
            return 1;
        } else {
            if (size <= 0) {
                fprintf(stderr, "Wrong size [errno: %d]\n", errno);
                exit(1);
            }
            sprintf(reg, "sb[%d]", global_sym_tab->size); // sm_get_count(global_sym_tab->symbol_table));
            sm_put(global_sym_tab->symbol_table, name + 1, reg);
            global_sym_tab->size += size;
            return 0;
        }
    } else {
        // first lookup whether the variable exists in local symbol table
        if (sm_exists(local_sym_tab->symbol_table, name)) {
            sm_get(local_sym_tab->symbol_table, name, reg, REG_NAME_LEN);
            return 1;
        } else if (sm_exists(global_sym_tab->symbol_table, name)) {
            // then check whether it's in the global symbol table
            sm_get(global_sym_tab->symbol_table, name, reg, REG_NAME_LEN);
            return 1;
        } else {
            // otherwise create the local variable in the local table
            if (size <= 0) {
                fprintf(stderr, "Wrong size [errno: %d]\n", errno);
                exit(1);
            }
            sprintf(reg, "fp[%d]", local_sym_tab->num_local_vars++);
            sm_put(local_sym_tab->symbol_table, name, reg);
            local_sym_tab->num_local_vars += size;
            return 0;
        }
    }
}

// return number of arguments
int pushArgsOnStack(nodeType* args, int lbl_kept) {
    if (args == NULL) 
        return 0;

    if (args->type != typeOpr || args->opr.oper != ',') {
        ex(args, -1, 1, lbl_kept);       
        return 1;
    }

    int num_args = pushArgsOnStack(args->opr.op[0], lbl_kept);
    ex(args->opr.op[1], -1, 1, lbl_kept);

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

    // update the current frame
    local_sym_tab = prev;
}

// return 1 if array ptr and 0 otherwise
int isArrayPtr(nodeType* p) {
    StrMap* arr_dim_sym_tab = getArrDimSymTab();
    char dimension[DIM_STR_LEN];
    int arr_dimension;

    if (p->type == typeId && sm_exists(arr_dim_sym_tab, p->id.varName)) {
        return 1;
    } else if (p->type == typeArr) {
        if (sm_exists(arr_dim_sym_tab, p->arr.name)) {
            sm_get(arr_dim_sym_tab, p->arr.name, dimension, DIM_STR_LEN);
            arr_dimension = atoi(strtok(dimension, ","));
            return p->arr.dimension < arr_dimension;
        } else if (sm_exists(local_sym_tab->symbol_table, p->arr.name)) {
            return 0;
        }
    }

    return 0;
}

// get the array dimension symbol table
StrMap* getArrDimSymTab() {
    if (flevel == 0) {
        return global_sym_tab->arr_dim_sym_tab;
    } else {
        return local_sym_tab->arr_dim_sym_tab;
    }
}

// array declaration
void declareArray(char* reg, arrNodeType* array, int lbl_kept) {
    StrMap* arrayDimTab = getArrDimSymTab();
    char dimension[DIM_STR_LEN], buffer[DIM_STR_LEN];

    // calculate offset
    assert(array->dimension >= 1);
    arrOffsetListNodeType *node = array->offsetListHead;
    int offset = node->offset->con.value;
    sprintf(dimension, "%d,%d", array->dimension, offset);
    node = node->next;

    while (node) {
        // only support static declaration
        assert(node->offset->type == typeCon); 
        assert(node->offset->con.type != varTypeStr && node->offset->con.type != varTypeNil); 

        offset *= node->offset->con.value;
        sprintf(buffer, "%s,%d", dimension, node->offset->con.value);
        strcpy(dimension, buffer);
        node = node->next;
    }

    // declare
    getRegister(reg, array->name, offset);
    assert(!sm_exists(arrayDimTab, array->name));
    sm_put(arrayDimTab, array->name, dimension);

    array->size = offset;
}

// array assignment
void assignArray(nodeType* p) {
    // push base register address
    pushBasePtr(p);
    if (!scanning) { fprintf(stdout, "\tadd\n"); fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpop\tac[0]\n"); }

    // pop to each element
    for (int i = 1; i < p->arr.size; i++) {
        if (!scanning) { fprintf(stdout, "\tpush\tac[%d]\n", i-1); fprintf(stdout, "\tpop\tac[%d]\n", i); }
    }
}

// put char array
void putCharArray(nodeType* p, int hasNewLine, int lbl_kept) {
    int lbl1, lbl2;

    pushPtr(p, lbl_kept);
    if (!scanning) fprintf(stdout, "\tpop\tac\n"); 

    lbl1 = lbl++;
    lbl2 = lbl++;
    if (!scanning) {
        // start push char with loop
        fprintf(stdout, "L%03d:\n", lbl1);
        fprintf(stdout, "\tpush\tac[0]\n");
        fprintf(stdout, "\tpush\t0\n");
        fprintf(stdout, "\tcompLE\n");
        fprintf(stdout, "\tj1\tL%03d\n", lbl2);

        // put char
        fprintf(stdout, "\tpush\tac[0]\n");
        fprintf(stdout, "\tputc_\n");

        // increment index
        fprintf(stdout, "\tpush\tac\n");
        fprintf(stdout, "\tpush\t1\n");
        fprintf(stdout, "\tadd\n");
        fprintf(stdout, "\tpop\tac\n");

        fprintf(stdout, "\tjmp\tL%03d\n", lbl1);
        fprintf(stdout, "L%03d:\n", lbl2);

        if (hasNewLine) {
            fprintf(stdout, "\tpush\t0\n");
            fprintf(stdout, "\tputc\n");
        }
    }
}

// get char array
void getCharArray(nodeType* p, int lbl_kept) {
    int lbl1, lbl2;

    pushPtr(p, lbl_kept);
    if (!scanning) fprintf(stdout, "\tpop\tac\n"); 

    // start push char with loop
    lbl1 = lbl++;
    lbl2 = lbl++;
    if (!scanning) {
        fprintf(stdout, "L%03d:\n", lbl1);

        // get char
        fprintf(stdout, "\tgetc\n");
        fprintf(stdout, "\tpop\tac[0]\n");  

        // jump on value == \n
        fprintf(stdout, "\tpush\tac[0]\n");  
        fprintf(stdout, "\tpush\t%d\n", '\n');  
        fprintf(stdout, "\tcompEQ\n");

        fprintf(stdout, "\tj1\tL%03d\n", lbl2);

        // increment index
        fprintf(stdout, "\tpush\tac\n");
        fprintf(stdout, "\tpush\t1\n");
        fprintf(stdout, "\tadd\n");
        fprintf(stdout, "\tpop\tac\n"); 

        fprintf(stdout, "\tjmp\tL%03d\n", lbl1);
        fprintf(stdout, "L%03d:\n", lbl2);

        // mark the last char as \0
        fprintf(stdout, "\tpush\t0\n");
        fprintf(stdout, "\tpop\tac[0]\n");  
    }
}

// char array assignment
void assignCharArray(nodeType* p, char* str, int lbl_kept) {
    int l = strlen(str);

    pushPtr(p, lbl_kept);
    if (!scanning) fprintf(stdout, "\tpop\tac\n"); 

    // start push char by going through each char in string
    for (int i = 0; i < l; i++) {
        if (!scanning) { fprintf(stdout, "\tpush\t\'%c\'\n", str[i]); fprintf(stdout, "\tpop\tac[%d]\n", i); }
    }

    // mark the last char as \0
    if (!scanning) { fprintf(stdout, "\tpush\t0\n"); fprintf(stdout, "\tpop\tac[%d]\n", l); }
}

// push pointer
void pushPtr(nodeType* p, int lbl_kept) {
    StrMap* arrDimTab = getArrDimSymTab();
    char dimension[DIM_STR_LEN];
    int dim; 
    char* temp_dim;
    char reg[REG_NAME_LEN];

    if (p->type == typeArr) {
        if (sm_exists(local_sym_tab->symbol_table, p->arr.name)) {
            // param is an array pointer
            getRegister(reg, p->arr.name, -1);
            if (!scanning) fprintf(stdout, "\tpush\t%s\n", reg);

            // calculate the offset
            if (!scanning) fprintf(stdout, "\tpush\t0\n"); 
            arrOffsetListNodeType *node = p->arr.offsetListHead;
            ex(node->offset, -1, 1, lbl_kept);
            if (!scanning) fprintf(stdout, "\tadd\n");
        } else {
            pushBasePtr(p);

            // calculate offset
            if (!scanning) fprintf(stdout, "\tpush\t0\n"); 
            arrOffsetListNodeType *node = p->arr.offsetListHead;
            ex(node->offset, -1, 1, lbl_kept);
            if (!scanning) fprintf(stdout, "\tadd\n"); 

            node = node->next;
            if (sm_exists(arrDimTab, p->arr.name)) {
                sm_get(arrDimTab, p->arr.name, dimension, DIM_STR_LEN);
                dim = atoi(strtok(dimension, ",")); // dummy
                dim = atoi(strtok(NULL, ","));      // dummy

                while (node) {
                    dim = atoi(strtok(NULL, ","));
                    if (!scanning) { fprintf(stdout, "\tpush\t%d\n", dim); fprintf(stdout, "\tmul\n"); }
                    ex(node->offset, -1, 1, lbl_kept);
                    if (!scanning) fprintf(stdout, "\tadd\n"); 

                    node = node->next;
                }

                temp_dim = strtok(NULL, ",");
                while (temp_dim) {
                    dim = atoi(temp_dim);
                    if (!scanning) { fprintf(stdout, "\tpush\t%d\n", dim); fprintf(stdout, "\tmul\n"); }
                    temp_dim = strtok(NULL, ",");
                }
            }
            if (!scanning) fprintf(stdout, "\tadd\n");
        }
    } else if (p->type == typeId) {
        pushBasePtr(p);
    }

    if (!scanning) fprintf(stdout, "\tadd\n");    
}

// push pointer value
void pushPtrValue(nodeType* p, int lbl_kept) {
    pushPtr(p, lbl_kept);
    if (!scanning) { fprintf(stdout, "\tpop\tac\n"); fprintf(stdout, "\tpush\tac[0]\n"); }
}

// push base pointer for array and variable
void pushBasePtr(nodeType* p) {
    char reg[REG_NAME_LEN], baseReg[3] = {0}, baseRegOffset[REG_NAME_LEN] = {0};

    switch(p->type) {
        case typeArr:
            getRegister(reg, p->arr.name, -1);
            break;
        case typeId:
            getRegister(reg, p->id.varName, -1);
            break;
        default:
            return;
    }
    strncpy(baseReg, reg, 2);
    strncpy(baseRegOffset, reg + 3, strlen(reg) - 4);

    if (!scanning) { fprintf(stdout, "\tpush\t%s\n", baseReg); fprintf(stdout, "\tpush\t%s\n", baseRegOffset); }
}

// program initialization for execution
void init() {
    // init symbol tables
    global_sym_tab = (SymTab*) malloc(sizeof(SymTab));
    global_sym_tab->symbol_table = sm_new(GLOBAL_TAB_SIZE);
    global_sym_tab->arr_dim_sym_tab = sm_new(GLOBAL_TAB_SIZE);
    global_sym_tab->size = 0;
    func_sym_tab = (SymTab*) malloc(sizeof(SymTab));
    func_sym_tab->symbol_table = sm_new(FUNC_TAB_SIZE);
    func_sym_tab->arr_dim_sym_tab = sm_new(FUNC_TAB_SIZE);
    func_sym_tab->size = 0;

    // init string table
    string_tab = sm_new(GLOBAL_TAB_SIZE);
    string_var_tab = sm_new(GLOBAL_TAB_SIZE);

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
    sm_delete(global_sym_tab->symbol_table);
    sm_delete(func_sym_tab->symbol_table);
    sm_delete(global_sym_tab->arr_dim_sym_tab);
    sm_delete(func_sym_tab->arr_dim_sym_tab);

    // delete string table
    sm_delete(string_tab);
    sm_delete(string_var_tab);

    // free the local symbol table
    free(local_sym_tab);
    free(global_sym_tab);
    free(func_sym_tab);

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
    int numOfGlobalVars = global_sym_tab->size; // sm_get_count(global_sym_tab->symbol_table);
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
        ex(n, -1, 0);
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