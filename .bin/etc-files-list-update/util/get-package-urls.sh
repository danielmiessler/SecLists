#!/bin/bash

# get new package URLs
# load the list of amd64 packages from ubuntu
export dist="$(cat current_distro)"
export repo="http://archive.ubuntu.com/ubuntu"

# print URLs
curl $repo/dists/$dist/main/binary-amd64/Packages.gz | \
  gzip -d | awk '/^Filename: / { print ENVIRON["repo"] "/" $2 }'
