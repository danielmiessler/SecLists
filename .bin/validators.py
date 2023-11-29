#!/usr/bin/python3

# The workflow commands are from https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
# TL;DR You can echo text out and the text can trigger workflow commands if in format "::workflow-command parameter1={data},parameter2={data}::{command value}"
# We are using the warnings and errors settings.
# You may use the below lines for testing
#
# Invalid test args ./.bin/validators.py bad test args: ./.bin/new-line-checker.py "Fuzzing/file-extensions-all-cases.txt Fuzzing/file-extensions-lower-case.txt Fuzzing/file-extensions-upper-case.txt Fuzzing/file-extensions.txt"
# valid test args: ./.bin/validators.py "Discovery/Web-Content/trickest-robots-disallowed-wordlists/top-100.txt"
#
# Script by @molangning. I am the guy you want to ping when this script get borked, not the repository owners

import os,subprocess,sys

args=sys.argv[1]
files=[]
STEP_SUMMARY_LOCATION=""
IS_RUNNING_AS_ACTIONS=False

if "GITHUB_STEP_SUMMARY" not in os.environ:
    print("[!] GITHUB_STEP_SUMMARY not found in system environments!")
    print("[-] This error may occur if you are running this script in your own machine\n")
else:
    STEP_SUMMARY_LOCATION=os.environ["GITHUB_STEP_SUMMARY"]
    IS_RUNNING_AS_ACTIONS=True

if IS_RUNNING_AS_ACTIONS:
    print("[+] Now running as github actions\n")
else:
    print("[+] Now running as normal user\n")

WARNING_STRING="::warning file=%s,line=%s,col=%s,endColumn=%s::%s"
ERROR_STRING="::error file=%s,line=%s,col=%s,endColumn=%s::%s"

def print_warn(file,msg,line=1,col=1,endcol=1):
    if IS_RUNNING_AS_ACTIONS:
        print(WARNING_STRING%(file,line,col,endcol,msg))
    else:
        print(msg)

def print_err(file,msg,line=1,col=1,endcol=1):
    if IS_RUNNING_AS_ACTIONS:
        print(ERROR_STRING%(file,line,col,endcol,msg))
    else:
        print(msg)
        
for root,_,file_list in os.walk('.bin/checkers'):
    for file in file_list:
        if file.endswith('.md'):
            continue

        files.append(os.path.join(root,file))

sys_env=os.environ.copy()
sys_env.update({"IS_RUNNING_UNDER_CALLER_SCRIPT":"1"})

for i in files:
    try:
        output=subprocess.check_output([i,args],env=sys_env)

    except PermissionError:
        print_warn(i,"[!] Not running test %s due to insufficient privileges!"%(i))
        print_warn(i,"[!] chmod +x it to let the workflow run the check.\n")

    except subprocess.CalledProcessError as exec_err:
        print_err(i,"[!] Error! Calling command with args %s failed!"%(str([i,args])))
        print_err(i,"[!] Process exited with error code %s and error message %s\n"%(exec_err.returncode,exec_err.output))

    print(output.decode('utf-8'))