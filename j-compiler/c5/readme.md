# A simple calculator language (c5) - interpreter and compiler

## Intro

c5i - interpreter [`make c5i`]
c5c - compiler -> [`make c5c`]
nas - the assembler for a simulated stack machine [`make nas`]

Or, you can run `make all` to make all executables.

## Features

This is a compiler for a simple programming lanaguage. The features implemeted are:

- Constants and variables
- Arithmetic compuations (`+`, `-`, `*`, `/`)
- Logic expression (`AND`, `OR`, `>`, `<`, etc)
- Control flow (`for`, `while`, `if`)
- Functions
- I/O

## Example programs

There are three sample programs in the directory `sample_progs`:

- fact.sc - factorial
- rev-c.sc - string-reverse
- max.sc - picking the max from two numbers

## To run - compiler

```
./c5c fact.sc >fact.nas
./nas fact.nas
```

Run `make clean` to remove all intermediate or auxiliary files.

## Tests

There are 11 tests in the `test` directory. To run them, simply execute `./run_tests.sh`. But make sure you've built the executables `c5c` and `nas`.

## Contact

- Author: James, Qiu Haoran
- Email: jamesqiu@hku.hk
