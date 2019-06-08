/* NAS V0.7 */
/* Changes: puti/c/s can follow by an optional format string */
/* Changes: support floating numbers */

%{
  #include <stdlib.h>
  #include <stdio.h>
  #include <string.h>
  #include <errno.h>

  #define PUSHI 1
  #define PUSHR	2
  #define PUSHRI 3
  #define PUSHRR 4
  #define POPR 5
  #define POPRI 6
  #define POPRR 7

  #define PUTIS 8
  #define PUTSS 9
  #define PUTCS 10
  #define PUTFS 11

  void yyerror(char *);
  int yylex(void);

  extern FILE* yyin;

  int reg[4]; // 0 - sb; 1 - fp; 2 - ac/in; 3 - sp
  #define SB reg[0]
  #define FP reg[1]
  #define IN reg[2]
  #define SP reg[3]

  #define SIZE 20000 // max code size
  #define LABELS 1000
  #define ST_SIZE 20000 // max stack size

  // Increment SP and check
  // #define ISP if (++SP >= ST_SIZE) error(1, 0, "Stack overflow!")
  // No error() on Solaris:
  #define ISP if (++SP >= ST_SIZE) { printf("Stack overflow!"); exit(1); }

  // max size of string is 500

  int pc;                   // program counter during assembly
  long in[SIZE], opx[SIZE]; // instructions and their operands
  double op[SIZE];          // operands - considering float numbers 
  int lb[LABELS];           // labels[000..999]

  char *str;
%}


%union {
  int i;
  double f;
  char s[500];
}

%token <i>INT <f>FLOAT <i>REG <i>LABEL PUSH POP LT GT GE LE NE EQ <s>STRING
%token CALL RET END J0 J1 JMP ADD SUB MUL DIV RDIV MOD NEG AND OR
%token GETI GETS GETC GETF PUTI PUTS PUTC PUTF PUTI_ PUTS_ PUTC_ PUTF_
%nonassoc ':'

%%

program:
	program line
	|
	;

line:
	instruction
	| LABEL ':'	{ lb[$1] = pc; }
	;

instruction:
	PUSH INT	{ in[pc] = PUSHI; op[pc++] = $2; }
	| PUSH FLOAT { in[pc] = PUSHI; op[pc++] = $2; }
	| PUSH STRING	{ 
		in[pc] = PUSHI;
		str = (char *) malloc(strlen($2)+1);
		strcpy(str, $2); op[pc++] = (long) str;
	}
	| PUSH REG	{ in[pc] = PUSHR; op[pc++] = $2; }
	| PUSH REG '[' INT ']'
			{ in[pc] = PUSHRI; op[pc] = $2; opx[pc++] = $4; }
	| PUSH REG '[' REG ']'
			{ in[pc] = PUSHRR; op[pc] = $2; opx[pc++] = $4; }
	| POP REG	{ in[pc] = POPR; op[pc++] = $2; }
	| POP REG '[' INT ']'
			{ in[pc] = POPRI; op[pc] = $2; opx[pc++] = $4; }
	| POP REG '[' REG ']'
			{ in[pc] = POPRR; op[pc] = $2; opx[pc++] = $4; }
	| CALL LABEL ',' INT
			{ in[pc] = CALL; op[pc] = $2; opx[pc++] = $4; }
	| RET		{ in[pc++] = RET; }
	| END		{ in[pc++] = END; }
	| LT		{ in[pc++] = LT; }
	| GT		{ in[pc++] = GT; }
	| GE		{ in[pc++] = GE; }
	| LE		{ in[pc++] = LE; }
	| NE		{ in[pc++] = NE; }
	| EQ		{ in[pc++] = EQ; }
	| J0 LABEL	{ in[pc] = J0; op[pc++] = $2; }
	| J1 LABEL	{ in[pc] = J1; op[pc++] = $2; }
	| JMP LABEL	{ in[pc] = JMP; op[pc++] = $2; }
	| ADD		{ in[pc++] = ADD; }
	| SUB		{ in[pc++] = SUB; }
	| MUL		{ in[pc++] = MUL; }
	| DIV		{ in[pc++] = DIV; }
	| RDIV      { in[pc++] = RDIV; }
	| MOD		{ in[pc++] = MOD; }
	| NEG		{ in[pc++] = NEG; }
	| AND		{ in[pc++] = AND; }
	| OR		{ in[pc++] = OR; }
	| GETI		{ in[pc++] = GETI; }
	| GETS		{ in[pc++] = GETS; }
	| GETC		{ in[pc++] = GETC; }
	| GETF		{ in[pc++] = GETF; }
	| PUTI		{ in[pc++] = PUTI; }
	| PUTI STRING	{
		in[pc] = PUTIS;
		str = (char *) malloc(strlen($2)+1);
		strcpy(str, $2); op[pc++] = (long) str;
	}
	| PUTS		{ in[pc++] = PUTS; }
	| PUTS STRING	{
		in[pc] = PUTSS;
		str = (char *) malloc(strlen($2)+1);
		strcpy(str, $2); op[pc++] = (long) str;
	}
	| PUTC		{ in[pc++] = PUTC; }
	| PUTC STRING	{
		in[pc] = PUTCS;
		str = (char *) malloc(strlen($2)+1);
		strcpy(str, $2); op[pc++] = (long) str;
	}
	| PUTF		{ in[pc++] = PUTF; }
	| PUTF STRING	{
		in[pc] = PUTFS;
		str = (char *) malloc(strlen($2)+1);
		strcpy(str, $2); op[pc++] = (long) str;
	}
	| PUTI_		{ in[pc++] = PUTI_; }
	| PUTS_		{ in[pc++] = PUTS_; }
	| PUTC_		{ in[pc++] = PUTC_; }
	| PUTF_     { in[pc++] = PUTF_; }
	;

