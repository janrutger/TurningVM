#!/usr/bin/env python
# coding: utf-8

"""
A simple VM interpreter.

Code from the post at http://csl.name/post/vm/
This version should work on both Python 2 and 3.
"""

from __future__ import print_function
#from collections import deque
from io import StringIO
import sys
import tokenize


def get_input(*args, **kw):
    """Read a string from standard input."""
    if sys.version[0] == "2":
        return raw_input(*args, **kw)
    else:
        return input(*args, **kw)



class Machine:
    def __init__(self, executer):
        self.exec = executer
        self.dispatch_map = {
            "%":        self.mod,
            "*":        self.mul,
            "+":        self.plus,
            "-":        self.minus,
            "/":        self.div,
            "drop":     self.drop,
            "dup":      self.dup, 
            "over":     self.over,
            "swap":     self.swap,
            ".":        self.println,
            "init":     self.init,
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


    def run(self, code):
        self.instruction_pointer =  0
        self.code = code
        while self.instruction_pointer < len(self.code):
            opcode = self.code[self.instruction_pointer]
            self.instruction_pointer += 1
            self.dispatch(opcode)

    def dispatch(self, op):
        if op in self.dispatch_map:
            self.dispatch_map[op]()
        elif isinstance(op, int):
            self.push(op) # push numbers on stack
        elif isinstance(op, str) and op[0]==op[-1]=='"':
            self.push(op[1:-1]) # push quoted strings on stack
        else:
            raise RuntimeError("Unknown opcode: '%s'" % op)

    # OPERATIONS FOLLOW:

    def plus(self):
        #self.push(self.pop() + self.pop())
        self.exec.run_rpc([('CALL', '@plus'), ('HALT', '')])

    def exit(self):
        sys.exit(0)

    def init(self):
        self.exec.run_rpc([('SPEED', 40), ('CLRA', ''), ('CLRB', ''), ('LIFO', '%_system'), ('HALT', '')])

    def minus(self):
        self.exec.run_rpc([('CALL', '@minus'), ('HALT', '')])

    def mul(self):
        self.exec.run_rpc([('CALL', '@mul'), ('HALT', '')])

    def div(self):
        self.exec.run_rpc([('CALL', '@div'), ('HALT', '')])

    def mod(self):
        self.exec.run_rpc([('CALL', '@mod'), ('HALT', '')])

    def dup(self):
        self.push(self.top())

    def over(self):
        # b = self.pop()
        # a = self.pop()
        # self.push(a)
        # self.push(b)
        # self.push(a)
        self.exec.run_rpc([('CALL', '@over'), ('HALT', '')])

    def drop(self):
        self.pop()

    def swap(self):
        # b = self.pop()
        # a = self.pop()
        # self.push(b)
        # self.push(a)
        self.exec.run_rpc([('CALL', '@swap'), ('HALT', '')])

    def println(self):
        sys.stdout.write("%s\n" % self.pop())
        sys.stdout.flush()

    

    def parse(self,text):
        # Note that the tokenizer module is intended for parsing Python source
        # code, so if you're going to expand on the parser, you may have to use
        # another tokenizer.

        if sys.version[0] == "2":
            stream = StringIO(unicode(text))
        else:
            stream = StringIO(text)

        tokens = tokenize.generate_tokens(stream.readline)

        for toknum, tokval, _, _, _ in tokens:
            if toknum == tokenize.NUMBER:
                yield int(tokval)
            elif toknum in [tokenize.OP, tokenize.STRING, tokenize.NAME]:
                yield tokval
            elif toknum in [tokenize.ENDMARKER, tokenize.NEWLINE]:
                break
            else:
                raise RuntimeError("Unknown token %s: '%s'" %
                        (tokenize.tok_name[toknum], tokval))


    def repl(self):
        print('Hit CTRL+D or type "exit" to quit.')

        while True:
            try:
                source = get_input("> ")
                code = list(self.parse(source))
                self.run(code)
            except (RuntimeError, IndexError) as e:
                print("IndexError: %s" % e)
            except KeyboardInterrupt:
                print("\nKeyboardInterrupt")

