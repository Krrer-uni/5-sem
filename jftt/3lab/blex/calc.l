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
\+	{ return ADD; }
-	{ return SUB; }
\*	{ return MUL; }
\/	{ return DIV; }
\^  { return POW; }
\(	{ return '('; }
\)	{ return ')'; }
\n  { return '\n'; }
%%