# import threading
import time

from cpu import tapecommander as tc
from cpu import exec_no_opcode as nop
from cpu import exec_opcode as op
from cpu import timers as ti


class Executer:
    def __init__(self, memory, ui):
        self.memory = memory
        self.tape_commander = tc.Tapecommander()
        self.execNOP = nop.Exec_no_opcode(self.tape_commander)
        self.execOP = op.Exec_opcode(self.tape_commander)
        self.timers = ti.Timers(self.tape_commander)
        self.ui = ui #need this for prt instruction
        self.pc = int(0)
        self.ControlC = False

    def refresh_tapes(self, tapes):
        return self.execNOP.print(tapes)

    def is_str(self, v):
        return type(v) is str

    def run_commando(self, commando, operand):
        try:
            if self.is_str(operand):
                return eval("self." + commando.lower() + "(\'" + operand + "\')")
            else:
                return eval("self." + commando.lower() + "(" + str(operand) + ")")
        except:
            exit_code = self.execOP.run(commando)
            self.pc = self.pc + 1
            return exit_code

    def input(self, operand):
        val = self.memory.input(operand)
        self.execNOP.push(val)
        self.pc = self.pc + 1
        return "HALT"
    
    def output(self, operand):
        val = self.memory.output(operand)
        self.pc = self.pc + 1
        return "HALT"

    def iobuff(self, operand):
        self.memory.makeStack("IObuff", operand)
        self.pc = self.pc + 1
        return "HALT"

    def lifo(self, operand):
        self.memory.makeStack("LIFO", operand)
        self.pc = self.pc + 1
        return "HALT"

    def array(self, operand):
        self.memory.array(operand)
        self.pc = self.pc + 1
        return "HALT"

    def index(self, operand):
        if isinstance(operand, int):
            self.memory.index(self.execNOP.pull(), operand + self.pc)
        else:
            self.memory.index(self.execNOP.pull(), operand)
        self.pc = self.pc + 1
        return "HALT"

    def set(self, operand):
        index = self.execNOP.pull()
        self.memory.set(operand, index)
        self.pc = self.pc + 1
        return "HALT"

    def readelm(self, operand):
        index = self.execNOP.pull()
        exit_code = self.memory.readElement(operand, index)
        if exit_code == "no-element" or exit_code == "adres-element":
            self.execNOP.status("unset")
        else:
            self.execNOP.push(exit_code)
            self.execNOP.status("set")
        self.pc = self.pc + 1 
        return "HALT"

    def readelmi(self, operand):
        adres = self.execNOP.pull()
        index = self.execNOP.pull()
        exit_code = self.memory.readElement(adres, index)
        if exit_code == "no-element" or exit_code == "adres-element":
            self.execNOP.status("unset")
        else:
            self.execNOP.push(exit_code)
            self.execNOP.status("set")
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

    def sti(self, operand):
        index = self.execNOP.pull()
        val = self.execNOP.pull()
        self.memory.writeMem(index, val)
        self.pc = self.pc + 1
        return "HALT"

    def prt(self, operand):
        val = self.execNOP.pull()
        text2print = int(val, 2)
        self.ui.println(text2print)
        #print("-->", int(val, 2))
        self.pc = self.pc + 1
        return "HALT"

    def ldi(self, operand):
        index =self.execNOP.pull()
        val =self.memory.readMem(index)
        self.execNOP.push(val)
        self.pc = self.pc +1
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
        index = self.execNOP.pull()
        adres = self.memory.readMem(index)
        self.pc = adres
        return "HALT"

    def ret(self, operand):
        adres = self.memory.readMem("%_system")
        self.pc = adres + 1
        return "HALT"
    
    def job(self, operand):
        index  = self.execNOP.pull()        #get adrespointer from stack
        #memVal = self.memory.peek(index)    #peek geheugen
        memVal = ('$n', 5)
        self.jobID = self.jobID + 1
        jobID  = str(self.cpuID) + str(self.jobID)
        self.jobQueue.append((jobID, memVal, operand))
        self.jobsPending.append(jobID)
        self.pc = self.pc + 1
        return "HALT"

    def start(self, operand):
        if len(self.jobQueue) == 0:
            self.execNOP.status("unset")
            print("no job")
        else:
            self.execNOP.status("set")
            print(self.jobQueue.pop())
        self.pc = self.pc + 1
        return "HALT"

    def speed(self, operand):
        self.tape_commander.CPUspeed = 0.001 * operand
        self.pc = self.pc + 1
        return "HALT"

    def nop(self, operand):
        self.pc = self.pc + 1
        return "HALT"

    def settimer(self, operand):
        self.timers.set(operand)
        self.pc = self.pc + 1
        return "HALT"
    
    def prttimer(self, operand):
        val = self.timers.print(operand)
        text2print = str(val)
        self.ui.println(text2print)
        self.pc = self.pc + 1
        return "HALT"

    def gettimer(self, operand):
        val = self.timers.gettime(operand)
        exit_code = self.execNOP.push(bin(val)[2:])
        self.pc = self.pc + 1
        return exit_code

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
        self.ControlC = False

        while exit_code != "CPUstopped" and self.ControlC == False:
            address_value = self.memory.readMem(self.pc)
            #print(self.pc, address_value[0], address_value[1])
            #step = input()
            exit_code = self.run_commando(address_value[0], address_value[1])
            #time.sleep(0.01)

        if self.ControlC == True:
            self.ui.println("ctrl-C")

        if exit_code == "CPUstopped":
            #step = input()
            return "HALT"
        else:
            return "error"
        

    def enable_mpu(self, jobQueue, jobResults, cpuID):
        self.cpuID = cpuID
        self.jobID = 0
        self.jobsPending = []
        self.jobQueue   = jobQueue
        self.jobResults = jobResults

    def memPage(self):
        return self.memory
