/* NAS 0.6 */
/* Changes: puti/c/s can follow by an optional format string */

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

  int pc; // program counter during assembly
  long in[SIZE], op[SIZE], opx[SIZE]; // instructions and their operands
  int lb[LABELS]; // labels[000..999]

  char *str;
%}


%union {
  int i;
  char s[500];
}

%token <i>INT <i>REG <i>LABEL PUSH POP LT GT GE LE NE EQ <s>STRING
%token CALL RET END J0 J1 JMP ADD SUB MUL DIV MOD NEG AND OR
%token GETI GETS GETC PUTI PUTS PUTC PUTI_ PUTS_ PUTC_
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
	| MOD		{ in[pc++] = MOD; }
	| NEG		{ in[pc++] = NEG; }
	| AND		{ in[pc++] = AND; }
	| OR		{ in[pc++] = OR; }
	| GETI		{ in[pc++] = GETI; }
	| GETS		{ in[pc++] = GETS; }
	| GETC		{ in[pc++] = GETC; }
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
	| PUTI_		{ in[pc++] = PUTI_; }
	| PUTS_		{ in[pc++] = PUTS_; }
	| PUTC_		{ in[pc++] = PUTC_; }
	;

%%

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(int argc, char *argv[]) {
  //int st[ST_SIZE];
  long st[ST_SIZE];

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
	st[SP] = reg[op[i++]]; ISP; break;
      case PUSHRI:
	st[SP] = st[reg[op[i]] + opx[i]]; i++; ISP; break;
	// check sp pt errors here?
      case PUSHRR:
	st[SP] = st[reg[op[i]] + reg[opx[i]]]; i++; ISP; break;
      case POPR:
	reg[op[i++]] = st[--SP]; break;
      case POPRI:
	st[reg[op[i]] + opx[i]] = st[--SP]; i++; break;
      case POPRR:
	st[reg[op[i]] + reg[opx[i]]] = st[--SP]; i++; break;

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
	i = lb[op[i-1]];
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

      case LT: EVAL(<)
      case GT: EVAL(>)
      case GE: EVAL(>=)
      case LE: EVAL(<=)
      case NE: EVAL(!=)
      case EQ: EVAL(==)
      case ADD: EVAL(+)
      case SUB: EVAL(-)
      case MUL: EVAL(*)
      case DIV: EVAL(/)
      case MOD: EVAL(%)
      case AND: EVAL(&&)
      case OR: EVAL(||)
      case NEG:
	st[SP-1] = -st[SP-1]; i++; break;
      case J0:
	i = st[--SP] ? i + 1 : lb[op[i]]; break;
      case J1:
	i = st[--SP] ? lb[op[i]] : i + 1; break;
      case JMP:
	i = lb[op[i]]; break;
      case GETI:
	scanf("%ld", &st[SP]);
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
	printf("%ld\n", st[--SP]); i++; break;
      case PUTIS:
	printf((char *) op[i], st[--SP]); i++; break;
      case PUTS:
	printf("%s\n", (char *) st[--SP]); i++; break;
      case PUTSS:
	printf((char *) op[i], st[--SP]); i++; break;
      case PUTC:
	putchar(st[--SP]); putchar('\n'); i++; break;
      case PUTCS:
	printf((char *) op[i], st[--SP]); i++; break;
      case PUTI_:
	printf("%ld", st[--SP]); i++; break;
      case PUTS_:
	printf("%s", (char *) st[--SP]); i++; break;
      case PUTC_:
	putchar(st[--SP]); i++; break;
    }
  return 0;
}
