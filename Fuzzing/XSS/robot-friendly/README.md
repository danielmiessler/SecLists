# XSS Robot-Friendly version

This directory contains XSS you can test for. For human friendly versions, go to the [human-friendly](../human-friendly) directory.

There are some line you may need to change/take note in order for your testing process to go smoothly. (e.g. third party resources that may get flagged by WAF and the xss itself) 

Some XSS trigger condition may require you to interact with the web pages to trigger it. You should read through all the wordlists here and understand what each XSS does, then customizing it to your own needs.

`XSS-Vectors-Mario.txt` and `XSS-With-Context-Jhaddix.txt` may not work as well as before because all XSS are squished into one line and may break some xss that relies on new lines.

To see the results, look out for message popups or network activity in the devtools of your browser.

Happy hacking!