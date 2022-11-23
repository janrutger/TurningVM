import threading
import unittest

from assembler.assembler import Assembler
from cpu.executer import Executer
from machine.keyboard import Keyboard
from machine.plotter import Plotter
from machine.vmachine import Machine
from mmu import mmu
from mmu.mmu import MMU


def runner():
    memory = mmu.MMU()
    plotter = Plotter(memory)
    keyboard = Keyboard(memory)
    executes = Executer(memory)
    machine = Machine(executes, plotter, keyboard)
    exitcode = machine.repl()


class Testing(unittest.TestCase):

    def test_string(self):
        assembler = Assembler()

        my_mmu = MMU()
        my_mmu.loadMem(assembler.compile(assembler.readASM("/Users/ernstvorsteveld/git/jr/TurningVM/assembler/VMloader.asm")))
        my_mmu.loadMem(assembler.compile(assembler.readASM("/Users/ernstvorsteveld/git/jr/TurningVM/assembler/VMmain.asm")))

        job = threading.Thread(target=runner)
        job.start()
