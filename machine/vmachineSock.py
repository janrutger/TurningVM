#!/usr/bin/env python
# coding: utf-8

"""
Example:
: fact dup 1 != if dup 1 - fact * then ;

"""
from __future__ import print_function
import sys
import copy

from multiprocessing import Process, Manager
from cpu.executer import Executer




class Machine:
    def __init__(self, executer, ui):
        self.cpu0 = executer
        self.ui = ui 

        self.word_map = {}
        self.dispatch_map = {
            "%": self.mod,
            "*": self.mul,
            "+": self.plus,
            "-": self.minus,
            "!": self.fac,
            "/": self.div,
            "=": self.eq,
            "!=": self.neq,
            "drop": self.drop,
            "dup": self.dup,
            "over": self.over,
            "swap": self.swap,
            ".": self.println,
            "init": self.init,
            "main": self.main,
            "halt": self.halt,
            "mpu": self.mpu
        }


    def pop(self):
        val = self.cpu0.run_commando('PULL', None)
        value = int(val, 2)
        return value

    def push(self, value):
        value = (bin(value)[2:])
        self.cpu0.run_commando('PUSH', value)

    def top(self):
        value = self.pop()
        self.push(value)
        return value

    def tokenice(self, text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                code.append(int(token))
            else:
                code.append(token)
        return (code)

    def parse(self, code):
        _code = copy.copy(code)
        while len(_code) > 0:
            opcode = _code.pop(0)
            if opcode == ":":
                wordcode = []
                word = str(_code.pop(0))
                nextToken = _code.pop(0)
                while nextToken != ";":
                    wordcode.append(nextToken)
                    nextToken = _code.pop(0)
                self.word_map[word] = wordcode
            elif str(opcode) in self.word_map:
                wordCode = self.word_map[str(opcode)]
                _code = wordCode + _code
            elif opcode == "do":
                indexVal = self.pop()
                countVal = self.pop()
                doCode = []
                nextToken = _code.pop(0)
                while nextToken != "loop":
                    doCode.append(nextToken)
                    nextToken = _code.pop(0)
                while countVal != indexVal:
                    _code = doCode + _code
                    countVal = countVal - 1
            elif opcode == "if":
                trueValue = self.pop()
                if trueValue == 0:  # True
                    ifCode = []
                    nextToken = _code.pop(0)
                    while nextToken != "then":
                        ifCode.append(nextToken)
                        nextToken = _code.pop(0)
                    # self.parse(ifCode)
                    _code = ifCode + _code
                else:  # False
                    nextToken = _code.pop(0)
                    while nextToken != "then":
                        nextToken = _code.pop(0)
            else:
                self.dispatch(opcode)

    def dispatch(self, op):
        # if str(op) in self.word_map:
        #     self.parse(self.word_map[str(op)])
        if op in self.dispatch_map:
            self.dispatch_map[op]()
        elif isinstance(op, int):
            self.push(op)  # push numbers on stack
        elif isinstance(op, str) and op[0] == op[-1] == '"':
            self.push(op[1:-1])  # push quoted strings on stack
        else:
            raise RuntimeError("Unknown opcode: '%s'" % op)


    def mpuEnable(self):
        self.CPUS = []
        manager = Manager()
        self.jobQueue = manager.list()
        self.jobResults = manager.dict()

        self.initCode = [('LIFO', '%_system'), ('CALL', '@core'), ('HALT', '')]

        #self.cpu0.run_rpc([('LIFO', '%_system'), ('IOBUFF', '%_display'),('IOBUFF', '%_xygraph'),('CALL', '@__MemAllocGlobels'), ('HALT', '')])
        self.cpu0.run_rpc([('LIFO', '%_system'),('CALL', '@__MemAllocGlobels'), ('HALT', '')])
        self.memPage0 = self.cpu0.memPage()
        self.cpu0.enable_mpu(self.jobQueue, self.jobResults, 0)

    def mpuStart(self):
        self.cpu1 = Executer(self.memPage0, None)
        self.cpu1.enable_mpu(self.jobQueue, self.jobResults, 1)
        CPU1 = Process(target=self.cpu1.run_rpc, args=(self.initCode, ))
        self.CPUS.append(CPU1)
        CPU1.start()

        self.cpu2 = Executer(self.memPage0, None)
        self.cpu2.enable_mpu(self.jobQueue, self.jobResults, 2)
        CPU2 = Process(target=self.cpu2.run_rpc, args=(self.initCode, ))
        self.CPUS.append(CPU2)
        CPU2.start()

        self.cpu3 = Executer(self.memPage0, None)
        self.cpu3.enable_mpu(self.jobQueue, self.jobResults, 3)
        CPU3 = Process(target=self.cpu3.run_rpc, args=(self.initCode, ))
        self.CPUS.append(CPU3)
        CPU3.start()
        

    def repl(self):
        self.mpuEnable()
        self.ui.println('Type "halt" to quit.')


        while True:
            try:
                self.ui.println("ok>")
                source = self.ui.get_input()
                #print(source)
                code = list(self.tokenice(source))
                self.parse(code)
                # self.ui.send_status(
                #     self.cpu0.refresh_tapes({"ST", "RA", "RB", "S"}))
            except (RuntimeError, IndexError) as e:
                print("IndexError: %s" % e)
            except KeyboardInterrupt:
                print("\nKeyboardInterrupt")

    # OPERATIONS FOLLOW:

    def plus(self):
        # self.push(self.pop() + self.pop())
        self.cpu0.run_rpc([('CALL', '@plus'), ('HALT', '')])

    def halt(self):
        self.ui.println("Halting...")
        for cpu in self.CPUS:
            cpu.terminate()
            cpu.join()

        self.ui.println("HALTED")
        sys.exit(0)
        #exit()

    def main(self):
        self.cpu0.run_rpc([('CALL', '@main'), ('HALT', '')])

    def init(self):
        # self.cpu0.run_rpc([('SPEED', 1), ('CLRA', ''), ('CLRB', ''), ('IOBUFF', '%_plotter'), ('OUTPUT', '%_plotter'), ('IOBUFF', '%_kbd'),
        #                    ('LIFO', '%_system'), ('HALT', '')])
        self.cpu0.run_rpc([('LIFO', '%_system'), ('CALL', '@init_vmachine'), ('SPEED', 300), ('HALT', '')])

    def minus(self):
        self.cpu0.run_rpc([('CALL', '@minus'), ('HALT', '')])

    def mul(self):
        self.cpu0.run_rpc([('CALL', '@mul'), ('HALT', '')])

    def fac(self):
        self.cpu0.run_rpc([('CALL', '@factorial'), ('HALT', '')])

    def div(self):
        self.cpu0.run_rpc([('CALL', '@div'), ('HALT', '')])

    def mod(self):
        self.cpu0.run_rpc([('CALL', '@mod'), ('HALT', '')])

    def eq(self):
        self.cpu0.run_rpc([('CALL', '@eq'), ('HALT', '')])

    def neq(self):
        self.cpu0.run_rpc([('CALL', '@neq'), ('HALT', '')])

    def dup(self):
        self.cpu0.run_rpc([('CALL', '@dup'), ('HALT', '')])
        #self.push(self.top())

    def over(self):
        self.cpu0.run_rpc([('CALL', '@over'), ('HALT', '')])

    def drop(self):
        self.pop()

    def swap(self):
        self.cpu0.run_rpc([('CALL', '@swap'), ('HALT', '')])

    def println(self):
        val = str(self.pop())
        self.ui.println(val)

    def mpu(self):
        #self.mpuEnable()
        self.mpuStart()
        
