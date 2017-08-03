<html>

<head>
 <%
     Function DispErrs(errmsg)
errmsg = errmsg & " "
if len(trim(errmsg))>0 then 
		Response.write ("<br><b><font size=1 face=verdana color=red>")
		Response.write ("<ol>" &errmsg& "</ol></font></b>")
		Session("errmsg")=""
end if
End Function



    %>   

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



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >
<%if session("exchid")="NSX" then%>
<!--#INCLUDE FILE="header.asp"-->
<%end if%>
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><%if session("exchid")="NSX" then%>
<!--#INCLUDE FILE="lmenu.asp"-->
<%end if%></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">FORGOTTEN PASSWORD</font></b></h1>
	
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    <form method="POST" action="member_forgot_check_v2.asp">
  <div class="table-responsive"><table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        
			<p class="plaintext">Please
        enter your user name so that 
          we can retrieve your password for you. The password will be 
          automatically sent to your previously nominated email address. <br><%disperrs(Session("errmsg"))%></p>
		
      </td>
    </tr>
    <tr>
      <td class="textlabel" bgcolor="#FFFFFF"> 
              
				<b><font face="Arial">Enter Username:</font></b><font face="Arial"><b>
				</b>
				<input type="text" name="memberid" size="25" class="TextBox" value="<%=Session("memberid")%>"></font><input type="submit" value="Email It" name="B1" style="background-color: #FFFFFF; color: #6D7BA0; font-family: Arial; font-weight: bold">
				
      </td>
    </tr>
    </table></div>
</form>
    




<p align="left">&nbsp;&nbsp;&nbsp;</p>



    &nbsp;
    
    

<p>&nbsp;



    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
<p>&nbsp;
    </td>
  </tr>
</table></div>
</div>
<%if session("exchid")="NSX" then%>
<!--#INCLUDE FILE="footer.asp"-->
<%end if%>

        
    
        
</body>

</html>
