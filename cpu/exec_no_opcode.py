class Exec_no_opcode:
    def __init__(self, tapecommander, ui):
        self.tapecommander = tapecommander
        self.ui = ui

    def returnStatus(self):
        tape_list = {"S"}
        result = self.tapecommander.do_read(tape_list)
        bit = result["S"]
        if bit == "1":
            return "true"
        if bit == "0":
            return "false"
        if bit == "_":
            return "null"

    def status(self, switch):
        write_set = {"S": "1"}
        write_unset = {"S": "0"}
        if switch == "set":
            self.tapecommander.do_write(write_set)
        elif switch == "unset":
            self.tapecommander.do_write(write_unset)
        #self.ui.send_status(self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))



    def push(self, operand):
        move_left = {"ST": "L"}
        write_separator = {"ST": "#"}
        write_bit = {}
        self.tapecommander.do_move(move_left)
        self.tapecommander.do_write(write_separator)
        #self.ui.send_status(self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))

        for bit in operand:
            write_bit["ST"] = bit
            self.tapecommander.do_move(move_left)
            self.tapecommander.do_write(write_bit)
            #self.ui.send_status(self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))

        return "oke"

    def print(self, tapeList):
        return self.tapecommander.print_tape(tapeList)

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
            #self.ui.send_status(self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))


        self.tapecommander.do_write(writeBlank)
        self.tapecommander.do_move(move)
        #self.ui.send_status(self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))


        return (result)
