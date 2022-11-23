import time

class Keyboard:
    def __init__(self, memory):
        self.memory  = memory
        self.online = False

        self.stringTable = {}
        self.stringTable["null"] = 0
        self.stringTable["+"] = 1
        self.stringTable["."] = 2
        self.stringTable["halt"] = 900
        



    def tokenice(self,text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                decimal = int(token)
                #binary = bin(decimal)[2:]
                code.append(decimal)
                code.append("0")            # a 0 means number on stack is integer
            elif token in self.stringTable:
                code.append(self.stringTable[token])
                code.append("1")            # a 1 means number on stack is referance to a Module
            else:
                pass                        # A UNKOWN token
            
        return(code)


    def input(self):
        inputLine = input("...>>")
        tokens =self.tokenice(inputLine)
        return(tokens)


    def start(self, IObuff):
        self.online = True
        
        while self.online:
            if self.memory.waitForInput:
                tokens = self.input()
                for token in tokens:
                    self.memory.writeIObuff(IObuff, token)
                self.memory.waitForInput = False
            else:
                time.sleep(1)

  

    def stop(self):
        self.online = False