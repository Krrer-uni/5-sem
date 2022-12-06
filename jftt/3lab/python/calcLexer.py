base = 1234577

tokens = (
    'NUM',
    'IGNORE',
    'ERROR',
    'NEWLINE',
    'COMMENT',
)

literals = ['=', '+', '-', '*', '/', '(', ')','\n']

# Tokens

def t_NUM(t):
    r'\d+'
    t.value = int(t.value)
    return t

t_ignore = " \t"


def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)
