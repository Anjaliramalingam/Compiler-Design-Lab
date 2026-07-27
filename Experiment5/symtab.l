%{
#include &lt;stdio.h&gt;
#include &lt;string.h&gt;
#include &lt;stdlib.h&gt;
struct symtab {
char name[30];
int type;
} symtab[100];
int sc = 0;
int lookup(char *s) {
int i;
for (i = 0; i &lt; sc; i++)
if (strcmp(symtab[i].name, s) == 0)
return i;
return -1;

}
void insert(char *s) {
if (lookup(s) == -1) {
strcpy(symtab[sc].name, s);
symtab[sc].type = 1;
sc++;
}
}
%}
DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*
%%
&quot;/*&quot;([^*]|\*+[^*/])*\*+&quot;/&quot; { printf(&quot;Comment : %s\n&quot;, yytext); }
&quot;//&quot;.* { printf(&quot;Comment : %s\n&quot;, yytext); }
{ID} { insert(yytext); printf(&quot;Identifier : %s\n&quot;, yytext); }
{DIGIT}+ { printf(&quot;Constant : %s\n&quot;, yytext); }
&quot;+&quot;|&quot;-&quot;|&quot;*&quot;|&quot;/&quot;|&quot;=&quot;|&quot;&lt;&quot;|&quot;&gt;&quot; { printf(&quot;Operator : %s\n&quot;, yytext); }
[ \t\n] { /* skip whitespace */ }
. { /* ignore other characters */ }
%%
int yywrap() { return 1; }
int main(int argc, char *argv[]) {
if (argc &lt; 2) {
printf(&quot;Usage: %s &lt;input file&gt;\n&quot;, argv[0]);
return 1;
}
yyin = fopen(argv[1], &quot;r&quot;);
if (!yyin) {
printf(&quot;Cannot open file %s\n&quot;, argv[1]);
return 1;
}
yylex();
printf(&quot;\nSYMBOL TABLE\n&quot;);
printf(&quot;S.No\tName\n&quot;);
int i;
for (i = 0; i &lt; sc; i++)
printf(&quot;%d\t%s\n&quot;, i + 1, symtab[i].name);
fclose(yyin);
return 0;
}
