#!/usr/bin/python3

import os
import sys
import xml.etree.ElementTree as ET

if not sys.argv[1]:
    exit(0)

files=sys.argv[1].split(" ")

for i in files:
    if not os.path.isfile(i):
        print("[!] %s does not exist!"%(i))
        exit(2)

for i in files:
    ET