# Websocket demo, from iosoft.blog
 
import signal, sys, json
from SimpleWebSocketServer import WebSocket, SimpleWebSocketServer
 
PORTNUM = 8001

webclients = []
clients    = []
backends   = []

# Websocket class to echo received data
class Echo(WebSocket):
 
    def handleMessage(self):
        #print("Echoing '%s'" % self.data)
        input = (json.loads(self.data))
        if "tapeUpdate" in input:
            for client in webclients:
                if client != self:
                    try:
                        #print(self.data)
                        client.sendMessage(self.data)
                    except Exception as n:
                        print(n)

        elif "request" in input:
            #print("Received tapeReq")
            for client in backends:
                try:
                    client.sendMessage(self.data)
                except Exception as n:
                    print(n)

        elif "register" in input:
            if input["register"] == "webclient":
                webclients.clear()
                webclients.append(self)
            elif input["register"] == "backend":
                backends.clear()
                backends.append(self)
                clients.remove(self)
            
            print(self.address, "set client", len(clients),
                  len(webclients), len(backends))

        elif "commando" in input:
            if input["commando"] == "load":
                for client in backends:
                    if client != self:
                        try:
                            client.sendMessage(self.data)
                        except Exception as n:
                            print(n)
            
            if input["commando"] == "start":
                for client in backends:
                    if client != self:
                        try:
                            client.sendMessage(self.data)
                        except Exception as n:
                            print(n)

        elif "printline" in input:
            for client in webclients:
                try:
                    client.sendMessage(self.data)
                except Exception as n:
                    print(n)
                    


        elif "output" in input: 
            print("Output", input["output"])
            for client in webclients:
                try:
                    client.sendMessage(self.data)
                except Exception as n:
                    print(n)

            
        elif "keyboard" in input:
            print("Keyboard", input)
            for client in backends:
                try:
                    client.sendMessage(self.data)
                except Exception as n:
                    print(n)

        
        else:
            print("Unkown input messagetype", input)
        
    def handleConnected(self):
        print(self.address, 'connected')
        clients.append(self)
 
    def handleClose(self):
        clients.remove(self)
        print(self.address, 'Disconnected')
    
 
# Handle ctrl-C: close server
def close_server(signal, frame):
    server.close()
    sys.exit()
 
if __name__ == "__main__":
    print("Websocket server on port %s" % PORTNUM)
    server = SimpleWebSocketServer('', PORTNUM, Echo)
    signal.signal(signal.SIGINT, close_server)
    server.serveforever()
    


    