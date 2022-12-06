%option noyywrap
%option yylineno
%{
#include "calc_y.h"
#include "string.h"
int yylex();
%}
%%
[ \t]+ 	;
[0-9]+  	{ yylval.NUM = atoi(yytext); return NUM; }
\+	{ return '+'; }
-	{ return '-'; }
\*	{ return '*'; }
\/	{ return '/'; }
\^  { return '^'; }
\(	{ return '('; }
\)	{ return ')'; }
\\[ \t]*\n { return BREAKLINE;}
\n  { return '\n'; }
#   { return '#'; }
.   { return CHAR; }
%%