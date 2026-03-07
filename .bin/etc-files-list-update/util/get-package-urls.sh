#!/bin/bash
set -euo pipefail

# get new package URLs
# load the list of amd64 packages from ubuntu
export dist="$(cat current_distro)"
export repo="http://archive.ubuntu.com/ubuntu"
export url="$repo/dists/$dist/main/binary-amd64/Packages.gz"

# print URLs
if ! data="$(curl -fsSL "$url")"; then
  echo "[ERROR] The download of package lists from Ubuntu failed. The URL was: \"$url\". Either the server is down, or it's time to update the distro name in this file: \"SecLists/.bin/etc-files-list-update/current_distro\"" >&2
  exit 1
fi

printf '%s' "$data" | gzip -d | awk -v repo="$repo" '/^Filename: / { print repo "/" $2 }'