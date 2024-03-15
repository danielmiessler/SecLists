#!/usr/bin/python3

import os,shutil

print("[+] trickest wordlist patcher")

ROOT=".working_space"
INPUT_TECHNOLOGIES=os.path.join(ROOT,"wordlists/technologies/")
INPUT_ROBOTS=os.path.join(ROOT,"wordlists/robots/")
OUTPUT_TECHNOLOGIES="Discovery/Web-Content/CMS/trickest-cms-wordlist/"
OUTPUT_ROBOTS="Discovery/Web-Content/trickest-robots-disallowed-wordlists/"

if not os.path.isdir(".working_space"):
    print("[!] Working dir not found!")
    exit(2)

if not os.path.isdir(os.path.join(ROOT,"wordlists")):
    print("[!] wordlists dir not found!")
    exit(2)

if not os.path.isdir(OUTPUT_TECHNOLOGIES):
    os.makedirs(OUTPUT_TECHNOLOGIES)

if not os.path.isdir(OUTPUT_ROBOTS):
    os.makedirs(OUTPUT_ROBOTS)

for i in os.listdir(INPUT_TECHNOLOGIES):
    path=os.path.join(INPUT_TECHNOLOGIES,i)

    if os.path.isfile(path):
        shutil.copy(path,OUTPUT_TECHNOLOGIES)
    else:
        shutil.copytree(path,OUTPUT_TECHNOLOGIES,dirs_exist_ok=True)

for i in os.listdir(INPUT_ROBOTS):
    path=os.path.join(INPUT_ROBOTS,i)

    if os.path.isfile(path):
        shutil.copy(path,OUTPUT_ROBOTS)
    else:
        shutil.copytree(path,OUTPUT_ROBOTS,dirs_exist_ok=True)

print("[+] Copied all the files")
for i in [OUTPUT_ROBOTS,OUTPUT_TECHNOLOGIES]:
    for root,_,file_list in os.walk(i):
        for file in file_list:
            
            path=os.path.join(root,file)
            contents=open(path,"rb").read()

            if contents.endswith(b"\n"):
                print("[!] %s ends with new line"%(path))
                contents=contents[:-1]
                open(path,"wb").write(contents)

            patch_content=[]
            counter=0
            for content in contents.split(b"\n"):
                counter+=1
                if not content:
                    print("[+] %s has an empty line at %i"%(path,counter))
                    continue
                patch_content.append(content)
                
            if len(contents)!=len(patch_content):
                open(path,"wb").write(b"\n".join(patch_content))



