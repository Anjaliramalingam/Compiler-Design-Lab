%{
#include "exp10.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

[a-zA-Z][a-zA-Z0-9]* {
    yylval.str = strdup(yytext);
    return ID;
}

"="     { return '='; }
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
";"     { return ';'; }

[ \t\n]+ ;

.       { return yytext[0]; }

%%
