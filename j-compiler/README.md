# A simple calculator language (j-sc) - interpreter and compiler

There are two versions of them: c4 and c5.

## Intro - c5

c5i - interpreter [make c5i]
c5c - compiler -> [make c5c]
nas - the assembler for a simulated stack machine [make nas]

## Example programs

for.sc - a double for loop
fact.sc - factorial

## To run - c4

```
c4i fact.sc
c4c fact.sc >fact.sas
sas fact.sas

c4i for.sc
c4c for.sc >for.sas
sas for.sas
```