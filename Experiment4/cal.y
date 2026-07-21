%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%union{
    double dval;
}

%token <dval> NUM
%type <dval> Expression

%left '+' '-'
%left '*' '/'

%%

Statement
    : Expression '\n'
      {
          printf("Answer: %.2f\n", $1);
      }
    ;

Expression
    : Expression '+' Expression { $$ = $1 + $3; }
    | Expression '-' Expression { $$ = $1 - $3; }
    | Expression '*' Expression { $$ = $1 * $3; }
    | Expression '/' Expression { $$ = $1 / $3; }
    | '(' Expression ')'        { $$ = $2; }
    | NUM                       { $$ = $1; }
    ;

%%

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(const char *s)
{
    printf("Invalid Expression\n");
    return 0;
}

