#include <stdio.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;

int ex(nodeType *p) {
    int lblx, lbly, lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
        case typeCon:
            if (p->con.type == conTypeInt)
                printf("\tpush\t%d\n", (int) p->con.value);
            else if (p->con.type == conTypeChar)
                printf("\tpush\t\'%c\'\n", (char) p->con.value);
            else if (p->con.type == conTypeString)
                printf("\tpush\t\"%s\"\n", (char*) p->con.value);
            break;
        case typeId:        
            printf("\tpush\t%c\n", p->id.i + 'a'); 
            break;
        case typeOpr:
            switch(p->opr.oper) {
        case FOR:
            ex(p->opr.op[0]);
            printf("L%03d:\n", lblx = lbl++);
            ex(p->opr.op[1]);
            printf("\tj0\tL%03d\n", lbly = lbl++);
            ex(p->opr.op[3]);
            ex(p->opr.op[2]);
            printf("\tjmp\tL%03d\n", lblx);
            printf("L%03d:\n", lbly);
            break;
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            printf("\tj0\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                printf("\tj0\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                printf("\tj0\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case READ:
            printf("\tread\n");
                printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tprint\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tneg\n");
            break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
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
    }
    return 0;
}