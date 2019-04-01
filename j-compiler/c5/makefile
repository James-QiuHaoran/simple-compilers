all: c5i c5c nas

c5i: lex.yy.c y.tab.c c5i.c
	gcc -o c5i lex.yy.c y.tab.c c5i.c

c5c: lex.yy.c y.tab.c c5c.c
	gcc -o c5c lex.yy.c y.tab.c c5c.c

lex.yy.c: c5.l
	flex c5.l

y.tab.c: c5.y
	bison -y -d c5.y

nas: nas.c nas.tab.c
	gcc -o nas nas.c nas.tab.c

nas.c: nas.l
	flex -o nas.c nas.l

nas.tab.c: nas.y
	bison -d nas.y

cleanc5:
	$(RM) lex.yy.c y.tab.c y.tab.h c5i c5c

cleannas:
	$(RM) nas.c nas.tab.c nas.tab.h nas

clean:
	$(RM) lex.yy.c y.tab.c y.tab.h c5i c5c
	$(RM) nas.c nas.tab.c nas.tab.h nas
