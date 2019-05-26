# Interpreters and compilers for a c-like simple programming language

There are three versions of them: c4, c5 and c6.

## Intro

- c4i - interpreter [`make c4i`]
- c4c/c5c/c6c - compiler -> [`make c4c/c5c/c6c`]
- sas/nas - the assembler for a simulated stack machine [`make sas/nas`]

Or, you can run `make all` to make all executables.

## Feature

For c4,

- Integer value
- Arithmetic expressions e.g. `+, -, *, /`
- for, while, if statements
- I/O

For c5,

- Constants and variables (global & local)
- Arithmetic compuations (`+`, `-`, `*`, `/`)
- Logic expression (`AND`, `OR`, `>`, `<`, etc)
- Control flow (`for`, `while`, `if`)
- Functions (could be recursive)
- I/O

For c6,

- Constants and variables (global & local)
- Arithmetic compuations (`+`, `-`, `*`, `/`)
- Logic expression (`AND`, `OR`, `>`, `<`, etc)
- Control flow (`for`, `while`, `if`)
- Functions (could be recursive)
- I/O
- Control flow: `break` and `continue`;
- String functioning as other normal variables (assignment, comparison, print);
- Multi-dimensional arrays (any dimension);
- String concatenation;
- Reference (`*`) & Dereference (`&`);

## Example programs

- for.sc - a double for loop
- fact.sc - factorial
- max.sc - pick the max number
- rev-c.sc - reverse the string

## To run

```
c4i fact.sc
c4c/c5c/c6c fact.sc >fact.as
sas/nas fact.as

c4i for.sc
c4c/c5c/c6c for.sc >for.as
sas/nas for.as
```

Run `make clean` to remove all intermediate or auxiliary files.

## Contact

- Author: James Qiu
- Email: jamesqiu@hku.hk
