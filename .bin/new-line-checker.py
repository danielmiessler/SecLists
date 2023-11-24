#!/usr/bin/env python3

# test string: ./.bin/new-line-checker.py "Fuzzing/file-extensions-all-cases.txt Fuzzing/file-extensions-lower-case.txt Fuzzing/file-extensions-upper-case.txt Fuzzing/file-extensions.txt"

import os
import sys

print("[+] New line check")

files=sys.argv[1].split(" ")

for i in files:
    if not os.path.isfile(i):
        print("[!] %s does not exist!"%(i))
        exit(2)

for i in files:
    f=open(i,"r")
    contents=f.read()

    if len(contents) == 0:
        continue
    
    if contents[-1] == '\n':
        print("[!] %s ends with a new line"%(i))
        exit(2)
    print("[+] %s passed new line check"%(i))

print("[+] All files passed checks")
# exit(0)