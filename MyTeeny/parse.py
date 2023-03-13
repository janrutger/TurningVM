import sys
from lex import *

# Parser object keeps track of current token and checks if the code matches the grammar.
class Parser:
    def __init__(self, lexer):
        self.lexer = lexer

        self.symbols = set()    # All variables we have declared so far.
        self.labelsDeclared = set() # Keep track of all labels declared
        self.labelsGotoed = set() # All labels goto'ed, so we know if they exist or not.

        self.curToken = None
        self.peekToken = None
        self.nextToken()
        self.nextToken()    # Call this twice to initialize current and peek.

    # Return true if the current token matches.
    def checkToken(self, kind):
        return kind == self.curToken.kind

    # Return true if the next token matches.
    def checkPeek(self, kind):
        return kind == self.peekToken.kind

    # Try to match current token. If not, error. Advances the current token.
    def match(self, kind):
        if not self.checkToken(kind):
            self.abort("Expected " + kind.name + ", got " + self.curToken.kind.name)
        self.nextToken()

    # Advances the current token.
    def nextToken(self):
        self.curToken = self.peekToken
        self.peekToken = self.lexer.getToken()
        # No need to worry about passing the EOF, lexer handles that.

    # Return true if the current token is a comparison operator.
    def isComparisonOperator(self):
        return self.checkToken(TokenType.GT) or self.checkToken(TokenType.GTEQ) or self.checkToken(TokenType.LT) or self.checkToken(TokenType.LTEQ) or self.checkToken(TokenType.EQEQ) or self.checkToken(TokenType.NOTEQ)

    def abort(self, message):
        sys.exit("Error. " + message)


    # Production rules.

    # program    ::=	{statement}
    def program(self):
        print("PROGRAM")

        # Since some newlines are required in our grammar, need to skip the excess.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()

        # Parse all the statements in the program.
        while not self.checkToken(TokenType.EOF):
            self.statement()

        # Check that each label referenced in a GOTO is declared.
        for label in self.labelsGotoed:
            if label not in self.labelsDeclared:
                self.abort("Attempting to GOTO to undeclared label: " + label)

    # statement  ::=  
        # One of the following statements...
    def statement(self):
        # Check the first token to see what kind of statement this is.
        #   "LABEL" ident nl
        if self.checkToken(TokenType.LABEL):
            print("STATEMENT-LABEL")
            self.nextToken()

            # Make sure this label doesn't already exist.
            if self.curToken.text in self.labelsDeclared:
                self.abort("Label already exists: " + self.curToken.text)
            self.labelsDeclared.add(self.curToken.text)

            self.match(TokenType.IDENT)

        # | "GOTO" ident nl
        elif self.checkToken(TokenType.GOTO):
            print("STATEMENT-GOTO")
            self.nextToken()
            self.labelsGotoed.add(self.curToken.text)
            self.match(TokenType.IDENT)

        # | "DEFINE" nl {statement} nl "AS" ident nl
        elif self.checkToken(TokenType.DEFINE):
            pass

        # | "{" ({expression} | st) "}"   "REPEAT"   nl {statement} nl "END" nl	   
        
        
        # | ({expression} | st) ( "PRINT" nl | "PLOT" nl | "AS" ident nl | "DO"   nl {statement} nl "END" nl | "GOTO" ident) nl | nl )
        else: #it must be an expression
            if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
                self.st()
            else:
                self.expression()

    # expression ::=	INTEGER | word | ident
    def expression(self):
        print("EXPRESSION")
        while self.checkToken(TokenType.NUMBER) or self.checkToken(TokenType.WORD) or self.checkToken(TokenType.IDENT):
            if self.checkToken(TokenType.NUMBER):
                print("Number")
            elif self.checkToken(TokenType.IDENT):
                print("Ident")
            else:  #Must be an word
                print("Word")

            self.nextToken()
        self.nl()


    # word ::=	 ('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'POP'|'INPUT')

    # ident ::=	STRING

    # st ::= ('.'|'..')
    def st(self):
        print("st")

    # nl ::= '\n'+
    # nl ::= '\n'+
    def nl(self):
        print("NEWLINE")

        # Require at least one newline.
        self.match(TokenType.NEWLINE)
        # But we will allow extra newlines too, of course.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()