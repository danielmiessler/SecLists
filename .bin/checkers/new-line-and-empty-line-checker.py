#!/usr/bin/env python3

import os,sys

if not sys.argv[1]:
    exit(0)

IS_WRAPPED=False

if "IS_RUNNING_UNDER_CALLER_SCRIPT" in os.environ:
    IS_WRAPPED=os.environ['IS_RUNNING_UNDER_CALLER_SCRIPT']=="1"

def print_normal(msg):

    if IS_WRAPPED:
        return
    print(msg)    

def print_err(file,line_number):
   
    if IS_WRAPPED:
        print("E,%s,%s"%(file,line_number))

def print_warn(file,line_number):
   
    if IS_WRAPPED:
        print("W,%s,%s"%(file,line_number))    

print_normal("[+] New line and empty line check")
if IS_WRAPPED:
    print("New line and empty line check")
    print("To fix the error, you would have to remove the empty lines or new lines at the end of the file.")

files=sys.argv[1].split(" ")

for i in files:
    if not os.path.isfile(i):
        print_err(i,0)
        print_normal("[!] %s does not exist!"%(i))
        exit(2)

overall_pass_status=True

for i in files:
    
    contents=open(i,"rb").read()
    line_number=len(contents.split(b'\n'))+1

    if contents[-1:] == b'\n':
        print_normal("[!] Warning: %s ends with a new line!"%(i))
        print_warn(i,line_number)
        overall_pass_status=False
    else:
        print_normal("[+] %s passed new line check!"%(i))

    counter=1

    line_pass_status=True

    for line in contents.splitlines():
        if not line:
            print_normal("[!] Warning: %s has an empty entry on line %i!"%(i,counter))
            print_warn(i,counter)
            pass_status=False
            line_pass_status=False
            continue

        elif not line.strip():
            print_normal("[!] Warning: %s has an whitespace only entry on line %i!"%(i,counter))
            print_warn(i,counter)
            pass_status=False
            line_pass_status=False
            continue

        counter+=1
    if line_pass_status:
        print_normal("[+] %s passed empty line check!"%(i))

if overall_pass_status:
    print_normal("[+] All files passed checks")
    exit(0)

print_normal("[!] Warning: One or more files failed to pass the checks")

if IS_WRAPPED:
    exit(0)
else:
    exit(2)
