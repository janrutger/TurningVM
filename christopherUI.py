from string import Template
import PySimpleGUI as sg
import threading

from assembler import assembler as ASM
from mmu       import mmu       as MMU
from cpu       import executer  as ex
from machine   import vmachine  as vm
from machine   import plotter   as plt

memory    = MMU.MMU()
executer  = ex.Executer(memory)
plotter   = plt.Plotter(memory) 
machine   = vm.Machine(executer, plotter)

assembler = ASM.Assembler()
ALLTAPES = ["ST", "RA", "RB", "S"] 
THREAD = False
BINfile = ""
currentASMfileName = ""

#def runner(pc):
def runner():
    #exitcode = executer.run_memory(pc)
    exitcode = machine.repl()
    window['-stout-'].print("Value ", exitcode)

def updateTapeInfo():
    pos = 0;
    #result = executer.run_commando("PRINT", ALLTAPES)
    result = executer.refreshTapes(ALLTAPES)
    for tape in result.keys():
        data = result[tape]
        window[Template('-TapeLeftPos${pos}-').substitute(pos = pos)].update(data[0])
        window[Template('-TapeHeadPos${pos}-').substitute(pos = pos)].update(data[1])
        window[Template('-TapeRightPos${pos}-').substitute(pos = pos)].update(data[2])
        pos += 1

# UI definitions
sg.theme('Dark Blue 3')

def tapeLayout(label, left, head, right, name):
    return [
        sg.Text(size=(32,1), key=left, justification='right', text=label),
        sg.Text(size=(1,1),  key=head, justification='center'),
        sg.Text(size=(12,1), key=right,justification='left'),
        sg.Text(name)
        ]
    

frame_TapeInformatie =[
    tapeLayout('Stack',      '-TapeLeftPos0-', '-TapeHeadPos0-','-TapeRightPos0-', 'Stack'),
    tapeLayout('Register A', '-TapeLeftPos1-', '-TapeHeadPos1-','-TapeRightPos1-', 'A Register'),
    tapeLayout('Register B', '-TapeLeftPos2-', '-TapeHeadPos2-','-TapeRightPos2-', 'B Register'),
    tapeLayout('Status',     '-TapeLeftPos3-', '-TapeHeadPos3-','-TapeRightPos3-', 'Status')
    ]

frame_MemInformatie=[
    [sg.Text('#', size=(12,1), key='-adres-'),
     sg.Text('Opcode', size=(12,1), key='-opcode-'),
     sg.Text('Operand', size=(12,1), key='-operand-')]
    ]



layout = [
    [sg.Multiline("Initialize.... \n", size=(65, 5), key="-stout-")],
    [sg.FileBrowse("Open",font='Courier 10', size=[10,1], key="-open-"),
     sg.Button("Compile", font='Courier 10', size=[10,1], key="-compile-", disabled=True),
     sg.Button("Load", font='Courier 10', size=[10,1], key="-load-", disabled=True),
     sg.Button("Run", font='Courier 10',  size=[10,1], key="-run-", disabled=True)],
    [sg.Frame('Tape Informatie', frame_TapeInformatie,font='Courier 12')],
    [sg.Frame('Memory Stack', frame_MemInformatie, font='Courier 12')],
    [sg.Button("Shutdown", font='Courier 10', size=[10,1], key='-shutdown-')]
]


# Create the Window
window = sg.Window('Christopher (TM)', layout)
#window.Finalize()
#window['-compile-'].update(disabled=True)
#window['-load-'].update(disabled=True)
#window['-run-'].update(disabled=True)
#window['-stout-'].print("Initialize")

# Event Loop to process "events"
while True:             
    event, values = window.read(timeout=100)
    #print(event, values)
    #print(values['-open-'])
    if event == sg.WIN_CLOSED or event == '-shutdown-':
        window['-stout-'].print("Shutdown, waiting for finisch")
        #executer.stopPlotter()
        if THREAD == True:
            job.join()
            break
        else:
            break

    if (values['-open-']) != '':
        if currentASMfileName != values['-open-']:
            ASMfile = assembler.readASM(values['-open-'])
            currentASMfileName = values['-open-']
            window['-stout-'].print("ASM file loaded")
            window['-compile-'].update(disabled=False)

    if event == '-compile-':
        BINfile = assembler.compile(ASMfile)
        window['-stout-'].print("Assembly compiled, binary generated")
        window['-compile-'].update(disabled=True)

    if BINfile != "" and THREAD == False:
            window['-load-'].update(disabled=False)

    if event == '-load-':
        memory.loadMem(BINfile)
        window['-run-'].update(disabled=False)
        window['-stout-'].print("Binary loaded in memory")

    if event == '-run-':
        pc = 0
        window['-load-'].update(disabled=True)
        window['-run-'].update(disabled=True)
        window['-stout-'].print("Binary started")
        #job = threading.Thread(target=runner, args=((pc,)))
        job = threading.Thread(target=runner)
        job.start()
        THREAD = True
    
    updateTapeInfo()

    if THREAD == True:
        if not job.is_alive():
            THREAD = False
            window['-load-'].update(disabled=False)
            window['-run-'].update(disabled=False)
            window['-stout-'].print("Binary ended")
            #job.join()
            # print(exitvalue)


    

window.close()