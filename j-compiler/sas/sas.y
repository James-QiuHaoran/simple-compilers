%{
  #include <stdio.h>

  #define PUSHN 1
  #define PUSHR 2
  void yyerror(char *);
  int yylex(void);

  extern FILE* yyin;

  int pc;
  int in[500], op[500]; // instructions and their operands
  int lb[1000]; // labels[000..999]

%}

%token INT REG LABEL PUSH POP LT GT GE LE NE EQ
%token JZ JMP ADD SUB MUL DIV MOD NEG AND OR READ PRINT
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
	PUSH INT	{ in[pc] = PUSHN; op[pc++] = $2; }
	| PUSH REG	{ in[pc] = PUSHR; op[pc++] = $2; }
	| POP REG	{ in[pc] = POP; op[pc++] = $2; }
	| LT		{ in[pc++] = LT; }
	| GT		{ in[pc++] = GT; }
	| GE		{ in[pc++] = GE; }
	| LE		{ in[pc++] = LE; }
	| NE		{ in[pc++] = NE; }
	| EQ		{ in[pc++] = EQ; }
	| JZ LABEL	{ in[pc] = JZ; op[pc++] = $2; }
	| JMP LABEL	{ in[pc] = JMP; op[pc++] = $2; }
	| ADD		{ in[pc++] = ADD; }
	| SUB		{ in[pc++] = SUB; }
	| MUL		{ in[pc++] = MUL; }
	| DIV		{ in[pc++] = DIV; }
	| MOD		{ in[pc++] = MOD; }
	| NEG		{ in[pc++] = NEG; }
	| AND		{ in[pc++] = AND; }
	| OR		{ in[pc++] = OR; }
	| READ		{ in[pc++] = READ; }
	| PRINT		{ in[pc++] = PRINT; }
	;

%%

void yyerror(char *s) {
  printf("%s\n", s);
}


int main(int argc, char *argv[]) {
  int st[500];
  int reg[26];
  int i = 0;
  int sp = 0;

  yyin = fopen(argv[1], "r");

  pc = 0;

  // First pass: read the .sas into the arrays in, op, and lb
  yyparse();

  // Second pass: execute the arrays
  while (i < pc)
    switch (in[i]) {
      case PUSHN:
	st[sp++] = op[i++]; break;
      case PUSHR:
	st[sp++] = reg[op[i++]]; break;
      case POP:
	reg[op[i++]] = st[--sp]; break;

#define EVAL(opr) st[sp-2] = st[sp-2] opr st[sp-1]; sp--; i++; break;

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
	st[sp-1] = -st[sp-1]; i++; break;
      case JZ:
	i = st[--sp] ? i + 1 : lb[op[i]]; break;
      case JMP:
	i = lb[op[i]]; break;
      case READ:
	printf("? "); scanf("%d", &st[sp++]); i++; break;
      case PRINT:
	printf("%d\n", st[sp-1]); i++; break;
    }
  return 0;
}
