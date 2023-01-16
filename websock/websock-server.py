# Websocket demo, from iosoft.blog
 
import signal, sys, json
from SimpleWebSocketServer import WebSocket, SimpleWebSocketServer
 
PORTNUM = 8001

webclients = []
clients    = []
# Websocket class to echo received data
class Echo(WebSocket):
 
    def handleMessage(self):
        #print("Echoing '%s'" % self.data)
        input = (json.loads(self.data))
        if "tapeUpdate" in input:
            for client in webclients:
                if client != self:
                    try:
                        #client.sendMessage(json.dumps(input))
                        client.sendMessage(self.data)
                        self.sendMessage("sent" + self.data)
                    except Exception as n:
                        print(n)
        elif "register" in input:
            if input["register"] == "webclient":
                webclients.clear()
                webclients.append(self)
            
            print(self.address, "set client", len(clients), len(webclients))           
        else:
            #self.sendMessage(input)
            print("Unkown input messagetype" % self.data)
        
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
    


    