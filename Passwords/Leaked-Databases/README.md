## fortinet-2021.txt

`fortinet-2021.txt` contains:

- A [mimikatz](https://github.com/gentilkiwi/mimikatz) dump: Search for `mimikatz` and `SRV_TRAX_LAZ\admin`
- Active Directory LDAP dumps: Search for `cn=`
- IP addresses: Search for `10.1.0.0/20`
- Usernames in an unknown format that seem to be related to IP addresses: Search for lines that match the regex `^.*[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+`
- Encrypted username:password combos: Search for `LUU9P1g5y758fJ1M:{N|3D9g:|zYQB$yH?DIfAvTnk_MrUz3Ge:![zF)~n;t:4Tw^X2-`
- Poorly formatted username:password combinations: In some instances, there's single lines with several combos in the same line and no clear distinction as to where each combo begins and ends.

A cleaned-up version is available as `fortinet-2021_clean-combos.txt`. `fortinet-2021_clean-combos.txt` only contains the clearly distinguishable `username:password` lines.