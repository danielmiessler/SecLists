#!/usr/bin/python3

# The workflow commands are from https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
# TL;DR You can echo text out and the text can trigger workflow commands if in format "::workflow-command parameter1={data},parameter2={data}::{command value}"
# We are using the warnings and errors settings.
# You may use the below lines for testing
#
# Invalid test args ./.bin/validators.py "Fuzzing/file-extensions-all-cases.txt Fuzzing/file-extensions-lower-case.txt Fuzzing/file-extensions-upper-case.txt Fuzzing/file-extensions.txt"
# valid test args: ./.bin/validators.py "Discovery/Web-Content/trickest-robots-disallowed-wordlists/top-100.txt"
#
# Script by @molangning. I am the guy you want to ping when this script get borked, not the repository owners

import os,subprocess,sys

files=[]
STEP_SUMMARY_LOCATION="summary.md"
IS_RUNNING_AS_ACTIONS=False
CHECK_MARK_EMOJI=":white_check_mark:"
CROSS_MARK_EMOJI=":negative_squared_cross_mark:"
QUESTION_MARK_EMOJI=":question:"
FORMATTED_OUTPUT_FORMAT="""
### %s

%s

- - -

Warnings

```
%s
```

Errors

```
%s
```
"""
UNFORMATTED_OUTPUT_FORMAT="""
### %s

- - -

Output

```
%s
```
"""
SUMMARY_FORMAT="""
# Checks summary

This is a summary of the checks ran on the pushed files. If there is any errors please fix them before pushing again.
## Check statuses

| Test name | Passed? |
| --------- | :-----: |
%s

## Errors and warnings
%s

## Other unformatted outputs
This section is for scripts that doesn't follow specifications

%s
"""
TABLE_FORMAT="| %s | %s |\n"
WARN_MSG="Warnings in file %s on lines %s"
ERROR_MSG="Errors in file %s on lines %s"
WARNING_STRING="::warning file=%s,line=%s,col=%s,endColumn=%s::%s"
ERROR_STRING="::error file=%s,line=%s,col=%s,endColumn=%s::%s"

if "CHANGED_FILES" not in os.environ:
    print("[!] CHANGED_FILES environment variable not found!")
    print("[-] This error may occur if you are running this script in your own machine\n")
    if len(sys.argv) < 2:
        print("[!] No arguments set, exiting.")
        exit(2)
    
    args=sys.argv[1]
else:
    args=os.environ["CHANGED_FILES"]

print(f"[+] Checking these files {args}")

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
all_events=[]

for i in files:
    events={"error":[],"warn":[],"raw_output":""}
    is_using_wrapped_syntax=True
    exec_status=1 # 0 for fail, 1 for success, 2 for unknown
    description=""
    
    try:
        output=subprocess.check_output([i,args],env=sys_env)

    except PermissionError:
        print_warn(i,"[!] Not running test %s due to insufficient privileges!"%(i))
        print_warn(i,"[!] chmod +x it to let the workflow run the check.\n")
        continue

    except subprocess.CalledProcessError as exec_err:
        print_err(i,"[!] Error! Calling command with args %s failed!"%(str([i,args])))
        print_err(i,"[!] Process exited with error code %s and error message %s\n"%(exec_err.returncode,exec_err.output))
        continue

    output=output.decode('utf-8')
    events["raw_output"]=output

    split_output=output.split('\n')
    
    if split_output[-1]=="":
        split_output=split_output[:-1]

    if len(split_output)<2:
        print_warn(i,"[!] Checker printed out less than two lines! Assuming not wrapped calls compliant.")
        exec_status=2
        is_using_wrapped_syntax=False

    else:

        for line in split_output[2:]:
            
            if not len(line):
                continue

            try:
                event_type,file,line_number=line.split(',')
            except:
                print_warn(i,"[!] Split fail! Assuming checker %s is not wrapped calls compliant."%(i))
                is_using_wrapped_syntax=False
                exec_status=2
                break

            if event_type=="W":
                events["warn"].append([file,line_number])
                print_err(file,"[!] Checker %s got a warning for %s on line %s"%(i,file,line_number),line=line_number)
            elif event_type=="E":
                events["error"].append([file,line_number])
                print_err(file,"[!] Checker %s got a error for %s on line %s"%(i,file,line_number),line=line_number)
            else:
                print_warn(i,"[!] Event decoding fail! Assuming checker %s is not wrapped calls compliant"%(i))
                exec_status=2
                break

    if is_using_wrapped_syntax:
        script_name=split_output[0]
        description=split_output[1]
        if len(events["error"])==0 and len(events["warn"])==0:
            print("[+] Ran %s and got no warnings or errors"%(script_name))
            exec_status=1
        else:
            print("[+] Ran %s, got %i errors and %i warnings"%(script_name,len(events["error"]),len(events["warn"])))
            exec_status=0
    else:
        print("[+] Ran checker %s but finished with unknown status"%(i))
        script_name=i

    all_events.append([script_name,events,exec_status,description])

