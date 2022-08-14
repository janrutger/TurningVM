class MMU:
    def __init__(self):
        self.memory = []
        self.virtMemAdresses = {}


    def loadMem(self, binProgram):
        i = 0
        while i < len(binProgram):
            self.memory.append(binProgram[i])
            i = i + 1
        

    def dumpMem(self):
        return(self.memory)
        

    def readMem(self, adres):
        if isinstance(adres, int):
            return(self.memory[adres])
        else:
            if adres in self.virtMemAdresses.keys():
                return(self.memory[self.virtMemAdresses[adres]][1])
            else:
                return("error")

    def writeMem(self, adres, memVal):
        if isinstance(adres, int):
            self.memory[adres] = memVal
        else:      
            if adres in self.virtMemAdresses.keys():
                self.memory[self.virtMemAdresses[adres]] = ("MEM", memVal)
            if adres not in self.virtMemAdresses.keys() and adres[0] == "$":
                self.virtMemAdresses[adres] = len(self.memory)
                self.memory.append(("MEM", memVal))
            else:
                return("error")
    

