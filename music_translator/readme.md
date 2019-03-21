# Parser for music notation translation

The translator translates music notations from simple music notation to ABC notation.

## Instructions

### How to build

```
bison -y -d trans.y
flex trans.l
gcc -c y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o trans.exe
```

Or you can run `./build.sh` under the source code directory.

### How to parse

To translate your music notation, run:

```
./trans.exe <notation.txt
```

Enjoy your tranlator!

## Contact

- Author: Qiu Haoran (3035234478)
- Email: jamesqiu@hku.hk
