## Add new date formats using / editing the bash script.
Example:
```
YEAR=2019; mkdir -p "$YEAR"; FILE="$YEAR/${YEAR}-MM-DD.txt"; for m in {01..12}; do for d in {01..31}; do echo "$YEAR-$m-$d" >> "$FILE"; done; done
```
