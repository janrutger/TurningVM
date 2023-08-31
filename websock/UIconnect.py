import websocket
import time
import json


class UIconnect:
    def __init__(self):
        self.kbdBuff = []
        self.updateRefreshCount = 0
        self.updateRefreshRate  = 1
        self.counter = 0

    def set(self, ws):
        self.ws = ws

    def println(self, text2print):
        message = {"printline": text2print}
        self.ws.send(json.dumps(message))
    
    def output(self, adres, values):
        message = {"output": adres, "values" : values}
        self.ws.send(json.dumps(message))

    def writeKbdBuff(self, value):
        self.kbdBuff.append(value)

    def get_input(self):
        while len(self.kbdBuff) == 0:
            time.sleep(1)
        resp = self.kbdBuff.pop(0)
        self.println("> " + resp)
        return (resp)

    def kbdRead(self, stringTable):
        self.stringTable = stringTable
        inputLine = self.get_input()
        tokens = self.tokenice(inputLine)
        print(tokens)
        return(tokens)

    def tokenice(self, text):
        code = []
        tokens = text.split()
        for token in tokens:
            if token.isnumeric():
                decimal = int(token)
                #binary = bin(decimal)[2:]
                code.append(decimal)
                # a 0 means number on stack is integer
                code.append("0")
            elif token in self.stringTable:
                code.append(self.stringTable[token])
                # a 1 means number on stack is referance to a string
                code.append("1")
            else:
                code.append(self.stringTable['null'])
                # a 1 means number on stack is referance to a string
                code.append("1")
        return(code)
    

    def display(self, stringTable, data):
        result = ""
        while len(data) > 0:
            typed = data.pop()
            if typed == 0:
                text = data.pop()
                result = str(text) + " " + result
            if typed == 1:
                lookup = data.pop()
                for lookfor, index in stringTable.items():
                    if index == lookup:
                        result = lookfor + " " + result
        self.println(result)
        return
