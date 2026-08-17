# Compiler-Design-Lab

Compiler Design Lab Experiments using FLEX and BISON

# Compiler Design Lab

This repository contains Compiler Design Lab experiments implemented using FLEX and BISON.

## Experiments

- Experiment 1 - Lexical Analyzer with Symbol Table
- Experiment 2 - Lexical Analyzer using FLEX
- Experiment 3 - Arithmetic Expression Recognition
- Experiment 4 - Variable Recognition
- Experiment 5 - Control Structure Recognition
- Experiment 6 - Calculator using FLEX and BISON
- Experiment 7 - Generate Three Address Code (TAC) for a Simple Program
- Experiment 8 - Type Checking using FLEX and BISON
- Experiment 9 - Code Optimization Techniques (Constant Folding, Strength Reduction and Algebraic Simplification)
- Experiment 10 - Back-End of Compiler: Generate 8086 Assembly Code from Three Address Code

## Tools Used

- FLEX (LEX)
- BISON (YACC)
- GCC Compiler
- Ubuntu (WSL)

## Programming Language

- C

## How to Compile and Run

```bash
flex filename.l
bison -d filename.y
gcc lex.yy.c filename.tab.c -o output -lfl
./output
