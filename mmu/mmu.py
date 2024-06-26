import time
import sys

class MMU:
    def __init__(self, ui):
        self.initMem()
        self.ui = ui
        self.waitForInput = "REQ-done"
        self.stringTable = {}

    def loadMem(self, binProgram):
        line = binProgram.pop(0)
        self.stringTable = eval(line)
        if binProgram[0][0] != "@":
            self.initMem()
            self.loader = True
        elif binProgram[0][0] == "@" and self.loader == False:
            bloader = [('SPEED', 1), ('LIFO', '%_system'), ('JP', '@main')]
            for memVal in bloader:
                self.memory.append(memVal)
            self.loader = True

        for line in binProgram:
            if line[0] == "@":
                info = line.split()
                self.symbolTable[info[0]] = len(self.memory)
            else:
                self.memory.append(line)
        print(len(self.memory))

    def initMem(self):
        self.memory = []
        self.virtMemAdresses = {}
        # self.symbolMap ={}
        self.symbolTable = {}
        self.loader = False

    def panic(self, message): #print fatal messsage andsleep forever
        print(message)
        while True:
            time.sleep(1)

    def dumpMem(self):
        return (self.memory)

    def output(self, adres):
        if adres in self.virtMemAdresses.keys():
            memType, memVal = self.memory[self.virtMemAdresses[adres]]
            if memType == "IObuff":
                if adres == '%_plotter':
                    self.ui.output(adres, memVal)
                elif adres == '%_xygraph':
                    self.ui.output(adres, memVal)
                elif adres == '%_display':
                    self.ui.display(self.stringTable, memVal)
                else:
                    self.panic("FATAL: output [unknown device]")
            else:
                self.panic("FATAL: output [unknown memtype]")
        else:
            self.panic("FATAL: output [unknown mem adress]")

    def writeIObuff(self, adres, value):
        if adres in self.virtMemAdresses.keys():
            memType, memVal_ = self.memory[self.virtMemAdresses[adres]]
            if memType == "IObuff":
                memVal_.append(int(value))
                self.memory[self.virtMemAdresses[adres]] = (memType, memVal_)
            else:
                self.panic("FATAL: writeIObuff [unknown memtype]")
        else:
            self.panic("FATAL: writeIObuff [unknown mem adress]")

    def input(self, adres):
        if adres in self.virtMemAdresses.keys():
            memType, memVal = self.memory[self.virtMemAdresses[adres]]
            if memType == "IObuff":
                if len(memVal) == 0:
                    self.ui.println(">")
                    tokens = self.ui.kbdRead(self.stringTable)
                    for token in tokens:
                        self.writeIObuff(adres, token)
                return (self.readMem(adres))
            else:
                self.panic("FATAL: input [unknown memtype]")
        else:
            self.panic("FATAL: input [unknown mem adress]")
    
    def readElement(self, adres, element):
        element = int(element, 2)
        if adres in self.virtMemAdresses.keys():
            memType, memVal = self.memory[self.virtMemAdresses[adres]]
            if memType == "INDEX":  # stores a adress
                if isinstance(memVal, int):
                    return ("adres-element")
                elif memVal in self.virtMemAdresses.keys():
                    return (self.readElement(memVal, bin(element)[2:]))
                else:
                    self.panic("FATAL: readElement [unknown index]")

            elif memType == "MEM":
                if element == 0:
                    return (memVal)
                else:
                    return ("no-element")
            elif memType == "LIFO" :
                if len(memVal) == 0 or len(memVal) <= element:
                    return ("no-element")
                else:
                    memVal_ = memVal[element]
                    if isinstance(memVal_, int):
                        return("adres-element")
                    else:
                        return (memVal_)
            elif memType == "IObuff":
                if len(memVal) == 0 or len(memVal) <= element:
                    return ("no-element")
                else:
                    memVal_ = memVal[element]
                    return (bin(memVal_)[2:])
            elif memType == "ARRAY":
                if len(memVal) == 0 or len(memVal)-1 < element:
                    return ("no-element")
                else:
                    if element == 0:
                        memVal_ = memVal[0]
                        return (bin(memVal_)[2:])
                    else:
                        memVal_ = memVal[element]
                        return (memVal_)
            else:
                self.panic("FATAL: readElement [unknown memtype]")
        else:
            self.panic("FATAL: readElement [unknown adress]" + adres)



    def readMem(self, adres):
        if isinstance(adres, int):
            opcode, operand = self.memory[adres]
            if operand != '' and str(operand)[0] == "@":
                operand = self.symbolTable[operand] - adres
            return ((opcode, operand))
        else:
            if adres in self.virtMemAdresses.keys():
                memType, memVal = self.memory[self.virtMemAdresses[adres]]
                if memType == "INDEX":  # stores a adress
                    if isinstance(memVal, int):
                        return (memVal)
                    elif memVal in self.virtMemAdresses.keys():
                        return (self.readMem(memVal))
                    else:
                        self.panic("FATAL: readMem [unknown index]")

                elif memType == "MEM":  # stores a value
                    return (memVal)
                elif memType == "LIFO":
                    memVal_ = memVal.pop()
                    return (memVal_)
                elif memType == "IObuff":
                    memVal_ = memVal.pop(0)
                    return (bin(memVal_)[2:])
                elif memType == "ARRAY":
                    memVal_ = memVal[0]
                    return (bin(memVal_)[2:])
                else:
                    self.panic("FATAL: readMem [unknown memtype]")
            else:
                self.panic("FATAL: readMem [unknown adress]" + adres)

    def writeMem(self, adres, memVal):
        if isinstance(adres, int):
            self.memory[adres] = memVal
        else:
            if adres in self.virtMemAdresses.keys():
                memType, memVal_ = self.memory[self.virtMemAdresses[adres]]
                if memType == "INDEX":  # stores a adress
                    if memVal_ in self.virtMemAdresses.keys():
                        self.writeMem(memVal_, memVal)
                    else:
                        self.panic("FATAL: WriteMem [unknown index]")

                elif memType == "MEM":
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal)
                elif memType == "LIFO":
                    memVal_.append(memVal)
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal_)
                elif memType == "IObuff":
                    memVal_.append(int(memVal, 2))
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal_)
                elif memType == "ARRAY":
                    memVal_.append(memVal)
                    memVal_[0] = len(memVal_) - 1
                    self.memory[self.virtMemAdresses[adres]] = (memType, memVal_)
                else:
                    self.panic("FATAL: WriteMem [unknown memtype]")

            elif adres[0] == "$":
                self.virtMemAdresses[adres] = len(self.memory)
                self.memory.append(("MEM", memVal))
            else:
                self.panic("FATAL: WriteMem [unknown adres/invalid memtype]" + adres)


    def makeStack(self, memType, adres):
        memVal = []
        if adres not in self.virtMemAdresses.keys() and adres[0] == "%":
            self.virtMemAdresses[adres] = len(self.memory)
            self.memory.append((memType, memVal))
        else:
            self.memory[self.virtMemAdresses[adres]] = (memType, memVal)

    def index(self, adres, memVal):  # adres=stack value, memVal=adress pointer (int, @xx, :nn)
        memType = "INDEX"
        if adres not in self.virtMemAdresses.keys():
            self.virtMemAdresses[adres] = len(self.memory)
            self.memory.append((memType, memVal))
        else:
            self.memory[self.virtMemAdresses[adres]] = (memType, memVal)

    def array(self, adres): #init a array
        memType = "ARRAY"
        memVal = []
        memVal.append(0) # set a empty array, lenght = 0
        if adres not in self.virtMemAdresses.keys() and adres[0] == "*":
            self.virtMemAdresses[adres] = len(self.memory)
            self.memory.append((memType, memVal))
        else:
            self.memory[self.virtMemAdresses[adres]] = (memType, memVal)

    def set(self, memType, index):
        if memType == "$MEM":
            adres = "$_" + index
            self.writeMem(adres, "0")
            self.index(index, adres)
        elif memType == "%LIFO":
            adres = "%_" + index
            self.makeStack("LIFO", adres)
            self.index(index, adres)
        elif memType == "%IObuff":
            adres = "%_" + index
            self.makeStack("IObuff", adres)
            self.index(index, adres)
        elif memType == "*ARRAY":
            adres = "*_" + index
            self.array(adres)
            self.index(index, adres)
        else:
            self.panic("FATAL: set [unknown memtype]")

    def peek(self, adres):
        if isinstance(adres, int):
            self.panic("FATAL: peek [illegal adress]")
        else:
            if adres in self.virtMemAdresses.keys():
                memType, memVal = self.memory[self.virtMemAdresses[adres]]
                if memType == "INDEX":  # Peek a adress
                    if isinstance(memVal, int):
                        self.panic("FATAL: peek [illegal adress]")
                    elif memVal in self.virtMemAdresses.keys():
                        return (self.peek(memVal))
                    else:
                        self.panic("FATAL: peek [unknown index]")
                elif memType == "MEM" or memType == "ARRAY":  # Peek a value
                    return ((adres, self.memory[self.virtMemAdresses[adres]]))
                else:
                    self.panic("FATAL: peek [unknown memtype]")
            else:
                self.panic("FATAL: peek [unknown adress] " + adres)

    def poke(self, pokeVal):
        if pokeVal[0] not in self.virtMemAdresses.keys():
            if pokeVal[1][0] == "MEM":
                self.writeMem(pokeVal[0], "0")
            elif pokeVal[1][0] == "ARRAY":
                self.array(pokeVal[0])
            else:
                self.panic("FATAL: WriteMem [unknown memtype]")
        self.memory[self.virtMemAdresses[pokeVal[0]]] = (pokeVal[1])

