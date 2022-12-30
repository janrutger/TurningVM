import threading
import unittest

from assembler.assembler import Assembler
from cpu.executer import Executer
from machine.keyboard import Keyboard
from machine.plotter import Plotter
from machine.vmachine import Machine
from mmu import mmu


def runner(memory):
    plotter = Plotter(memory)
    keyboard = Keyboard(memory)
    executes = Executer(memory)
    machine = Machine(executes, plotter, keyboard)
    exitcode = machine.repl()


class Testing(unittest.TestCase):

    def test_string(self):
        assembler = Assembler()

        memory = mmu.MMU()
        memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMloader.asm")))
        memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMmain.asm")))


        runner(memory)

