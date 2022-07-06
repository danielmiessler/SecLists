#!/bin/bash

export url=$1

tf=$(mktemp -d)
wd=$(pwd)
cd $tf
wget "$url" -O output 2>/dev/null >/dev/null
ar -x output # extracts data.tar.xz control.tar.xz

# extract tar
if [ -f control.tar.xz ]; then
  xz -d control.tar.xz 2>/dev/null
elif [ -f control.tar.zst ]; then # need to install zstd
  zstd -d control.tar.zst 2>/dev/null
elif [ -f control.tar.gz ]; then
  tar -xzvf control.tar.gz 2>/dev/null >/dev/null
else
  (echo "$url unknown deb compression format" && ls) >> problems
  exit 0
fi

# extract control
tar -xvf control.tar 2>/dev/null >/dev/null

# replace 2 spaces after md5sum with tab
sed 's/^\([0-9a-zA-Z]*\)  /\1\t/' md5sums > inputdata

# print filenames
awk '
BEGIN {
  FS="\t"
}
{
  gsub(/^\.\//,"",$2)
  print "/" $2
}
' inputdata

# cleanup
cd "$wd"
rm -rf $tf
