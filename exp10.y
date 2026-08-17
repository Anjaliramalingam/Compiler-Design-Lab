%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
%}

%union
{
    char *str;
}

%token <str> ID
%type <str> expr

%left '+' '-'
%left '*' '/'

%%

program
    :
      stmts
    ;

stmts
    :
      stmts stmt
    |
      stmt
    ;

stmt
    :
      ID '=' expr ';'
      {
          printf("MOV %s, AX\n\n",$1);
      }
    ;

expr
    :
      ID
      {
          printf("MOV AX, %s\n",$1);
          $$=$1;
      }

    | expr '+' ID
      {
          printf("ADD AX, %s\n",$3);
          $$=$3;
      }

    | expr '-' ID
      {
          printf("SUB AX, %s\n",$3);
          $$=$3;
      }

    | expr '*' ID
      {
          printf("MUL %s\n",$3);
          $$=$3;
      }

    | expr '/' ID
      {
          printf("MOV DX, 0\n");
          printf("MOV BX, %s\n",$3);
          printf("DIV BX\n");
          $$=$3;
      }
    ;

%%

int main()
{
    printf("Enter TAC statements (Press Ctrl+D to finish):\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}
