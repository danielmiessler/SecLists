The Passwords directory will hold a number of password lists that can be used by multiple tools when attempting to guess credentials for a given targeted service. This will include a number of very popular lists in cooperation with their maintainers, including the RockYou lists maintained by Rob Bowes.

---

- Password lists containing the count are located in the "withcount" folder.
- Lists over 100Mb have been compressed.


## scraped-JWT-secrets.txt

This wordlist is from <https://github.com/wallarm/jwt-secrets>
<br><br>

## SCRABBLE-hackerhouse.tgz

**Use for:** Cracking passwords

**Structure of the wordlist:** Uppercase and lowercase iterations of a set of 45,380 words, with a single digit ranging 0 to 9 at the end. This wordlist has been made using the Scrabble words dictionary. Contains a total of 589,940 lines.

_Source: https://github.com/hackerhouse-opensource/tools_

## cve-2026-123158-long-passwords.txt

**Use for:** Credential guesses made of synthetic passwords longer than 256 characters. The first five sit inside the 257–1024 character window documented for CVE-2026-123158 (SSHole). Twenty more continue past that window, through 2048 and up to 6144 characters.

**Structure of the wordlist:** Twenty-five unique lines, ordered by length. Each password starts with `lenNNN-` and is padded with `A` to that exact length. The file has no comments.

_Source: https://sshhole.com/_

_Reference: https://nvd.nist.gov/vuln/detail/CVE-2026-123158_

---

Some passwords lists are +100MB and can't be stored on the repository. The following are external links to download more:

- [Breach compilation](https://web.archive.org/web/20200501154512/https://gist.github.com/scottlinux/9a3b11257ac575e4f71de811322ce6b3) _(original link recovered)_
- [Weakpass](https://weakpass.com/)
