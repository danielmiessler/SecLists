# CMS Wordlists

These wordlists are specific to Content Management Systems.

## AdobeCQ-AEM_2017.txt
Use for: Discovering sensitive filepaths of **Adobe Experience Manager**
Creation date: Oct 1, 2017
No updates have been made to this wordlist since its creation.


## Oracle-EBS-wordlist.txt
Use for: Fuzzing for common filepaths of [Oracle E-Business Suite](https://www.oracle.com/applications/ebusiness/) (EBS) version 11.

EBS v11 exposes:
- usernames
- ports
- OS information
- protocol information
- Unauthenticated file upload
- Cookie contents
- SHA-1 hashed passwords

As an Unauthenticated user it's also possible to:
- Create forms
- Get servlets status
- Get certain configuration files

Reference: https://the-infosec.com/2017/03/29/do-you-know-what-your-erp-is-telling-us/

Date of last update: Oct 7, 2019