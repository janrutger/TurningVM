import enum
import sys

class Lexer:
    def __init__(self, input):
        self.source = input + '\n' # Source code to lex as a string. Append a newline to simplify lexing/parsing the last token/statement.
        self.curChar = ''   # Current character in the string.
        self.curPos = -1    # Current position in the string.
        self.nextChar()

    # Process the next character.
    def nextChar(self):
        self.curPos += 1
        if self.curPos >= len(self.source):
            self.curChar = '\0'  # EOF
        else:
            self.curChar = self.source[self.curPos]

    # Return the lookahead character.
    def peek(self):
        if self.curPos + 1 >= len(self.source):
            return '\0'
        return self.source[self.curPos+1]

    # Invalid token found, print error message and exit.
    def abort(self, message):
        print("Lexing error. " + message)
        sys.exit("Lexing error. " + message)
		
    # Skip whitespace except newlines, which we will use to indicate the end of a statement.
    def skipWhitespace(self):
        while self.curChar == ' ' or self.curChar == '\t' or self.curChar == '\r':
            self.nextChar()
		
    # Skip comments in the code.
    def skipComment(self): 
        if self.curChar == '#':
            while self.curChar != '\n':
                self.nextChar()

    # Return the next token.
    def getToken(self):
        self.skipWhitespace()
        self.skipComment()
        token = None

        # Check the first character of this token to see if we can decide what it is.
        # If it is a multiple character operator (e.g., !=), number, identifier, or keyword then we will process the rest.
        if self.curChar == '+':
            token = Token(self.curChar, TokenType.WORD)
        elif self.curChar == '-':
            token = Token(self.curChar, TokenType.WORD)
        elif self.curChar == '*':
            token = Token(self.curChar, TokenType.WORD)
        elif self.curChar == '/':
            token = Token(self.curChar, TokenType.WORD)
        elif self.curChar == '%':
            token = Token(self.curChar, TokenType.WORD)
        elif self.curChar == '{':
            token = Token(self.curChar, TokenType.OPENC)
        elif self.curChar == '}':
            token = Token(self.curChar, TokenType.CLOSEC)

        elif self.curChar == '=':
            # Check whether this token is = or ==
            if self.peek() == '=':
                lastChar = self.curChar
                self.nextChar()
                token = Token(lastChar + self.curChar, TokenType.WORD)
            else:
                self.abort("Expected ==, got =" + self.peek())

        elif self.curChar == '>':
            # Check whether this is token is > or >=
            # if self.peek() == '=':
            #     lastChar = self.curChar
            #     self.nextChar()
            #     token = Token(lastChar + self.curChar, TokenType.GTEQ)
            # else:
            #     token = Token(self.curChar, TokenType.GT)
            token = Token(self.curChar, TokenType.WORD)

        elif self.curChar == '<':
                # Check whether this is token is < or <=
                # if self.peek() == '=':
                #     lastChar = self.curChar
                #     self.nextChar()
                #     token = Token(lastChar + self.curChar, TokenType.LTEQ)
                # else:
                #     token = Token(self.curChar, TokenType.LT)
                token = Token(self.curChar, TokenType.WORD)

        elif self.curChar == '!':
            if self.peek() == '=':
                lastChar = self.curChar
                self.nextChar()
                token = Token(lastChar + self.curChar, TokenType.WORD)
            else:
                #self.abort("Expected !=, got !" + self.peek())
                token = Token(self.curChar, TokenType.WORD)
    
        elif self.curChar == '.':
            if self.peek() == '.':
                lastChar = self.curChar
                self.nextChar()
                token = Token(lastChar + self.curChar, TokenType.DDOT)
            else:
                token = Token(self.curChar, TokenType.DOT)

        elif self.curChar == '\"':
            # Get characters between quotations.
            self.nextChar()
            startPos = self.curPos

            while self.curChar != '\"':
                # Don't allow special characters in the string. No escape characters, newlines, tabs, or %.
                # We will be using C's printf on this string.
                if self.curChar == '\r' or self.curChar == '\n' or self.curChar == '\t' or self.curChar == '\\' or self.curChar == '%':
                    self.abort("Illegal character in string.")
                self.nextChar()

            tokText = self.source[startPos : self.curPos] # Get the substring.
            token = Token(tokText, TokenType.STRING)

        elif self.curChar.isdigit():
            # Leading character is a digit, so this must be a number.
            # Get all consecutive digits and decimal if there is one.
            startPos = self.curPos
            while self.peek().isdigit():
                self.nextChar()
            # if self.peek() == '.': # Decimal!
            #     self.nextChar()

            #     # Must have at least one digit after decimal.
            #     if not self.peek().isdigit(): 
            #         # Error!
            #         self.abort("Illegal character in number.")
            #     while self.peek().isdigit():
            #         self.nextChar()

            tokText = self.source[startPos : self.curPos + 1] # Get the substring.
            token = Token(tokText, TokenType.NUMBER)
        elif self.curChar.isalpha():
            # Leading character is a letter, so this must be an identifier or a keyword.
            # Get all consecutive alpha numeric characters.
            startPos = self.curPos
            while self.peek().isalnum():
                self.nextChar()

            # Check if the token is in the list of keywords.
            tokText = self.source[startPos : self.curPos + 1] # Get the substring.
            keyword = Token.checkIfKeyword(tokText)

            if keyword == None: # Identifier
                token = Token(tokText, TokenType.IDENT)
            else:   # Keyword
                if tokText in ['GCD','DUP','SWAP','OVER','DEL','INPUT']:
                    token = Token(tokText, TokenType.WORD)
                else:
                    token = Token(tokText, keyword)

        elif self.curChar == '\n':
            token = Token(self.curChar, TokenType.NEWLINE)
        elif self.curChar == '\0':
            token = Token('', TokenType.EOF)
        else:
            # Unknown token!
            self.abort("Unknown token: " + self.curChar)
			
        self.nextChar()
        return token


# Token contains the original text and the type of token.
class Token:   
    def __init__(self, tokenText, tokenKind):
        self.text = tokenText   # The token's actual text. Used for identifiers, strings, and numbers.
        self.kind = tokenKind   # The TokenType that this token is classified as.

    @staticmethod
    def checkIfKeyword(tokenText):
        for kind in TokenType:
            # Relies on all keyword enum values being 1XX.
            if kind.name == tokenText and kind.value >= 100 and kind.value < 200:
                return kind
        return None


# TokenType is our enum for all the types of tokens.
class TokenType(enum.Enum):
    WORD = -2
    EOF = -1
    NEWLINE = 0
    NUMBER = 1
    IDENT = 2
    STRING = 3
# Keywords.
    LABEL = 101
    GOTO = 102
    PRINT = 103
    INPUT = 104
    DEFINE = 106
    AS = 107
    PLOT = 108
    DO = 109
    REPEAT = 110
    END = 111
    OPENC = 112
    CLOSEC = 113
# Operators.
    GCD = 114
    DUP = 115
    SWAP = 116
    OVER = 117
    DEL = 118
    PLUS = 201
    MINUS = 202
    ASTERISK = 203
    SLASH = 204
    BANG = 205
    DOT = 207
    DDOT =208
    EQEQ = 210
    NOTEQ = 211
    LT = 212
    GT = 213
    PCT = 214
    
