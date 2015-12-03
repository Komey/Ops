#!/usr/bin/python
from SocketServer import ThreadingTCPServer, StreamRequestHandler
import traceback
import commands

class MyStreamRequestHandlerr(StreamRequestHandler):
    def handle(self):
        while True:
            try:
                data = self.request.recv(1024).strip()
                print "receive from (%r):%r" % (self.client_address, data)
                cmd_status,cmd_result=commands.getstatusoutput(data)
                if len(cmd_result.strip()) ==0:
                    self.request.sendall('Done.')
                else:
                    self.request.sendall(cmd_result)
            except:
                traceback.print_exc()
                break

if __name__ == "__main__":

    host = ""
    port = 50007
    addr = (host, port)

    server = ThreadingTCPServer(addr, MyStreamRequestHandlerr)  
    print "HI~ listern on ",port
    server.serve_forever()
  
