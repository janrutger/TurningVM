import websocket
import time
import json


class UIconnect:
    def __init__(self, ws=None):
        if ws:
            self.ws = websocket.create_connection("ws://localhost:8001/")

    def set(self, ws):
        self.ws = ws


    def send_status(self, tapestate):
        message = {"tapeUpdate": tapestate}
        self.ws.send(json.dumps(message))

    def println(self, text2print):
        message = {"printline": text2print}
        self.ws.send(json.dumps(message))

    def input(self):
        message = {"inputReq": "keyboard"}
        self.ws.send(json.dumps(message))
