%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct symbol {
    char name[50];
    char type[20];
};

struct symbol symtab[100];
int sym_count = 0;

char *keywords[] = {
    "int","float","char","double","void",
    "if","else","while","for","return",
    "switch","case","break","continue",
    "struct","typedef","long","short",
    "unsigned","signed",NULL
};

int is_keyword(char *word) {
    int i;
    for(i = 0; keywords[i] != NULL; i++)
        if(strcmp(keywords[i], word) == 0)
            return 1;
    return 0;
}

void insert_symbol(char *name) {
    int i;
    for(i = 0; i < sym_count; i++)
        if(strcmp(symtab[i].name, name) == 0)
            return;
    strcpy(symtab[sym_count].name, name);
    strcpy(symtab[sym_count].type, "identifier");
    sym_count++;
}

void display_symtab() {
    int i;
    printf("\n============================================\n");
    printf("           SYMBOL TABLE\n");
    printf("============================================\n");
    printf("%-5s %-20s %-15s\n","S.No","NAME","TYPE");
    printf("--------------------------------------------\n");
    for(i = 0; i < sym_count; i++)
        printf("%-5d %-20s %-15s\n",
               i+1, symtab[i].name, symtab[i].type);
    printf("============================================\n");
    printf("Total symbols: %d\n", sym_count);
}
%}

%%

"#include"|"#define"  {
    printf("PREPROCESSOR\t: %s\n", yytext);
}

"<"[a-zA-Z0-9_.]+".h"  {
    printf("HEADER FILE\t: %s\n", yytext);
}

"int"|"float"|"char"|"double"|"void"|"if"|"else"|"while"|"for"|"return"|"switch"|"case"|"break"|"continue"|"struct"|"typedef"|"long"|"short"|"unsigned"|"signed"  {
    printf("KEYWORD\t\t: %s\n", yytext);
}

[0-9]+("."[0-9]+)?  {
    printf("NUMBER\t\t: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]*  {
    if(!is_keyword(yytext)) {
        printf("IDENTIFIER\t: %s\n", yytext);
        insert_symbol(yytext);
    }
}

"+"|"-"|"*"|"/"  {
    printf("ARITH OP\t: %s\n", yytext);
}

"=="|"!="|"<="|">="|"<"|">"  {
    printf("RELAT OP\t: %s\n", yytext);
}

"="|"+="|"-="  {
    printf("ASSIGN OP\t: %s\n", yytext);
}

";"|","|"("|")"|"{"|"}"  {
    printf("DELIMITER\t: %s\n", yytext);
}

"//".*  {
    printf("COMMENT\t\t: %s\n", yytext);
}

"\""[^\"]*"\""  {
    printf("STRING\t\t: %s\n", yytext);
}

"\n"  { }
[ \t]+ { }
.     { }

%%

int yywrap() { return 1; }

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("Usage: ./ex1_symtab <filename>\n");
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL) {
        printf("Cannot open file: %s\n", argv[1]);
        return 1;
    }
    printf("========== LEXICAL ANALYSIS ==========\n\n");
    yyin = fp;
    yylex();
    fclose(fp);
    display_symtab();
    return 0;
}
