#!/usr/bin/env python3

import os
import re
import json
import requests
import subprocess
from datetime import datetime, timedelta

# TODO Summary file
# TODO Advanced crontab syntax

BASE_PATH = ".bin/wordlist-updaters"
SOURCE_PATH = os.path.join(BASE_PATH, "sources.json")
STATUS_PATH = os.path.join(BASE_PATH, "status.json")
FREQUENCY_REGEX = r"^(?:([0-9]+)d|())(?:([0-9]+)h|())(?!.*?d)$"
VALID_TYPES = ["file", "git_dir"]
TIME_NOW = datetime.now()


def request_wrapper(url):
    for i in range(1, 4):
        r = requests.get(url)
        if r.status_code == 200:
            # print("[+] Got %s successfully!"%(url))
            break
        if i == 3:
            print("[!] Failed to get %s." % (url))
            exit(2)
        print("[!] Getting %s failed(%i/3)" % (url, i))

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
    source_keys = source.keys()

    if task_name not in STATUS.keys():
        print(f"[+] Queuing task {task_name} as task was never checked before")
        to_check.append(source)
        continue

    if "output" not in source_keys or not isinstance(source["output"], str):
        print(f"[!] Skipping task {task_name} as output field is missing/invalid")
        continue

    if "type" not in source_keys or not isinstance(source["type"], str):
        print(f"[!] Skipping task {task_name} as type field is missing/invalid")
        continue

    if source["type"] not in VALID_TYPES:
        print(f"[!] Skipping task {task_name} as type is invalid")
        continue

    if source["output"].startswith("/"):
        print(f"[!] Skipping task {task_name} as output path is not relative.")
        continue

    if source["type"].startswith("git_") and not source["source"].endswith(".git"):
        print(
            f"[!] Skipping task {task_name} as a git task was defined with a non git url."
        )
        continue

    if "last_update" not in STATUS[task_name].keys() or not isinstance(
        STATUS[task_name]["last_update"], int
    ):
        print(f"[!] Queuing task {task_name} as last_update field is missing/invalid")
        to_check.append(source)
        continue

    if not ("frequency" in source_keys) ^ ("update_time" in source_keys):
        print(
            f"[!] Skipping task {task_name} as only frequency or update_time can be specified"
        )
        continue

    if "frequency" in source_keys and isinstance(source["frequency"], str):
        regex_match = re.search(FREQUENCY_REGEX, source["frequency"])

        if not regex_match:
            print(
                f"[!] Skipping task {task_name} as frequency field contains invalid formatting of days and hours"
            )
            continue

        days, _, hours, _ = regex_match.groups()

        days = int(days or 0)
        hours = int(hours or 0)

        next_update_time = datetime.fromtimestamp(
            STATUS[task_name]["last_update"]
        ) + timedelta(days=days, hours=hours)

        time_to_update = int((next_update_time - TIME_NOW).total_seconds())

        if TIME_NOW > next_update_time:
            print(
                f"[+] Queuing task {task_name} as it is {time_to_update} seconds after scheduled update time."
            )
            to_check.append(source)
            continue

        elif time_to_update <= 300:
            print(
                f"[+] Queuing task {task_name} as it is less than 5 minutes to update. ({time_to_update} seconds to update)"
            )
            to_check.append(source)
            continue

        print(
            f"[!] Skipping task {task_name} as it is more than 5 minutes to update ({time_to_update} seconds to update)"
        )
        continue

    elif "update_time" in source_keys and isinstance(source["update_time"], str):
        update_time = source["update_time"]

        if len(update_time) != 4 and update_time.isnumeric():
            print(f"[!] Skipping task {task_name} as it is in a incorrect format")
            continue

        hours = int(update_time[:2])
        minutes = int(update_time[2:])

        if hours not in range(1, 25):
            print(f"[!] Skipping task {task_name} as hours is not in range 1-24.")
            continue

        if minutes not in range(1, 61):
            print(f"[!] Skipping task {task_name} as minutes is not in range 1-60.")
            continue

        scheduled_update_time = TIME_NOW.replace(hour=hours, minute=minutes)
        if (
            TIME_NOW <= scheduled_update_time
            and TIME_NOW + timedelta(hours=1) >= scheduled_update_time
        ):
            print(
                f"[+] Queuing task {task_name} as update time is within the next hour"
            )
            to_check.append(source)
            continue

    else:
        print(f"[!] Skipping task {task_name} as update_time field is invalid")
        continue

if len(to_check) == 0:
    print("[!] No task were queued. Exiting.")
    exit()

print(f"[+] Queued a total of {len(to_check)} tasks to run.")

for task in to_check:
    print(f"[+] Starting task {task['name']}")

    if task["name"] not in STATUS.keys():
        STATUS[task["name"]] = {}

    task_type = task["type"]

    if task_type == "file":
        content = request_wrapper(task["source"])
        open(task["output"], "w").write(content)
        print("[+] Saved file to output location")

        STATUS[task["name"]]["last_update"] = int(datetime.now().timestamp())

    elif task_type == "git_dir":
        if not os.path.exists(task["output"]):
            print(f"[+] Making directory {task['output']}")
            os.makedirs(task["output"])

        subprocess.run(
            ["git", "clone", "-q", "--depth=1", task["source"]], cwd=task["output"]
        )
        STATUS[task["name"]]["last_update"] = int(datetime.now().timestamp())

    if task["post_run_script"]:
        print("[+] Running post run script")
        subprocess.run(task["post_run_script"])
        print("[+] Finished running post run script")

    print(f"[+] Finished task {task['name']}")

json.dump(STATUS, open(STATUS_PATH, "w"), indent=4)
