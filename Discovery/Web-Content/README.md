# Web discovery wordlists

## AdobeXML.fuzz.txt
Use for: Discovering sensitive filepaths of **Adobe ColdFusion**

Creation date: Aug 27, 2012

No updates have been made to this wordlist since its creation.


## raft-* wordlists
Use for: Directory and file brute-forcing leading to identification of vulnerabilities in web applications.

Source: [Google's RAFT](https://code.google.com/archive/p/raft/)


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

These are the wordlists that compose this wordlist:
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
- common_directories.txt

## dsstorewordlist.txt

Use for: discovering files and directories

This wordlist was collected by parsing Alexa top-million sites for **[.DS_Store](https://en.wikipedia.org/wiki/.DS_Store)** files, extracting all the found files, and then extracting found file and directory names from around 300k real websites. The files were then sorted by probability and one-occurrence strings were removed.

Source: https://github.com/aels/subdirectories-discover

## vulnerability-scan_j2ee-websites_WEB-INF.txt
Use for: discovering sensitive j2ee files exploiting a lfi

References:
- https://gist.github.com/harisec/519dc6b45c6b594908c37d9ac19edbc3
- https://github.com/projectdiscovery/nuclei-templates/blob/master/vulnerabilities/generic/generic-j2ee-lfi.yaml
- https://github.com/ilmila/J2EEScan/blob/master/src/main/java/burp/j2ee/issues/impl/LFIModule.java


## Microsoft-Frontpage.txt
Use for: Fuzzing for common filepaths in webpages designed with **[Microsoft Frontpage](https://en.wikipedia.org/wiki/Microsoft_FrontPage)**

Year of the first release of Microsoft Frontpage: 1997

Year of the last release of Microsoft Frontpage: 2003

Date of last update: Oct 14, 2010

## graphql.txt
Use for: Fuzzing for common filepaths in webpages that use the **[GraphQL Query Language](https://graphql.org/)**

## reverse-proxy-inconsistencies.txt
Use for: Detecting the backend admin/console interfaces and tomcat manager interfaces hiding behind reverse proxies by leveraging inconsistencies in how certain requests are handled.

See: [A fresh look on reverse proxy related attacks | acunetix.com | Aleksei Tiurin | 2019-01-22](https://www.acunetix.com/blog/articles/a-fresh-look-on-reverse-proxy-related-attacks/)