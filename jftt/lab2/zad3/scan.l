%{
#include<stdio.h> 

int yywrap(); 
int yylex();
int NL=0;
int WC=0;
int debug_flag = 1;
%} 

%%
"/""\\\n"?\/[^!\/](.*|(\\)\n)*(.*)\n {};
"/*"[^\*!]([^\*]|(\*[^/]))*"*/"((\n)?) {};
"/*"[\*!]([^\*]|(\*[^/]))*"*/"((\n)?) {if(debug_flag) printf("%s",yytext);};
"/""\\\n"?"/""\\\n"?[!\/](.*|(\\)\n)*(.*)\n {if(debug_flag) printf("%s",yytext);};

%%

int yywrap() { 
    return 1; 
} 

int main() { 
    return yylex(); 
}
