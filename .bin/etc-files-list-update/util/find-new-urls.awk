#!/usr/bin/awk -f
BEGIN {
  # load all the URLs we scanned already
  command = "util/print-urls.sh"
  while (command | getline) {
    urls[$0] = 1 # add to set
  }
  close(command)
  # get package URLs that do not appear in the list
  command = "util/get-package-urls.sh"
  while (command | getline) {
    if (!($0 in urls)) print
  }
}
