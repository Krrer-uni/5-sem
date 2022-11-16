%{
#include<stdio.h> 

int yywrap(); 
int yylex();
int NL=0;
int WC=0;
%} 

%%
^([[:blank:]]*) ;
[[:blank:]]*$;
[[:blank:]]* printf(" ");
([[:blank:]]|\n)*		{printf("\n"); NL++; };
[^[:blank:]\n]* {printf("%s", yytext ); WC++;};
%%

int yywrap() { 
    // printf("\n---\n\%d \%d\n",NL,WC); 
    return 1; 
} 

int main() { 
    return yylex(); 
}