%%

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(int argc, char *argv[]) {
  // int st[ST_SIZE];
  // long st[ST_SIZE];
  double st[ST_SIZE];

  SB = 0;
  FP = 0;
  SP = 0;

  int i = 0; // the pc used by the execution
  int temp;

  char buf[500];

  yyin = fopen(argv[1], "r");

  pc = 0;

  // First pass: read the .as into the arrays in, op, opx, and lb
  yyparse();

  // Second pass: execute the arrays
  while (i < pc)
    switch (in[i]) {
      case PUSHI:
		st[SP] = op[i++]; ISP; break;
      case PUSHR:
		st[SP] = reg[(long)op[i++]]; ISP; break;
      case PUSHRI:
		st[SP] = st[reg[(long)op[i]] + opx[i]]; i++; ISP; break;
		// check sp pt errors here?
      case PUSHRR:
		st[SP] = st[reg[(long)op[i]] + reg[opx[i]]]; i++; ISP; break;
      case POPR:
		reg[(long)op[i++]] = st[--SP]; break;
      case POPRI:
		st[reg[(long)op[i]] + opx[i]] = st[--SP]; i++; break;
      case POPRR:
		st[reg[(long)op[i]] + reg[opx[i]]] = st[--SP]; i++; break;

      case CALL:
		// save old SP
		st[SP] = SP - opx[i]; ISP;
		// save old FP
		st[SP] = FP; ISP;
		// save return address
		st[SP] = ++i; ISP;
		// set new FP
		FP = SP;
		// jump!
		i = lb[(long)op[i-1]];
		break;
	  case RET:
		// keep return value
		temp = st[--SP];
		// return address
		i = st[FP - 1];
		// restore SP
		SP = st[FP - 3];
		// restore FP
		FP = st[FP - 2];
		// push return value
		st[SP] = temp; ISP;
		break;

      case END:
		i = 99999999;
		break;

#define EVAL(opr) st[SP-2] = st[SP-2] opr st[SP-1]; SP--; i++; break;
#define EVAL_LONG(opr) st[SP-2] = (long) st[SP-2] opr (long) st[SP-1]; SP--; i++; break;

      case LT: EVAL(<)
      case GT: EVAL(>)
      case GE: EVAL(>=)
      case LE: EVAL(<=)
      case NE: EVAL(!=)
      case EQ: EVAL(==)
      case ADD: EVAL(+)
      case SUB: EVAL(-)
      case MUL: EVAL(*)
      case DIV: EVAL_LONG(/)
      case RDIV: EVAL(/)
      case MOD: EVAL_LONG(%)
      case AND: EVAL(&&)
      case OR: EVAL(||)
      case NEG:
		st[SP-1] = -st[SP-1]; i++; break;
      case J0:
		i = st[--SP] ? i + 1 : lb[(long)op[i]]; break;
      case J1:
		i = st[--SP] ? lb[(long)op[i]] : i + 1; break;
      case JMP:
		i = lb[(long)op[i]]; break;
      case GETI:
		scanf("%lf", &st[SP]);
		getchar(); // chew up the newline
		i++; ISP; break;
	  case GETF:
		scanf("%lf", &st[SP]);
		getchar(); // chew up the newline
		i++; ISP; break;
      case GETS:
        scanf("%500[^\n]", buf);
		getchar(); // chew up the newline
		str = (char *) malloc(strlen(buf)+1);
		strcpy(str, buf); st[SP] = (long) str; ISP;
		i++;
		break;
      case GETC:
		st[SP] = getchar(); ISP; i++; break;
      case PUTI:
		printf("%ld\n", (long)st[--SP]); i++; break;
	  case PUTF:
		printf("%lf\n", st[--SP]); i++; break;
      case PUTIS:
		printf((char *) (long) op[i], st[--SP]); i++; break;
	  case PUTFS:
		printf((char *) (long) op[i], st[--SP]); i++; break;
      case PUTS:
		printf("%s\n", (char *) (long) st[--SP]); i++; break;
      case PUTSS:
		printf((char *) (long) op[i], st[--SP]); i++; break;
      case PUTC:
		putchar(st[--SP]); putchar('\n'); i++; break;
      case PUTCS:
		printf((char *) (long) op[i], st[--SP]); i++; break;
      case PUTI_:
		printf("%ld", (long) st[--SP]); i++; break;
	  case PUTF_:
	    printf("%lf", st[--SP]); i++; break;
      case PUTS_:
		printf("%s", (char *) (long) st[--SP]); i++; break;
      case PUTC_:
		putchar(st[--SP]); i++; break;
    }
  return 0;
}
