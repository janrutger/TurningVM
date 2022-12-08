import time

class Keyboard:
    def __init__(self, memory):
        self.memory  = memory
        self.online = False

        # self.stringTable = {}
        # self.stringTable["null"] = 0
        # self.stringTable["+"] = 1
        # self.stringTable["-"] = 2
        # self.stringTable["*"] = 3
        # self.stringTable["/"] = 4
        # self.stringTable["%"] = 5
        # self.stringTable["."] = 6
        
        # self.stringTable["halt"] = 9
        # self.stringTable["xyz"] = 10
        



    def tokenice(self,text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                decimal = int(token)
                #binary = bin(decimal)[2:]
                code.append(decimal)
                code.append("0")            # a 0 means number on stack is integer
            elif token in self.memory.stringTable:
                code.append(self.memory.stringTable[token])
                code.append("1")            # a 1 means number on stack is referance to a string
            else:
                self.tokenice('null')       # A UNKOWN token return null
            
        return(code)


    def input(self):
        inputLine = input("...>>")
        if inputLine == '':
            inputLine = 'null'
        tokens =self.tokenice(inputLine)
        return(tokens)


    def start(self, IObuff):
        self.online = True
        
        while self.online:
            if self.memory.waitForInput == IObuff:
                tokens = self.input()
                for token in tokens:
                    self.memory.writeIObuff(IObuff, token)
                self.memory.waitForInput = "REQ-done"
            else:
                time.sleep(1)

  

    def stop(self):
        self.online = False