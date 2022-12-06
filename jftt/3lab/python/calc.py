from ply import lex, yacc

import calcLexer
import calcParser


def main():
    lexer = lex.lex(module=calcLexer)
    parser = yacc.yacc(module=calcParser)
    while True:
        text = ""
        while True:
            try:
                text += input()
            except EOFError:
                return
            text +='\n'
            if not text.endswith('\\\n'):
                break
            parser.parse(text, lexer = lexer)


if __name__ == "__main__":
    main()