# A simple calculator language (c5) - interpreter and compiler

## Intro

c5i - interpreter [make c5i]
c5c - compiler -> [make c5c]
nas - the assembler for a simulated stack machine [make nas]

Or, you can run `make all` to make all executables.

## Example programs

for.sc - a double for loop
fact.sc - factorial

## To run - compiler

```
c5c fact.sc >fact.nas
nas fact.nas

c5c for.sc >for.nas
nas for.nas
```

Run `make clean` to remove all intermediate or auxiliary files.
