![seclists.png](https://danielmiessler.com/images/seclists-long.png "seclists.png")

# About SecList

SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more. The goal is to enable a security tester to pull this repo onto a new testing box and have access to every type of list that may be needed.

This project is maintained by [Daniel Miessler](http://www.danielmiessler.com/ "Daniel Miessler") and [Jason Haddix](http://www.securityaegis.com "Jason Haddix").

## Attribution

- Adam Muntner (@amuntner) and for the **FuzzDB** content, including all authors from the FuzzDB project (https://github.com/fuzzdb-project/fuzzdb) [`./Fuzzing/*.fuzzdb.txt`]
- Ron Bowes (@iagox86) of **SkullSecurity** for collaborating and including all his lists here (https://wiki.skullsecurity.org/Passwords)
- Clarkson University for their research that led to the **Clarkson password** list [`./Passwords/clarkson-university-82.txt`]
- All the authors listed in the XSS with context doc, which was found on pastebin and added to by us
- Ferruh Mavituna for the beginnings of the **LFI Fuzz** list
- Kevin Johnson for **Laudanum shells** (https://sourceforge.net/projects/laudanum/) [`./Web-Shells/laudanum-0.8/`]
- RSnake for **fierce DNS hostname** list [`./Discovery/DNS/fierce-hostlist.txt`]
- Charlie Campbell for **Spanish word list**, numerous other contributions
- Rob Fuller (@mubix) for the IZMY list [`./Passwords/Leaked-Databases/izmy.txt`]
- Mark Burnett for the **10 million passwords** list
- Steve Crapo for doing splitting work on a number of large lists
- Thanks to Blessen Thomas for recommending **Mario's/cure53's XSS vectors**
- Thanks to Danny Chrastil for submitting an anonymous **JSON fuzzing** list
- Many thanks to @geekspeed, @EricSB, @lukebeer, @patrickmollohan, @g0tmi1k, @albinowax, and @kurobeats for submitting via pull requests
- Special thanks to @shipCod3 for MANY contributions and for a **SSH user/pass** list
- Thanks to Samar Dhwoj Acharya for allowing his **GitHub Dorks** content to be included
- Thanks to Liam Somerville for the excellent list of **default passwords**
- Great thanks to Michael Henriksen for allowing us to include his **Gitrob project's signatures**
- Honored to have @Brutelogic's brilliant **XSS Cheatsheet** added to the Fuzzing section [`./Fuzzing/XSS*-BruteLogic.txt`]
- 0xsobky's **Ultimate XSS Polyglot** [`./Fuzzing/Polyglots/XSS-Polyglot-Ultimate-0xsobky.txt`]
- @otih for **bruteforce collected user/pass** lists [`./Passwords/Honeypot-Captures/multiplesources-passwords-fabian-fingerle.de.txt`]
- @govolution for **BetterDefaultPassList** (https://github.com/govolution/betterdefaultpasslist) [`./Passwords/Default-Credentials/*-betterdefaultpasslist.txt`]
- Max Woolf (@minimaxir) for **Big List of Naughty Strings** (https://github.com/minimaxir/big-list-of-naughty-strings) [`./Fuzzing/big-list-of-naughty-strings.txt`]
- Ian Gallagher (@craSH) for **HTTP Request Headers** [`./Miscellaneous/http-request-headers/`]
- Arvind Doraiswamy (@arvinddoraiswamy) for **numeric-fields-only** [`./Fuzzing/numeric_fields_only.txt`]
- @badibouzouk for **Domino Hunter** (https://sourceforge.net/projects/dominohunter/) [`./Discovery/Web-Content/Domino-Hunter/`]
- @coldfusion39 for **domi-owned** (https://github.com/coldfusion39/domi-owned) [`./Discovery/Web-Content/domino-*-coldfusion39.txt`]
- Ella Rose (@erose1337) for **security-question-answers** (https://github.com/erose1337/penetration_testing/tree/master/data) [`./Miscellaneous/security-question-answers/`]
- @D35m0nd142 for **LFISuite** (https://github.com/D35m0nd142/LFISuite) [`./Fuzzing/LFI-LFISuite-pathtotest*.txt`]

This project stays great because of care and love from the community, and we will never forget that. If you know of a contribution that is not listed above, please let us know...

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Licensing

This project is licensed under the MIT license.

![MIT License](https://danielmiessler.com/images/mitlicense.png)

—

<sup>NOTE: Downloading this repository is likely to cause a false-positive alarm by your antivirus or antimalware software, the filepath should be whitelisted. There is nothing in Seclists or FuzzDB that can harm your computer as-is, however it's not recommended to store these files on a server or other important system due to the risk of local file include attacks.</sup>
