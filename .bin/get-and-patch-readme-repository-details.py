#!/usr/bin/python3

# If you change the commit message you need to change .github/workflows/readme-updater.yml

import requests,re

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

size=requests.get(REPOSITORY_API%(REPOSITORY)).json()['size'] # Its in kb

suffixes=['MB','GB','TB']
final_size=[str(size),"","KB"]

for i in suffixes:
    if len(final_size[0])>3:
        
        final_size[1]=final_size[0][-3:]+final_size[1]
        final_size[0]=final_size[0][:-3]
        final_size[2]=i

trailing_nums=list(final_size[1])

decimal_len=3-len(final_size[0])
if int(trailing_nums[decimal_len])>=5:
    trailing_nums[decimal_len-1]=str(int(trailing_nums[decimal_len-1])+1)

trailing_nums=''.join(trailing_nums)
trailing_nums=trailing_nums[:decimal_len]

final_size=final_size[0]+'.'+trailing_nums+' '+final_size[2]

eta_lower_bound=int(str(size/5000/60).split('.')[0]) # Get whole number after decimal point
eta_upper_bound=eta_lower_bound+1

DETAIL_USER_NOTICE_STRING=DETAIL_USER_NOTICE_STRING%(DETAILS_ANCHOR,final_size,eta_lower_bound,eta_upper_bound,DETAILS_ANCHOR)

readme_contents=open("README.md").read()

if re.match(DETAILS_ANCHOR_REGEX,readme_contents,flags=re.DOTALL):
    print("[!] Error: No details anchor found!")
    exit(2)

readme_contents=re.sub(DETAILS_ANCHOR_REGEX,DETAIL_USER_NOTICE_STRING,readme_contents,flags=re.DOTALL)
open("README.md","w").write(readme_contents)

print("[+] Wrote README.md!")
