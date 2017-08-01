<%@ LANGUAGE="VBSCRIPT" %>
<%
Response.Buffer = False
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

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
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" style="background-color: #FFFFFF" >
<table cellpadding="4" style="border-collapse: collapse; " width="100%">
	<tr>
		<td class="plaintext" bgcolor="#959CA0">
		<font color="#FFFFFF"><b>General</b></font></td>
		<td class="plaintext" bgcolor="#959CA0" align="right"><b>
		<a target="_blank" href="<%= Application("nsx_SiteRootURL") %>"><font color="#FFFFFF">NSX</font></a></b></td>
	</tr>
	<%
	 
 		 	cl = array("#EEEEEE","#FFFFFF")
 		 	lap = 1
		
%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext"><font color="#000000" size="1">Issuers</font></td>
		<td class="plaintext" align="right">
		<font size="1">37</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext">
		<font color="#000000" size="1">Securities</font></td>
		<td class="plaintext" align="right">
		<font size="1">97</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext"><font color="#000000" size="1">Market 
          Capitalisation</font></td>
		<td class="plaintext" align="right">
		<font size="1">$2,437m</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext">
		<font color="#000000" size="1">Brokers</font></td>
		<td class="plaintext" align="right">
		<font size="1">16</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext"><font color="#000000" size="1">Advisers</font></td>
		<td class="plaintext" align="right"><font size="1">30</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext"><font size="1">Facilitators</font></td>
		<td class="plaintext" align="right">
		<font size="1">1</font></td>
	</tr><%lap = (-lap)+1%>
	<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
		<td class="plaintext" colspan="2"><font size="1">
		<a target="_top" href="market_phases.asp">Market Hours</a>: 10.00am to 
		4.15pm AEST. Hours includes CSPA and
		AHA phases.&nbsp;</font></td>
	</tr><%lap = (-lap)+1%>
</table>


</body>
</html>