# A simple programming language - c6's compiler

## Introduction

c6c - compiler -> [`make c6c`]
nas - the assembler for a simulated stack machine [`make nas`]

Or, you can run `make all` to make all executables.

## Features

This is a compiler for a simple programming lanaguage. c6 is based on c5, which has the following features:

- Constants and variables (global & local)
- Arithmetic compuations (`+`, `-`, `*`, `/`)
- Logic expression (`AND`, `OR`, `>`, `<`, etc)
- Control flow (`for`, `while`, `if`)
- Functions (could be recursive)
- I/O

In addition, these features have been added to c6:

- Control flow: `break` and `continue`
- Arrays

## Example programs

There are three sample programs in the directory `sample_progs`:

- fact.sc - factorial
- rev-c.sc - string-reverse
- max.sc - picking the max from two numbers

## To run the compiler

```
./c6c fact.sc >fact.nas
./nas fact.nas
```

Run `make clean` to remove all intermediate or auxiliary files.

## Tests

There are 15 tests in the `test` directory. To run them, simply execute `./run_tests.sh`. But make sure you've built the executables `c6c` and `nas`.

## Contact

- Author: James, Qiu Haoran
- Email: jamesqiu@hku.hk
