# Web-Server wordlists

The wordlists contained in this directory are specific for testing certain **web server software**.

## Java-Servlet-Runner-Adobe-JRun
Use for: Fuzzing for common filepaths in webpages served with **[Java Servlet Runner (Adobe JRun)](https://adobe.fandom.com/wiki/JRun)**

Year of the first release of Java Servlet Runner (Adobe JRun): 1997    
Year of the last release of Java Servlet Runner (Adobe JRun): 2007

Date of last update: Oct 14, 2010


## Oracle-Sun-iPlanet.txt
Use for: Fuzzing for common filepaths in webpages served with **[Oracle Sun iPlanet](https://www.oracle.com/middleware/technologies/webtier.html)**

Year of the first release of Sun-iPlanet (Adobe JRun): 1994    
Year of the last release of Sun-iPlanet (Adobe JRun): 2017

Date of last update: Oct 14, 2010


## Glassfish-Sun-Microsystems.txt
Use for: Fuzzing for common filepaths in webpages served with **[Glassfish - Sun Microsystems](https://glassfish.org/)**

Year of the first release of Glassfish: [2005](https://en.wikipedia.org/wiki/GlassFish)    
Glassfish is still in recieving updates as of 2024.

Date of last update: Oct 14, 2010


## Apache.fuzz.txt
Use for: Discvering sensitive content in Apache web servers.

Date of last update: Jan 26, 2015


## Apache-Tomcat.txt
Use for: Discovering sensitive content in Apache Tomcat servers.

Date of last update: Dec 14, 2017


## iis-systemweb.txt
Use for: Fuzzing the `/aspnet_client/system_web/` directory on [Microsoft IIS](https://www.iis.net/) servers to detect **CGIs** and **scripts** even even if the two ladder directories are inaccessible.

Reference: https://github.com/irsdl/IIS-ShortName-Scanner

Discussion: https://github.com/danielmiessler/SecLists/pull/783

Date of last update: Jun 27, 2022


## JBoss.txt
Use for: Fuzzing for common filepaths in webpages served with **[JBoss - RedHat](https://jbossas.jboss.org)** (not to be confused with "JBoss EAP").

Date of the first release of JBoss: [2002-05-29](https://jbossas.jboss.org/downloads/)    
Date of the last release of JBoss: 2012-03-09

Date of last wordlist update: Feb 27, 2014


## Apache-Axis.txt
Use for: Fuzzing for common filepaths in webpages created with **[Apache Axis](https://axis.apache.org/axis/)**

Date of the first release of Apache Axis: [2002-10-07](https://jbossas.jboss.org/downloads/)    
Date of the last release of Apache Axis: 2006-04-22


## IIS-POST.txt
Use for: Fuzzing for Microsoft IIS files which require being scanned for with the HTTP POST verb