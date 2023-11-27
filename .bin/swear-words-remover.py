#!/usr/bin/python3

# Beware of the Scunthorpe problem!
# https://en.wikipedia.org/wiki/Scunthorpe_problem

import os

print("[+] Curse words remover")

SOURCE_FOLDER="Miscellaneous/list-of-swear-words"
TARGET_DIRS=["Passwords/Common-Credentials"]
curse_words=[]
TARGET_SUFFIX="-without-curse-words"

for root,_,file_list in os.walk(SOURCE_FOLDER):
    for file in file_list:
        if not file.endswith(".txt"):
            continue
        curse_words+=open(os.path.join(root,file)).read().split('\n')

# dedupe them
curse_words=list(dict.fromkeys(curse_words))

target_files=[]

for i in TARGET_DIRS:
    for root,_,file_list in os.walk(i):
        for file in file_list:
            if not file.endswith(".txt"):
                continue
            target_files.append(os.path.join(root,file))

print("[+] Got %s files to check"%(len(target_files)))

for i in target_files:

    print("[+] Checking %s"%(i))

    counter=0
    contents=open(i).read().split('\n')
    root,file=i.rsplit("/",1) 
    root+=TARGET_SUFFIX
    clean_contents=[]

    for password in contents:
        
        has_curse_word=False

        if not password:
            continue
        
        for curse_word in curse_words:
            if curse_word in password:
                has_curse_word=True
                break

        if has_curse_word:
            counter+=1
            continue

        clean_contents.append(password)

    contents="\n".join(clean_contents)

    if not os.path.isdir(root):
        os.makedirs(root)

    if counter==0:
        print("[+] No curse words found in %s"%(i))
    else:
        print("[!] Removed %i swear words from %s"%(counter,i))
        open(os.path.join(root,file),"w").write(contents)
