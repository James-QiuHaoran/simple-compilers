sas: sas.c sas.tab.c
	gcc -o sas sas.c sas.tab.c

sas.c: sas.l
	flex -o sas.c sas.l

sas.tab.c: sas.y
	bison -d sas.y

clean:
	rm -rf sas sas.c sas.tab.c sas.tab.h
