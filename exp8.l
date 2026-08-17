%{
#include "exp8.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

"int"           { return INT; }
"float"         { return FLOAT; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    return ID;
}

[0-9]+ {
    yylval.str = strdup(yytext);
    return NUM;
}

"="     { return '='; }
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
";"     { return ';'; }

[ \t\n]+    ;

.       { return yytext[0]; }

%%
