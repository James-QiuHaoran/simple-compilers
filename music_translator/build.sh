bison -y -d trans.y
echo ">>>> bison -y -d trans.y"
echo "y.tab.c and y.tab.h are created!"

flex trans.l
echo ">>>> flex trans.l"
echo "lex.yy.c is created!"

gcc -c y.tab.c lex.yy.c
echo ">>>> gcc -c y.tab.c lex.yy.c"
echo "lex.yy.o and y.tab.o are created!"

gcc y.tab.o lex.yy.o -o trans.exe
echo ">>>> gcc y.tab.o lex.yy.o -o trans.exe"
echo "trans.exe is created!"
echo ""
echo "Usage: ./trans.exe < test.txt"