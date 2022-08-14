from assembler import ASMschema as schema


class Compiler:
    def __init__(self):
        self.ASMschema = schema.loadSchema()
        self.labels = {}

    def checkOperand(self, operandType, operand_, progLen):
        if operand_[0] == ":":                      # input is a mem label
            return(self.labels[operand_] - progLen)
        if operand_[0] == "$":                      # input is mem adres
            return(str(operand_))
        if operand_[0] == "%":                      # input is mem stack adres
            return(str(operand_))
        if operand_.isnumeric():                    # input is numeriek
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
                return(error)
            if operandType == "n":
                return(error)
            
        

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
            if line[0] == ":":
                label = line.split()[0]
                self.labels[label] = linenumber
            else:
                newProgram.append(line)
                linenumber = linenumber + 1
        return(newProgram)

    def ProcesLines(self, program):
        newProgram =[]
        for line in program:
            opcode_ = line.split()[0].lower()
            if len(line.split()) == 2:
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
                    operand = self.checkOperand(operandType, operand_, len(newProgram))
            
                x = (opcode,operand)
                #print(type(x))
                newProgram.append(x)
        return(newProgram)

