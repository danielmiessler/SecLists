#!/usr/bin/bash

set -e 
set -o pipefail

mkdir -p .working_space
cd .working_space
git clone --depth=1 https://github.com/trickest/wordlists.git
cd ../

./.bin/trickest-patcher.py
rm -rf .working_space