#!/usr/bin/env python3

import json
import os
from datetime import datetime, timedelta
import re
import requests

# TODO Summary file 

BASE_PATH = ".bin/wordlist-updaters"
SOURCE_PATH = os.path.join(BASE_PATH, "sources.json")
STATUS_PATH = os.path.join(BASE_PATH, "status.json")
FREQUENCY_REGEX = r"^(?:([0-9]+)d|())(?:([0-9]+)h|())(?!.*?d)$"
VALID_TYPES = ["file", "git_dir"]

def request_wrapper(url):

    for i in range(1,4):
        r = requests.get(url)
        if r.status_code == 200:
            # print("[+] Got %s successfully!"%(url))
            break
        if i == 3:
            print("[!] Failed to get %s."%(url))
            exit(2)
        print("[!] Getting %s failed(%i/3)"%(url,i))

    return r.text

# Check if the files exists
if not os.path.isfile(SOURCE_PATH):
    print("[!] Sources.json is missing!")
    exit(2)

if not os.path.isfile(STATUS_PATH):
    print("[!] Status.json is missing!")
    exit(2)

SOURCES = json.load(open(SOURCE_PATH, "r"))
STATUS = json.load(open(STATUS_PATH, "r"))

to_check = []

for source in SOURCES:
    task_name = source["name"]

    if not task_name in STATUS.keys():
        print(f"[+] Queuing task {task_name} as task was never checked before")
        to_check.append(source)
        continue

    if not "last_update" in STATUS[task_name].keys() or not isinstance(STATUS[task_name]["last_update"], int):
        print(f"[!] Queuing task {task_name} as last_update field is missing/invalid")
        to_check.append(source)
        continue

    if not "frequency" in source.keys() or not isinstance(source["frequency"], str):
        print(f"[!] Skipping task {task_name} as frequency field is missing/invalid")
        continue

    if not "output" in source.keys() or not isinstance(source["output"], str):
        print(f"[!] Skipping task {task_name} as output field is missing/invalid")
        continue

    if not "type" in source.keys() or not isinstance(source["type"], str):
        print(f"[!] Skipping task {task_name} as type field is missing/invalid")
        continue

    if not source["type"] in VALID_TYPES:
        print(f"[!] Skipping task {task_name} as type is invalid")
        continue

    if source["output"].startswith("/"):
        print(f"[!] Skipping task {task_name} as output path is not relative.")
        continue

    regex_match = re.search(FREQUENCY_REGEX, source["frequency"])

    if not regex_match:
        print(f"[!] Skipping task {task_name} as frequency field contains invalid formatting of days and hours")
        continue

    days, _, hours, _ = regex_match.groups()

    days = bool(days) | 0
    hours = bool(hours) | 0

    next_update_time = datetime.fromtimestamp(STATUS[task_name]["last_update"]) + timedelta(days=days, hours=hours)
    time_now = datetime.now()
    time_from_update = time_now - next_update_time

    if time_now < next_update_time:
        if time_from_update.seconds <= 300:
            print(f"[+] Queuing task {task_name} as it is less than 5 minutes to update. ({time_from_update.seconds} seconds to update)")
            to_check.append(source)
            continue

        print(f"[!] Skipping task {task_name} as it is more than 5 minutes to update ({time_from_update.seconds} seconds to update)")
        continue

    print(f"[+] Queuing task {task_name} as it is {time_from_update.seconds} seconds after scheduled update time.")
    to_check.append(source)
    
if len(to_check) == 0:
    print(f"[!] No task were queued. Exiting.")
    exit()

print(f"[+] Queued a total of {len(to_check)} tasks to run.")

for task in to_check:
    print(f"[+] Starting task {task['name']}")
    
    if task["type"] == "file":
        content = request_wrapper(task["source"])
        open(task["output"], "w").write(content)
        print(f"Saved file to output location")
    print(f"[+] Finished task {task['name']}")
    