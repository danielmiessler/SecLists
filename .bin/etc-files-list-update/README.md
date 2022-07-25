# Etc File List Updater

## Overview
The purpose of this set of scripts is to update the file `Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt`.
It is intended to be run periodically.
The scripts scan all deb packages in the ubuntu apt repository that have been updated since the last scan.
URLs that have been scanned will be added to a data file that can be stored in git.

## Running
The script must be run from its working directory.
```bash
cd .bin/etc-files-list-update && ./update.sh
```

## Details
URLs for deb files that have already been scanned are stored in gzip format in the `deb-url-history/` directory.
The current ubuntu distro for which packages are retrieved is stored in the file `current_distro`. This should be changed every few years.
