%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line_num = 1;
int token_count = 0;
%}

%option noyywrap

%%

"#include"|"#define"|"#ifdef"|"#ifndef"|"#endif"  {
    printf("Line %d  PREPROCESSOR\t: %s\n", line_num, yytext);
    token_count++;
}

"<"[a-zA-Z0-9_.]+".h"  {
    printf("Line %d  HEADER FILE\t: %s\n", line_num, yytext);
    token_count++;
}
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" {
    printf("Line %d  KEYWORD\t\t: %s\n", line_num, yytext);
    token_count++;
}

[a-zA-Z_][a-zA-Z0-9_]*  {
    printf("Line %d  IDENTIFIER\t: %s\n", line_num, yytext);
    token_count++;
}

[0-9]+(\.[0-9]+)?  {
    printf("Line %d  NUMBER\t\t: %s\n", line_num, yytext);
    token_count++;
}

"=="|"!="|"<="|">="  {
    printf("Line %d  RELAT OP\t: %s\n", line_num, yytext);
    token_count++;
}

"="|"+="|"-="|"*="|"/="  {
    printf("Line %d  ASSIGN OP\t: %s\n", line_num, yytext);
    token_count++;
}

"++"|"--"|"+"|"-"|"*"|"/"|"%"  {
    printf("Line %d  ARITH OP\t: %s\n", line_num, yytext);
    token_count++;
}

"<"|">"|"!"  {
    printf("Line %d  RELAT OP\t: %s\n", line_num, yytext);
    token_count++;
}

"&&"|"||"  {
    printf("Line %d  LOGIC OP\t: %s\n", line_num, yytext);
    token_count++;
}

";"|","|"("|")"|"{"|"}"|"["|"]"|":"  {
    printf("Line %d  DELIMITER\t: %s\n", line_num, yytext);
    token_count++;
}

"//"[^\n]*  {
    printf("Line %d  COMMENT\t\t: %s\n", line_num, yytext);
    token_count++;
}

"/"([^]|\+[^/])\+"/"  {
    printf("Line %d  COMMENT\t\t: /* ... */\n", line_num);
    token_count++;
}

\"[^\"\n]*\"  {
    printf("Line %d  STRING\t\t: %s\n", line_num, yytext);
    token_count++;
}

\n  { line_num++; }
[ \t]+  { }
.  { }

%%

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("Usage: ./ex2_lexer <filename>\n");
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL) {
        printf("Cannot open file: %s\n", argv[1]);
        return 1;
    }
    printf("========================================\n");
    printf("      LEXICAL ANALYSIS RESULT\n");
    printf("      Input file: %s\n", argv[1]);
    printf("========================================\n\n");
    yyin = fp;
    yylex();
    fclose(fp);
    printf("\n========================================\n");
    printf("Total tokens found  : %d\n", token_count);
    printf("Total lines scanned : %d\n", line_num - 1);
    printf("========================================\n");
    return 0;
}
