import sys
from lex import *

# Parser object keeps track of current token and checks if the code matches the grammar.
class Parser:
    def __init__(self, lexer, emitter):
        self.lexer = lexer
        self.emitter = emitter

        self.symbols = set()    # All variables we have declared so far.
        self.labelsDeclared = set() # Keep track of all labels declared
        self.labelsGotoed = set() # All labels goto'ed, so we know if they exist or not.

        self.curToken = None
        self.peekToken = None
        self.labelnumber = -1 
        self.nextToken()
        self.nextToken()    # Call this twice to initialize current and peek.

    def LabelNum(self):
        self.labelnumber = self.labelnumber + 1
        return(str(self.labelnumber))

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
        self.emitter.headerLine("@main")
        self.emitter.headerLine("call @stackssys")

        # Since some newlines are required in our grammar, need to skip the excess.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()

        # Parse all the statements in the program.
        while not self.checkToken(TokenType.EOF):
            self.statement()

        # Wrap things up.
        self.emitter.emitLine("ret")

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
            self.nextToken()

            # Make sure this label doesn't already exist.
            if self.curToken.text in self.labelsDeclared:
                self.abort("Label already exists: " + self.curToken.text)
            self.labelsDeclared.add(self.curToken.text)
            self.emitter.emitLine(":" + self.curToken.text)
            self.match(TokenType.IDENT)
            self.nl() 

        # | "GOTO" ident nl
        elif self.checkToken(TokenType.GOTO):
            self.nextToken()
            self.labelsGotoed.add(self.curToken.text)
            self.emitter.emitLine("jump " + ":" + self.curToken.text)
            self.match(TokenType.IDENT)
            self.nl() 

        # | "DEFINE" nl {statement} nl "AS" ident nl
        elif self.checkToken(TokenType.DEFINE):
            pass

        # | "{" ({expression} | st) "}"   "REPEAT"   nl {statement} nl "END" nl	
        elif self.checkToken(TokenType.OPENC):
            num = self.LabelNum()
            self.emitter.emitLine(":_" + num + "_condition_start")
            self.nextToken()  
            if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
                self.st()
            else:
                self.expression()
            self.match(TokenType.CLOSEC)

            self.match(TokenType.REPEAT)
            self.emitter.emitLine("loada")
            self.emitter.emitLine("testz")
            self.emitter.emitLine("jumpf " + ":_" + num + "_repeat_end")
            #self.nextToken()
            self.nl()
            while not self.checkToken(TokenType.END):
                self.statement()
                
            self.emitter.emitLine("jump " + ":_" + num + "_condition_start")
            self.emitter.emitLine(":_" + num + "_repeat_end")
            self.emitter.emitLine("clra")
            self.match(TokenType.END)
            self.nl()

        
        
        # | ({expression} | st) ( "PRINT" nl | "PLOT" nl | "AS" ident nl | "DO"   nl {statement} nl "END" nl | "GOTO" ident) nl | nl )
        else: #it must be an expression
            if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
                self.st()
            else:
                self.expression()
            
            if self.checkToken(TokenType.PRINT):
                self.emitter.emitLine("prt")
                self.nextToken()
                self.nl()
            elif self.checkToken(TokenType.PLOT):
                self.emitter.emitLine("call @plot")
                self.nextToken()
                self.nl()
            elif self.checkToken(TokenType.AS):
                self.nextToken()
                if self.curToken.text not in self.symbols:
                    self.symbols.add(self.curToken.text)
                    #self.emitter.headerLine("push " + "'" + self.curToken.text + "'")
                    #self.emitter.headerLine("set $MEM")
                
                #self.emitter.emitLine("push " + "'" + self.curToken.text + "'")
                #self.emitter.emitLine("storei")
                self.emitter.emitLine("storem " + "$" + self.curToken.text)
                self.match(TokenType.IDENT)  
                self.nl()
            elif self.checkToken(TokenType.DO):
                num = self.LabelNum()
                self.nextToken()
                self.emitter.emitLine("loada")
                self.emitter.emitLine("testz")
                self.emitter.emitLine("jumpf " + ":_" + num + "_do_end")
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                self.match(TokenType.END)
                self.emitter.emitLine(":_" + num + "_do_end")
                self.emitter.emitLine("clra")
                self.nl()
            elif self.checkToken(TokenType.GOTO):
                num = self.LabelNum()
                self.nextToken()
                self.emitter.emitLine("loada")
                self.emitter.emitLine("testz")
                self.emitter.emitLine("jumpf " + ":_" + num + "_goto_end")
                self.emitter.emitLine("jump " + ":" + self.curToken.text)
                self.emitter.emitLine(":_" + num + "_goto_end")
                self.emitter.emitLine("clra")
                self.match(TokenType.IDENT)  
                self.nl()   
            else:
                self.nl()

    # expression ::=	INTEGER | word | ident
    def expression(self):
        while self.checkToken(TokenType.NUMBER) or self.checkToken(TokenType.WORD) or self.checkToken(TokenType.IDENT):
            if self.checkToken(TokenType.NUMBER):
                self.emitter.emitLine("push " + self.curToken.text)
                self.nextToken()
            elif self.checkToken(TokenType.IDENT):
                self.ident()
            else:  #Must be an word
                self.word()
        


    # word ::=	 ('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'POP'|'INPUT')
    def word(self):
        if self.curToken.text == '+':
            self.emitter.emitLine("call @plus")
            self.nextToken()
        elif self.curToken.text == '/':
            self.emitter.emitLine("call @div")
            self.nextToken()
        elif self.curToken.text == '==':
            self.emitter.emitLine("call @eq")
            self.nextToken()
        elif self.curToken.text == '!=':
            self.emitter.emitLine("call @neq")
            self.nextToken()
        elif self.curToken.text == 'GCD':
            self.emitter.emitLine("call @_gcd")
            self.nextToken()
        else:
            self.emitter.emitLine("push " + "'" + self.curToken.text + "'")
            self.emitter.emitLine("calli")
            self.nextToken()

    # ident ::=	STRING
    def ident(self):
        if self.curToken.text not in self.symbols:
                self.abort("Referencing variable before assignment: " + self.curToken.text)
        #self.emitter.emitLine("push " + "'" + self.curToken.text + "'")
        #self.emitter.emitLine("loadi")
        self.emitter.emitLine("loadm " + "$" + self.curToken.text)

        self.nextToken()

    # st ::= ('.'|'..')
    def st(self):
        if self.checkToken(TokenType.DDOT):
            self.emitter.emitLine("call @dup") #duplicate Top Off Stack
        else:
            pass #use Top Off Stack

        self.nextToken()

    
    # nl ::= '\n'+
    def nl(self):
        # Require at least one newline.
        self.match(TokenType.NEWLINE)
        # But we will allow extra newlines too, of course.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()