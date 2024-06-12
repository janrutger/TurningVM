# Emitter object keeps track of the generated code and outputs it.
class Emitter:
    def __init__(self, out):
        self.fullPath = "../assembler/out.asm"
        self.header = ""
        self.code = ""
        self.functions = ""
        self.allocGLOBELS = ""
        self.context = "program"

    def emit(self, code):
        self.code += code

    def emitLine(self, code):
        if self.context == "program":
            self.code += code + '\n'
        else:
            self.functions += code + '\n'

    def memLine(self, code):
        self.allocGLOBELS += code + '\n'

    def headerLine(self, code):
        self.header += code + '\n'

    def writeFile(self):
        with open(self.fullPath, 'w') as outputFile:
            outputFile.write(self.header + self.code + self.functions + self.allocGLOBELS)