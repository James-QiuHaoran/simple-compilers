# A simple calculator language (j-sc) - interpreter and compiler

There are two versions of them: c4 and c5.

## Intro

c4i/c5i - interpreter [make c4i/c5i]
c4c/c5c - compiler -> [make c4c/c5c]
nas - the assembler for a simulated stack machine [make nas]

Or, you can run `make all` to make all executables.

## Example programs

for.sc - a double for loop
fact.sc - factorial

## To run

```
c4i/c5i fact.sc
c4c/c5c fact.sc >fact.sas
sas fact.sas

c4i/c5i for.sc
c4c/c5c for.sc >for.sas
sas for.sas
```

Run `make clean` to remove all intermediate or auxiliary files.
