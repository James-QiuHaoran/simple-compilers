all: c6c nas

c6c: lex.yy.c y.tab.c c6c.c strmap.c
	gcc -o c6c lex.yy.c y.tab.c c6c.c strmap.c

lex.yy.c: c6.l
	flex c6.l

y.tab.c: c6.y
	bison -y -d c6.y

nas: nas.c nas.tab.c
	gcc -o nas nas.c nas.tab.c

nas.c: nas.l
	flex -o nas.c nas.l

nas.tab.c: nas.y
	bison -d nas.y

cleanc6:
	$(RM) lex.yy.c y.tab.c y.tab.h c6c

cleannas:
	$(RM) nas.c nas.tab.c nas.tab.h nas

clean:
	$(RM) lex.yy.c y.tab.c y.tab.h c6c
	$(RM) nas.c nas.tab.c nas.tab.h nas