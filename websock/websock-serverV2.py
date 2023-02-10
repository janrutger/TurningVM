# Websocket demo, from iosoft.blog
 
import signal, sys, json
from SimpleWebSocketServer import WebSocket, SimpleWebSocketServer
 
PORTNUM = 8001


clients    = []


# Websocket class to echo received data
class Echo(WebSocket):
 
    def handleMessage(self):
        #print("Echoing '%s'" % self.data)
        #input = (json.loads(self.data))
        for client in clients:
            if client != self:
                try:
                    #print(self.data)
                    client.sendMessage(self.data)
                except Exception as n:
                    print(n)

        
        
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
    


    