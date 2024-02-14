#!/usr/bin/python3

import os
import sys
import xml.etree.ElementTree as et

if len(sys.argv) == 1:
    exit(0)

files=sys.argv[1].split(" ")

for i in files:
    if not os.path.isfile(i):
        print("[!] %s does not exist!"%(i))
        exit(2)

for i in files:
    xml_file = et.parse(i)
    
    contents = []

    for j in xml_file.getroot().findall("attack"):
        xss = j.find('code').text

        if not xss:
            continue

        if "\n" in xss:
            print("Xss have newline in it.")
            print(xss, "\n")

        contents.append(xss)

    file_dir, file_name = i.rsplit("/", 1)
    file_name = os.path.join(file_dir, file_name.rsplit(".", 1)[0] + ".txt")

    open(file_name, "w").write("\n".join(contents))

    print(f"Wrote to {file_name}")
        
        