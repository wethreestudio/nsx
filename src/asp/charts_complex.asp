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
<link rel=stylesheet href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font></b><font face="Arial">DAILY 
    TRADING CHART</h1>
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<p align="left">
<%
id = ucase(request.querystring("tradingcode"))

%>
</p>
<div class="table-responsive"><table>





	<tr>
		<td width=100%>
		<iframe name="main" src="http://www.paritech.com.au/files/nsx/pco2NSX.asp?exchange1=NSX&symbol=<%=id%>" width="600" height="1000" frameborder="0" scrolling="auto"></iframe>
		
		

		
		</td>
	</tr>
    
      </table></div>







<p>&nbsp;
    </td>
    
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

</body>

</html>