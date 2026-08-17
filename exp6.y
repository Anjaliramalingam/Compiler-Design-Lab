%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%define api.value.type {double}

%token NUM

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
      expr '\n' { printf("Answer: %.2f\n",$1); }
      ;

expr:
      expr '+' expr { $$=$1+$3; }
    | expr '-' expr { $$=$1-$3; }
    | expr '*' expr { $$=$1*$3; }
    | expr '/' expr { $$=$1/$3; }
    | '(' expr ')'  { $$=$2; }
    | '-' expr %prec UMINUS { $$=-$2; }
    | NUM
    ;

%%

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Invalid Expression\n");
}
