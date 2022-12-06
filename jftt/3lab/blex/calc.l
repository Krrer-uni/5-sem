%option noyywrap
%option yylineno
%{
#include "calc_y.hh"
#include "string.h"
int yylex();
%}
%%
[ \t]+ 	;
(\\[ \t]*\n)+ ;
[0-9]+  	{ yylval.NUM = atoi(yytext); return NUM; }
\+	{ return '+'; }
-	{ return '-'; }
\*	{ return '*'; }
\/	{ return '/'; }
\^  { return '^'; }
\(	{ return '('; }
\)	{ return ')'; }
\n  { return '\n'; }
#   { return '#'; }
.   { return CHAR; }
%%