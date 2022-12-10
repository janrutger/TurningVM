from assembler import ASMcompiler as c


class Assembler:
    def __init__(self):
        self.compiler = c.Compiler()

    def readASM(self, filename):
        ASMfile = []
        file = open(filename, "r")
        for line in file:
            ASMfile.append(line.strip())
        file.close()
        return (ASMfile)

    def compile(self, ASMfile):
        program = self.compiler.parseProgram(ASMfile)
        # print(program)
        program = self.compiler.ProcesLabels(program)
        # print(program)
        BINprogram = self.compiler.ProcesLines(program)
        stringTable = str(self.compiler.stringTable)

        BINprogram.insert(0, str(stringTable))
        print(BINprogram)

        return (BINprogram)

    def execute(self, programFile):
        pass
