#!/usr/bin/python
import socket
import sys
if(len(sys.argv)<3):
    print "you shoud run this .py with host and port~"
    sys.exit(0)
HOST= sys.argv[1]
PORT= int(sys.argv[2])
print HOST,PORT

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((HOST,PORT))
while 1:
    cmd=raw_input("Please input cmd:")
    s.sendall(cmd)
    data=s.recv(1024)
    print data
s.close()  
