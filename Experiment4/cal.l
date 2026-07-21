%{
#include "cal.tab.h"
#include <stdlib.h>
%}

DIGIT [0-9]+

%option noyywrap

%%

{DIGIT} {
    yylval.dval = atof(yytext);
    return NUM;
}

\n      { return '\n'; }

[ \t]   ;

.       { return yytext[0]; }

%%
