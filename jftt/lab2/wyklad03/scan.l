%{
#include<stdio.h> 

int yywrap(); 
int yylex();
int NL=0;
%} 
%%
^[[:blank:]]*register[[:blank:]]+	; 
long[[:blank:]]+int	printf("long"); 
unsigned[[:blank:]]+int	printf("unsigneasd int"); 
signed[[:blank:]]+int	printf("int"); 
\n			{ printf("\n"); NL++; }
%%
int yywrap() { 
    printf("---\n\%d\n",NL); 
    return 1; 
} 
int main() { 
    return yylex(); 
}
