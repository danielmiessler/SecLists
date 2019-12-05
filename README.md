![seclists.png](https://danielmiessler.com/images/seclists-long.png "seclists.png")

### About SecLists

SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more. The goal is to enable a security tester to pull this repository onto a new testing box and have access to every type of list that may be needed.

This project is maintained by [Daniel Miessler](https://danielmiessler.com/), [Jason Haddix](http://www.securityaegis.com), and [g0tmi1k](https://twitter.com/g0tmi1k).

- - -

### Install

**Zip**
```
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
  && unzip SecList.zip \
  && rm -f SecList.zip
```

**Git (Small)**
```
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
```

**Git (Complete)**
```
git clone https://github.com/danielmiessler/SecLists.git
```

**Kali Linux** ([Tool Page](https://tools.kali.org/password-attacks/seclists))
```
apt -y install seclists
```

- - -

### Attribution

See [CONTRIBUTORS.md](CONTRIBUTORS.md)

- - -

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

- - -

### Similar Projects

* [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
* [FuzzDB](https://github.com/fuzzdb-project/fuzzdb)

- - -

### Licensing

This project is licensed under the [MIT license](LICENSE).

![MIT License](https://danielmiessler.com/images/mitlicense.png)

—

<sup>NOTE: Downloading this repository is likely to cause a false-positive alarm by your anti-virus or anti-malware software, the filepath should be whitelisted. There is nothing in SecLists that can harm your computer as-is, however it's not recommended to store these files on a server or other important system due to the risk of local file include attacks.</sup>
