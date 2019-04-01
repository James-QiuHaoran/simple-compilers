# A simple calculator language (c5) - interpreter and compiler

## Intro

c5i - interpreter [make c5i]
c5c - compiler -> [make c5c]
nas - the assembler for a simulated stack machine [make nas]

Or, you can run `make all` to make all executables.

## Example programs

for.sc - a double for loop
fact.sc - factorial

## To run

```
c5i fact.sc
c5c fact.sc >fact.sas
sas fact.sas

c5i for.sc
c5c for.sc >for.sas
sas for.sas
```

Run `make clean` to remove all intermediate or auxiliary files.
