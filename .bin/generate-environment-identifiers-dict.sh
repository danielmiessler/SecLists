#!/usr/bin/env bash
# Script to build a list of of environment identifiers based on sub domain names.
## References:
# See https://blog.majestic.com/development/alexa-top-1-million-sites-retired-heres-majestic-million/
# See https://github.com/danielmiessler/SecLists/issues/654
# See https://github.com/danielmiessler/SecLists/pull/671
## Requires jq
#
# Add more top level domain in the expression below
TLD_WANTED_EXPR="\.(lu|be)$"
#
echo "[+] Download Majestic CSV file..."
wget -O majestic.csv https://downloads.majestic.com/majestic_million.csv
echo "[+] Extract wanted domains..."
cat majestic.csv | cut -d',' -f3 | grep -E $TLD_WANTED_EXPR > domains.txt
wc -l domains.txt
echo "[+] Extract sub domains via Certificate Transparency logs (https://crt.sh)..."
while IFS= read -r line
do
	printf "\rDomain: %-40s" "$line"
	curl -sk "https://crt.sh/?q=$line&output=json" | jq -r ".[].name_value" | cut -d'.' -f1 1>> subdomains.txt 2>/dev/null
done < domains.txt
cat subdomains.txt | sort -u > subdomains.tmp
mv subdomains.tmp subdomains.txt 
wc -l subdomains.txt
echo "[+] Extract environment like sub domains..."
grep -Ei "^(de|dv|ts|te|in|st|ho|pr|pp)" subdomains.txt > env-like-subdomains.txt
echo "[i] Manually review the generated file 'env-like-subdomains.txt' for accurate content."
wc -l env-like-subdomains.txt
