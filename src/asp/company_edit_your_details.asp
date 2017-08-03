<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% ID = session("subid") 

CHECKFOR = "CSX" 

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if
%>
<!--#INCLUDE FILE="member_check.asp"-->

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
    <td width="200" valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="company_lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">CHANGE USER DETAILS</font></b></h1>
	
	</td>
  </tr>
  <tr>
  
    

    <td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">
    
      <p> &nbsp;
      <div align="center">
        <center>
      <div class="table-responsive"><table border="0" cellspacing="1" width="90%" >
  <tr>
    <td valign="top" width="100%" class="highlightbox">
      <p><font color="#FFFFFF"><font size="2" face="Arial"><b>Warning: </b> Y</font><font size="2">ou 
		are editing a live document.&nbsp; Any changes you submit will be over 
		written within the database and may adversely affect the way you access 
		protected pages.&nbsp; After submitting changes please be patient while 
		the database updates.&nbsp; Password changes ONLY take effect when you 
		log in again.</font></font></p>
    </td>
  </tr>
</table></div>
        </center>
      </div>
<% 
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT uSubscribers.* FROM uSubscribers WHERE (subid = " & SafeSqlParameter(ID) & ")"
CmdEditUser.Open SQL, ConnPasswords
%>

<form method="POST" action="company_save_your_details.asp">
  <input type="hidden" name="ID" value="<% =ID %>">
  <div align="center">
    <center>
	<div class="table-responsive"><table border="0" width="450" cellspacing="1" bgcolor="#FFFFFF" cellpadding="0" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
    <center>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">
		<font color="#808080">Name<strong><small><font face="Arial">:</font></small></strong></font></td>
      <td bgcolor="#FFFFFF">
      <input type="text" name="salutation" size="5" value="<%=CmdEditUser("salutation")%>" style="border: 1px solid #6D7BA0; background-color:#EEEEEE">&nbsp;
      <input type="text" name="fname" size="15" value="<%=CmdEditUser("fname")%>" style="border: 1 solid #6D7BA0 ;background-color:#EEEEEE">&nbsp;
      <input type="text" name="lname" size="15" value="<%=CmdEditUser("lname")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
     <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">Organisation:</td>
      <td bgcolor="#FFFFFF"><font face="Arial">
		<input type="text" name="organisation" size="30"
      value="<%=CmdEditUser("organisation")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></font></td>
    </tr>
     <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">Position:</td>
      <td bgcolor="#FFFFFF"><font face="Arial">
		<input type="text" name="position" size="30"
      value="<%=CmdEditUser("position")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></font></td>
    </tr>
     <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">Occupation:</td>
      <td bgcolor="#FFFFFF"><font face="Arial">
		<input type="text" name="occupation" size="30"
      value="<%=CmdEditUser("occupation")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></font></td>
    </tr>
     <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Address:</font></b></td>
      <td bgcolor="#FFFFFF"><font face="Arial"><textarea rows="3" name="address" cols="30" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"><%=CmdEditUser("address")%></textarea></font></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Suburb:</font></b></td>
      <td bgcolor="#FFFFFF"><font face="Arial"><input type="text" name="suburb" size="30"
      value="<%=CmdEditUser("suburb")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></font></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">City:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="city" size="30"
      value="<%=CmdEditUser("city")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">State:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="state" size="30"
      value="<%=CmdEditUser("state")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Country:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="country" size="30"
      value="<%=CmdEditUser("country")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">ZIP/Postcode:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="zip" size="30"
      value="<%=CmdEditUser("zip")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Phone:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="phone" size="30"
      value="<%=CmdEditUser("phone")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Fax:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="fax" size="30"
      value="<%=CmdEditUser("fax")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Email:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="email" size="30"
      value="<%=CmdEditUser("email")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
        <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel"><b>
		<font size="2" face="Arial" color="#808080">Mobile:</font></b></td>
      <td bgcolor="#FFFFFF"><input type="text" name="mobile" size="30"
      value="<%=CmdEditUser("mobile")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">
		<font color="#808080">Username<strong><small><font face="Arial">:</font></small></strong></font></td>
      <td bgcolor="#FFFFFF" class="plaintext"><%=CmdEditUser("USERNAME")%></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">
		<font color="#808080">Password<strong><small><font face="Arial">:</font></small></strong></font></td>
      <td bgcolor="#FFFFFF"><input type="text" name="PASSWORD" size="30"
      value="<%=CmdEditUser("PASSWORD")%>" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel">
		&nbsp;&nbsp;&nbsp; </td>
      <td bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp; </td>
    </tr>
      </table></div>
    </center>
    </div>
  </center>
  <div align="center"><p><input type="submit" value="Save User Info" style="color: #6D7BA0; background-color: #FFFFFF; font-family: arial; font-size: 10pt; font-weight: bold"></p>
  </div>
</form>
<%
CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing
%>

      <p> &nbsp;&nbsp;&nbsp;&nbsp;
    
    </td>
      
    

</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->



</html>