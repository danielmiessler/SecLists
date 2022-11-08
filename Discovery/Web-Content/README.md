# Web discovery wordlists

## combined_words.txt

Use for: discovering files    
This list is automatically updated by a github action whenever any of the lists it's composed by is modified.

This list is a combination of the following wordlists:

- big.txt
- common.txt
- raft-large-words-lowercase.txt
- raft-large-words.txt
- raft-medium-words-lowercase.txt
- raft-medium-words.txt
- raft-small-words-lowercase.txt
- raft-small-words.txt


## combined_directories.txt

Use for: discovering files and directories    
This list is automatically updated by a github action whenever any of the lists it's composed by is modified.

This list is a combination of the following wordlists:
- apache.txt
- combined_words.txt
- directory-list-1.0.txt
- directory-list-2.3-big.txt
- directory-list-2.3-medium.txt
- directory-list-2.3-small.txt
- raft-large-directories-lowercase.txt
- raft-large-directories.txt
- raft-medium-directories-lowercase.txt
- raft-medium-directories.txt
- raft-small-directories-lowercase.txt
- raft-small-directories.txt

## dsstorewordlist.txt

Source: https://github.com/aels/subdirectories-discover
Perfect wordlist to discover directories and files on target site with tools like ffuf.

- It was collected by parsing Alexa top-million sites for .DS_Store files (https://en.wikipedia.org/wiki/.DS_Store), extracting all the found files, and then extracting found file and directory names from around 300k real websites.
- Then sorted by probability and removed strings with one occurrence.
- Resulted file you can download is below. Happy Hunting!
