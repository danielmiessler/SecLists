#!/usr/bin/env bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed

set -e 
set -o pipefail

# wrapper for all the checking scripts
echo $1
./.bin/check-file-for-starting-slash "$1"
./.bin/new-line-and-empty-line-checker.py "$1"