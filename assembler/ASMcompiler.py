from assembler import ASMschema as schema


class Compiler:
    def __init__(self):
        self.ASMschema = schema.loadSchema()
        self.labels = {}

        self.stringTable = {}
        self.stringTable["null"] = 0
        self.stringTable["+"] = 1
        self.stringTable["."] = 2
        self.stringTable["halt"] = 900

    def checkOperand(self, operandType, operand_, progLen):
        if operand_[0] == ":":                      # operand is a mem label
            return(self.labels[operand_] - progLen)
        if operand_[0] == "$":                      # operand is mem adres
            return(str(operand_))
        if operand_[0] == "%":                      # operand is mem stack adres
            return(str(operand_))
        if operand_[0] == "@":                      # operand is a symbol
            return(str(operand_))
        #if operand_ == "plotter":
        #    return("plotter")
        if operand_[0]==operand_[-1]=="'":
            return(bin(self.stringTable[operand_[1:-1]])[2:])
        if operand_.isnumeric():                    # operand is numeriek
            if operandType == "n":
                return(int(operand_))
            if operandType == "b":
                b = int(operand_)
                return(bin(b)[2:])
            else:
                return("error")
        if isinstance((int(operand_, 2)), int):     # input is binair
            if operandType == "b":
                return(operand_[2:])
            if operandType == "n":
                return(int(operand_, 2))
        else:                                       # input is string (dit lijkt niet te werken)
            if operandType == "b":
                return("error")
            if operandType == "n":
                return("error")
            
        

    def parseProgram(self, program):
        newProgram = []
        for line in program:
            if line == "" or line[0] == "#":
                pass
            else:
                newProgram.append(line)
        return(newProgram)

    def ProcesLabels(self, program):
        newProgram = []
        linenumber = 0
        for line in program:
            if line[0] == "@":
                # symbol = line.split()[0]
                # newProgram.append(symbol)
                newProgram.append(line)
            elif line[0] == ":":
                label = line.split()[0]
                self.labels[label] = linenumber
            else:
                newProgram.append(line)
                linenumber = linenumber + 1
        return(newProgram)

    def ProcesLines(self, program):
        newProgram = []
        linenumber = 0

        for line in program:
            if line[0] == "@":
                newProgram.append(line)
            else:
                opcode_ = line.split()[0].lower()
                if len(line.split()) >= 2:
                    operand_ = line.split()[1]
                else:
                    operand_ = None
                
                if opcode_ not in self.ASMschema.keys():
                    return("error")
                else:
                    opcode = self.ASMschema[opcode_][0]
                    if operand_ == None:
                        operand = ""
                    else:
                        operandType = self.ASMschema[opcode_][1]
                        operand = self.checkOperand(operandType, operand_, linenumber)
                    newProgram.append((opcode,operand))
                    linenumber = linenumber +1

        return(newProgram)

