%{
#include<stdio.h> 
#include<stdbool.h>
#define STACK_SIZE 100
int yywrap(); 
int yylex();
int stack[STACK_SIZE];
int stack_top = -1;
int NL=0;
int WC=0;
bool pop_error_flag = false;
bool push_error_flag = false;
bool wrong_char_flag = false;
bool divide_zero_flag = false;

int pop(){
    if(stack_top == -1){
        pop_error_flag = true;
        return 0;
    }
    return stack[stack_top--];
}

int push(int number){
    if(stack_top == STACK_SIZE-1){
        
        push_error_flag = true;
        return 0;
    }
    stack[++stack_top] = number;
    return 1;
}

%} 
DIGIT [0-9]
NUMBER [1-9][0-9]*
OPERATOR [+-%/^]
%%

[[:blank:]]*-?[0-9]+ {push(atoi(yytext));}

[[:blank:]]*\+ {
    int a = pop();
    int b = pop();
    push(b + a);
}

[[:blank:]]*- {
    int a = pop();
    int b = pop();
    push(b - a);
}

[[:blank:]]*\* {
    int a = pop();
    int b = pop();
    push(b * a);
}

[[:blank:]]*\/ {
    int a = pop();
    int b = pop();
    if(a == 0){
        push(1);
        divide_zero_flag = true;
    }
    else{
        push(b / a);
    }
    
}

[[:blank:]]*% {
    int a = pop();
    int b = pop();
        if(a == 0){
        push(1);
        divide_zero_flag = true;
    }
    else{
        push(b % a);
    }
}

[[:blank:]]*\n {
    int result = pop();
    if(stack_top >= 0){
        printf("ERROR too few operators\n");
    }else if(pop_error_flag == true){
        printf("ERROR too few arguments\n");
    }else if(push_error_flag == true){
        printf("ERROR stack overflow\n");
    }else if(wrong_char_flag == true){
        printf("ERROR illegal character\n");
    }else if(divide_zero_flag = true){
        printf("ERROR division by 0\n");
    }else {
        printf("%d\n",result);
    }
    divide_zero_flag = false;
    pop_error_flag = false;
    push_error_flag = false;
    stack_top = -1;
}

[^[[DIGIT]|[OPERATOR]|\n|[[:blank:]]]] wrong_char_flag=true;

%%

int yywrap() { 
    return 1; 
} 

int main() { 
    return yylex(); 
}
