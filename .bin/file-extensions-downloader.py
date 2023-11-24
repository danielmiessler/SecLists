#!/usr/bin/python3

# Open a pull req if any sources are missing/need to be added

from bs4 import BeautifulSoup
import requests
import time
import re

MICROSOFT_URL="https://support.microsoft.com/en-us/windows/common-file-name-extensions-in-windows-da4a4430-8e76-89c5-59f7-1cdbbc75cb01"
WIKI_ROOT="https://en.wikipedia.org"
WIKI_URL="https://en.wikipedia.org/wiki/List_of_filename_extensions"
GFG_URL="https://www.geeksforgeeks.org/list-of-file-formats/"

wiki_urls=[]
exts=[]
tables=[]

res=requests.get(WIKI_URL).text
wiki_soup=BeautifulSoup(res,"html.parser")

for i in wiki_soup.findAll('div',{"class":"mw-content-ltr mw-parser-output"})[0].findAll("ul")[2].findAll("li"):
    wiki_urls.append(WIKI_ROOT+i.a.get('href'))

for i in wiki_urls:
    res=requests.get(i).text
    wiki_soup=BeautifulSoup(res,"html.parser")

    tables+=wiki_soup.findAll("table")
    time.sleep(0.5)

for i in tables:

    if "wikitable" not in i["class"]:
        continue
        

    for ext in i.tbody.findAll("tr"):
        ext=ext.findAll('td')

        if ext==[]:
            continue

        ext=re.sub(r"\[.*?\]","",ext[0].text).strip()

        if "," in ext:
            for j in ext.split(","):

                if "." in j:
                    continue

                exts.append(j.strip())
            continue
        
        if "." in ext:
            continue

        exts.append(ext)

res=requests.get(MICROSOFT_URL).text
microsoft_soup=BeautifulSoup(res,"html.parser")

microsoft_exts=microsoft_soup.findAll("tbody")[1].findAll('p')[::2]

for i in microsoft_exts:

    i=i.text

    if "," in i:
        i=i.split(",")
        for j in i:
            exts.append(j.strip())
        continue

    exts.append(i)

res=requests.get(GFG_URL).text
gfg_soup=BeautifulSoup(res,"html.parser")

gfg_exts=gfg_soup.findAll("tbody")

for i in gfg_exts:
    i=i.findAll('th')
    for ext in i:
        ext=ext.text.strip()
        if ext.startswith('.'):
            exts.append(ext[1:].upper())
        else:
            exts.append(ext.upper())

cleaned_exts=[]
for i in exts:
    
    # https://stackoverflow.com/questions/3627784/case-insensitive-in
    if i.upper() in (cleaned_ext.upper() for cleaned_ext in cleaned_exts):
        continue

    cleaned_exts.append(i)

exts=cleaned_exts

exts=list(dict.fromkeys(exts))
exts.sort()

open("../Fuzzing/file-extensions.txt","w").write("\n".join(exts))

mutated_exts=[]

for i in exts:
    mutated_exts.append(i)
    mutated_exts.append(i.upper())
    mutated_exts.append(i.lower())

mutated_exts=list(dict.fromkeys(mutated_exts))
mutated_exts.sort()

open("../Fuzzing/file-extensions-all-cases.txt","w").write("\n".join(mutated_exts))

mutated_exts=[]

for i in exts:
    mutated_exts.append(i.lower())

mutated_exts=list(dict.fromkeys(mutated_exts))
mutated_exts.sort()

open("../Fuzzing/file-extensions-lower-case.txt","w").write("\n".join(mutated_exts))

mutated_exts=[]

for i in exts:
    mutated_exts.append(i.upper())

mutated_exts=list(dict.fromkeys(mutated_exts))
mutated_exts.sort()

open("../Fuzzing/file-extensions-upper-case.txt","w").write("\n".join(mutated_exts))
