# -----------------------------------------------------------------------------
# calc.py
#
# A simple calculator with variables.   This is from O'Reilly's
# "Lex and Yacc", p. 63.
# -----------------------------------------------------------------------------
import galois

# SETUP
base = 1234577
pbase = base-1
output = ""
GF = galois.GF(1234577)

def to_gf(a, n):
    while a < 0:
        a+=n
    while a >= n:
        a -= n
    return a

def gcdExtended(a, b):
    # Base Case
    if a == 0 :
        return b,0,1
             
    gcd,x1,y1 = gcdExtended(b%a, a)
     
    # Update x and y using results of recursive
    # call
    x = y1 - (b//a) * x1
    y = x1
     
    return gcd,x,y


import sys
sys.path.insert(0, "../..")



###################LEXER#############################


tokens = (
    'NUMBER',
    'COMMENT',
)

literals = ['=', '+', '-', '*', '/', '(', ')','^']

# Tokens

t_ignore = " \t"
def t_ignore_breakline(t):
    r'\\'
    pass

def t_ignore_COMMENT(t):
     r'\#.*\n'
     pass

def t_NUMBER(t):
    r'\d+'
    t.value = int(t.value)
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")


def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# Build the lexer
import ply.lex as lex
lex.lex()
lexer = lex.lex(debug=1)
#####################PARSER########################

precedence = (
    ('left', '+', '-'),
    ('left', '*', '/'),
    ('right', 'UMINUS'),
    ('right', '^'),
)



def p_statement_expr(p):
    'statement : expression'
    global output
    print(output,"\nWynik: ", p[1])
    output = ""


def p_expression_binop(p):
    '''expression : expression '+' expression
                  | expression '-' expression
                  | expression '*' expression
                  | expression '/' expression
                  | expression '^' pow_exp '''
    global output
    if p[2] == '+':
        p[0] = p[1] + p[3]
        output+="+ "
    elif p[2] == '-':
        p[0] = p[1] - p[3]
        output+="- "
    elif p[2] == '*':
        p[0] = p[1] * p[3]
        output+="* "
    elif p[2] == '/':
        p[0] = p[1] / p[3]
        output+="/ "
    elif p[2] == '^':
        p[0] = pow(p[1], int(p[3]))
        output+="^ "


def p_expression_uminus(p):
    "expression : '-' expression %prec UMINUS"
    p[0] = -p[2]


def p_expression_group(p):
    "expression : '(' expression ')'"
    p[0] = p[2]


def p_expression_number(p):
    "expression : number"
    p[0] = GF(to_gf(p[1],base))
    global output
    output+=str(p[0])+" "

##################POW_ARITHM#####################
def p_pow_exp_binop(p):
    '''pow_exp : pow_exp '+' pow_exp
                  | pow_exp '-' pow_exp
                  | pow_exp '*' pow_exp
                  | pow_exp '/' pow_exp'''
    global output
    if p[2] == '+':
        p[0] = (p[1] + p[3])%pbase
        output+="+ "
    elif p[2] == '-':
        p[0] = (p[1] - p[3])%pbase
        output+="- "
    elif p[2] == '*':
        p[0] = (p[1] * p[3])%pbase
        output+="* "
    elif p[2] == '/':
        k,x,y = gcdExtended(pbase,p[3])
        if k != 1:
            print(p[3], " nie jest odwracalny w GF(",pbase,")")
            return
        p[0] = (p[1] * y)%pbase
        output+="/ "

def p_pow_exp_uminus(p):
    "pow_exp : '-' pow_exp %prec UMINUS"
    p[0] = -p[2]


def p_pow_exp_group(p):
    "pow_exp : '(' pow_exp ')'"
    p[0] = p[2]


def p_pow_exp_number(p):
    "pow_exp : number"
    p[0] = to_gf(p[1],pbase)
    global output
    output+=str(p[0])+" "

############NUMBER####################

def p_number(p):
    '''number   : '-' NUMBER %prec UMINUS
                | NUMBER'''
    global output
    if p[1] == '-':
        p[0] = -p[2]
    else :
        p[0] = p[1]


def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()


while 1:
    lines = ""
    while 1:
        try:
            lines += input()
        except EOFError:
            break
        lines += '\n'
        if not lines.endswith('\\\n'):
            
            yacc.parse(lines)
            break
    
