
import matplotlib.pyplot as plt
import time

class Plotter:
    def __init__(self, memory):
        self.memory = memory
        self.online = False
        self.newPlot = True

    def start(self, IObuff):
        self.online = True
        plt.ion()
        self.fig = plt.figure(figsize=(8, 5))
        self.ax = self.fig.add_subplot(111)

        while self.online:
            bufValues = self.memory.readIObuff(IObuff)
            if self.newPlot and bufValues == []:
                pass
            elif not self.newPlot and bufValues == []:
                # del self.ax
                # del self.fig
                plt.close('all')
                self.fig = plt.figure(figsize=(8, 5))
                self.ax = self.fig.add_subplot(111)
                self.newPlot = True
            else:
                self.newPlot = False
                x = range(len(bufValues))
                y = bufValues

                # line = self.ax.plot(x,y,'o')
                plt.scatter(x, y, s=5)

                self.fig.canvas.draw()
                self.fig.canvas.flush_events()
                plt.cla()

            time.sleep(5)

        plt.close('all')
        # del self.ax
        # del self.fig

    def stop(self):
        self.online = False
        self.newPlot = True
