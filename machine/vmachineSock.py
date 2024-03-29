#!/usr/bin/env python
# coding: utf-8

"""
Deze code is gebaseerd op http://csl.name/post/vm/
waarvoor veel dank.

Example:
: fact dup 1 != if dup 1 - fact * then ;

"""
from __future__ import print_function
import threading
import time
import sys
import copy





class Machine:
    def __init__(self, executer, ui):
        self.exec = executer
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
            "halt": self.halt
        }


    def pop(self):
        val = self.exec.run_commando('PULL', None)
        value = int(val, 2)
        return value

    def push(self, value):
        value = (bin(value)[2:])
        self.exec.run_commando('PUSH', value)

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



    def repl(self):
        self.ui.println('Type "halt" to quit.')

        while True:
            try:
                self.ui.println("ok>")
                source = self.ui.get_input()
                #print(source)
                code = list(self.tokenice(source))
                self.parse(code)
                # self.ui.send_status(
                #     self.exec.refresh_tapes({"ST", "RA", "RB", "S"}))
            except (RuntimeError, IndexError) as e:
                print("IndexError: %s" % e)
            except KeyboardInterrupt:
                print("\nKeyboardInterrupt")

    # OPERATIONS FOLLOW:

    def plus(self):
        # self.push(self.pop() + self.pop())
        self.exec.run_rpc([('CALL', '@plus'), ('HALT', '')])

    def halt(self):
        self.ui.println("HALTED")
        sys.exit(0)
        #exit()

    def main(self):
        self.exec.run_rpc([('CALL', '@main'), ('HALT', '')])

    def init(self):
        # self.exec.run_rpc([('SPEED', 1), ('CLRA', ''), ('CLRB', ''), ('IOBUFF', '%_plotter'), ('OUTPUT', '%_plotter'), ('IOBUFF', '%_kbd'),
        #                    ('LIFO', '%_system'), ('HALT', '')])
        self.exec.run_rpc([('LIFO', '%_system'), ('CALL', '@init_vmachine'), ('HALT', '')])

    def minus(self):
        self.exec.run_rpc([('CALL', '@minus'), ('HALT', '')])

    def mul(self):
        self.exec.run_rpc([('CALL', '@mul'), ('HALT', '')])

    def fac(self):
        self.exec.run_rpc([('CALL', '@factorial'), ('HALT', '')])

    def div(self):
        self.exec.run_rpc([('CALL', '@div'), ('HALT', '')])

    def mod(self):
        self.exec.run_rpc([('CALL', '@mod'), ('HALT', '')])

    def eq(self):
        self.exec.run_rpc([('CALL', '@eq'), ('HALT', '')])

    def neq(self):
        self.exec.run_rpc([('CALL', '@neq'), ('HALT', '')])

    def dup(self):
        self.exec.run_rpc([('CALL', '@dup'), ('HALT', '')])
        #self.push(self.top())

    def over(self):
        self.exec.run_rpc([('CALL', '@over'), ('HALT', '')])

    def drop(self):
        self.pop()

    def swap(self):
        self.exec.run_rpc([('CALL', '@swap'), ('HALT', '')])

    def println(self):
        val = str(self.pop())
        self.ui.println(val)
        
