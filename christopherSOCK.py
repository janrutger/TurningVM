import threading
import time
import websocket
import json
import rel

from assembler.assembler import Assembler
from cpu.executer import Executer
from machine.vmachineSock import Machine
from mmu import mmu
from websock import UIconnect as UI

ui = UI.UIconnect()
memory = mmu.MMU(ui)
executes = Executer(memory, ui)
machine = Machine(executes, ui)

counter = 0

def runner():
    print("runner")
    exitcode = machine.repl()



def load():
    assembler = Assembler()

    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMloader_2308.asm")))
    # memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMdivmod.asm")))

    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMloader.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/divmod.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/A133058.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/main.asm")))

    
    memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMloader_2308.asm")))
    memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMextentions.asm")))
    memory.loadMem(assembler.compile(assembler.readASM("./assembler/turtle.thg")))
    memory.loadMem(assembler.compile(
        assembler.readASM("./assembler/out.asm")))

    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/VMloader_2308.asm")))
    # #memory.loadMem(assembler.compile(assembler.readASM("./assembler/VMdivmod.asm")))
    # memory.loadMem(assembler.compile(
    #     assembler.readASM("./assembler/sleep.asm")))



def on_message(wsapp, message):
    input = json.loads(message)
    if "commando" in input and input["commando"] == "load":
        print(input)
        load()
    elif "commando" in input and input["commando"] == "start":
        print(input)
        #runner()
        job = threading.Thread(target=runner)
        job.start()
    elif "commando" in input and input["commando"] == "ctrlc":
        print(input)
        ControlC()
    elif "keyboard" in input:
        print("Place in buffer")
        ui.writeKbdBuff(input["keyboard"])
    elif "request" in input:
        #print("Tapereq")
        ui.send_status(executes.refresh_tapes({"ST", "RA", "RB", "S"}))

        
        
        

def on_open(wsapp):
    text2print = {"printline" : "Backend activated"}
    wsapp.send(json.dumps(text2print))
    print("register websocket")
    ui.set(wsapp)


def SendTapeUpdate():
    tapeState = executes.refresh_tapes({"ST", "RA", "RB", "S"})
    #counter += 1
    message = json.dumps({"tapeUpdate": tapeState})
    timeStamp = time.time()
    #wsapp.send(json.dumps(message) + "|" + str(timeStamp))
    wsapp.send(message+ "|" + str(timeStamp))
    
    return True

def ControlC():
    executes.ControlC = True
    return True


rel.timeout(0.05, SendTapeUpdate) #0.05

wsapp = websocket.WebSocketApp("ws://127.0.0.1:8001/", on_message=on_message,
                               on_open=on_open)
wsapp.run_forever(dispatcher=rel)
#rel.signal(2, ControlC)
rel.dispatch()

