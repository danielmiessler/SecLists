#!/usr/bin/env python3

import os,sys,json

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

print_normal("[+] Remote wordlist overwrite check")
if IS_WRAPPED:
    print("Remote wordlist overwrite check")
    print("Files that the script catches will be overwritten next update.")

files=sys.argv[1].split(" ")

for i in files:
    if not os.path.isfile(i):
        print_err(i,0)
        print_normal("[!] %s does not exist!"%(i))
        exit(2)

overall_pass_status=True

sources = json.load(open(".bin/wordlist-updaters/sources.json"))
overwritten_paths = {
    "dirs": [],
    "files": []
}

for source in sources:
    found_paths = []
    
    if "output" in source.keys():
        found_paths.append(source["output"])

    if "additional_paths" in source.keys():
        found_paths += source["additional_paths"]

    for path in found_paths:
        
        if os.path.isdir(path):
            overwritten_paths["dirs"].append(path)

        elif os.path.isfile(path):
            overwritten_paths["files"].append(path)

for i in files:

    for dir_path in overwritten_paths["dirs"]:
        if i.startswith(dir_path):
            print_normal(f"[!] Warning: file {i} is in a directory that will get overwritten!")
            print_err(i, 0)
            overall_pass_status=False
            break

    for file_path in overwritten_paths["files"]:
        if i == file_path:
            print_normal(f"[!] Warning: file {i} will get overwritten!")
            print_err(i, 0)
            overall_pass_status=False
            break

if overall_pass_status:
    print_normal("[+] All files passed overwrite checks")
    exit(0)

print_normal("[!] Warning: One or more files failed to pass the overwrite checks")

if IS_WRAPPED:
    exit(0)
else:
    exit(2)
