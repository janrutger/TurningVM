#!/usr/bin/env python
# coding: utf-8

"""
A simple VM interpreter.

Code from the post at http://csl.name/post/vm/
This version should work on both Python 2 and 3.
"""

from __future__ import print_function
#from collections import deque
#from io import StringIO
import sys
#import tokenize
import copy


def get_input(*args, **kw):
    """Read a string from standard input."""
    if sys.version[0] == "2":
        return raw_input(*args, **kw)
    else:
        return input(*args, **kw)



class Machine:
    def __init__(self, executer):
        self.exec = executer
        self.word_map = {}
        self.dispatch_map = {
            "%":        self.mod,
            "*":        self.mul,
            "+":        self.plus,
            "-":        self.minus,
            "/":        self.div,
            "=":        self.eq,
            "drop":     self.drop,
            "dup":      self.dup, 
            "over":     self.over,
            "swap":     self.swap,
            ".":        self.println,
            "init":     self.init,
            "main":     self.main,
            "exit":     self.exit    
        }
        

    def pop(self):
        val = self.exec.run_commando('PULL', None)
        value = int(val,2)
        return value

    def push(self, value):
        value = (bin(value)[2:])
        self.exec.run_commando('PUSH', value)

    def top(self):
        #return self.data_stack.top()
        value = self.pop()
        self.push(value)
        return value

    def tokenise(self,text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                code.append(int(token))
            else:
                code.append(token)
        return(code)

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
            elif opcode == "if":
                trueValue = self.pop()
                if trueValue == 0:    #True
                    ifCode = []
                    nextToken = _code.pop(0)
                    while nextToken != "then":
                        ifCode.append(nextToken)
                        nextToken = _code.pop(0)
                    self.parse(ifCode)
                else:               #False
                    nextToken = _code.pop(0)
                    while nextToken != "then":
                        nextToken = _code.pop(0)
            else:
                self.dispatch(opcode)

    def dispatch(self, op):
        if str(op) in self.word_map:
            self.parse(self.word_map[str(op)])
        elif op in self.dispatch_map:
            self.dispatch_map[op]()
        elif isinstance(op, int):
            self.push(op) # push numbers on stack
        elif isinstance(op, str) and op[0]==op[-1]=='"':
            self.push(op[1:-1]) # push quoted strings on stack
        else:
            raise RuntimeError("Unknown opcode: '%s'" % op)

    def repl(self):
        print('Hit CTRL+D or type "exit" to quit.')

        while True:
            try:
                source = get_input("> ")
                code = list(self.tokenise(source))
                self.parse(code)
            except (RuntimeError, IndexError) as e:
                print("IndexError: %s" % e)
            except KeyboardInterrupt:
                print("\nKeyboardInterrupt")






    # OPERATIONS FOLLOW:

    def plus(self):
        #self.push(self.pop() + self.pop())
        self.exec.run_rpc([('CALL', '@plus'), ('HALT', '')])

    def exit(self):
        sys.exit(0)

    def main(self):
        self.exec.run_rpc([('CALL', '@main'), ('HALT', '')])

    def init(self):
        self.exec.run_rpc([('SPEED', 400), ('CLRA', ''), ('CLRB', ''), ('LIFO', '%_system'), ('HALT', '')])

    def minus(self):
        self.exec.run_rpc([('CALL', '@minus'), ('HALT', '')])

    def mul(self):
        self.exec.run_rpc([('CALL', '@mul'), ('HALT', '')])

    def div(self):
        self.exec.run_rpc([('CALL', '@div'), ('HALT', '')])

    def mod(self):
        self.exec.run_rpc([('CALL', '@mod'), ('HALT', '')])

    def eq(self):
        self.exec.run_rpc([('CALL', '@eq'), ('HALT', '')])

    def dup(self):
        self.push(self.top())

    def over(self):
        self.exec.run_rpc([('CALL', '@over'), ('HALT', '')])

    def drop(self):
        self.pop()

    def swap(self):
        self.exec.run_rpc([('CALL', '@swap'), ('HALT', '')])

    def println(self):
        sys.stdout.write("%s\n" % self.pop())
        sys.stdout.flush()

