# Websocket demo, from iosoft.blog
 
import signal, sys, json, time
from SimpleWebSocketServer import WebSocket, SimpleWebSocketServer
 
PORTNUM = 8001
clients    = []
# Websocket class to echo received data
class Echo(WebSocket):
 
    def handleMessage(self):
        timeReceive = time.time()
        for client in clients:

            if client != self:
                try:
                    message = self.data.split("|")
                    client.sendMessage(message[0])
                    #client.sendMessage(self.data)
                    timeSend = time.time()
                    if len(message) > 1:
                        a = round((timeReceive - float(message[1])) *1000, 2)
                        b = round((timeSend   - float(timeReceive)) *1000, 2)
                        #c = message[2]
                        l = len(message[0])
                        d = client.address[1]
                        print(l,a,b, d)
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
    


    