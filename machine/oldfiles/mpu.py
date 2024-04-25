from  multiprocessing import Process, Manager
from cpu.executer import Executer


class MPU:
    def __init__(self):
        with Manager() as manager:
            self.jobQueue   = manager.list()
            self.jobResults = manager.dict()
            self.initCode   = [('LIFO', '%_system'),('CALL', '@init_vmachine'), ('HALT', '')]


    def queues(self):
        return(self.jobQueue, self.jobResults)
    
    def enable(self, cpu0):
        self.memPage0 = cpu0.memPage()
        cpu0.enable_mpu(self.jobQueue, self.jobResults, 0)
    
        self.cpu1 = Executer(self.memPage0, None)
        self.cpu1.enable_mpu(self.jobQueue, self.jobResults, 1)

        CPU1 = Process(target=self.cpu1.run_rpc, args=(self.initCode, ))

        #CPU1.start()

        #CPU1.join()

        print("done")