all_pass=True
failed_checks=[]
unformatted_raw_output=[]
table_content=""
errors_encountered=""

for name,events,exec_status,description in all_events:
    
    if exec_status==0:
        table_content+=TABLE_FORMAT%(name,"No %s"%(CROSS_MARK_EMOJI))
        all_pass=False
        failed_checks.append([name,events,description])
    elif exec_status==1:
        table_content+=TABLE_FORMAT%(name,"Yes %s"%(CHECK_MARK_EMOJI))
    elif exec_status==2:
        table_content+=TABLE_FORMAT%(name,"Unknown %s"%(QUESTION_MARK_EMOJI))
        unformatted_raw_output.append([name,events["raw_output"]])

formatted_raw_output=[]
for name,output in unformatted_raw_output:
    formatted_raw_output.append(UNFORMATTED_OUTPUT_FORMAT%(name,output))

formatted_raw_output='\n- - -\n'.join(formatted_raw_output)
cleaned_failed_checks={}

for name,events,description in failed_checks:

    for err_type,err in events.items():
        if err_type not in ["error","warn"]:
            continue

        for file,line_number in err:

            if file not in cleaned_failed_checks.keys():
                cleaned_failed_checks[file]={}
            
            if name not in cleaned_failed_checks[file].keys():
                cleaned_failed_checks[file][name]={}
                cleaned_failed_checks[file][name]["warn"]=[]
                cleaned_failed_checks[file][name]["error"]=[]
                cleaned_failed_checks[file][name]["description"]=description

            cleaned_failed_checks[file][name][err_type].append(int(line_number))

for file, checker in cleaned_failed_checks.items():
    for name, warn_and_errors in checker.items():

        for k,v in warn_and_errors.items():
            
            if k not in ["error","warn"]:
                continue

            v.sort()
            lines=[]

            for i in v:
                i=int(i)

                if not lines:
                    lines.append([i,i])
                    continue

                if lines[-1][1]+1==i:
                    lines[-1][1]=i
                else:
                    lines.append([i,i])

            warn_and_errors[k]=lines

if all_pass:
    error_text="All good! No checks failed."

else:

    error_text=[]
    check_results={}

    for file, checker in cleaned_failed_checks.items():
        for checker_name, warn_and_errors in checker.items():
            
            error_msg=""
            warn_msg=""
            current_errors=[]
            current_warnings=[]

            if checker_name not in check_results.keys():
                check_results.update({checker_name:{"warn":[],"error":[],"description":warn_and_errors["description"]}})

            for line_numbers in warn_and_errors["warn"]:
                
                line_numbers[0]=str(line_numbers[0])
                line_numbers[1]=str(line_numbers[1])

                if line_numbers[0]==line_numbers[1]:
                    current_warnings.append(line_numbers[0])
                    continue
                
                current_warnings.append('-'.join(line_numbers))

            for line_numbers in warn_and_errors["error"]:

                line_numbers[0]=str(line_numbers[0])
                line_numbers[1]=str(line_numbers[1])

                if line_numbers[0]==line_numbers[1]:
                    current_errors.append(line_numbers[0])
                    continue
                
                current_errors.append('-'.join(line_numbers))

            if current_errors:
                error_msg=ERROR_MSG%(file,', '.join(current_errors))
                check_results[checker_name]["error"].append(error_msg)

            if current_warnings:
                warn_msg=WARN_MSG%(file,', '.join(current_warnings))
                check_results[checker_name]["warn"].append(warn_msg)

    for checker,results in check_results.items():
    
        if len(results["error"])>0:
            error_msg='\n'.join(results["error"])
        else:
            error_msg="There are no errors for this check!"

        if len(results["warn"])>0:
            warn_msg='\n'.join(results["warn"])
        else:
            warn_msg="There are no warnings for this check!"
        error_text.append(FORMATTED_OUTPUT_FORMAT%(checker,results["description"],warn_msg,error_msg))

    error_text='\n- - -\n'.join(error_text)

open(STEP_SUMMARY_LOCATION,"w").write(SUMMARY_FORMAT%(table_content,error_text,formatted_raw_output))

if not all_pass:
    print_err(".bin/validators.py","[!] Not all checks passed.")
    exit(2)
