base = 1234577

tokens = (
    'NUMBER',
    'PLUS',
    # 'MINUS',
    # 'TIMES',
    # 'DIVIDE',
    # 'LPAREN',
    # 'RPAREN',

    'IGNORE',
    'ERROR',
    'NEWLINE',
    'COMMENT',
)

t_PLUS = r'\+'

def t_NUMBER(t):
    r'\d+'
    t.value = int(t.value)
    return t

t_ignore = " \t"


def t_NEWLINE(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_ERROR(t):
    
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)
