%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token LET DIG

%%

variable : var
         ;

var : var DIG
    | var LET
    | LET
    ;

%%

int main()
{
    printf("Enter the variable:\n");
    yyparse();
    printf("Valid variable\n");
    return 0;
}

void yyerror(const char *s)
{
    printf("Invalid variable\n");
    exit(0);
}
