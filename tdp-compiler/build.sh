bison -y -d tdp.y
flex tdp.l
gcc -c y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o tdp
