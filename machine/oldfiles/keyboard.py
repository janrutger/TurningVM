import time

class Keyboard:
    def __init__(self, memory):
        self.memory  = memory
        self.online = False




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
                code.append(self.memory.stringTable['null'])
                code.append("1")       # a 1 means number on stack is referance to a string
               
            
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