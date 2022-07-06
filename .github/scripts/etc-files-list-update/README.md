# etc file list updater

## overview
The purpose of this set of scripts is to scan deb packages from the ubuntu apt repository.

## running
The script must be run from its working directory.
```bash
cd .github/scripts/etc-files-list-update && ./update.sh
```

## details
URLs for deb files that have already been scanned are stored in gzip format in the `deb-url-history/` directory.
The current ubuntu distro for which packages are retrieved is stored in the file `current_distro`. This should be changed every few years.
