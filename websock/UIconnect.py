import websocket
import time
import json


class UIconnect:
    def __init__(self):
        self.kbdBuff = []
        self.updateCount = 0

    def set(self, ws):
        self.ws = ws


    def send_status(self, tapestate):
        message = {"tapeUpdate": tapestate}
        self.ws.send(json.dumps(message))
        

    def println(self, text2print):
        message = {"printline": text2print}
        self.ws.send(json.dumps(message))

    
    def output(self, adres, values):
        message = {"output": adres, "values" : values}
        self.ws.send(json.dumps(message))




    def writeKbdBuff(self, value):
        self.kbdBuff.append(value)

    def get_input(self):
        self.println("2>>")
        while len(self.kbdBuff) == 0:
            time.sleep(1)
        resp = self.kbdBuff.pop(0)
        self.println(resp)
        return (resp)
