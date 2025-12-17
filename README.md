<div align="center">
    <a href="https://go.warp.dev/seclists" target="_blank">
        <sup>Special thanks to:</sup>
        <br>
        <img alt="Warp sponsorship" width="400" src="https://github.com/warpdotdev/brand-assets/blob/main/Github/Sponsor/Warp-Github-LG-02.png">
        <br>
        <h>Warp, built for coding with multiple AI agents</b>
        <br>
        <sup>Available for macOS, Linux and Windows</sup>
    </a>
</div>


</div>

---

![seclists.png](SecLists.png "seclists.png")

### About SecLists

SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more. The goal is to enable a security tester to pull this repository onto a new testing box and have access to every type of list that may be needed.

This project is maintained by [Daniel Miessler](https://danielmiessler.com/), [Jason Haddix](https://twitter.com/Jhaddix), [Ignacio Portal](https://github.com/ItsIgnacioPortal) and [g0tmi1k](https://blog.g0tmi1k.com/).

- - -


### Repository details

![Repo size](https://img.shields.io/github/repo-size/danielmiessler/SecLists.svg)

<!-- This badge is automatically updated by a GitHub Action. Do not edit manually. -->
![Approx cloning time](https://img.shields.io/badge/clone%20time-~%207m%2023s%20@50Mb/s-blue)


- - -

### Install

**Zip**

```
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip && unzip SecList.zip && rm -f SecList.zip
```

**Git: No commit history (faster)**

```
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
```

**Git: Complete**

```
git clone https://github.com/danielmiessler/SecLists.git
```

**Kali Linux** ([Tool Page](https://www.kali.org/tools/seclists/))

```
apt -y install seclists
```

**BlackArch** ([Tool Page](https://blackarch.org/tools.html))

```
sudo pacman -S seclists
```

- - -

### Attribution

See [CONTRIBUTORS.md](CONTRIBUTORS.md)

- - -

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

- - -

### Similar Projects

- [Assetnote Wordlists](https://wordlists.assetnote.io/): High quality wordlists for content and subdomain discovery which are automatically updated every month.
- [fuzz.txt](https://github.com/Bo0oM/fuzz.txt): Wordlists of "potentially dangerous" files.
- [FuzzDB](https://github.com/fuzzdb-project/fuzzdb): Dictionary of attack patterns and primitives for black-box application fault injection and resource discovery. 
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings): A list of useful payloads and bypass for Web Application Security and Pentest/CTF 
- [BiblePass](https://github.com/MusicGivesMeLife/BiblePass): Wordlists compiled from Bible verses
- [SamLists](https://github.com/the-xentropy/samlists): Data-driven wordlists containing HTTP parameter names, directory names and filenames.

### Wordlist Tools

- [Cook](https://github.com/giteshnxtlvl/cook): A wordlist framework. An overpowered wordlist generator, splitter, merger, finder and saver. Cook facilitates the creation of permutations and combinations with a variety of encodings and many more features.
- [Wl](https://github.com/s0md3v/wl): CLI utility for converting strings to a given casing style.
- [CeWL](https://github.com/digininja/CeWL): Custom Word List generator.
- [Genoveva](https://github.com/joseaguardia/GENOVEVA): From a word list, it generates up to 17,335,754 combinations per word, mixing lowercase, capitalized, uppercase, full and partial L33T (for each vowel and "s"), reverse, numbers from 1 to 4 digits, dates in mmddyyyy format from 1950 to 2030, date format mmddyy, symbols at the end, symbols between name and date...

- - -

### Licensing

This project is licensed under the [MIT license](LICENSE).

[![MIT License](https://img.shields.io/badge/license-MIT_License-blue)](https://opensource.org/licenses/MIT)

<sup>NOTE: Downloading this repository is likely to cause a false-positive alarm by your anti-virus or anti-malware software, the filepath should be whitelisted. There is nothing in SecLists that can harm your computer as-is, however it's not recommended to store these files on a server or other important system due to the risk of local file include attacks.</sup>
