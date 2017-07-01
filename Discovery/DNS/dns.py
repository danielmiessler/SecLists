#!/usr/bin/python3

import socket, sys

#Quick python DNS Discovery Script

if __name__ == "__main__":
    print(socket.gethostbyname(sys.argv[1]))  
