# CGIs

These wordlists are for testing legacy systems that use **Common Gateway Interface** scripts.

## CGI-HTTP-POST-Windows.fuzz.txt
Use for: Exploiting various vulnerabilities in the now defunct WYSIWYG HTML editor and website administration tool, [Microsoft FrontPage](https://en.wikipedia.org/wiki/Microsoft_FrontPage)

Source: https://github.com/deepak0401/Front-Page-Exploit

Date of last update: Aug 27, 2012

The last version of FrontPage was released on 2003.

## CGI-HTTP-POST.fuzz.txt
Use for: Exploiting/Discovering various vulnerabilities in extremely old systems (Circa 1998) that use "CGI". 

Date of last update: Aug 27, 2012

This wordlist tests for the following vulnerabilities:
- Default password in the [Nortel Meridian](https://en.wikipedia.org/wiki/Nortel_Meridian) private branch exchange **telephone switching system**. Source: [Nikto](https://github.com/sullo/nikto/blob/07653b73cb711972df72a8c66191468705a9b14e/program/databases/db_tests#L1167).
- XSS in the **"Bajie HTTP JServer"** (software site completely defunct, no archives exist). Source: [Nikto](https://github.com/sullo/nikto/blob/07653b73cb711972df72a8c66191468705a9b14e/program/databases/db_tests#L803)
- CGI Vulnerability in an unknown system (payload `lastlines.cgi?process`) which would allow attackers to "read arbitrary files and/or execute commands". Source: [Nikto](https://github.com/sullo/nikto/blob/07653b73cb711972df72a8c66191468705a9b14e/program/databases/db_tests#L1036)
- Remote File Include in **[myPHPNuke](https://web.archive.org/web/20140812223623/http://www.myphpnuke.com/)**. Source: [Nessus](https://www.tenable.com/plugins/nessus/11836)
- DoS in the **"D-Link Ethernet/Fast Ethernet Print Server DP-300+"**. Source: [Sullo's Security Advisory Archive](https://raw.githubusercontent.com/sullo/advisory-archives/master/phenoelit.de_dp-300.txt).


## CGI-Microsoft.fuzz.txt
Use for: Exploiting/Discovering various vulnerabilities in miscelaneous CGI scripts that run on Microsoft operating systems.

Date of last update: Aug 27, 2012