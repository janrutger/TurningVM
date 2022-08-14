


class Exec_no_opcode:
    def __init__(self, tapecommander):
        self.tapecommander = tapecommander

    def returnStatus(self):
        tapeList = {"S"}
        result   = self.tapecommander.do_read(tapeList)
        bit = result["S"]
        if bit == "1":
            return("true")
        if bit == "0":
            return("false")
        if bit == "_":
            return("null")

    def push(self, operand):
        moveLeft = {"ST": "L"}
        writeSeperator = {"ST": "#"}
        writeBit = {}
        self.tapecommander.do_move(moveLeft)
        self.tapecommander.do_write(writeSeperator)
        for bit in operand:
            writeBit["ST"] = bit
            self.tapecommander.do_move(moveLeft)
            self.tapecommander.do_write(writeBit)
        return("oke")    

    def print(self, tapeList):
        resultValue = {}
        resultValue = self.tapecommander.print_tape(tapeList)
        return(resultValue)


    def pull(self):
        result = ""
        move = {"ST": "R"}
        writeBlank = {"ST": "_"}
        bit = self.tapecommander.do_read({"ST"})

        while bit["ST"] != "#" and bit["ST"] != "_":
            result = bit["ST"] + result
            self.tapecommander.do_write(writeBlank)
            self.tapecommander.do_move(move)
            bit = self.tapecommander.do_read({"ST"})

        self.tapecommander.do_write(writeBlank)
        self.tapecommander.do_move(move)

        return(result)