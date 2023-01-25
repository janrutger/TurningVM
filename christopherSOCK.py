import threading
import time
import websocket
import json

from assembler.assembler import Assembler
from cpu.executer import Executer
#from machine.keyboard import Keyboard
#from machine.plotter import Plotter
from machine.vmachineSock import Machine
from mmu import mmu
from websock import UIconnect as UI

memory = mmu.MMU()
ui = UI.UIconnect()
executes = Executer(memory, ui)
machine = Machine(executes, ui)

def runner():

    print("runner")
    #plotter = Plotter(memory)
    #keyboard = Keyboard(memory)
    #executes = Executer(memory, ui)
    #machine = Machine(executes, plotter, keyboard)
    #machine = Machine(executes)
    exitcode = machine.repl()



def load():
    assembler = Assembler()

    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/VMloader.asm")))
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/VMmain.asm")))

    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMloader.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/A133058.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/main.asm")))





def on_message(wsapp, message):
    input = json.loads(message)
    if "commando" in input and input["commando"] == "load":
        print(input)
        load()
    elif "commando" in input and input["commando"] == "start":
        print(input)
        runner()
    elif "keyboard" in input:
        machine.writeKbdBuff(input["keyboard"])

        
        
        

def on_open(wsapp):
    print("register")
    message = {"register": "backend"}
    wsapp.send(json.dumps(message))
    text2print = {"printline" : "Backend activated"}
    wsapp.send(json.dumps(text2print))
    ui.set(wsapp)





wsapp = websocket.WebSocketApp("ws://localhost:8001/", on_message=on_message,
                               on_open=on_open)
wsapp.run_forever()

