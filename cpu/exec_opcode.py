from cpu import opcodes as oc


class Exec_opcode:
    def __init__(self, tapecommander, ui):
        self.tapecommander = tapecommander
        self.opcodes = self.opcodes = oc.Opcodes()
        self.ui = ui

    def run(self, opcode):
        tapeList = self.opcodes.get_tapelist(opcode)
        state = "START"
        stepCounter = 0

        tapeValues = self.tapecommander.do_read(tapeList)
        turingRules = self.opcodes.get_turingrule(opcode, tapeValues, state)

        if turingRules == -1:
            nextState = "ERROR"
        else:
            writeValue = turingRules[0]
            moveValue = turingRules[1]
            nextState = turingRules[2]

            self.tapecommander.do_write(writeValue)
            self.tapecommander.do_move(moveValue)
            # if self.ui.checkRefresh() == True:
            #     self.ui.send_status(
            #         self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))

            stepCounter = stepCounter + 1
            #tapeprint =self.tapecommander.print_tape({"ST", "RA", "RB", "S"})
            # print(stepCounter,opcode, state, tapeprint, nextState) #JRK hier worden de tape in de console geprint, nog geen UI

        while nextState != "HALT" and nextState != "ERROR":
            state = nextState
            tapeValues = self.tapecommander.do_read(tapeList)
            turingRules = self.opcodes.get_turingrule(
                opcode, tapeValues, state)
            if turingRules == -1:
                nextState = "ERROR"
                break

            writeValue = turingRules[0]
            moveValue = turingRules[1]
            nextState = turingRules[2]

            self.tapecommander.do_write(writeValue)
            self.tapecommander.do_move(moveValue)
            # if self.ui.checkRefresh() == True:
            #     self.ui.send_status(
            #         self.tapecommander.print_tape({"ST", "RA", "RB", "S"}))

            stepCounter = stepCounter + 1
            # if self.tapecommander.CPUspeed > 0 or nextState == "HALT":
            #     tapeprint = self.tapecommander.print_tape(
            #         {"ST", "RA", "RB", "S"})
            #     # print(stepCounter,opcode, state, tapeprint, nextState) #JRK hier worden de tape in de console geprint, nog geen UI
            #     pass
            # else:
            #     #print(stepCounter, opcode, state, ">", nextState)
            #     pass

        return (nextState)  # do something smarter over here
