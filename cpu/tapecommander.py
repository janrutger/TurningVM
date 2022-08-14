from cpu import tape as t
import time


class  Tapecommander:
    def __init__(self):
        alltapesnames = {"ST", "RA", "RB", "S"}
        self.alltapes = {}
        for tape in alltapesnames:
            self.alltapes[tape] = t.Tape(tape, ['_','_','_','_'], 2)
        self.CPUspeed = 0

    def do_read(self, tapeList):
        tapeValues = {}
        for tape in tapeList:
            thisTape = self.alltapes[tape]
            resultValue = thisTape.read()
            tapeValues[tape] = resultValue
        return(tapeValues)

    def do_write(self, writeValues):
        tapeList = list(writeValues.keys())
        time.sleep(self.CPUspeed/1000)
        for tape in tapeList:
            thisTape = self.alltapes[tape]
            thisTape.write(writeValues[tape])
        

    def do_move(self, moveValues):
        tapeList = list(moveValues.keys())
        #time.sleep(self.CPUspeed/100)
        for tape in tapeList:
            thisTape = self.alltapes[tape]
            thisTape.move(moveValues[tape])
        time.sleep(self.CPUspeed/1000)
    
    def get_head(self, tapelist):
        head = {}
        for tape in tapelist:
            currenttape = self.alltapes[tape]
            resultvalue = currenttape.getHead()
            head[tape] = resultvalue
        return(head)
    
    def print_tape(self, tapeList):
        printResult = {}
        for tape in tapeList:
            currenttape = self.alltapes[tape]
            resultValue = currenttape.print()
            printResult[tape] = resultValue
        return(printResult)
