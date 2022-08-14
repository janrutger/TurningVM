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
                memType, memVal = self.memory[self.virtMemAdresses[adres]]
                if memType == "MEM":
                    return(memVal)
                if memType == "LIFO":
                    memVal_ = memVal.pop()
                    return(memVal_)
                else:
                    return("error: unknow memtype")
            else:
                return("error")

    def writeMem(self, adres, memVal):
        if isinstance(adres, int):
            self.memory[adres] = memVal
        else:      
            if adres in self.virtMemAdresses.keys():
                memType, memVal_ = self.memory[self.virtMemAdresses[adres]]
                if memType == "MEM":
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal)
                if memType == "LIFO":
                    memVal_.append(memVal)
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal_)
                else:
                    return("error: unknow memtype")

            if adres not in self.virtMemAdresses.keys() and adres[0] == "$":
                self.virtMemAdresses[adres] = len(self.memory)
                self.memory.append(("MEM", memVal))
            else:
                return("error")
    

    def makeStack(self, memType, adres):
        memVal = []
        if adres not in self.virtMemAdresses.keys() and adres[0] == "%":
            self.virtMemAdresses[adres] = len(self.memory)
            self.memory.append((memType, memVal))
        else:
            return("error")