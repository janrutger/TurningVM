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
from websock import UIconnect as UI

memory = mmu.MMU()
ui = UI.UIconnect()
#VMmachine = threading.Thread(target=runner, args=((memory,)))


def runner(memory):
    print("runner")
    plotter = Plotter(memory)
    keyboard = Keyboard(memory)
    executes = Executer(memory, ui)
    machine = Machine(executes, plotter, keyboard)
    exitcode = machine.repl()

def start():
    runner(memory)

def load():
    assembler = Assembler()

    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMloader.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMmain.asm")))

    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/VMloader.asm")))
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/A133058.asm")))
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/main.asm")))





def on_message(wsapp, message):
    input = json.loads(message)
    if input["commando"] == "load":
        print(input)
        load()
    elif input["commando"] == "start":
        print(input)
        #runner(memory)
        #VMrunning = True
        VMmachine.start()
        

def on_open(wsapp):
    print("register")
    message = {"register": "backend"}
    wsapp.send(json.dumps(message))
    ui.set(wsapp)



VMmachine = threading.Thread(target=runner, args=((memory,)))
wsapp = websocket.WebSocketApp("ws://localhost:8001/", on_message=on_message,
                               on_open=on_open)
wsapp.run_forever()

