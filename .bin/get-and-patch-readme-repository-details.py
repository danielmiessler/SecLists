#!/usr/bin/python3

# If you change the commit message you need to change .github/workflows/readme-updater.yml

import requests,re
from decimal import Decimal

print("[+] Readme stats updater")

# Constants
CONNECTION_SPEED_MBPS = 50  # Change this to set a different cloning speed (in Mbps)
REPOSITORY_API="https://api.github.com/repos/%s"
REPOSITORY="danielmiessler/SecLists"
BADGE_REGEX=r"!\[Approx cloning time\]\(https://img\.shields\.io/badge/.*?\)"
BADGE_TEMPLATE = f"![Approx cloning time](https://img.shields.io/badge/clone%%20time-~%%20%s%%20@%dMb/s-blue)"
ERROR_STRING="::error file=%s,line=%s,col=%s,endColumn=%s::%s"

def print_err(file,msg,line=1,col=1,endcol=1):
    print(ERROR_STRING%(file,line,col,endcol,msg))

size=requests.get(REPOSITORY_API%(REPOSITORY)).json()['size'] # Its in kb

# Calculate size in MB
size_mb = Decimal(size) / 1024

# Calculate cloning time for the defined connection speed (convert size to bits)
cloning_time_seconds = int((size_mb * 8) / CONNECTION_SPEED_MBPS)

# Cloning time seconds to minutes and seconds
minutes = cloning_time_seconds // 60
seconds = cloning_time_seconds % 60

if minutes > 0:
    cloning_time = f"{minutes}m%20{seconds}s"
else:
    cloning_time = f"{seconds}s"

# New badge string
approx_cloning_time_badge = BADGE_TEMPLATE % (cloning_time, CONNECTION_SPEED_MBPS)

readme_contents=open("README.md").read()

if not re.search(BADGE_REGEX,readme_contents,flags=re.DOTALL):
    print_err("README.md", "[!] Error: No approx cloning time badge found!")
    exit(2)

# Update the badge in the README.md content
new_readme_content = re.sub(
    BADGE_REGEX,
    approx_cloning_time_badge,
    readme_contents,
    count=1
)

open("README.md","w").write(new_readme_content)

print(f"[+] Updated README.md with new cloning time badge at {CONNECTION_SPEED_MBPS}Mb/s!")
