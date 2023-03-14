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
        print("STATEMENT")
        # Check the first token to see what kind of statement this is.
        #   "LABEL" ident nl
        if self.checkToken(TokenType.LABEL):
            print("STATEMENT-LABEL")
            self.nextToken()

            # Make sure this label doesn't already exist.
            if self.curToken.text in self.labelsDeclared:
                self.abort("Label already exists: " + self.curToken.text)
            self.labelsDeclared.add(self.curToken.text)
            print(self.curToken.text)
            self.match(TokenType.IDENT)
            self.nl() 

        # | "GOTO" ident nl
        elif self.checkToken(TokenType.GOTO):
            print("STATEMENT-GOTO")
            self.nextToken()
            self.labelsGotoed.add(self.curToken.text)
            print(self.curToken.text)
            self.match(TokenType.IDENT)
            self.nl() 

        # | "DEFINE" nl {statement} nl "AS" ident nl
        elif self.checkToken(TokenType.DEFINE):
            pass

        # | "{" ({expression} | st) "}"   "REPEAT"   nl {statement} nl "END" nl	
        elif self.checkToken(TokenType.OPENC):
            print("STATEMENT-open")
            self.nextToken()  
            if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
                self.st()
            else:
                self.expression()
            
            self.match(TokenType.CLOSEC)

            self.match(TokenType.REPEAT)
            print("Repeat")
            self.nextToken()
            #self.nl()
            self.statement()
            print("End")
            self.match(TokenType.END)
            self.nl()

        
        
        # | ({expression} | st) ( "PRINT" nl | "PLOT" nl | "AS" ident nl | "DO"   nl {statement} nl "END" nl | "GOTO" ident) nl | nl )
        else: #it must be an expression
            if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
                self.st()
            else:
                self.expression()
            
            if self.checkToken(TokenType.PRINT):
                print("Print")
                self.nextToken()
                self.nl()
            elif self.checkToken(TokenType.PLOT):
                print("Plot")
                self.nextToken()
                self.nl()
            elif self.checkToken(TokenType.AS):
                print("As")
                self.nextToken()
                print(self.curToken.text)
                self.match(TokenType.IDENT)  
                self.nl()
            elif self.checkToken(TokenType.DO):
                print("Do")
                self.nextToken()
                self.nl()
                self.statement()
                print("End")
                self.match(TokenType.END)
                self.nl()
            elif self.checkToken(TokenType.GOTO):
                print("Goto")
                self.nextToken()
                self.labelsGotoed.add(self.curToken.text)
                print(self.curToken.text)
                self.match(TokenType.IDENT)  
                self.nl()   
            else:
                self.nl()

    # expression ::=	INTEGER | word | ident
    def expression(self):
        print("EXPRESSION")
        while self.checkToken(TokenType.NUMBER) or self.checkToken(TokenType.WORD) or self.checkToken(TokenType.IDENT):
            if self.checkToken(TokenType.NUMBER):
                print("Number")
                self.nextToken()
            elif self.checkToken(TokenType.IDENT):
                self.ident()
            else:  #Must be an word
                self.word()
        


    # word ::=	 ('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'POP'|'INPUT')
    def word(self):
        print("word")
        self.nextToken()

    # ident ::=	STRING
    def ident(self):
        print("ident")
        self.nextToken()

    # st ::= ('.'|'..')
    def st(self):
        print("st")
        self.nextToken()

    
    # nl ::= '\n'+
    def nl(self):
        print("Newline")

        # Require at least one newline.
        self.match(TokenType.NEWLINE)
        # But we will allow extra newlines too, of course.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()