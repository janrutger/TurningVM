import sys
from lexV4 import *

# Parser object keeps track of current token and checks if the code matches the grammar.
class Parser:
    def __init__(self, lexer, emitter):
        self.lexer = lexer
        self.emitter = emitter

        self.symbols = set()    # All variables we have declared so far.
        self.arrays = set()     # jrk: All arrayes we have declared so far.
        self.functions = set()  # jrk: All functions we have declared so far.
        self.jobs = set()       # jrk: All jobs we have declared

        self.things = set()     #jrk: All THING things we need
        self.curThing = None
        self.curThis = ""

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

    # Returns true if symbol is not used yet
    def isFreeSymbol(self, symbol):
        return symbol not in self.symbols and symbol not in self.functions and symbol not in self.jobs and symbol not in self.arrays and symbol not in self.things

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
        if self.checkToken(TokenType.DEFINE) and self.checkPeek(TokenType.NEWLINE):
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
        # [ (("VALUE" variable [INTEGER] nl) | ("ARRAY" array ['['(INTEGER)+']'] nl))+ ]
        self.emitter.memLine("@__MemAllocGlobels")
        while self.checkToken(TokenType.VALUE) or self.checkToken(TokenType.ARRAY):
            if self.checkToken(TokenType.VALUE):
                self.match(TokenType.VALUE)
                if self.isFreeSymbol(self.curToken.text):
                    self.symbols.add(self.curToken.text)
                if self.curToken.text in self.symbols:
                    self.emitter.memLine("push " + str(0))
                    self.emitter.memLine("storem " + "$" + self.curToken.text)
                    var = self.curToken.text
                    self.match(TokenType.IDENT)
                else:
                    self.abort("Already in use as Function: " + self.curToken.text)

                if self.checkToken(TokenType.NUMBER):
                    self.emitter.memLine("push " + self.curToken.text)
                    self.emitter.memLine("storem " + "$" + var)
                    self.match(TokenType.NUMBER)
                self.nl()

            elif self.checkToken(TokenType.ARRAY):
                self.match(TokenType.ARRAY)
                if self.isFreeSymbol(self.curToken.text):
                    self.arrays.add(self.curToken.text)
                if self.curToken.text in self.arrays:
                    self.emitter.memLine("array " + "*" + self.curToken.text)
                    arr = self.curToken.text
                    self.match(TokenType.IDENT)
                else:
                    self.abort("Already in use as Variable: " + self.curToken.text)
                
                if self.checkToken(TokenType.OPENBL):
                    self.match(TokenType.OPENBL)
                    while self.checkToken(TokenType.NUMBER):
                        self.emitter.memLine("push " + self.curToken.text)
                        self.emitter.memLine("storem " + "*" + arr)
                        self.match(TokenType.NUMBER)
                    self.match(TokenType.CLOSEBL)
                self.nl()


        # [ ("FUNCTION" function nl {statement} <nl> "END" nl)+ ]
        while self.checkToken(TokenType.FUNCTION):
            self.match(TokenType.FUNCTION)
            if self.isFreeSymbol(self.curToken.text):
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
        
        # [("THING" thing nl
        #   "INIT" nl {statement} nl "END" nl
        #   "THIS" function nl {statement} nl "END" nl
        #  ["THIS" function nl {statement} nl "END" nl] +
        #   "END" nl)+]
        while self.checkToken(TokenType.THING):
            self.match(TokenType.THING)
            if self.isFreeSymbol(self.curToken.text):
                self.things.add(self.curToken.text)
            if self.curToken.text in self.things:
                self.curThing = self.curToken.text
                self.match(TokenType.IDENT)
                self.nl()
        #   "INIT" nl {statement} nl "END" nl
                self.match(TokenType.INIT)
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                self.match(TokenType.END)
                self.nl()
        #   "THIS" function nl {statement} nl "END" nl
        #  ["THIS" function nl {statement} nl "END" nl] +
                while self.checkToken(TokenType.THIS):
                    self.this()
                    symbol = self.curThis + self.curToken.text
                    self.curThis = ""
                    self.match(TokenType.IDENT)

                    if self.isFreeSymbol(symbol):
                        self.functions.add(symbol)
                    if symbol in self.functions:
                        self.emitter.context = "functions"
                        self.emitter.emitLine("@~" + symbol)
                        self.nl()
                        while not self.checkToken(TokenType.END):
                            self.statement()
                        self.match(TokenType.END)
                        self.emitter.emitLine("ret")
                        self.emitter.context = "program"
                        self.nl()
                    else:
                        self.abort("Already in use as a variable, job or function: " + symbol)
                #   "END" nl)+]
                self.curThing = None
                self.curthis  = ""
                self.match(TokenType.END)
                self.nl()
            else:
                self.abort("Already in use as a Somethis: " + self.curThing)



        # [ ("JOB" job "USE" (variable | array) nl {statement} nl "RETURN" (variable | array) nl)+ ]
        while self.checkToken(TokenType.JOB):
            self.match(TokenType.JOB)
            if self.isFreeSymbol(self.curToken.text):
                self.jobs.add(self.curToken.text)
            if self.curToken.text in self.jobs:
                jobName = self.curToken.text
                self.emitter.context = "functions"
                self.emitter.emitLine("@~" + self.curToken.text)
                self.match(TokenType.IDENT)
                self.emitter.memLine("push " + "'jobinput_" + jobName + "'")
                self.match(TokenType.USE)
                if self.curToken.text in self.symbols:
                    self.emitter.memLine("index " + "$" + self.curToken.text)
                    self.match(TokenType.IDENT)
                elif self.curToken.text in self.arrays:
                    self.emitter.memLine("index " + "*" + self.curToken.text)
                    self.match(TokenType.IDENT)            
                else:
                    self.abort(
                        "Referencing variable before assignment: " + self.curToken.text)
                self.nl()
                while not self.checkToken(TokenType.RETURN):
                    self.statement()
                self.match(TokenType.RETURN)
                if self.curToken.text in self.symbols:
                    self.emitter.emitLine("done " + "$" + self.curToken.text)
                    self.match(TokenType.IDENT)
                elif self.curToken.text in self.arrays:
                    self.emitter.emitLine("done " + "*" + self.curToken.text)
                    self.match(TokenType.IDENT)  
                else:
                    self.abort("Referencing variable before assignment: " + self.curToken.text)
                self.emitter.context = "program"
                self.nl()
        if self.checkToken(TokenType.END):
            self.match(TokenType.END)
            self.emitter.memLine("ret")
            self.nl()
        else:
            self.abort("Wrong keyword VALUE/FUNCTION/JOB/THING allowd or missing END statement: " + self.curToken.text)

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

        # | ("DEFINE" | "FUNCTION") function nl {statement} nl "END" nl 
        elif self.checkToken(TokenType.DEFINE) or self.checkToken(TokenType.FUNCTION): 
            self.nextToken()
            if self.isFreeSymbol(self.curToken.text):
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

       	# |   "ARRAY" array['['(INTEGER)+']'] nl
        # |   "ARRAY" [“THIS”] array ['['(INTEGER)+']'] nl
        elif self.checkToken(TokenType.ARRAY):
            self.match(TokenType.ARRAY)

            if self.checkToken(TokenType.THIS):
                self.this()

            if self.checkToken(TokenType.IDENT):
                symbol = self.curThis + self.curToken.text
                self.curThis = ""
            self.match(TokenType.IDENT)

            if self.isFreeSymbol(symbol):
                self.arrays.add(symbol)
            if symbol in self.arrays:
                self.emitter.emitLine("array " + "*" + symbol)
            else:
                self.abort("Already in use as Variable: " + symbol)

            if self.checkToken(TokenType.OPENBL):
                self.match(TokenType.OPENBL)
                while self.checkToken(TokenType.NUMBER):
                    self.emitter.emitLine("push " + self.curToken.text)
                    self.emitter.emitLine("storem " + "*" + symbol)
                    self.match(TokenType.NUMBER)
                self.match(TokenType.CLOSEBL)
            self.nl()
        
        # |   “QUEUE” <job> <nl>
        elif self.checkToken(TokenType.QUEUE):
            self.match(TokenType.QUEUE)
            if self.curToken.text in self.jobs:
                self.emitter.emitLine("push " + "'jobinput_" + self.curToken.text + "'")
                self.emitter.emitLine("job " + "@~" + self.curToken.text)
                self.match(TokenType.IDENT)
                self.nl()

        # |  “JOIN” <nl> 
        elif self.checkToken(TokenType.JOIN):
            self.emitter.emitLine("join")
            self.match(TokenType.JOIN)
            self.nl()

        # |   “RESULT”  nl {statement} nl "END" nl
        elif self.checkToken(TokenType.RESULT):
            num = self.LabelNum()
            self.match(TokenType.RESULT)
            self.emitter.emitLine("result")
            self.emitter.emitLine("jumpf " + ":_" + num + "_no_result")
            self.nl()
            while not self.checkToken(TokenType.END):
                self.statement()
            self.match(TokenType.END)
            self.emitter.emitLine(":_" + num + "_no_result")
            self.nl()
        
        # |   “WITH” array (“EACH” nl {statement} nl "END" | “COPY” array ) nl
        # |   “WITH” array (“EACH” nl {statement} nl "END" | “COPY” array | "PLOT" ["NEW"]) nl
        elif self.checkToken(TokenType.WITH):
            self.match(TokenType.WITH)

            if self.checkToken(TokenType.THIS):
                self.this()

            if self.checkToken(TokenType.IDENT):
                symbol = self.curThis + self.curToken.text
                self.curThis = ""
            self.match(TokenType.IDENT)

            if symbol not in self.arrays:
                self.abort("Referencing variable before assignment: " + self.curToken.text)

            #self.match(TokenType.IDENT)
            # if self.checkToken(TokenType.CLEAR):
            #     self.emitter.emitLine("array " + "*" + array)
            #     self.match(TokenType.CLEAR)
            #     self.nl()
            if self.checkToken(TokenType.EACH):
                num = self.LabelNum()
                self.emitter.emitLine("push " + str(1))
                self.emitter.emitLine("storem " + "$" + "_" + num + "_" + symbol)

                self.emitter.emitLine(":_" + num + "_start_each")
                self.emitter.emitLine("loadm " + "$" + "_" + num + "_" + symbol)
                self.emitter.emitLine("readelm *" + symbol)
                self.emitter.emitLine("jumpf " + ":_" + num + "_end_each")
                self.match(TokenType.EACH)
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()

                self.emitter.emitLine("loadm " + "$" + "_" + num + "_" + symbol)
                self.emitter.emitLine("loadb")
                self.emitter.emitLine("incb")
                self.emitter.emitLine("moveb")
                self.emitter.emitLine("storem " + "$" + "_" + num + "_" + symbol)

                self.emitter.emitLine("jump " + ":_" + num + "_start_each")
                self.emitter.emitLine(":_" + num + "_end_each")
                self.match(TokenType.END)
                self.nl()

            if self.checkToken(TokenType.COPY):
                num = self.LabelNum()
                self.emitter.emitLine("push " + str(1))
                self.emitter.emitLine("storem " + "$" + "_" + num + "_" + symbol)

                self.emitter.emitLine(":_" + num + "_start_copy")
                self.emitter.emitLine("loadm " + "$" + "_" + num + "_" + symbol)
                self.emitter.emitLine("readelm *" + symbol)
                self.emitter.emitLine("jumpf " + ":_" + num + "_end_copy")
                self.match(TokenType.COPY)

                if self.checkToken(TokenType.THIS):
                    self.this()
                if self.checkToken(TokenType.IDENT):
                    symbol2 = self.curThis + self.curToken.text
                    self.curThis = ""
                    self.match(TokenType.IDENT)

                if symbol2 not in self.arrays:
                    self.abort("Referencing variable before assignment: " + symbol2)
                else:
                    self.emitter.emitLine("storem " + "*" + symbol2)


                self.emitter.emitLine("loadm " + "$" + "_" + num + "_" + symbol)
                self.emitter.emitLine("loadb")
                self.emitter.emitLine("incb")
                self.emitter.emitLine("moveb")
                self.emitter.emitLine("storem " + "$" + "_" + num + "_" + symbol)

                self.emitter.emitLine("jump " + ":_" + num + "_start_copy")
                self.emitter.emitLine(":_" + num + "_end_copy")
                self.nl()
            
            if self.checkToken(TokenType.PLOT):
                self.match(TokenType.PLOT)
                if self.checkToken(TokenType.NEW):
                    self.emitter.emitLine("call @plotnew")
                    self.match(TokenType.NEW)
                self.emitter.emitLine("push '_input_plotarray'")
                self.emitter.emitLine("index  *" + symbol)
                self.emitter.emitLine("call @_plotarray")
                self.nl()
                
                

        # | "{" (expression | st) "}" ("REPEAT" | "DO") nl {statement} nl "END" nl
        elif self.checkToken(TokenType.OPENC):
            num = self.LabelNum()
            self.emitter.emitLine(":_" + num + "_condition_start")
            self.nextToken()  #(removing dot and double dot functions V3)
            # if self.checkToken(TokenType.DOT) or self.checkToken(TokenType.DDOT):
            #     self.st()
            # else:
            #     self.expression()
            self.expression()
            self.match(TokenType.CLOSEC)

            #self.match(TokenType.REPEAT)
            if self.checkToken(TokenType.REPEAT) or self.checkToken(TokenType.DO):
                self.nextToken()
                self.emitter.emitLine("loada")
                self.emitter.emitLine("testz")
                self.emitter.emitLine("clra")
                self.emitter.emitLine("jumpf " + ":_" + num + "_repeat_end")
                self.nl()
                while not self.checkToken(TokenType.END):
                    self.statement()
                    
                self.emitter.emitLine("jump " + ":_" + num + "_condition_start")
                self.emitter.emitLine(":_" + num + "_repeat_end")
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
            # | "AS" (variable | '['array']') nl
            # | "AS" [“THIS”] (variable | '['array']') nl
            elif self.checkToken(TokenType.AS):
                self.nextToken()
                if self.checkToken(TokenType.THIS):
                    self.this()
                if self.checkToken(TokenType.IDENT):
                    symbol = self.curThis + self.curToken.text
                    self.curThis = ""
                    self.match(TokenType.IDENT)

                    if self.isFreeSymbol(symbol):
                        self.symbols.add(symbol)
                    if symbol in self.symbols:
                        self.emitter.emitLine("storem " + "$" + symbol)
                        self.nl()
                    else:
                        self.abort("Already in use as a Function " + symbol)
                else:
                    self.match(TokenType.OPENBL)
                    symbol = self.curThis + self.curToken.text
                    self.curThis = ""
                    self.match(TokenType.IDENT)

                    if symbol in self.arrays:
                        self.emitter.emitLine("storem " + "*" + symbol)
                        self.match(TokenType.CLOSEBL)
                        self.nl()
                    else:
                        self.abort(
                            "Referencing variable before assignment: " + symbol)

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
                self.match(TokenType.IDENT)  
                self.nl()   
            else:
                self.nl()

    # expression ::=	(INTEGER | STRING | function | "`"function | variable | array | '['array']' | word)+
    # expression ::=	(INTEGER | STRING | function | "`"function | [“THIS”] variable | [“THIS”] array | [“THIS”] '['array']' | thing function | word)+
    def expression(self):
        while self.checkToken(TokenType.NUMBER) or self.checkToken(TokenType.STRING) or self.checkToken(TokenType.IDENT) or self.checkToken(TokenType.BT) or self.checkToken(TokenType.WORD) or self.checkToken(TokenType.OPENBL) or self.checkToken(TokenType.THIS):
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
            elif self.checkToken(TokenType.THIS):
                self.this() 
            elif self.checkToken(TokenType.OPENBL):
                self.nextToken()
                num = self.LabelNum()

                symbol = self.curThis + self.curToken.text
                self.curThis = ""
                self.match(TokenType.IDENT)

                if symbol in self.arrays:
                    self.emitter.emitLine("readelm " + "*" + symbol)
                    self.emitter.emitLine("jumpt " + ":_" + num + "_readelm_done")
                    self.emitter.emitLine("call " + "@__illegal_Array_Index")
                    self.emitter.emitLine(":_" + num + "_readelm_done")
                    self.match(TokenType.CLOSEBL)
                else:
                    self.abort("Referencing variable before assignment: " + symbol)
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
        elif self.curToken.text == 'DEPTH':
            self.emitter.emitLine("pending")
            self.nextToken()
        else:
            self.abort("UNKOWN Operator word: " + self.curToken.text)


    # ident ::=	STRING
    def ident(self):
        symbol = self.curThis + self.curToken.text
        self.curThis = ""

        if symbol in self.symbols:
            self.emitter.emitLine("loadm " + "$" + symbol)
        elif symbol in self.arrays:
            self.emitter.emitLine("loadm " + "*" + symbol)
        elif symbol in self.functions:
            self.emitter.emitLine("call " + "@~" + symbol)
        elif symbol in self.things:
            thing = symbol
            self.nextToken()
            function = self.curToken.text
            #self.match(TokenType.IDENT)
            self.emitter.emitLine("call " + "@~(" + thing + ")_" + function )
        else:
            self.abort("Referencing variable before assignment: " + symbol)
        self.nextToken()

    # THIS
    def this(self):
        if self.curThing == None:
            self.abort("Using THIS outside a THING is not allowd")
        else:
            self.curThis = "(" + self.curThing + ")_"
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