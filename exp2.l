%{
#include <stdio.h>

extern FILE *yyin;
%}

KEYWORD     int|float|char|double|void|for|while|if|else|return|struct|switch|case|break|do
ID          [a-zA-Z_][a-zA-Z0-9_]*
NUM         [0-9]+

%%

"#include"                 { printf("Preprocessor Directive : %s\n", yytext); }
"<"[a-zA-Z0-9_.]+">"       { printf("Header File : %s\n", yytext); }

{KEYWORD}                  { printf("Keyword : %s\n", yytext); }
{ID}                       { printf("Identifier : %s\n", yytext); }
{NUM}                      { printf("Number : %s\n", yytext); }

"=="|"<="|">="             { printf("Operator : %s\n", yytext); }
"+"|"-"|"*"|"/"|"="|"<"|">" { printf("Operator : %s\n", yytext); }

"("                        { printf("Delimiter : %s\n", yytext); }
")"                        { printf("Delimiter : %s\n", yytext); }
"{"                        { printf("Delimiter : %s\n", yytext); }
"}"                        { printf("Delimiter : %s\n", yytext); }
";"                        { printf("Delimiter : %s\n", yytext); }
","                        { printf("Delimiter : %s\n", yytext); }

[ \t\n]+                   ;

.                           ;

%%

int yywrap()
{
    return 1;
}

int main(int argc,char *argv[])
{
    if(argc<2)
    {
        printf("Usage: %s <input file>\n",argv[0]);
        return 1;
    }

    yyin=fopen(argv[1],"r");

    if(yyin==NULL)
    {
        printf("Cannot open file\n");
        return 1;
    }

    yylex();

    fclose(yyin);

    printf("\nEnd of File\n");

    return 0;
}
