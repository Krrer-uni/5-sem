%{
#include<stdio.h> 

int yywrap(); 
int yylex();
int NL=0;
int WC=0;
%} 

%%
"\"\"\""([^(\")]|.[^(\")]|..[^(\")]|\n)*"\"\"\""\n? printf("%s",yytext);
"\"""\\\n"?[^"\""]*"\"" printf("%s",yytext);
"\'""\\\n"?[^"\'"]*"\'" printf("%s",yytext);
[[:blank:]]*"#"(.*)\n ;
%%

int yywrap() { 
    return 1; 
} 

int main() { 
    return yylex(); 
}
