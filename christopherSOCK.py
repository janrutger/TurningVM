import threading
import time
import websocket
import json

from assembler.assembler import Assembler
from cpu.executer import Executer
from machine.keyboard import Keyboard
from machine.plotter import Plotter
from machine.vmachine import Machine
from mmu import mmu


def _runner(memory):
    plotter = Plotter(memory)
    keyboard = Keyboard(memory)
    executes = Executer(memory)
    machine = Machine(executes, plotter, keyboard)
    exitcode = machine.repl()

def start():
    _runner(memory)

def load():
    assembler = Assembler()

    memory = mmu.MMU()
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/VMloader.asm")))
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/VMmain.asm")))



def on_message(wsapp, message):
    print(message)

def on_open(wsapp):
    print("register")
    message = {"register": "backend"}
    wsapp.send(json.dumps(message))



wsapp = websocket.WebSocketApp("ws://localhost:8001/", on_message=on_message,
                               on_open=on_open)
wsapp.run_forever()


