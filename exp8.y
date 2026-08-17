%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

struct sym
{
    char name[20];
    char type[10];
} table[50];

int n = 0;

void insert(char *name,char *type)
{
    strcpy(table[n].name,name);
    strcpy(table[n].type,type);
    n++;
}

char* typeOf(char *name)
{
    for(int i=0;i<n;i++)
    {
        if(strcmp(table[i].name,name)==0)
            return table[i].type;
    }

    return "undefined";
}
%}

%union
{
    char *str;
}

%token <str> ID NUM
%token INT FLOAT

%type <str> expr

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
      decl
    |
      assign
    ;

decl
    :
      INT ID ';'
        {
            insert($2,"int");
        }
    |
      FLOAT ID ';'
        {
            insert($2,"float");
        }
    ;

assign
    :
      ID '=' expr ';'
      {
          char *lt = typeOf($1);

          if(strcmp(lt,"undefined")==0)
              printf("Undefined variable : %s\n",$1);

          else if(strcmp(lt,$3)==0)
              printf("No type mismatch\n");

          else
              printf("Type mismatch\n");
      }
    ;

expr
    :
      ID
      {
          char *t = typeOf($1);

          if(strcmp(t,"undefined")==0)
              printf("Undefined variable : %s\n",$1);

          $$ = t;
      }
    |
      NUM
      {
          $$ = "int";
      }
    |
      expr '+' expr
      {
          $$ = (strcmp($1,$3)==0)?$1:"mismatch";
      }
    |
      expr '-' expr
      {
          $$ = (strcmp($1,$3)==0)?$1:"mismatch";
      }
    |
      expr '*' expr
      {
          $$ = (strcmp($1,$3)==0)?$1:"mismatch";
      }
    |
      expr '/' expr
      {
          $$ = (strcmp($1,$3)==0)?$1:"mismatch";
      }
    ;

%%

int main()
{
    printf("Enter declarations and assignments:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}
