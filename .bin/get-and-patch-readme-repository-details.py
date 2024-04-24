#!/usr/bin/python3

# If you change the commit message you need to change .github/workflows/readme-updater.yml

import requests,re
from decimal import Decimal

print("[+] Readme stats updater")

REPOSITORY_API="https://api.github.com/repos/%s"
REPOSITORY="danielmiessler/SecLists"
DETAILS_ANCHOR="<!--- details anchor -->"
DETAILS_ANCHOR_REGEX=r"%s.*?%s"%(DETAILS_ANCHOR,DETAILS_ANCHOR)
COMMIT_MESSAGE="[Github Action] Automated readme update."
DETAIL_USER_NOTICE_STRING="""%s

### Repository details

Size of a complete clone of SecLists is currently at `%s`

Cloning this repository should take %i-%i minutes at 5MB/s speeds.

%s"""
ERROR_STRING="::error file=%s,line=%s,col=%s,endColumn=%s::%s"

def print_err(file,msg,line=1,col=1,endcol=1):
    print(ERROR_STRING%(file,line,col,endcol,msg))

size=requests.get(REPOSITORY_API%(REPOSITORY)).json()['size'] # Its in kb

suffixes=['MB','GB','TB']
final_size=[str(size),"","KB"]

for i in suffixes:
    if len(final_size[0])>3:
        
        final_size[1]=final_size[0][-3:]+final_size[1]
        final_size[0]=final_size[0][:-3]
        final_size[2]=i

final_size="%s %s"%(str(round(Decimal('.'.join(final_size[:2])),1)),final_size[2])

eta_lower_bound=int(str(size/5000/60).split('.')[0]) # Get whole number after decimal point
eta_upper_bound=eta_lower_bound+1

DETAIL_USER_NOTICE_STRING=DETAIL_USER_NOTICE_STRING%(DETAILS_ANCHOR,final_size,eta_lower_bound,eta_upper_bound,DETAILS_ANCHOR)

readme_contents=open("README.md").read()

if not re.search(DETAILS_ANCHOR_REGEX,readme_contents,flags=re.DOTALL):
    print_err("README.md", "[!] Error: No details anchor found!")
    exit(2)

readme_contents=re.sub(DETAILS_ANCHOR_REGEX,DETAIL_USER_NOTICE_STRING,readme_contents,count=1,flags=re.DOTALL)
open("README.md","w").write(readme_contents)

print("[+] Wrote README.md!")
