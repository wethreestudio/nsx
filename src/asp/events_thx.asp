<%
errmsg=trim(request("errmsg") & " ")
%>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle,enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><font face="Arial">THANK YOU</h1>
	
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
		Thank you for telling us about your event.
		
		
		<%if errmsg<>"" then %>
		
		<p>However, there were some problems with what you have submitted: <b><font color=red> <%=errmsg%></font></b></p>
		
		
		
		<%end if%>
		
		<p>If you have any changes to 
		your entry please <a href="contacts.asp">
		Contact Us</a> </p>
		<p>The Staff,<br>
		<b>NSX</b></p>
		<p>Go to full <a href="events_list.asp">list of events</a></p>
		<p><b>Please Note: </b>The NSX reserves the right to not publish an 
		event notification.&nbsp; For the service to be relevant to NSX website 
		users the NSX would prefer corporate, industrial and finance industry 
		related event notifications such as conferences, seminars and workshops.&nbsp; 
		This is a free service.</p>
	



<p align="center">&nbsp;</p>
	<p align="center">&nbsp;</p>
    </td>
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->

</body>

</html>
