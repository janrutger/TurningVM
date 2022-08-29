class Keyboard:
    def __init__(self, memory):
        self.memory  = memory



    def tokenice(self,text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                decimal = int(token)
                binary = bin(decimal)[2:]
                code.append(binary)
                code.append("0")            # a 0 means number on stack is integer
            elif token in self.memory.symbolMap:
                code.append(self.memory.symbolMap[token])
                code.append("1")            # a 1 means number on stack is referance to a Module
            else:
                pass                        # A UNKOWN token
            
        return(code)


    def input(self):
        inputLine = input("...>>")
        tokens =self.tokenice(inputLine)
        print(tokens)

        #self.memory.writeIO()