<%@ LANGUAGE="VBSCRIPT" %>
<%

Response.Redirect "/marketdata/company_search"
Response.End


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
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font><font face="Arial">COMPANY 
	RESEARCH<br>
	</font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a target="_blank" href="http://www.australianinvestor.com.au/">
	<img border="0" src="images/research_images/ai_bull_logo100.gif" width="350" height="65"></a></h1>
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<p align="left">
<%
id = ucase(request.querystring("tradingcode"))

%>
</p>
<table align=center width=100%>





	<tr>
		<td width=100%>
		<iframe name="main" src="http://www.australianinvestor.com.au/NewsFeed_CoAnalysisTwo.asp?asxCode=NSX:<%=id%>" width="794" height="1500" frameborder="0" scrolling="auto" align="center"></iframe>
		
		

		
		</td>
	</tr>
    
      </table>







<p><b>Disclaimer</b>: Research available on this page is provided independently by 
<a target="_blank" href="http://www.australianinvestor.com.au/">Australian 
Investor Pty Limited.</a>&nbsp; <br>
NSX takes no responsibility for the content 
provided by Australian Investor.</td>
    
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->

</body>

</html>