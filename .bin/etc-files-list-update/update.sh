#!/bin/bash

export listpath="../../Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt"
[ -f all_files.gz ] && rm all_files.gz

# every year, start a new gzip list so there is not as much bloat updating blobs in git
year=$(date +%Y)

echo "finding URLs" 1>&2

# get new URLs
util/find-new-urls.awk > url_batch

# exit if there's no new URLs to scan
if [[ $(wc -l url_batch | awk '{print $1}') == 0 ]]
then
  echo "no new URLs" 1>&2
  rm url_batch
  exit 0
fi

# scan them
for u in $(cat url_batch)
do
  echo "scanning $u" 1>&2
  util/scan-package.sh "$u" | gzip >> all_files.gz
done

echo "searching for etc files" 1>&2

# get all files matching /etc/
# ignore repeat files already in the list
zcat all_files.gz | awk '
BEGIN {
  lp = ENVIRON["listpath"]
  while (getline < lp) {
    seen[$0] = 1
  }
}
/^\/etc\// && !seen[$0] { print }
' > updated_etc_files

echo "updating list" 1>&2

# concatenate the existing list and the output
cat "$listpath" updated_etc_files > updated_file

# update the list
mv updated_file "$listpath"

# save progress
cat url_batch | gzip >> "deb-url-history/$year.gz"

# cleanup
rm url_batch
rm updated_etc_files
rm all_files.gz
