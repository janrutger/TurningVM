import websocket
import json


class UIconnect:
    def __init__(self, wsapp):
        #self.ws = websocket.create_connection("ws://localhost:8001/")
        self.ws = wsapp

    
    def send_status(self, tapestate):
        message = {"tapeUpdate": tapestate}
        self.ws.send(json.dumps(message))
