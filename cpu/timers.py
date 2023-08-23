import time

class Timers:
    def __init__(self, tapecommander):
        self.timers = {}
        self.tapecommander = tapecommander


    def set(self, number):
        timerx = (time.time(), self.tapecommander.TapeCounterAll)
        self.timers[number] = timerx


    def print(self, number):
        spentTime = round((time.time() - self.timers[number][0]), 3)
        cycles = self.tapecommander.TapeCounterAll - self.timers[number][1]
        freq = round((1 / (spentTime/cycles)) / 1000, 3)
        result = "> " + str(spentTime) + " seconden, " + str(cycles) + " cycles, " + str(freq) + " KHz"
        return result
    
    def gettime(self, number):
        spentTime = int((time.time() - self.timers[number][0]))
        return spentTime
