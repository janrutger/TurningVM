import sys
from lexV3 import *

# Parser object keeps track of current token and checks if the code matches the grammar.
class Parser:
    def __init__(self, lexer, emitter):
        self.lexer = lexer
        self.emitter = emitter

        self.symbols = set()    # All variables we have declared so far.
        self.functions = set()  #jrk: All functions we have declared so far.
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

    # program    ::=	[(define)] {statement}
    def program(self):
        self.emitter.headerLine("@main")
        self.emitter.headerLine("settimer 0")
        self.emitter.headerLine("speed 0")

        # Since some newlines are required in our grammar, need to skip the excess.
        while self.checkToken(TokenType.NEWLINE):
            self.nextToken()

        # Check is the source starts with the optional difinition block (DEFINE)
        # define     ::= "DEFINE" nl
        if self.checkToken(TokenType.DEFINE):
            self.match(TokenType.DEFINE)
            self.nl()
            self.defineBlock()

        # Parse all the statements in the program.
        while not self.checkToken(TokenType.EOF):
            self.statement()

        # Wrap things up.
        self.emitter.emitLine("prttimer 0")
        self.emitter.emitLine("ret")

        # Check that each label referenced in a GOTO is declared.
        for label in self.labelsGotoed:
            if label not in self.labelsDeclared:
                self.abort("Attempting to GOTO to undeclared label: " + label)

    def defineBlock(self):
        # [ (("VALUE" [INTEGER] variable nl) )+ ]
        while self.checkToken(TokenType.VALUE):
            if self.checkPeek(TokenType.NUMBER): #init with number
                self.match(TokenType.VALUE)
                self.emitter.headerLine("push " + self.curToken.text)
                self.match(TokenType.NUMBER)
            else: #init with 0
                self.match(TokenType.VALUE)
                self.emitter.headerLine("push " + str(0))
            # assign to
            if self.curToken.text not in self.symbols and self.curToken.text not in self.functions:
                    self.symbols.add(self.curToken.text)
            if self.curToken.text in self.symbols:
                self.emitter.headerLine("storem " + "$" + self.curToken.text)
                self.match(TokenType.IDENT)  
                self.nl()
            else:
                self.abort("Already in use, but this is verry strange at this point: " + self.curToken.text)
        # [ ("FUNCTION" function nl {statement} <nl> "END" nl)+ ]
        while self.checkToken(TokenType.FUNCTION):
            self.match(TokenType.FUNCTION)
            if self.curToken.text not in self.symbols and self.curToken.text not in self.functions:
                self.functions.add(self.curToken.text)
            if self.curToken.text in self.functions:
                self.emitter.context = "functions"
                self.emitter.emitLine("@~" + self.curToken.text)
                self.match(TokenType.IDENT)
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                self.match(TokenType.END)
                self.emitter.emitLine("ret")
                self.emitter.context = "program"
                self.nl()
            else:
                self.abort("Already in use as a Variable: " + self.curToken.text)
        # [ ("JOB" job "USE" (variable) nl {statement} <nl> "RETURN" (variable) nl)+ ]



        if self.checkToken(TokenType.END):
            self.match(TokenType.END)
            self.nl()
        else:
            self.abort("Wrong keyword VALUE/FUNCTION/JOB allowd or missing END statement: " + self.curToken.text)

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

        # | "TIMER" INTEGER("SET" | "PRINT" | "GET")
        elif self.checkToken(TokenType.TIMER):
            self.nextToken()
            var = self.curToken.text
            self.match(TokenType.NUMBER)
            if int(var) < 16:
                self.abort("User defined timers starts at number 16, not " + var)
            if self.checkToken(TokenType.SET):
                self.emitter.emitLine("settimer " + var)
            elif self.checkToken(TokenType.PRINT):
                self.emitter.emitLine("prttimer " + var)
            elif self.checkToken(TokenType.GET):
                self.emitter.emitLine("gettimer " + var)
            self.nextToken()
            self.nl()

        # | "DEFINE" ident nl {statement} nl "END" nl
        elif self.checkToken(TokenType.DEFINE):
            self.nextToken()
            if self.curToken.text not in self.symbols and self.curToken.text not in self.functions:
                self.functions.add(self.curToken.text)
            if self.curToken.text in self.functions:
                self.emitter.context = "functions"
                self.emitter.emitLine("@~" + self.curToken.text)
                self.match(TokenType.IDENT)
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                self.match(TokenType.END)
                self.emitter.emitLine("ret")
                self.emitter.context = "program"
                self.nl()
            else:
                self.abort("Already in use as a Variable " + self.curToken.text)


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
            self.emitter.emitLine("clra")
            self.emitter.emitLine("jumpf " + ":_" + num + "_repeat_end")
            #self.nextToken()
            self.nl()
            while not self.checkToken(TokenType.END):
                self.statement()
                
            self.emitter.emitLine("jump " + ":_" + num + "_condition_start")
            self.emitter.emitLine(":_" + num + "_repeat_end")
            #self.emitter.emitLine("clra")
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
            elif self.checkToken(TokenType.WAIT):
                self.emitter.emitLine("call @sleep")
                self.nextToken()
                self.nl()
            elif self.checkToken(TokenType.AS):
                self.nextToken()
                if self.curToken.text not in self.symbols and self.curToken.text not in self.functions:
                    self.symbols.add(self.curToken.text)
                if self.curToken.text in self.symbols:
                    self.emitter.emitLine("storem " + "$" + self.curToken.text)
                    self.match(TokenType.IDENT)  
                    self.nl()
                else:
                    self.abort("Already in use as a Function " + self.curToken.text)
            elif self.checkToken(TokenType.DO):
                num = self.LabelNum()
                self.nextToken()
                self.emitter.emitLine("loada")
                self.emitter.emitLine("testz")
                self.emitter.emitLine("clra")
                self.emitter.emitLine("jumpf " + ":_" + num + "_do_end")
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                self.match(TokenType.END)
                self.emitter.emitLine(":_" + num + "_do_end")
                #self.emitter.emitLine("clra")
                self.nl()
            elif self.checkToken(TokenType.GOTO):
                num = self.LabelNum()
                self.nextToken()
                self.emitter.emitLine("loada")
                self.emitter.emitLine("testz")
                self.emitter.emitLine("clra")
                self.emitter.emitLine("jumpf " + ":_" + num + "_goto_end")
                self.emitter.emitLine("jump " + ":" + self.curToken.text)
                self.emitter.emitLine(":_" + num + "_goto_end")
                #self.emitter.emitLine("clra")
                self.match(TokenType.IDENT)  
                self.nl()   
            else:
                self.nl()

    # expression ::= INTEGER | STRING | "`" ident "`" | ident | word
    def expression(self):
        while self.checkToken(TokenType.NUMBER) or self.checkToken(TokenType.STRING) or self.checkToken(TokenType.IDENT) or self.checkToken(TokenType.BT) or self.checkToken(TokenType.WORD):
            if self.checkToken(TokenType.NUMBER):
                self.emitter.emitLine("push " + self.curToken.text)
                self.nextToken()
            elif self.checkToken(TokenType.STRING):
                self.emitter.emitLine("push " + "'" + self.curToken.text + "'")
                self.nextToken()
            elif self.checkToken(TokenType.BT):
                self.nextToken()
                self.emitter.emitLine("call " + "@" + self.curToken.text)
                self.match(TokenType.IDENT)
                #self.match(TokenType.BT)
            elif self.checkToken(TokenType.IDENT):
                self.ident()
            else:  #Must be an word
                self.word()
        

    # word ::=	 ('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'DROP'|'INPUT' |'RAWIN')
    def word(self):
        if self.curToken.text == '+':
            self.emitter.emitLine("call @plus")
            self.nextToken()
        elif self.curToken.text == '-':
            self.emitter.emitLine("call @minus")
            self.nextToken()
        elif self.curToken.text == '*':
            self.emitter.emitLine("call @mul")
            self.nextToken()
        elif self.curToken.text == '/':
            self.emitter.emitLine("call @div")
            self.nextToken()
        elif self.curToken.text == '%':
            self.emitter.emitLine("call @mod")
            self.nextToken()
        elif self.curToken.text == '!':
            self.emitter.emitLine("call @factorial")
            self.nextToken()
        elif self.curToken.text == '==':
            self.emitter.emitLine("call @eq")
            self.nextToken()
        elif self.curToken.text == '!=':
            self.emitter.emitLine("call @neq")
            self.nextToken()
        elif self.curToken.text == '<':
            self.emitter.emitLine("call @lt")
            self.nextToken()
        elif self.curToken.text == '>':
            self.emitter.emitLine("call @gt")
            self.nextToken()
        elif self.curToken.text == 'GCD':
            self.emitter.emitLine("call @_gcd")
            self.nextToken()
        elif self.curToken.text == 'DUP':
            self.emitter.emitLine("call @dup")
            self.nextToken()
        elif self.curToken.text == 'OVER':
            self.emitter.emitLine("call @over")
            self.nextToken()
        elif self.curToken.text == 'DROP':
            self.emitter.emitLine("pull")
            self.nextToken()
        elif self.curToken.text == 'SWAP':
            self.emitter.emitLine("call @swap")
            self.nextToken()
        elif self.curToken.text == 'INPUT':
            self.emitter.emitLine("call @input")
            self.nextToken()
        elif self.curToken.text == 'RAWIN':
            self.emitter.emitLine("call @rawin")
            self.nextToken()
        else:
            self.abort("UNKOWN Operator word: " + self.curToken.text)


    # ident ::=	STRING
    def ident(self):
        if self.curToken.text in self.symbols:
            self.emitter.emitLine("loadm " + "$" + self.curToken.text)
        elif self.curToken.text in self.functions:
            self.emitter.emitLine("call " + "@~" + self.curToken.text)
        else:
            self.abort("Referencing variable before assignment: " + self.curToken.text)

        

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