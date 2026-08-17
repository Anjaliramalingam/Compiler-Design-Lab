%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token IF ELSE WHILE FOR SWITCH CASE DEFAULT
%token ID NUM
%token LPAREN RPAREN LBRACE RBRACE COLON SEMICOLON
%token EQ LE GE LT GT ASSIGN

%%

program :
      if_stmt
    | while_stmt
    | for_stmt
    | switch_stmt
    ;

if_stmt :
      IF LPAREN condition RPAREN SEMICOLON
    | IF LPAREN condition RPAREN SEMICOLON ELSE SEMICOLON
    ;

while_stmt :
      WHILE LPAREN condition RPAREN SEMICOLON
    ;

for_stmt :
      FOR LPAREN ID ASSIGN NUM SEMICOLON condition SEMICOLON ID ASSIGN NUM RPAREN SEMICOLON
    ;

switch_stmt :
      SWITCH LPAREN ID RPAREN LBRACE CASE NUM COLON SEMICOLON DEFAULT COLON SEMICOLON RBRACE
    ;

condition :
      ID EQ NUM
    | ID LT NUM
    | ID GT NUM
    | ID LE NUM
    | ID GE NUM
    ;

%%

int main()
{
    printf("Enter Control Structure:\n");
    yyparse();
    printf("Valid Control Structure\n");
    return 0;
}

void yyerror(const char *s)
{
    printf("Invalid Control Structure\n");
    exit(0);
}

