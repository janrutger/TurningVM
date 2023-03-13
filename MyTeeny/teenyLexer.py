from lex import *

def main():
    input = " . .. 5 AS REPEAT DO  END PRINT PLOT INPUT LABEL GOTO DEFINE { } + - * / % ! GCD == != < > DUP SWAP OVER DEL a test1 999 "
    input = "5 AS a {a 0 !=} REPEAT a PRINT a 1 - AS a END a PRINT"

    lexer = Lexer(input)

    token = lexer.getToken()
    while token.kind != TokenType.EOF:
        print(token.kind, token.text)
        token = lexer.getToken()

main()


