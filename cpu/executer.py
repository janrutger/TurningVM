# import threading
import time

# from christopherUI import tapeLayout
from cpu import tapecommander as tc
from cpu import exec_no_opcode as nop
from cpu import exec_opcode as op


# from cpu import plotter as yplt

class Executer:
    def __init__(self, memory):
        self.memory = memory
        # self.plotter = yplt.Plotter(memory)
        self.tape_commander = tc.Tapecommander()
        self.execNOP = nop.Exec_no_opcode(self.tape_commander)
        self.execOP = op.Exec_opcode(self.tape_commander)
        self.pc = int(0)

    def refresh_tapes(self, tapes):
        return self.execNOP.print(tapes)

    def run_commando(self, commando, operand):
        try:
            return eval(commando.lower())(operand)
        except:
            exit_code = self.execOP.run(commando)
            self.pc = self.pc + 1
            return exit_code

    def input(self, operand):
        self.memory.waitForInput = True
        while self.memory.waitForInput:
            time.sleep(1)
        self.pc = self.pc + 1
        return "HALT"

    def iobuff(self, operand):
        self.memory.makeStack("IObuff", operand)
        self.pc = self.pc + 1
        return "HALT"

    def lifq(self, operand):
        self.memory.makeStack("LIFO", operand)
        self.pc = self.pc + 1
        return "HALT"

    def index(self, operand):
        self.memory.index(self.execNOP.pull(), operand + self.pc)
        self.pc = self.pc + 1
        return "HALT"

    def push(self, operand):
        exit_code = self.execNOP.push(operand)
        self.pc = self.pc + 1
        return exit_code

    def halt(self, operand):
        exit_code = "CPUstopped"
        self.pc = self.pc
        return exit_code

    def pull(self, operand):
        exit_code = self.execNOP.pull()
        self.pc = self.pc + 1
        return exit_code

    def stm(self, operand):
        val = self.execNOP.pull()
        self.memory.writeMem(operand, val)
        self.pc = self.pc + 1
        return "HALT"

    def prt(self, operand):
        val = self.execNOP.pull()
        print("-->", int(val, 2))
        self.pc = self.pc + 1
        return "HALT"

    def ldm(self, operand):
        val = self.memory.readMem(operand)
        self.execNOP.push(val)
        self.pc = self.pc + 1
        return "HALT"

    def jp(self, operand):
        self.pc = operand + self.pc
        return "HALT"

    def jpt(self, operand):
        exit_code = self.execNOP.returnStatus()
        if exit_code == "true":
            self.pc = operand + self.pc
        else:
            self.pc = self.pc + 1
        return exit_code

    def jpf(self, operand):
        exit_code = self.execNOP.returnStatus()
        if exit_code == "false":
            self.pc = operand + self.pc
        else:
            self.pc = self.pc + 1
        return exit_code

    def call(self, operand):
        self.memory.writeMem("%_system", self.pc)
        self.pc = operand + self.pc
        return "HALT"

    def calli(self, operand):
        self.memory.writeMem("%_system", self.pc)
        label = self.execNOP.pull()
        adres = self.memory.readMem(label)
        self.pc = adres
        return "HALT"

    def ret(self, operand):
        adres = self.memory.readMem("%_system")
        self.pc = adres + 1
        return "HALT"

    def speed(self, operand):
        self.tape_commander.CPUspeed = operand
        self.pc = self.pc + 1
        return "HALT"

    def nop(self, operand):
        self.pc = self.pc + 1
        return "HALT"

    def run_rpc(self, program):
        pc = 0
        while pc < len(program):
            self.memory.writeMem(pc, program[pc])
            pc = pc + 1

        pc = 0
        self.run_memory(pc)

    def run_memory(self, pc):
        self.pc = pc
        exit_code = "CPUrunning"

        while exit_code != "CPUstopped":
            address_value = self.memory.readMem(self.pc)
            # print(self.pc, address_value[0], address_value[1])

            exit_code = self.run_commando(address_value[0], address_value[1])

        if exit_code == "CPUstopped":
            return "HALT"
        else:
            return "error"
